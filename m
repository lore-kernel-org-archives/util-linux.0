Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:52391 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756355Ab2F0Vd1 convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 27 Jun 2012 17:33:27 -0400
Received: by wgbdr13 with SMTP id dr13so1502980wgb.1
        for <util-linux@vger.kernel.org>; Wed, 27 Jun 2012 14:33:25 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Wed, 27 Jun 2012 23:33:25 +0200
Message-ID: <CAG27Bk3xh7nAhvktOR45drKcKBgaCTtFqduOyvWz5arTGegCBA@mail.gmail.com>
Subject: [pull] /run directory and swapon
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

Now when the non-recursive build is merged I can send few patches I
build on top of them which are the first five of the lot.  Goal of the
patches is to move /var/run to /run, and allow package builder to use
--localstatedir=/distribution/run if the /run default is not suitable.
For more information why the directory default was changed see

http://lists.fedoraproject.org/pipermail/devel/2011-March/150031.html

Last two patches are coincidentally in this pull request.  The first one
will add UL table functions to swapon, and second makes size easy to
read by default.

Third one will make --summary output to match exactly what it used to
be before accidental format change causing header alignment to wobble
slightly.  I also made white spaces to match old format, although I do
not think anyone would have ever notice they changed as well.


The following changes since commit 59114ba325e02995414e8ec6f38e45a3634af953:

  swapon: fix typo (2012-06-27 14:04:03 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git varrun-swapon

for you to fetch changes up to c8867c03df3ce9cdd718de7eb9666c71bbb19e12:

  swapon: fix --summary output regression (2012-06-27 23:28:48 +0200)

----------------------------------------------------------------
Sami Kerola (8):
      build-sys: change --localstatedir to /run
      libuuid: use run configured state directory
      agetty: use configured run state directory
      uuidd: use configured run state directory in manual etc
      libuuid: make pseudo random file save path configurable
      swapon: add --show option
      swapon: make --show size to be human readable by default
      swapon: fix --summary output regression

 configure.ac                                 |  25 ++++
 include/pathnames.h                          |   1 +
 libuuid/src/uuidP.h                          |   4 +-
 libuuid/src/uuidd.h                          |   4 +-
 misc-utils/.gitignore                        |   3 +
 misc-utils/Makemodule.am                     |  10 +-
 misc-utils/{uuidd.8 => uuidd.8.in}           |   4 +-
 misc-utils/{uuidd.rc => uuidd.rc.in}         |   2 +-
 misc-utils/{uuidd.socket => uuidd.socket.in} |   2 +-
 sys-utils/swapon.8                           |  21 +++
 sys-utils/swapon.c                           | 205 ++++++++++++++++++++++++++-
 term-utils/agetty.c                          |   3 +-
 12 files changed, 272 insertions(+), 12 deletions(-)
 rename misc-utils/{uuidd.8 => uuidd.8.in} (94%)
 rename misc-utils/{uuidd.rc => uuidd.rc.in} (98%)
 rename misc-utils/{uuidd.socket => uuidd.socket.in} (68%)

diff --git a/configure.ac b/configure.ac
index 37d5fa4..4c2dd9a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -60,6 +60,24 @@ NONE:NONE | NONE:/usr | /usr:*)
   esac ;;
 esac

+case $prefix:$localstatedir in
+  NONE:'${prefix}/var')
+    localstatedir=/run
+    AC_MSG_NOTICE([  --localstatedir defaults to /run])
+    ;;
+  *:'${prefix}/var')
+    localstatedir=${prefix}/run
+    ;;
+  NONE:*)
+    ;;
+  *:*)
+    localstatedir=${prefix}/${localstatedir}
+    ;;
+esac
+AC_DEFINE_UNQUOTED([_PATH_LOCALSTATEDIR],
+		   "$localstatedir",
+		   [location for the storage of transient run state files])
+
 libdirname=`basename "$libdir"`
 AC_SUBST([libdirname])

@@ -1293,6 +1311,13 @@ LIBS=""

 AC_CONFIG_HEADERS(config.h)

