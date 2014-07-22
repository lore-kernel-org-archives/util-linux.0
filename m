Return-Path: davidlohr@hp.com
From: Davidlohr Bueso <davidlohr@hp.com>
To: kzak@redhat.com
Cc: davidlohr@hp.com, aswin@hp.com, util-linux@vger.kernel.org
Subject: [PATCH 11/13] sfdisk: rework option handling
Date: Tue, 22 Jul 2014 16:44:55 -0700
Message-Id: <1406072697-20912-12-git-send-email-davidlohr@hp.com>
In-Reply-To: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
References: <1406072697-20912-1-git-send-email-davidlohr@hp.com>
List-ID: <util-linux.vger.kernel.org>

One of the biggest characteristics of sfdisk is that it has an enormous amount
of argument options. While the manpage classifies this has a bug, it does
have its place, ie: user or (more likely) sysadmin scripts. Any reworking effort
must maintain 100% backward compatibility, otherwise we can make users unhappy.

With that in mind, this patch proposes a fundamental general structuring of
the program's UI. Just as cfdisk has ncurses and fdisk has those crazy character
based menus, sfdisk uses the command line arguments as the main way of interaction.
Specifically, there are 4 main types of options that will define the overall
program logic -- each of these types are completely independent and keep a very
particular order. It introduces a simple static 'struct sfdisk_option' type as a
table that maps to the group-specific callback if enabled by the user.
A few observations:

  * While this idea guarantees backward compatibility, it is possible for the
    implementation to be missing a few corner cases. This patch is pretty well
    tested, but still lacks 100% automation. So more testing is definitely
    welcome!

  * For now, have a global array of options. However, as the sfdisk context
    begins to be built, this array can be moved inside and have direct control
    over it.

While I doubt that there will ever be a need, adding a new group of options is
quite trivial, as it is to change the internal interfaces (sfdisk_option_*).
This last one will be more important as code matures.

Signed-off-by: Davidlohr Bueso <davidlohr@hp.com>
---
 disk-utils/sfdisk.c | 435 +++++++++++++++++++++++++++++++++++++---------------
 1 file changed, 315 insertions(+), 120 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index a097c6e..86ed112 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -40,6 +40,7 @@
 #include <sys/stat.h>
 #include <sys/utsname.h>
 #include <limits.h>
+#include <assert.h>
 
 #include "c.h"
 #include "nls.h"
@@ -53,6 +54,9 @@
 #include "strutils.h"
 #include "sysfs.h"
 
