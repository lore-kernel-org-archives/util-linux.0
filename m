Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:62089 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752943Ab1F3Jic convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 30 Jun 2011 05:38:32 -0400
Received: by qwk3 with SMTP id 3so1014422qwk.19
        for <util-linux@vger.kernel.org>; Thu, 30 Jun 2011 02:38:32 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Thu, 30 Jun 2011 11:38:31 +0200
Message-ID: <BANLkTikQsgSXBs4kybTvF0QvDDvbMub5hg@mail.gmail.com>
Subject: [git pull] blockdev fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit 37b94458bd0f4a178233ad0366a727bf5bde879f:

  sfdisk: fix coding style. (2011-06-29 12:47:38 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit blockdev

Sami Kerola (8):
      blockdev: set options read only
      blockdev: remove progname
      blockdev: add --help option
      blockdev: use libc error facilities
      blockdev: use pathnames.h to find partitions
      blockdev: broken compiler warning circumvention removed
      blockdev: type mismatch fix
      blockdev: coding style fix

 disk-utils/blockdev.c |  158 +++++++++++++++++++++---------------------------
 1 files changed, 69 insertions(+), 89 deletions(-)

diff --git a/disk-utils/blockdev.c b/disk-utils/blockdev.c
index 27b1a0a..cb9a296 100644
--- a/disk-utils/blockdev.c
+++ b/disk-utils/blockdev.c
@@ -14,9 +14,7 @@
 #include "c.h"
 #include "nls.h"
 #include "blkdev.h"
-
-const char *progname;
-
+#include "pathnames.h"

 struct bdc {
 	long		ioc;		/* ioctl code */
@@ -52,7 +50,7 @@ enum {

 #define IOCTL_ENTRY( io )	.ioc = io, .iocname = # io

-struct bdc bdcms[] =
+static const struct bdc bdcms[] =
 {
 	{
 		IOCTL_ENTRY(BLKROSET),
@@ -178,35 +176,32 @@ struct bdc bdcms[] =
 	}
 };

-static void
-usage(void) {
-	int i;
-	fputc('\n', stderr);
-	fprintf(stderr, _("Usage:\n"));
-	fprintf(stderr, _("  %s -V\n"), progname);
-	fprintf(stderr, _("  %s --report [devices]\n"), progname);
-	fprintf(stderr, _("  %s [-v|-q] commands devices\n"), progname);
-	fputc('\n', stderr);
-
-	fprintf(stderr, _("Available commands:\n"));
-	fprintf(stderr, "  %-25s %s\n", "--getsz",
-			_("get size in 512-byte sectors"));
+static void __attribute__ ((__noreturn__)) usage(FILE * out)
+{
+	size_t i;
+	fprintf(out, _("\nUsage:\n"
+		       "  %1$s -V\n"
+		       "  %1$s --report [devices]\n"
+		       "  %1$s [-v|-q] commands devices\n\n"
+		       "Available commands:\n"), program_invocation_short_name);
+
+	fprintf(out, _("  %-25s get size in 512-byte sectors\n"), "--getsz");
 	for (i = 0; i < ARRAY_SIZE(bdcms); i++) {
 		if (bdcms[i].argname)
-			fprintf(stderr, "  %s %-*s %s\n", bdcms[i].name,
-					(int) (24 - strlen(bdcms[i].name)),
-					bdcms[i].argname, _(bdcms[i].help));
+			fprintf(out, "  %s %-*s %s\n", bdcms[i].name,
+				(int)(24 - strlen(bdcms[i].name)),
+				bdcms[i].argname, _(bdcms[i].help));
 		else
-			fprintf(stderr, "  %-25s %s\n", bdcms[i].name,
-					_(bdcms[i].help));
+			fprintf(out, "  %-25s %s\n", bdcms[i].name,
+				_(bdcms[i].help));
 	}
-	fputc('\n', stderr);
-	exit(1);
+	fputc('\n', out);
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }

-static int
-find_cmd(char *s) {
-	int j;
+static int find_cmd(char *s)
+{
+	size_t j;

 	for (j = 0; j < ARRAY_SIZE(bdcms); j++)
 		if (!strcmp(s, bdcms[j].name))
@@ -219,31 +214,25 @@ void report_header(void);
 void report_device(char *device, int quiet);
 void report_all_devices(void);

-int
-main(int argc, char **argv) {
+int main(int argc, char **argv)
+{
 	int fd, d, j, k;
-	char *p;
-
-	/* egcs-2.91.66 is buggy and says:
-	   blockdev.c:93: warning: `d' might be used uninitialized */
-	d = 0;
-
-	progname = argv[0];
-	if ((p = strrchr(progname, '/')) != NULL)
-		progname = p+1;

 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);

 	if (argc < 2)
-		usage();
+		usage(stderr);

 	/* -V not together with commands */
 	if (!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version")) {
-		printf(_("%s (%s)\n"), progname, PACKAGE_STRING);
-		exit(0);
+		printf(_("%s (%s)\n"), program_invocation_short_name,
+		       PACKAGE_STRING);
+		return EXIT_SUCCESS;
 	}
+	if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
+		usage(stdout);

 	/* --report not together with other commands */
 	if (!strcmp(argv[1], "--report")) {
@@ -254,7 +243,7 @@ main(int argc, char **argv) {
 		} else {
 			report_all_devices();
 		}
-		exit(0);
+		return EXIT_SUCCESS;
 	}

 	/* do each of the commands on each of the devices */
@@ -277,22 +266,20 @@ main(int argc, char **argv) {
 	}

 	if (d >= argc)
-		usage();
+		usage(stderr);

 	for (k = d; k < argc; k++) {
 		fd = open(argv[k], O_RDONLY, 0);
-		if (fd < 0) {
-			perror(argv[k]);
-			exit(1);
-		}
+		if (fd < 0)
+			err(EXIT_FAILURE, _("cannot open %s"), argv[k]);
 		do_commands(fd, argv, d);
 		close(fd);
 	}
-	return 0;
+	return EXIT_SUCCESS;
 }

-void
-do_commands(int fd, char **argv, int d) {
+void do_commands(int fd, char **argv, int d)
+{
 	int res, i, j;
 	int iarg;
 	unsigned int uarg;
@@ -318,18 +305,18 @@ do_commands(int fd, char **argv, int d) {
 			if (res == 0)
 				printf("%lld\n", llu);
 			else
-				exit(1);
+				errx(EXIT_FAILURE,
+				     _("could not get device size"));
 			continue;
 		}

 		j = find_cmd(argv[i]);
 		if (j == -1) {
-			fprintf(stderr, _("%s: Unknown command: %s\n"),
-				progname, argv[i]);
-			usage();
+			warnx(_("Unknown command: %s"), argv[i]);
+			usage(stderr);
 		}

-		switch(bdcms[j].argtype) {
+		switch (bdcms[j].argtype) {
 		default:
 		case ARG_NONE:
 			res = ioctl(fd, bdcms[j].ioc, 0);
@@ -340,18 +327,18 @@ do_commands(int fd, char **argv, int d) {
 			break;
 		case ARG_INT:
 			if (bdcms[j].argname) {
-				if (i == d-1) {
-					fprintf(stderr, _("%s requires an argument\n"),
-						bdcms[j].name);
-					usage();
+				if (i == d - 1) {
+					warnx(_("%s requires an argument"),
+					      bdcms[j].name);
+					usage(stderr);
 				}
 				iarg = atoi(argv[++i]);
 			} else
 				iarg = bdcms[j].argval;

 			res = bdcms[j].flags & FL_NOPTR ?
-					ioctl(fd, bdcms[j].ioc, iarg) :
-					ioctl(fd, bdcms[j].ioc, &iarg);
+			    ioctl(fd, bdcms[j].ioc, iarg) :
+			    ioctl(fd, bdcms[j].ioc, &iarg);
 			break;
 		case ARG_UINT:
 			uarg = bdcms[j].argval;
@@ -379,7 +366,7 @@ do_commands(int fd, char **argv, int d) {
 			perror(bdcms[j].iocname);
 			if (verbose)
 				printf(_("%s failed.\n"), _(bdcms[j].help));
-			exit(1);
+			exit(EXIT_FAILURE);
 		}

 		if (bdcms[j].argtype == ARG_NONE ||
@@ -392,7 +379,7 @@ do_commands(int fd, char **argv, int d) {
 		if (verbose)
 			printf("%s: ", _(bdcms[j].help));

-		switch(bdcms[j].argtype) {
+		switch (bdcms[j].argtype) {
 		case ARG_USHRT:
 			printf("%hu\n", huarg);
 			break;
@@ -418,26 +405,21 @@ do_commands(int fd, char **argv, int d) {
 	}
 }

-#define PROC_PARTITIONS "/proc/partitions"
-
-void
-report_all_devices(void) {
+void report_all_devices(void)
+{
 	FILE *procpt;
 	char line[200];
 	char ptname[200];
 	char device[210];
 	int ma, mi, sz;

-	procpt = fopen(PROC_PARTITIONS, "r");
-	if (!procpt) {
-		fprintf(stderr, _("%s: cannot open %s\n"),
-			progname, PROC_PARTITIONS);
-		exit(1);
-	}
+	procpt = fopen(_PATH_PROC_PARTITIONS, "r");
+	if (!procpt)
+		err(EXIT_FAILURE, _("cannot open %s"), _PATH_PROC_PARTITIONS);

 	while (fgets(line, sizeof(line), procpt)) {
-		if (sscanf (line, " %d %d %d %200[^\n ]",
-			    &ma, &mi, &sz, ptname) != 4)
+		if (sscanf(line, " %d %d %d %200[^\n ]",
+			   &ma, &mi, &sz, ptname) != 4)
 			continue;

 		sprintf(device, "/dev/%s", ptname);
@@ -447,8 +429,8 @@ report_all_devices(void) {
 	fclose(procpt);
 }

-void
-report_device(char *device, int quiet) {
+void report_device(char *device, int quiet)
+{
 	int fd;
 	int ro, ssz, bsz;
 	long ra;
@@ -458,31 +440,29 @@ report_device(char *device, int quiet) {
 	fd = open(device, O_RDONLY | O_NONBLOCK);
 	if (fd < 0) {
 		if (!quiet)
-			fprintf(stderr, _("%s: cannot open %s\n"),
-				progname, device);
+			warn(_("cannot open %s"), device);
 		return;
 	}

 	ro = ssz = bsz = 0;
 	g.start = ra = 0;
-	if (ioctl (fd, BLKROGET, &ro) == 0 &&
-	    ioctl (fd, BLKRAGET, &ra) == 0 &&
-	    ioctl (fd, BLKSSZGET, &ssz) == 0 &&
-	    ioctl (fd, BLKBSZGET, &bsz) == 0 &&
-	    ioctl (fd, HDIO_GETGEO, &g) == 0 &&
-	    blkdev_get_size (fd, &bytes) == 0) {
+	if (ioctl(fd, BLKROGET, &ro) == 0 &&
+	    ioctl(fd, BLKRAGET, &ra) == 0 &&
+	    ioctl(fd, BLKSSZGET, &ssz) == 0 &&
+	    ioctl(fd, BLKBSZGET, &bsz) == 0 &&
+	    ioctl(fd, HDIO_GETGEO, &g) == 0 &&
+	    blkdev_get_size(fd, &bytes) == 0) {
 		printf("%s %5ld %5d %5d %10ld %15lld   %s\n",
 		       ro ? "ro" : "rw", ra, ssz, bsz, g.start, bytes, device);
 	} else {
 		if (!quiet)
-			fprintf(stderr, _("%s: ioctl error on %s\n"),
-				progname, device);
+			warnx(_("ioctl error on %s"), device);
 	}

 	close(fd);
 }

-void
-report_header() {
+void report_header()
+{
 	printf(_("RO    RA   SSZ   BSZ   StartSec            Size   Device\n"));
 }

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