+AC_SUBST([localstatedir])
+AC_CONFIG_FILES([
+misc-utils/uuidd.8
+misc-utils/uuidd.rc
+misc-utils/uuidd.socket
+])
+
 AC_CONFIG_FILES([
 Makefile
 libblkid/blkid.pc
diff --git a/include/pathnames.h b/include/pathnames.h
index ba8de01..d0ed7a1 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -63,6 +63,7 @@

 /* used in term-utils/agetty.c */
 #define _PATH_ISSUE		"/etc/issue"
+#define _PATH_NUMLOCK_ON	_PATH_LOCALSTATEDIR "/numlock-on"

 #define _PATH_LOGINDEFS		"/etc/login.defs"

diff --git a/libuuid/src/uuidP.h b/libuuid/src/uuidP.h
index 86a5e26..8de35c6 100644
--- a/libuuid/src/uuidP.h
+++ b/libuuid/src/uuidP.h
@@ -36,8 +36,10 @@
 #include <sys/types.h>

 #include "uuid.h"
+#include "uuidd.h"

-#define LIBUUID_CLOCK_FILE	"/var/lib/libuuid/clock.txt"
+/* contains pseudorandom value saved by get_clock() */
+#define LIBUUID_CLOCK_FILE UUIDD_DIR "/clock.txt"

 /*
  * Offset between 15-Oct-1582 and 1-Jan-70
diff --git a/libuuid/src/uuidd.h b/libuuid/src/uuidd.h
index ff7e6d7..3a907d4 100644
--- a/libuuid/src/uuidd.h
+++ b/libuuid/src/uuidd.h
@@ -35,7 +35,9 @@
 #ifndef _UUID_UUIDD_H
 #define _UUID_UUIDD_H

-#define UUIDD_DIR		"/run/uuidd"
+#include "config.h"
+
+#define UUIDD_DIR		_PATH_LOCALSTATEDIR "/uuidd"
 #define UUIDD_SOCKET_PATH	UUIDD_DIR "/request"
 #define UUIDD_PIDFILE_PATH	UUIDD_DIR "/uuidd.pid"
 #define UUIDD_PATH		"/usr/sbin/uuidd"
diff --git a/misc-utils/.gitignore b/misc-utils/.gitignore
index 37a4790..db148ba 100644
--- a/misc-utils/.gitignore
+++ b/misc-utils/.gitignore
@@ -1 +1,4 @@
+uuidd.8
+uuidd.rc
 uuidd.service
+uuidd.socket
diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index fa854b1..def03d7 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -108,11 +108,15 @@ endif
 endif # BUILD_UUIDD

 EXTRA_DIST += \
-	misc-utils/uuidd.rc \
+	misc-utils/uuidd.8.in \
+	misc-utils/uuidd.rc.in \
 	misc-utils/uuidd.service.in \
+	misc-utils/uuidd.socket.in
+CLEANFILES += \
+	misc-utils/uuidd.8 \
+	misc-utils/uuidd.rc \
+	misc-utils/uuidd.service \
 	misc-utils/uuidd.socket
-CLEANFILES += misc-utils/uuidd.service
-

 if BUILD_LIBBLKID
 sbin_PROGRAMS += blkid
diff --git a/misc-utils/uuidd.8 b/misc-utils/uuidd.8.in
similarity index 94%
rename from misc-utils/uuidd.8
rename to misc-utils/uuidd.8.in
index 90763f7..f35a41e 100644
--- a/misc-utils/uuidd.8
+++ b/misc-utils/uuidd.8.in
@@ -34,7 +34,7 @@ UUIDs.
 .TP
 .BR \-p , " \-\-pid " \fIpath\fR
 Specify the pathname where the pid file should be written.  By default,
-the pid file is written to /var/run/uuidd/uuidd.pid.
+the pid file is written to @localstatedir@/uuidd/uuidd.pid.
 .TP
 .BR \-P , " \-\-no-pid "
 Do not create pid file.
@@ -57,7 +57,7 @@ request it to return a random-based UUID.
 .TP
 .BR \-s , " \-\-socket " \fIpath\fR
 Specify the pathname used for the unix-domain socket used by uuidd.  By
-default, the pathname used is /var/run/uuidd/request.  This is primarily
+default, the pathname used is @localstatedir@/uuidd/request.  This is primarily
 for debugging purposes, since the pathname is hard-coded in the libuuid
 library.
 .TP
diff --git a/misc-utils/uuidd.rc b/misc-utils/uuidd.rc.in
similarity index 98%
rename from misc-utils/uuidd.rc
rename to misc-utils/uuidd.rc.in
index d10fced..27b75c6 100644
--- a/misc-utils/uuidd.rc
+++ b/misc-utils/uuidd.rc.in
@@ -22,7 +22,7 @@ PATH=/bin:/usr/bin:/sbin:/usr/sbin
 DAEMON=/usr/sbin/uuidd
 UUIDD_USER=uuidd
 UUIDD_GROUP=uuidd
-UUIDD_DIR=/var/run/uuidd
+UUIDD_DIR=@localstatedir@/uuidd
 PIDFILE=$UUIDD_DIR/uuidd.pid

 test -x $DAEMON || exit 0
diff --git a/misc-utils/uuidd.socket b/misc-utils/uuidd.socket.in
similarity index 68%
rename from misc-utils/uuidd.socket
rename to misc-utils/uuidd.socket.in
index 4eba789..d8be72f 100644
--- a/misc-utils/uuidd.socket
+++ b/misc-utils/uuidd.socket.in
@@ -2,7 +2,7 @@
 Description=UUID daemon activation socket

 [Socket]
-ListenStream=/var/run/uuidd/request
+ListenStream=@localstatedir@/uuidd/request

 [Install]
 WantedBy=sockets.target
diff --git a/sys-utils/swapon.8 b/sys-utils/swapon.8
index ee6a2fc..ed4df55 100644
--- a/sys-utils/swapon.8
+++ b/sys-utils/swapon.8
@@ -164,6 +164,27 @@ for use with
 Display swap usage summary by device. Equivalent to "cat /proc/swaps".
 Not available before Linux 2.1.25.
 .TP
+\fB\-\-show\fR [\fIcolumn,column\fR]
+Display definable device table similar to
+.B \-\-summary
+output.  See \-\-help output for
+.I column
+list.
+.TP
+.B \-\-noheadings
+Do not print headings when displaying
+.B \-\-show
+output.
+.TP
+.B \-\-raw
+Display
+.B \-\-show
+output without aligning table columns.
+.TP
+.B \-\-inhuman
+Display swap size in bytes in
+.B \-\-show
+output instead of user friendly size and unit.
 .B "\-U \fIuuid\fP"
 Use the partition that has the specified
 .IR uuid .
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 7358b4f..c786ed9 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -1,3 +1,4 @@
+#include <assert.h>
 #include <stdlib.h>
 #include <stdio.h>
 #include <getopt.h>
@@ -23,6 +24,8 @@

 #include "swapheader.h"
 #include "swapon-common.h"
+#include "strutils.h"
+#include "tt.h"

 #define PATH_MKSWAP	"/sbin/mkswap"

@@ -74,6 +77,109 @@ static int ifexists;
 static int fixpgsz;
 static int verbose;

+/* column names */
+struct colinfo {
+        const char *name; /* header */
+        double     whint; /* width hint (N < 1 is in percent of termwidth) */
+        int        flags; /* TT_FL_* */
+        const char *help;
+};
+enum { COL_PATH, COL_TYPE, COL_SIZE, COL_USED, COL_PRIO };
+struct colinfo infos[] = {
+	[COL_PATH]     = { "NAME",	0.20, 0, N_("device file or partition path") },
+	[COL_TYPE]     = { "TYPE",	0.20, TT_FL_TRUNC, N_("type of the device")},
+	[COL_SIZE]     = { "SIZE",	0.20, TT_FL_RIGHT, N_("size of the device")},
+	[COL_USED]     = { "USED",	0.20, TT_FL_RIGHT, N_("bytes in use")},
+	[COL_PRIO]     = { "PRIO",	0.20, TT_FL_RIGHT, N_("device priority")},
+};
+#define NCOLS ARRAY_SIZE(infos)
+static int columns[NCOLS], ncolumns;
+
+static void disable_columns_truncate(void)
+{
+	size_t i;
+
+	for (i = 0; i < NCOLS; i++)
+		infos[i].flags &= ~TT_FL_TRUNC;
+}
+
+static int column_name_to_id(const char *name, size_t namesz)
+{
+	size_t i;
+
+	assert(name);
+
+	for (i = 0; i < NCOLS; i++) {
+		const char *cn = infos[i].name;
+
+		if (!strncasecmp(name, cn, namesz) && !*(cn + namesz))
+			return i;
+	}
+	warnx(_("unknown column: %s"), name);
+	return -1;
+}
+
+static inline int get_column_id(int num)
+{
+	assert(ARRAY_SIZE(columns) == NCOLS);
+	assert(num < ncolumns);
+	assert(columns[num] < (int)NCOLS);
+
+	return columns[num];
+}
+
+static inline struct colinfo *get_column_info(unsigned num)
+{
+	return &infos[get_column_id(num)];
+}
+
+static void add_tt_line(struct tt *tt, struct libmnt_fs *fs, int inhuman)
+{
+	int i;
+	struct tt_line *line;
+
+	assert(tt);
+	assert(fs);
+
+	line = tt_add_line(tt, NULL);
+	if (!line) {
+		warn(_("failed to add line to output"));
+		return;
+	}
+
+	for (i = 0; i < ncolumns; i++) {
+		char *str = NULL;
+		int rc = 0;
+
+		switch (get_column_id(i)) {
+		case COL_PATH:
+			rc = xasprintf(&str, "%s", mnt_fs_get_source(fs));
+			break;
+		case COL_TYPE:
+			rc = xasprintf(&str, "%s", mnt_fs_get_swaptype(fs));
+			break;
+		case COL_SIZE:
+			if (inhuman)
+				rc = xasprintf(&str, "%d", mnt_fs_get_size(fs));
+			else
+				str = size_to_human_string(SIZE_SUFFIX_1LETTER, mnt_fs_get_size(fs));
+			break;
+		case COL_USED:
+			rc = xasprintf(&str, "%d", mnt_fs_get_usedsize(fs));
+			break;
+		case COL_PRIO:
+			rc = xasprintf(&str, "%d", mnt_fs_get_priority(fs));
+			break;
+		default:
+			break;
+		}
+
+		if (rc || str)
+			tt_line_set_data(line, i, str);
+	}
+	return;
+}
+
 static int display_summary(void)
 {
 	struct libmnt_table *st = get_swaps();
@@ -88,7 +194,7 @@ static int display_summary(void)
 		err(EXIT_FAILURE, _("failed to initialize libmount iterator"));

 	if (mnt_table_get_nents(st) > 0)
-		printf(_("%-39s\tType\tSize\tUsed\tPriority\n"), _("Filename"));
+		printf(_("%s\t\t\t\tType\t\tSize\tUsed\tPriority\n"), _("Filename"));

 	while (mnt_table_next_fs(st, itr, &fs) == 0) {
 		printf("%-39s\t%s\t%jd\t%jd\t%d\n",
@@ -103,6 +209,49 @@ static int display_summary(void)
 	return 0;
 }

+static int show_table(int tt_flags, int inhuman)
+{
+	struct libmnt_table *st = get_swaps();
+	struct libmnt_iter *itr;
+	struct libmnt_fs *fs;
+
+	int i, rc = 0;
+	struct list_head *p, *pnext;
+	struct tt *tt;
+
+	if (!st)
+		return -1;
+
+	itr = mnt_new_iter(MNT_ITER_FORWARD);
+	if (!itr)
+		err(EXIT_FAILURE, _("failed to initialize libmount iterator"));
+
+	tt = tt_new_table(tt_flags);
+	if (!tt) {
+		warn(_("failed to initialize output table"));
+		return -1;
+	}
+
+	for (i = 0; i < ncolumns; i++) {
+		struct colinfo *col = get_column_info(i);
+
+		if (!tt_define_column(tt, col->name, col->whint, col->flags)) {
+			warnx(_("failed to initialize output column"));
+			rc = -1;
+			goto done;
+		}
+	}
+
+	while (mnt_table_next_fs(st, itr, &fs) == 0)
+		add_tt_line(tt, fs, inhuman);
+
+	mnt_free_iter(itr);
+	tt_print_table(tt);
+ done:
+	tt_free_table(tt);
+	return rc;
+}
+
 /* calls mkswap */
 static int swap_reinitialize(const char *device,
 			     const char *label, const char *uuid)
@@ -505,6 +654,10 @@ static void __attribute__ ((__noreturn__))
usage(FILE * out)
 		" -f, --fixpgsz          reinitialize the swap space if necessary\n"
 		" -p, --priority <prio>  specify the priority of the swap device\n"
 		" -s, --summary          display summary about used swap devices and exit\n"
+		"     --show=<columns>   display definable device table\n"
+		"     --noheadings       don't print headings, use with --show\n"
+		"     --raw              use the raw output format, use with --show\n"
+		"     --inhuman          display swap size in bytes in --show output\n"
 		" -v, --verbose          verbose mode\n"), out);

 	fputs(USAGE_SEPARATOR, out);
@@ -521,6 +674,10 @@ static void __attribute__ ((__noreturn__))
usage(FILE * out)
 		" <device>               name of device to be used\n"
 		" <file>                 name of file to be used\n"), out);