+#define PRINT_ID 0400
+#define CHANGE_ID 01000
+
 struct systypes {
 	unsigned char type;
 	char *name;
@@ -63,6 +67,200 @@ static struct systypes i386_sys_types[] = {
 };
 
 /*
+ * sfdisk program command line handling internal API.
+ */
+enum {
+	/*
+	 * There are 4 independent, mutually exclusive types,
+	 * or groups, of options throughout sfdisk.
+	 *
+	 * Keep this particular order to maintain backward
+	 * option preference compatibility. Consider each group
+	 * call completely isolated to one another. Otherwise
+	 * existing scripts can be broken, ie:
+	 *
+	 * sfdisk -s -V /dev/sda
+	 * sfdisk -G -g -s /dev/sda
+	 */
+	SFDISK_OPT_OUT_GEOM = 0, /* list kernel's idea of the geometry */
+	SFDISK_OPT_OUT_PT_GEOM,  /* list the geometry by looking at the pt */
+	SFDISK_OPT_SIZE,         /* list size of the partition */
+	SFDISK_OPT_LIST,         /* list partitions of a device */
+	SFDISK_OPT_VERIFY,       /* check that listed partition is reasonable */
+#define SFDISK_OPT_GROUP1 SFDISK_OPT_VERIFY
+
+	SFDISK_OPT_ACTIVATE,     /* mark the indicated partitions active, the rest inactive */
+	SFDISK_OPT_UNHIDE,       /* mark various Microsoft partitions unhidden */
+#define SFDISK_OPT_GROUP2 SFDISK_OPT_UNHIDE
+
+	SFDISK_OPT_CHANGE_ID,    /* print or change partition IDs to a given value */
+#define SFDISK_OPT_GROUP3 SFDISK_OPT_CHANGE_ID
+
+	SFDISK_OPT_REREAD,      /* make the kernel re-read the partition table (BLKRRPART ioctl) */
+	SFDISK_OPT_RESTORE_SCT, /* restore filesystem/disk state backed-up by -O option  */
+#define SFDISK_OPT_GROUP4 SFDISK_OPT_RESTORE_SCT
+
+	N_SFDISK_OPTS,
+};
+
+struct sfdisk_option {
+	int active;
+
+	/*
+	 * Different different families of callbacks,
+	 * depending on the passed options. For each callback
+	 * type, there is a sfdisk_option_do_cb<N>() which
+	 * should be called only after successfully calling
+	 * sfdisk_option_is_cb<N>().
+	 */
+	int (*callback1)(char *, int, unsigned long long *);
+	int (*callback2)(char **, int, char *);
+	int (*callback3)(char *, char *, char *);
+	int (*callback4)(char *);
+};
+
+/* the different callbacks */
+static int do_geom(char *dev, int silent,
+		   unsigned long long *dummy  __attribute__((__unused__)));
+static int do_pt_geom(char *dev, int silent,
+		      unsigned long long *dummy __attribute__((__unused__)));
+static int do_size(char *dev, int silent, unsigned long long *total_size);
+static int do_verify(char *dev, int silent,
+		     unsigned long long *dummy __attribute__((__unused__)));
+static int do_list(char *dev, int silent,  unsigned long long *dummy __attribute__((__unused__)));
+static int do_activate(char **av, int ac, char *arg);
+static int do_unhide(char **av, int ac, char *arg);
+static int do_change_id(char *dev, char *pnam, char *id);
+static int do_reread(char *dev);
+static int do_restore_sectors(char *dev);
+
+static struct sfdisk_option opts[N_SFDISK_OPTS] = {
+		/* first group of options */
+		[SFDISK_OPT_OUT_GEOM]    = { 0,   do_geom,    NULL,        NULL },
+		[SFDISK_OPT_OUT_PT_GEOM] = { 0,   do_pt_geom, NULL,        NULL },
+		[SFDISK_OPT_SIZE]        = { 0,   do_size,    NULL,        NULL },
+		[SFDISK_OPT_VERIFY]      = { 0,   do_verify,  NULL,        NULL },
+		[SFDISK_OPT_LIST]        = { 0,   do_list,    NULL,        NULL },
+		/* second group of options */
+		[SFDISK_OPT_ACTIVATE]    = { 0,   NULL,       do_activate, NULL },
+		[SFDISK_OPT_UNHIDE]      = { 0,   NULL,       do_unhide,   NULL },
+		/* Third group of options */
+		[SFDISK_OPT_CHANGE_ID]   = { 0,   NULL,       NULL,        do_change_id, NULL},
+		/* fourth group of options */
+		[SFDISK_OPT_REREAD]      = { 0,   NULL,       NULL,        NULL,         do_reread },
+		[SFDISK_OPT_RESTORE_SCT] = { 0,   NULL,       NULL,        NULL,         do_restore_sectors },
+};
+
+static inline void sfdisk_option_checks(void)
+{
+	assert(N_SFDISK_OPTS - 1 == SFDISK_OPT_RESTORE_SCT);
+	assert((SFDISK_OPT_GROUP1 < SFDISK_OPT_GROUP2) &&
+	       (SFDISK_OPT_GROUP3 < SFDISK_OPT_GROUP4));
+}
+
+/* TYPE 1 option calls */
+static inline int sfdisk_option_is_cb1(struct sfdisk_option *opts)
+{
+	int i;
+
+	for (i = 0; i <= SFDISK_OPT_GROUP1; i++)
+		if (opts[i].active)
+			return 1;
+	return 0;
+}
+
+static int sfdisk_option_do_cb1(struct sfdisk_option *opts, char *dev,
+				int silent, unsigned long long *arg)
+{
+	int i, ret = 0;
+
+	for (i = 0; i <= SFDISK_OPT_GROUP1; i++)
+		if (opts[i].active)
+			ret = opts[i].callback1(dev, silent, arg);
+	return ret;
+}
+/* TYPE 2 option calls */
+static inline int sfdisk_option_is_cb2(struct sfdisk_option *opts)
+{
+	int i;
+
+	for (i = SFDISK_OPT_GROUP1; i <= SFDISK_OPT_GROUP2; i++)
+		if (opts[i].active)
+			return 1;
+	return 0;
+}
+
+static int sfdisk_option_do_cb2(struct sfdisk_option *opts, char **av,
+				int ac, char *arg)
+{
+	int i;
+
+	for (i = SFDISK_OPT_GROUP1; i <= SFDISK_OPT_GROUP2; i++) {
+		if (!opts[i].active)
+			continue;
+
+		return opts[i].callback2(av, ac, arg);
+	}
+	return 0; /* should never occur */
+}
+/* TYPE 3 option calls */
+static inline int sfdisk_option_is_cb3(struct sfdisk_option *opts)
+{
+	int i;
+
+	for (i = SFDISK_OPT_GROUP2; i <= SFDISK_OPT_GROUP3; i++)
+		if (opts[i].active)
+			return 1;
+	return 0;
+}
+
+static int sfdisk_option_do_cb3(struct sfdisk_option *opts,
+				int optind, int argc,
+				char *dev, char *pnam, char *id)
+{
+	int i;
+
+	for (i = SFDISK_OPT_GROUP2; i <= SFDISK_OPT_GROUP3; i++) {
+		int do_id = opts[SFDISK_OPT_CHANGE_ID].active;
+
+		if (!opts[i].active)
+			continue;
+
+		if (i == SFDISK_OPT_CHANGE_ID && do_id) {
+			if ((do_id & PRINT_ID) != 0 && optind != argc - 2)
+				errx(EXIT_FAILURE, _("usage: sfdisk --print-id device partition-number"));
+			else if ((do_id & CHANGE_ID) != 0 && optind != argc - 3)
+				errx(EXIT_FAILURE, _("usage: sfdisk --change-id device partition-number Id"));
+			else if (optind != argc - 3 && optind != argc - 2)
+				errx(EXIT_FAILURE, _("usage: sfdisk --id device partition-number [Id]"));
+		}
+		return opts[i].callback3(dev, pnam, id);
+	}
+	return 0; /* should never occur */
+}
+/* TYPE 4 option calls */
+static inline int sfdisk_option_is_cb4(struct sfdisk_option *opts)
+{
+	int i;
+
+	for (i = SFDISK_OPT_GROUP3; i <= SFDISK_OPT_GROUP4; i++)
+		if (opts[i].active)
+			return 1;
+	return 0;
+}
+
+static int sfdisk_option_do_cb4(struct sfdisk_option *opts, char *dev)
+
+{
+	int i;
+
+	for (i = SFDISK_OPT_GROUP3; i <= SFDISK_OPT_GROUP4; i++)
+		if (opts[i].active)
+			return opts[i].callback4(dev);
+	return 0;
+}
+
+/*
  * Table of contents:
  *  A. About seeking
  *  B. About sectors
@@ -79,15 +277,12 @@ int force = 0;			/* 1: do what I say, even if it is stupid ... */
 int quiet = 0;			/* 1: suppress all warnings */
 /* IA-64 gcc spec file currently does -DLinux... */
 #undef Linux
-int Linux = 0;			/* 1: suppress warnings irrelevant for Linux */
 int DOS = 0;			/* 1: shift extended partitions by #sectors, not 1 */
 int DOS_extended = 0;		/* 1: use starting cylinder boundary of extd partn */
 int dump = 0;			/* 1: list in a format suitable for later input */
-int verify = 0;			/* 1: check that listed partition is reasonable */
 int no_write = 0;		/* 1: do not actually write to disk */
 int no_reread = 0;		/* 1: skip the BLKRRPART ioctl test at startup */
 int leave_last = 0;		/* 1: don't allocate the last cylinder */
-int opt_list = 0;
 char *save_sector_file = NULL;
 char *restore_sector_file = NULL;
 
@@ -303,8 +498,8 @@ err:
 
 static int reread_disk_partition(char *dev, int fd);
 
-static int
-restore_sectors(char *dev) {
+static int do_restore_sectors(char *dev)
+{
 	int fdin = -1, fdout = -1;
 	int ct;
 	struct stat statbuf;
@@ -450,8 +645,8 @@ get_geometry(char *dev, int fd, int silent) {
 	return R;
 }
 
-static void
-get_cylindersize(char *dev, int fd, int silent) {
+static void get_cylindersize(char *dev, int fd, int silent)
+{
 	struct geometry R;
 
 	R = get_geometry(dev, fd, silent);
@@ -1070,14 +1265,17 @@ out_partition(char *dev, int format, struct part_desc *p,
 	}
 }
 
-static void
-out_partitions(char *dev, struct disk_desc *z) {
+static void out_partitions(char *dev, struct disk_desc *z)
+{
 	int pno, format = 0;
 
 	if (z->partno == 0) {
+		int opt_list = opts[SFDISK_OPT_LIST].active;
+
 		if (!opt_list)
 			warnx(_("No partitions found"));
 	} else {
+
 		if (get_fdisk_geometry(z) && !dump) {
 			warnx(_("Warning: The partition table looks like it was made\n"
 				"  for C/H/S=*/%ld/%ld (instead of %ld/%ld/%ld).\n"
@@ -1554,8 +1752,10 @@ amiga_partition(char *dev __attribute__ ((__unused__)),
 	return 0;
 }
 
-static void
-get_partitions(char *dev, int fd, struct disk_desc *z) {
+static void get_partitions(char *dev, int fd, struct disk_desc *z)
+{
+	int opt_list = opts[SFDISK_OPT_LIST].active;
+
 	z->partno = 0;
 
 	if (!msdos_partition(dev, fd, 0, z)
@@ -2339,13 +2539,15 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static void
-activate_usage(void) {
+static void activate_usage(void)
+{
 	char *p;
+
 	if (!strcmp(program_invocation_short_name, "activate"))
 		p = " ";
 	else
 		p = " --activate=";
+
 	fputs(USAGE_HEADER, stderr);
 	fputs(USAGE_SEPARATOR, stderr);
 	fprintf(stderr, _(" %s%sdevice            list active partitions on device\n"),
@@ -2356,9 +2558,6 @@ activate_usage(void) {
 	exit(EXIT_FAILURE);
 }
 
-#define PRINT_ID 0400
-#define CHANGE_ID 01000
-
 enum {
 	OPT_NO_REREAD = CHAR_MAX + 1,
 	OPT_LEAVE_LAST,
@@ -2457,14 +2656,12 @@ static char *nextproc(FILE *f)
 	return NULL;
 }
 
-unsigned long long total_size;
-
 /*
  *  H. Listing the current situation
  */
 
-static int
-my_open(char *dev, int rw, int silent) {
+static int my_open(char *dev, int rw, int silent)
+{
 	int fd, mode;
 
 	mode = (rw ? O_RDWR : O_RDONLY);
@@ -2478,7 +2675,8 @@ my_open(char *dev, int rw, int silent) {
 	return fd;
 }
 
-static int do_list(char *dev, int silent)
+static int do_list(char *dev, int silent,
+		   unsigned long long *dummy __attribute__((__unused__)))
 {
 	int fd, ret = 0;
 	struct disk_desc *z;
@@ -2490,31 +2688,51 @@ static int do_list(char *dev, int silent)
 	z = &oldp;
 
 	free_sectors();
-	get_cylindersize(dev, fd, dump ? 1 : opt_list ? 0 : 1);
+	get_cylindersize(dev, fd, dump ? 1 : 0);
 	get_partitions(dev, fd, z);
 
-	if (opt_list)
-		out_partitions(dev, z);
+	out_partitions(dev, z);
 
-	if (verify) {
-		if (partitions_ok(fd, z))
-			printf(_("%s: OK"), dev);
-		else
-			ret = 1;
-	}
+	close(fd);
+	return ret;
+}
+
+static int do_verify(char *dev, int silent,
+		     unsigned long long *dummy __attribute__((__unused__)))
+{
+	int fd, ret = 0, opt_list = opts[SFDISK_OPT_LIST].active;
+	struct disk_desc *z;
+
+	fd = my_open(dev, 0, silent);
+	if (fd < 0)
+		return ret;
+
+	z = &oldp;
+
+	free_sectors();
+	get_cylindersize(dev, fd, dump ? 1 :
+			 (opt_list && opts[SFDISK_OPT_SIZE].active) ? 0 : 1);
+	get_partitions(dev, fd, z);
+
+	if (partitions_ok(fd, z))
+		printf(_("%s: OK"), dev);
+	else
+		ret = 1;
 
 	close(fd);
 	return ret;
 }
 
-static void
-do_geom(char *dev, int silent) {
+static int do_geom(char *dev, int silent,
+		   unsigned long long *dummy  __attribute__((__unused__)))
+
+{
 	int fd;
 	struct geometry R;
 
 	fd = my_open(dev, 0, silent);
 	if (fd < 0)
-		return;
+		return 0;
 
 	R = get_geometry(dev, fd, silent);
 	if (R.cylinders)
@@ -2522,17 +2740,19 @@ do_geom(char *dev, int silent) {
 		       dev, R.cylinders, R.heads, R.sectors);
 
 	close(fd);
+	return 0;
 }
 
-static void
-do_pt_geom(char *dev, int silent) {
+static int do_pt_geom(char *dev, int silent,
+		      unsigned long long *dummy __attribute__((__unused__)))
+{
 	int fd;
 	struct disk_desc *z;
 	struct geometry R;
 
 	fd = my_open(dev, 0, silent);
 	if (fd < 0)
-		return;
+		return 0;
 
 	z = &oldp;
 
@@ -2554,17 +2774,18 @@ do_pt_geom(char *dev, int silent) {
 		       dev, R.cylinders, R.heads, R.sectors);
 
 	close(fd);
+	return 0;
 }
 
 /* for compatibility with earlier fdisk: provide option -s */
-static void
-do_size(char *dev, int silent) {
+static int do_size(char *dev, int silent, unsigned long long *total_size)
+{
 	int fd;
 	unsigned long long size;
 
 	fd = my_open(dev, 0, silent);
 	if (fd < 0)
-		return;
+		return 0;
 
 	if (blkdev_get_sectors(fd, &size) == -1) {
 		if (!silent)
@@ -2583,10 +2804,11 @@ do_size(char *dev, int silent) {
 	else
 		printf("%llu\n", size);
 
-	total_size += size;
+	*total_size += size;
 
 done:
 	close(fd);
+	return size;
 }
 
 /*
@@ -2778,8 +3000,8 @@ done:
 	return ret;
 }
 
-static void
-do_reread(char *dev) {
+static int do_reread(char *dev)
+{
 	int fd;
 
 	fd = my_open(dev, 0, 0);
@@ -2789,6 +3011,7 @@ do_reread(char *dev) {
 	}
 
 	close(fd);
+	return 0;
 }
 
 /*
@@ -2893,25 +3116,19 @@ static int do_fdisk(char *dev)
 
 int main(int argc, char **argv)
 {
-	int c, ret = 0;
-	char *dev;
-	int opt_size = 0;
-	int opt_out_geom = 0;
-	int opt_out_pt_geom = 0;
-	int opt_reread = 0;
-	int activate = 0;
-	int do_id = 0;
-	int unhide = 0;
-	char *activatearg = 0;
-	char *unhidearg = 0;
+	int c, err = 0;
+	char *dev, *args = NULL;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	/* simple option size/order sanity check */
+	sfdisk_option_checks();
+
 	if (!strcmp(program_invocation_short_name, "activate"))
-		activate = 1;		/* equivalent to `sfdisk -A' */
+		opts[SFDISK_OPT_ACTIVATE].active = 1; /* equivalent to `sfdisk -A' */
 
 	while ((c = getopt_long(argc, argv, "cdfghilnqsu:vx1A::C:DGH:I:LN:O:RS:TU::V",
 				long_opts, NULL)) != -1) {
@@ -2920,10 +3137,10 @@ int main(int argc, char **argv)
 			force = 1;
 			break;		/* does not imply quiet */
 		case 'g':
-			opt_out_geom = 1;
+			opts[SFDISK_OPT_OUT_GEOM].active = 1;
 			break;
 		case 'G':
-			opt_out_pt_geom = 1;
+			opts[SFDISK_OPT_OUT_PT_GEOM].active = 1;
 			break;
 		case 'i':
 			increment = 1;
@@ -2931,12 +3148,12 @@ int main(int argc, char **argv)
 		case 'c':
 		case 'c' + PRINT_ID:
 		case 'c' + CHANGE_ID:
-			do_id = c;
+			opts[SFDISK_OPT_CHANGE_ID].active = c;
 			break;
 		case 'd':
 			dump = 1;		/* fall through */
 		case 'l':
-			opt_list = 1;
+			opts[SFDISK_OPT_LIST].active = 1;
 			break;
 		case 'n':
 			no_write = 1;
@@ -2945,7 +3162,7 @@ int main(int argc, char **argv)
 			quiet = 1;
 			break;
 		case 's':
-			opt_size = 1;
+			opts[SFDISK_OPT_SIZE].active = 1;
 			break;
 		case 'u':
 			set_format(*optarg);
@@ -2959,8 +3176,8 @@ int main(int argc, char **argv)
 			show_extended = 1;
 			break;
 		case 'A':
-			activatearg = optarg;
-			activate = 1;
+			args = optarg;
+			opts[SFDISK_OPT_ACTIVATE].active = 1;
 			break;
 		case 'C':
 			U.cylinders = strtoul_or_err(optarg, _("invalid cylinders argument"));
@@ -2975,19 +3192,19 @@ int main(int argc, char **argv)
 			U.heads = strtoul_or_err(optarg, _("invalid heads argument"));
 			break;
 		case 'L':
-			Linux = 1;
 			break;
 		case 'N':
 			one_only = strtol_or_err(optarg, _("invalid number of partitions argument"));
 			break;
 		case 'I':
 			restore_sector_file = optarg;
+			opts[SFDISK_OPT_RESTORE_SCT].active = 1;
 			break;
 		case 'O':
 			save_sector_file = optarg;
 			break;
 		case 'R':
-			opt_reread = 1;
+			opts[SFDISK_OPT_REREAD].active = 1;
 			break;
 		case 'S':
 			U.sectors = strtoul_or_err(optarg, _("invalid sectors argument"));
@@ -2996,11 +3213,11 @@ int main(int argc, char **argv)
 			list_types();
 			return EXIT_SUCCESS;
 		case 'U':
-			unhidearg = optarg;
-			unhide = 1;
+			args = optarg;
+			opts[SFDISK_OPT_UNHIDE].active = 1;
 			break;
 		case 'V':
-			verify = 1;
+			opts[SFDISK_OPT_VERIFY].active = 1;
 			break;
 		default:
 			usage(stderr);
@@ -3038,88 +3255,66 @@ int main(int argc, char **argv)
 		}
 	}
 
-	if (optind == argc &&
-	    (opt_list || opt_out_geom || opt_out_pt_geom || opt_size || verify)) {
+	if ((optind == argc) && sfdisk_option_is_cb1(opts)) { /* ie: sfdisk -V */
 		FILE *procf;
-
-		/* try all known devices */
-		total_size = 0;
+		unsigned long long total_size = 0; /* try all known devices */
 
 		procf = fopen(_PATH_PROC_PARTITIONS, "r");
 		if (!procf)
 			fprintf(stderr, _("cannot open %s\n"), _PATH_PROC_PARTITIONS);
 		else {
-			while ((dev = nextproc(procf)) != NULL) {
-				if (!is_ide_cdrom_or_tape(dev)) {
-					if (opt_out_geom)
-						do_geom(dev, 1);
-					if (opt_out_pt_geom)
-						do_pt_geom(dev, 1);
-					if (opt_size)
-						do_size(dev, 1);
-					if (opt_list || verify)
-						ret = do_list(dev, 1);
-				}
+			while ((dev = nextproc(procf))) {
+				if (!is_ide_cdrom_or_tape(dev))
+					err = sfdisk_option_do_cb1(opts, dev, 1, &total_size);
 				free(dev);
 			}
 			fclose(procf);
 		}
 
-		if (opt_size)
-			printf(_("total: %llu blocks\n"), total_size);
-
+		if (opts[SFDISK_OPT_SIZE].active)
+				printf(_("total: %llu blocks\n"), total_size);
 		goto done;
 	}
 
-	if (optind == argc) {
-		if (activate)
+	if (optind == argc) { /* ie: sfdisk -A */
+		if (opts[SFDISK_OPT_ACTIVATE].active)
 			activate_usage();
 		else
 			usage(stderr);
+		/* neither usage-family functions returns to the caller */
 	}
 
-	if (opt_list || opt_out_geom || opt_out_pt_geom || opt_size || verify) {
-		while (optind < argc) {
-			if (opt_out_geom)
-				do_geom(argv[optind], 0);
-			if (opt_out_pt_geom)
-				do_pt_geom(argv[optind], 0);
-			if (opt_size)
-				do_size(argv[optind], 0);
-			if (opt_list || verify)
-				ret = do_list(argv[optind], 0);
-			optind++;
-		}
+	if (sfdisk_option_is_cb1(opts)) {
+		unsigned long long dummy = 0;
+
+		while (optind < argc)
+			err = sfdisk_option_do_cb1(opts, argv[optind++], 0, &dummy);
 		goto done;
 	}
 
-	if (activate) {
-		return do_activate(argv + optind, argc - optind, activatearg);
-	}
-	if (unhide) {
-		return do_unhide(argv + optind, argc - optind, unhidearg);
+	if (sfdisk_option_is_cb2(opts)) { /* ie: sfdisk -A /dev/sda */
+		err = sfdisk_option_do_cb2(opts, argv + optind, argc - optind, args);
+		goto done;
 	}
-	if (do_id) {
-		if ((do_id & PRINT_ID) != 0 && optind != argc - 2)
-			errx(EXIT_FAILURE, _("usage: sfdisk --print-id device partition-number"));
-		else if ((do_id & CHANGE_ID) != 0 && optind != argc - 3)
-			errx(EXIT_FAILURE, _("usage: sfdisk --change-id device partition-number Id"));
-		else if (optind != argc - 3 && optind != argc - 2)
-			errx(EXIT_FAILURE, _("usage: sfdisk --id device partition-number [Id]"));
-		return do_change_id(argv[optind], argv[optind + 1],
-				    (optind == argc - 2) ? 0 : argv[optind + 2]);
+
+	if (sfdisk_option_is_cb3(opts)) { /* ie: sfdisk -c /dev/sda */
+		err = sfdisk_option_do_cb3(opts, optind, argc,
+					   argv[optind], argv[optind + 1],
+					   (optind == argc - 2) ? 0 : argv[optind + 2]);
+		goto done;
 	}
 
 	if (optind != argc - 1)
 		errx(EXIT_FAILURE, _("can specify only one device (except with -l or -s)"));
 	dev = argv[optind];
 
-	if (opt_reread)
-		do_reread(dev);
-	else if (restore_sector_file)
-		restore_sectors(dev);
-	else
-		ret = do_fdisk(dev);
+	if (sfdisk_option_is_cb4(opts)) { /* ie: sfdisk -R /dev/sda */
+		err = sfdisk_option_do_cb4(opts, dev);
+		goto done;
+	}
+
+	/* ok ok, do the rest */
+	err = do_fdisk(dev);
 done:
-	return ret;
+	return err ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
1.8.1.4
