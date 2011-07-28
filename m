Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47509 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755984Ab1G1Vdn convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 28 Jul 2011 17:33:43 -0400
Received: by qwk3 with SMTP id 3so1558574qwk.19
        for <util-linux@vger.kernel.org>; Thu, 28 Jul 2011 14:33:42 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Thu, 28 Jul 2011 23:33:42 +0200
Message-ID: <CAG27Bk1-X+eqrVwP7cfZp-9-aCBwPtnYYBRJGi7wBt2-zaOMjA@mail.gmail.com>
Subject: [git pull] miscellaneous compiler warning fixes etc
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following changes since commit c632883f309762857b40003136eed9fb8eb63615:

  libblkid: minor change in man page (2011-07-26 16:46:00 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit misc

Sami Kerola (8):
      docs: remove README.namei
      chrt: conditional options & usage
      taskset: fix implicit overflow
      lib/loopdev: fix implicit overflows
      libmount/lock: fix implicit overflows
      lsblk: fix implicit overflows
      dmesg: fix implicit overflows
      libblkid: remove unnecessary test

 lib/loopdev.c                          |    8 ++--
 libblkid/src/superblocks/superblocks.c |    2 +-
 libmount/src/lock.c                    |    6 +-
 misc-utils/Makefile.am                 |    2 +-
 misc-utils/README.namei                |   31 --------------
 misc-utils/lsblk.c                     |    6 +-
 schedutils/chrt.c                      |   69 +++++++++++++++++++++++++++-----
 schedutils/taskset.c                   |    4 +-
 sys-utils/dmesg.c                      |   18 ++++----
 9 files changed, 82 insertions(+), 64 deletions(-)
 delete mode 100644 misc-utils/README.namei

diff --git a/lib/loopdev.c b/lib/loopdev.c
index 213063b..143aabc 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -239,7 +239,7 @@ int loopcxt_init_iterator(struct loopdev_cxt *lc, int flags)
 	memset(iter, 0, sizeof(*iter));
 	iter->ncur = -1;
 	iter->flags = flags;
-	iter->default_check = 1;
+	iter->default_check |= 1;

 	if (!lc->extra_check) {
 		/*
@@ -249,7 +249,7 @@ int loopcxt_init_iterator(struct loopdev_cxt *lc, int flags)
 		    stat(_PATH_DEV_LOOP, &st) == 0 && S_ISDIR(st.st_mode))
 			lc->flags |= LOOPDEV_FL_DEVSUBDIR;

-		lc->extra_check = 1;
+		lc->extra_check |= 1;
 	}
 	return 0;
 }
@@ -273,7 +273,7 @@ int loopcxt_deinit_iterator(struct loopdev_cxt *lc)
 		fclose(iter->proc);
 	iter->minors = NULL;
 	iter->proc = NULL;
-	iter->done = 1;
+	iter->done |= 1;
 	return 0;
 }

@@ -487,7 +487,7 @@ struct loop_info64 *loopcxt_get_info(struct loopdev_cxt *lc)
 		return NULL;

 	if (ioctl(fd, LOOP_GET_STATUS64, &lc->info) == 0) {
-		lc->has_info = 1;
+		lc->has_info |= 1;
 		return &lc->info;
 	}

diff --git a/libblkid/src/superblocks/superblocks.c
b/libblkid/src/superblocks/superblocks.c
index 9b618b2..caa9720 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -306,7 +306,7 @@ int blkid_known_fstype(const char *fstype)
  */
 int blkid_superblocks_get_name(size_t idx, const char **name, int *usage)
 {
-	if (idx >= 0 && idx < ARRAY_SIZE(idinfos)) {
+	if (idx < ARRAY_SIZE(idinfos)) {
 		if (name)
 			*name = idinfos[idx]->name;
 		if (usage)
diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index a6619b3..088ebed 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -224,7 +224,7 @@ static int lock_simplelock(struct libmnt_lock *ml)
 		rc = -errsv;
 		goto err;
 	}
-	ml->locked = 1;
+	ml->locked |= 1;
 	return 0;
 err:
 	if (ml->sigblock)
@@ -346,7 +346,7 @@ static void unlock_mtab(struct libmnt_lock *ml)

 		if (!stat(ml->lockfile, &lo) && !stat(ml->linkfile, &li) &&
 		    lo.st_dev == li.st_dev && lo.st_ino == li.st_ino)
-			ml->locked = 1;
+			ml->locked |= 1;
 	}

 	if (ml->linkfile)
@@ -417,7 +417,7 @@ static int lock_mtab(struct libmnt_lock *ml)

 		j = link(linkfile, lockfile);
 		if (j == 0)
-			ml->locked = 1;
+			ml->locked |= 1;

 		if (j < 0 && errno != EEXIST) {
 			if (errno > 0)
diff --git a/misc-utils/Makefile.am b/misc-utils/Makefile.am
index 0644373..9e2e66b 100644
--- a/misc-utils/Makefile.am
+++ b/misc-utils/Makefile.am
@@ -8,7 +8,7 @@ usrsbin_exec_PROGRAMS =

 usrbin_exec_PROGRAMS = cal ddate logger look mcookie namei whereis

-EXTRA_DIST += README.cal README.ddate README.namei
+EXTRA_DIST += README.cal README.ddate

 logger_SOURCES = logger.c $(top_srcdir)/lib/strutils.c
 mcookie_SOURCES = mcookie.c $(top_srcdir)/lib/md5.c
diff --git a/misc-utils/README.namei b/misc-utils/README.namei
deleted file mode 100644
index 490939e..0000000
--- a/misc-utils/README.namei
+++ /dev/null
@@ -1,31 +0,0 @@
-Tired of running into "Too many levels of symlinks" problems on
-your 4.2 BSD derivitive machine?
-
-We sure did... our NFS'ed network of lots of Suns, Vaxen and so forth
-made it impossible at times to trace down where a file REALLY lived.
-I mean ls -l is nice, but wouldn't you like to follow things like
-the namei routine in the kernel does?
-
-Well here it is.... the namei program.  It follows things out until
-a terminal state is found.
-
-This program compiles and runs under:
-
-    SunOS 4.0.1 (sun3's)
-    SunOS 4.0.3 (sun4's)
-    SunOS 4.1.1 (sun4's)
-    Ultrix 3.1
-    BSD 4.3
-
-and probably a host of other 4.2 derived systems (but probably not
-System V).
-
-Anyway, if anyone has any bugs (or enhancements), please send them to
-me in E-mail form.
-
-And, by the way, if you make LOTS of money off of this program, please
-don't tell me :-).
-
-    -Roger      (rogers@fangorn.wr.tek.com)
-		UUCP:	...!uunet!tektronix!fangorn.wr.tek.com!rogers
-		ARPA:	<rogers%fangorn.wr.tek.com@RELAY.CS.NET>
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 2e2c457..7457ae1 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -940,13 +940,13 @@ int main(int argc, char *argv[])
 	while((c = getopt_long(argc, argv, "abdDe:fhlnmo:Pirt", longopts,
NULL)) != -1) {
 		switch(c) {
 		case 'a':
-			lsblk->all_devices = 1;
+			lsblk->all_devices |= 1;
 			break;
 		case 'b':
-			lsblk->bytes = 1;
+			lsblk->bytes |= 1;
 			break;
 		case 'd':
-			lsblk->nodeps = 1;
+			lsblk->nodeps |= 1;
 			break;
 		case 'D':
 			columns[ncolumns++] = COL_NAME;
diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 58b71b5..2bbc657 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -34,6 +34,7 @@

 #include "strutils.h"
 #include "procutils.h"
+#include "xalloc.h"

 /* the SCHED_BATCH is supported since Linux 2.6.16
  *  -- temporary workaround for people with old glibc headers
@@ -67,13 +68,20 @@ static void __attribute__((__noreturn__)) show_usage(int rc)
 	"  chrt [options] {<pid> | <command> [<arg> ...]}\n"));

 	fprintf(out, _(
-	"\nScheduling policies:\n"
-	"  -b | --batch         set policy to SCHED_BATCH\n"
-	"  -f | --fifo          set policy to SCHED_FIFO\n"
-	"  -i | --idle          set policy to SCHED_IDLE\n"
+	"\nScheduling policies:\n"));
+#ifdef SCHED_BATCH
+	fprintf(out, _(
+	"  -b | --batch         set policy to SCHED_BATCH\n"));
+#endif
+	fprintf(out, _(
+	"  -f | --fifo          set policy to SCHED_FIFO\n"));
+#ifdef SCHED_IDLE
+	fprintf(out, _(
+	"  -i | --idle          set policy to SCHED_IDLE\n"));
+#endif
+	fprintf(out, _(
 	"  -o | --other         set policy to SCHED_OTHER\n"
 	"  -r | --rr            set policy to SCHED_RR (default)\n"));
-
 #ifdef SCHED_RESET_ON_FORK
 	fprintf(out, _(
 	"\nScheduling flags:\n"
@@ -192,24 +200,63 @@ static void show_min_max(void)
 	}
 }

+char *get_shortopts(const char *short_only, const struct option *longopts)
+{
+	char *shortopts;
+	int nopts;
+	int mopts = 16;
+
+	shortopts = xmalloc(sizeof(char) * mopts);
+	for (nopts = 0; short_only[0] != '\0'; short_only++) {
+		shortopts[nopts] = short_only[0];
+		nopts++;
+		if (nopts == mopts) {
+			mopts *= 2;
+			shortopts = xrealloc(shortopts, sizeof(char) * mopts);
+		}
+
+	}
+	for (; longopts->name != NULL; longopts++) {
+		if (longopts->val < CHAR_MAX) {
+			shortopts[nopts] = longopts->val;
+			nopts++;
+			if (nopts == mopts) {
+				mopts *= 2;
+				shortopts =
+				    xrealloc(shortopts, sizeof(char) * mopts);
+			}
+		}
+	}
+	shortopts[nopts] = '\0';
+
+	return shortopts;
+}
+
 int main(int argc, char **argv)
 {
 	int i, policy = SCHED_RR, priority = 0, verbose = 0, policy_flag = 0,
 	    all_tasks = 0;
+	char *shortopts;
 	struct sched_param sp;
 	pid_t pid = -1;

 	static const struct option longopts[] = {
 		{ "all-tasks",  0, NULL, 'a' },
+#ifdef SCHED_BATCH
 		{ "batch",	0, NULL, 'b' },
+#endif
 		{ "fifo",	0, NULL, 'f' },
+#ifdef SCHED_IDLE
 		{ "idle",	0, NULL, 'i' },
+#endif
 		{ "pid",	0, NULL, 'p' },
 		{ "help",	0, NULL, 'h' },
 		{ "max",        0, NULL, 'm' },
 		{ "other",	0, NULL, 'o' },
 		{ "rr",		0, NULL, 'r' },
+#ifdef SCHED_RESET_ON_FORK
 		{ "reset-on-fork", 0, NULL, 'R' },
+#endif
 		{ "verbose",	0, NULL, 'v' },
 		{ "version",	0, NULL, 'V' },
 		{ NULL,		0, NULL, 0 }
@@ -219,7 +266,8 @@ int main(int argc, char **argv)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);

-	while((i = getopt_long(argc, argv, "+abfiphmoRrvV", longopts, NULL)) != -1)
+	shortopts = get_shortopts("+", longopts);
+	while((i = getopt_long(argc, argv, shortopts, longopts, NULL)) != -1)
 	{
 		int ret = EXIT_FAILURE;

@@ -227,11 +275,11 @@ int main(int argc, char **argv)
 		case 'a':
 			all_tasks = 1;
 			break;
-		case 'b':
 #ifdef SCHED_BATCH
+		case 'b':
 			policy = SCHED_BATCH;
-#endif
 			break;
+#endif
 		case 'f':
 			policy = SCHED_FIFO;
 			break;
@@ -240,11 +288,11 @@ int main(int argc, char **argv)
 			policy_flag |= SCHED_RESET_ON_FORK;
 			break;
 #endif
-		case 'i':
 #ifdef SCHED_IDLE
+		case 'i':
 			policy = SCHED_IDLE;
-#endif
 			break;
+#endif
 		case 'm':
 			show_min_max();
 			return EXIT_SUCCESS;
@@ -271,6 +319,7 @@ int main(int argc, char **argv)
 			show_usage(ret);
 		}
 	}
+	free(shortopts);

 	if (((pid > -1) && argc - optind < 1) ||
 	    ((pid == -1) && argc - optind < 2))
diff --git a/schedutils/taskset.c b/schedutils/taskset.c
index 3a0db8f..d874693 100644
--- a/schedutils/taskset.c
+++ b/schedutils/taskset.c
@@ -159,7 +159,7 @@ int main(int argc, char **argv)
 					    _("failed to parse pid"));
 			break;
 		case 'c':
-			ts.use_list = 1;
+			ts.use_list |= 1;
 			break;
 		case 'V':
 			printf("%s from %s\n", program_invocation_short_name,
@@ -205,7 +205,7 @@ int main(int argc, char **argv)
 		err(EXIT_FAILURE, _("cpuset_alloc failed"));

 	if (argc - optind == 1)
-		ts.get_only = 1;
+		ts.get_only |= 1;

 	else if (ts.use_list) {
 		if (cpulist_parse(argv[optind], new_set, new_setsize))
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 7123c7f..1282411 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -667,24 +667,24 @@ int main(int argc, char *argv[])
 			cmd = SYSLOG_ACTION_CONSOLE_OFF;
 			break;
 		case 'd':
-			ctl.delta = 1;
+			ctl.delta |= 1;
 			break;
 		case 'E':
 			cmd = SYSLOG_ACTION_CONSOLE_ON;
 			break;
 		case 'f':
-			ctl.fltr_fac = 1;
+			ctl.fltr_fac |= 1;
 			list_to_bitarray(optarg, parse_facility, ctl.facilities);
 			break;
 		case 'h':
 			usage(stdout);
 			break;
 		case 'k':
-			ctl.fltr_fac = 1;
+			ctl.fltr_fac |= 1;
 			setbit(ctl.facilities, FAC_BASE(LOG_KERN));
 			break;
 		case 'l':
-			ctl.fltr_lev= 1;
+			ctl.fltr_lev |= 1;
 			list_to_bitarray(optarg, parse_level, ctl.levels);
 			break;
 		case 'n':
@@ -692,7 +692,7 @@ int main(int argc, char *argv[])
 			console_level = parse_level(optarg, 0);
 			break;
 		case 'r':
-			ctl.raw = 1;
+			ctl.raw |= 1;
 			break;
 		case 's':
 			bufsize = strtol_or_err(optarg,
@@ -703,13 +703,13 @@ int main(int argc, char *argv[])
 		case 'T':
 			ctl.boot_time = get_boot_time();
 			if (ctl.boot_time)
-				ctl.ctime = 1;
+				ctl.ctime |= 1;
 			break;
 		case 't':
-			ctl.notime = 1;
+			ctl.notime |= 1;
 			break;
 		case 'u':
-			ctl.fltr_fac = 1;
+			ctl.fltr_fac |= 1;
 			for (n = 1; n < ARRAY_SIZE(facility_names); n++)
 				setbit(ctl.facilities, n);
 			break;
@@ -718,7 +718,7 @@ int main(int argc, char *argv[])
 						  PACKAGE_STRING);
 			return EXIT_SUCCESS;
 		case 'x':
-			ctl.decode = 1;
+			ctl.decode |= 1;
 			break;
 		case '?':
 		default:

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