+	fputs(_("\nAvailable columns (for --show):\n"), out);
+	for (size_t i = 0; i < NCOLS; i++)
+		fprintf(out, " %11s  %s\n", infos[i].name, _(infos[i].help));
+
 	fprintf(out, USAGE_MAN_TAIL("swapon(8)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -528,8 +685,17 @@ static void __attribute__ ((__noreturn__))
usage(FILE * out)
 int main(int argc, char *argv[])
 {
 	int status = 0, c;
+	int show = 0, tt_flags = 0;
+	int inhuman = 0;
 	size_t i;

+	enum {
+		SHOW_OPTION = CHAR_MAX + 1,
+		RAW_OPTION,
+		NOHEADINGS_OPTION,
+		INHUMAN_OPTION
+	};
+
 	static const struct option long_opts[] = {
 		{ "priority", 1, 0, 'p' },
 		{ "discard",  0, 0, 'd' },
@@ -540,6 +706,10 @@ int main(int argc, char *argv[])
 		{ "help",     0, 0, 'h' },
 		{ "verbose",  0, 0, 'v' },
 		{ "version",  0, 0, 'V' },
+		{ "show",     2, 0, SHOW_OPTION },
+		{ "noheadings", 0, 0, NOHEADINGS_OPTION },
+		{ "raw",      0, 0, RAW_OPTION },
+		{ "inhuman",  0, 0, INHUMAN_OPTION },
 		{ NULL, 0, 0, 0 }
 	};

@@ -584,6 +754,26 @@ int main(int argc, char *argv[])
 		case 'v':		/* be chatty */
 			++verbose;
 			break;
+		case SHOW_OPTION:
+			if (optarg) {
+				ncolumns = string_to_idarray(optarg,
+							     columns,
+							     ARRAY_SIZE(columns),
+							     column_name_to_id);
+				if (ncolumns < 0)
+					return EXIT_FAILURE;
+			}
+			show = 1;
+			break;
+		case NOHEADINGS_OPTION:
+			tt_flags |= TT_FL_NOHEADINGS;
+			break;
+		case RAW_OPTION:
+			tt_flags |= TT_FL_RAW;
+			break;
+		case INHUMAN_OPTION:
+			inhuman = 1;
+			break;
 		case 'V':		/* version */
 			printf(UTIL_LINUX_VERSION);
 			return EXIT_SUCCESS;
@@ -596,6 +786,19 @@ int main(int argc, char *argv[])
 	}
 	argv += optind;

+	if (!ncolumns) {
+		/* default columns */
+		columns[ncolumns++] = COL_PATH;
+		columns[ncolumns++] = COL_TYPE;
+		columns[ncolumns++] = COL_SIZE;
+		columns[ncolumns++] = COL_USED;
+		columns[ncolumns++] = COL_PRIO;
+	}
+	if (show) {
+		status = show_table(tt_flags, inhuman);
+		return status;
+	}
+
 	if (!all && !numof_labels() && !numof_uuids() && *argv == NULL)
 		usage(stderr);

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 7514015..5c445df 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1259,9 +1259,8 @@ static void do_prompt(struct options *op, struct
termios *tp)
 		if (ioctl(STDIN_FILENO, KDGKBLED, &kb) == 0) {
 			char hint[256] = { '\0' };
 			int nl = 0;
-			struct stat st;

-			if (stat("/var/run/numlock-on", &st) == 0)
+			if (access(_PATH_NUMLOCK_ON, F_OK) == 0)
 				nl = 1;

 			if (nl && (kb & 0x02) == 0)

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
