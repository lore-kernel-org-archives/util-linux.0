Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:61580 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757519Ab2FQQaC convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jun 2012 12:30:02 -0400
Received: by wgbdr13 with SMTP id dr13so4793573wgb.1
        for <util-linux@vger.kernel.org>; Sun, 17 Jun 2012 09:30:00 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Sun, 17 Jun 2012 18:30:00 +0200
Message-ID: <CAG27Bk2mmG2JrsSLyGzuLwW=4M5hCY76r++BObc2MmTDghyT-g@mail.gmail.com>
Subject: [pull] exclusive options, compiler warnings and more regression fix
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

First few exclusive_option() patches are reaction to comment 'This is
good idea, I guess we have the same problem on more places...' from
Karel's earlier email.

http://www.spinics.net/lists/util-linux-ng/msg06379.html

Six patches from hexdump to lscpu the patches fix compiler warnings,
and are rather boring.

Second to last patch about more is perhaps most important of this weeks
work.  It fixes 'more' regression, which went unnoticed about month.
In case one made search with more, and reran it by using 'n' interface
command 'more' crashed always.  I'm happy that did not end up to
release.

Final patch makes wrap around issue to go way from 'more'.  There is
still one of such left, which is

fdiskbsdlabel.c:533:3: warning: assuming pointer wraparound does not
occur when comparing P +- C1 with P +- C2 [-Wstrict-overflow]

but quit frankly I am hesitant to touch that code as it is a bit
intertwined.  I also feel it is failure to have to check if a range
overlaps, surely the range check should happen at receiving of data not
just before writing it.  Perhaps someone (Davidlohr any interest to
this task?) will sanitize the fdiskbsdlabel.c, and if not I might
someday.


The following changes since commit 7cfd1b26437acd45f1e2e75c9648afabb8f5b2da:

  partx: use -s option for default output (2012-06-15 13:21:25 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk24

for you to fetch changes up to 327b7c5bfb3761a8125a41e6a059cb6a5ba5cc3d:

  more: fix pointer wrap around compiler warnings (2012-06-17 18:00:00 +0200)

----------------------------------------------------------------
Sami Kerola (24):
      include [optutils]: add exclusive_option() inline function
      partx: use exclusive_option()
      hwclock: use exclusive_option()
      blkid: use exclusive_option()
      findmnt: use exclusive_option()
      lsblk: use exclusive_option()
      chcpu: use exclusive_option()
      losetup: use exclusive_option()
      lscpu: use exclusive_option()
      prlimit: use exclusive_option()
      wdctl: use exclusive_option()
      wdctl: correct manual section reference
      wipefs: use exclusive_option()
      dmesg: use exclusive_option()
      mount: (new) use exclusive_option()
      hexdump: print sensible message when all input file arguments fail
      setarch: disallow unknown command line options
      fsck.cramfs: disallow unknown command line options
      mkfs.cramfs: disallow unknown command line options
      lib/mbsalign: abort() when non-expected case is encountered
      scriptreplay: fix compiler format warning
      lscpu: values in /proc/bus/pci/devices are always unsigned
      more: fix search repetition regression
      more: fix pointer wrap around compiler warnings

 disk-utils/fsck.cramfs.c  |    2 ++
 disk-utils/mkfs.cramfs.c  |    2 ++
 hwclock/hwclock.c         |   66 ++++++++++++++++++++++++++++-----------------
 include/optutils.h        |   19 +++++++++++++
 lib/mbsalign.c            |    2 ++
 misc-utils/blkid.c        |   20 ++++++++------
 misc-utils/findmnt.c      |   38 +++++++++++++++-----------
 misc-utils/lsblk.c        |   32 +++++++++++++---------
 misc-utils/wipefs.c       |   13 ++++++---
 partx/partx.c             |   51 +++++++++++++----------------------
 sys-utils/chcpu.c         |   22 ++++++++++++---
 sys-utils/dmesg.c         |   24 ++++++++++++-----
 sys-utils/losetup.c       |   26 +++++++++++++-----
 sys-utils/lscpu.c         |   31 ++++++++++++++-------
 sys-utils/mount.c         |   35 +++++++++++++++++++-----
 sys-utils/prlimit.c       |   16 ++++++-----
 sys-utils/setarch.c       |    7 ++++-
 sys-utils/wdctl.c         |   15 ++++++++---
 term-utils/scriptreplay.c |    3 +--
 text-utils/display.c      |    5 ++++
 text-utils/more.c         |   22 ++++++++++-----
 21 files changed, 303 insertions(+), 148 deletions(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 9d7256c..eab4ed5 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -671,6 +671,8 @@ int main(int argc, char **argv)
 		case 'v':
 			opt_verbose++;
 			break;
+		default:
+			usage(FSCK_EX_USAGE);
 		}

 	if ((argc - optind) != 1)
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 9e8f77f..37c4da1 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -769,6 +769,8 @@ int main(int argc, char **argv)
 		case 'z':
 			opt_holes = 1;
 			break;
+		default:
+			usage(FSCK_EX_USAGE);
 		}
 	}

diff --git a/hwclock/hwclock.c b/hwclock/hwclock.c
index bf1b4be..10ef8da 100644
--- a/hwclock/hwclock.c
+++ b/hwclock/hwclock.c
@@ -70,13 +70,17 @@
 #include <time.h>
 #include <unistd.h>

+#define OPTUTILS_EXIT_CODE EX_USAGE
+
 #include "c.h"
 #include "clock.h"
 #include "closestream.h"
 #include "nls.h"
+#include "optutils.h"
 #include "pathnames.h"
 #include "strutils.h"

+#define EXCL_ERROR
"--{adjust,getepoch,hctosys,predict,set,setepoch,show,systohc,systz}"
 #ifdef HAVE_LIBAUDIT
 #include <libaudit.h>
 static int hwaudit_fd = -1;
@@ -1448,6 +1452,29 @@ int main(int argc, char **argv)
 	bool permitted;		/* User is permitted to do the function */
 	int rc, c;

+	enum {
+		EXCL_NONE,
+
+		EXCL_ADJFILE,
+		EXCL_NO_AJDFILE,
+
+		EXCL_LOCALTIME,
+		EXCL_UTC,
+
+		EXCL_ADJUST,
+		EXCL_GETEPOCH,
+		EXCL_HCTOSYS,
+		EXCL_PREDICT,
+		EXCL_SET,
+		EXCL_SETEPOCH,
+		EXCL_SHOW,
+		EXCL_SYSTOHC,
+		EXCL_SYSTZ
+	};
+	int excl_adj = EXCL_NONE;
+	int excl_utc_local = EXCL_NONE;
+	int excl_action = EXCL_NONE;
+
 	/* Variables set by various options; show may also be set later */
 	/* The options debug, badyear and epoch_option are global */
 	bool show, set, systohc, hctosys, systz, adjust, getepoch, setepoch,
@@ -1542,18 +1569,23 @@ int main(int argc, char **argv)
 			break;
 		case 'a':
 			adjust = TRUE;
+			exclusive_option(&excl_action, EXCL_ADJUST, EXCL_ERROR);
 			break;
 		case 'r':
 			show = TRUE;
+			exclusive_option(&excl_action, EXCL_SHOW, EXCL_ERROR);
 			break;
 		case 's':
 			hctosys = TRUE;
+			exclusive_option(&excl_action, EXCL_HCTOSYS, EXCL_ERROR);
 			break;
 		case 'u':
 			utc = TRUE;
+			exclusive_option(&excl_utc_local, EXCL_UTC, "--{utc,localtime}");
 			break;
 		case 'w':
 			systohc = TRUE;
+			exclusive_option(&excl_action, EXCL_SYSTOHC, EXCL_ERROR);
 			break;
 #ifdef __alpha__
 		case 'A':
@@ -1571,20 +1603,25 @@ int main(int argc, char **argv)
 #endif
 		case OPT_SET:
 			set = TRUE;
+			exclusive_option(&excl_action, EXCL_SET, EXCL_ERROR);
 			break;
 #ifdef __linux__
 		case OPT_GETEPOCH:
 			getepoch = TRUE;
+			exclusive_option(&excl_action, EXCL_GETEPOCH, EXCL_ERROR);
 			break;
 		case OPT_SETEPOCH:
 			setepoch = TRUE;
+			exclusive_option(&excl_action, EXCL_SETEPOCH, EXCL_ERROR);
 			break;
 #endif
 		case OPT_NOADJFILE:
 			noadjfile = TRUE;
+			exclusive_option(&excl_adj, EXCL_NO_AJDFILE, "--{adjfile,noadjfile}");
 			break;
 		case OPT_LOCALTIME:
 			local_opt = TRUE;	/* --localtime */
+			exclusive_option(&excl_utc_local, EXCL_LOCALTIME, "--{utc,localtime}");
 			break;
 		case OPT_BADYEAR:
 			badyear = TRUE;
@@ -1604,12 +1641,15 @@ int main(int argc, char **argv)
 			break;
 		case OPT_ADJFILE:
 			adj_file_name = optarg;	/* --adjfile */
+			exclusive_option(&excl_adj, EXCL_ADJFILE, "--{adjfile,noadjfile}");
 			break;
 		case OPT_SYSTZ:
 			systz = TRUE;		/* --systz */
+			exclusive_option(&excl_action, EXCL_SYSTZ, EXCL_ERROR);
 			break;
 		case OPT_PREDICT_HC:
 			predict = TRUE;		/* --predict-hc */
+			exclusive_option(&excl_action, EXCL_PREDICT, EXCL_ERROR);
 			break;
 #ifdef __linux__
 		case 'f':
@@ -1644,34 +1684,10 @@ int main(int argc, char **argv)
 		      argc);
 	}

-	if (show + set + systohc + hctosys + systz + adjust + getepoch
-	    + setepoch + predict > 1) {
-		warnx(_("You have specified multiple functions.\n"
-			"You can only perform one function at a time."));
-		hwclock_exit(EX_USAGE);
-	}
-
-	if (utc && local_opt) {
-		warnx(_("The --utc and --localtime options "
-			"are mutually exclusive.  You specified both."));
-		hwclock_exit(EX_USAGE);
-	}
-
-	if (adjust && noadjfile) {
-		warnx(_("The --adjust and --noadjfile options "
-			"are mutually exclusive.  You specified both."));
-		hwclock_exit(EX_USAGE);
-	}
-
-	if (adj_file_name && noadjfile) {
-		warnx(_("The --adjfile and --noadjfile options "
-			"are mutually exclusive.  You specified both."));
-		hwclock_exit(EX_USAGE);
-	}
 	if (!adj_file_name)
 		adj_file_name = _PATH_ADJPATH;

-	if (noadjfile && !(utc || local_opt)) {
+	if (noadjfile && !excl_utc_local) {
 		warnx(_("With --noadjfile, you must specify "
 			"either --utc or --localtime"));
 		hwclock_exit(EX_USAGE);
diff --git a/include/optutils.h b/include/optutils.h
index f66d669..fae28fd 100644
--- a/include/optutils.h
+++ b/include/optutils.h
@@ -1,6 +1,9 @@
 #ifndef UTIL_LINUX_OPTUTILS_H
 #define UTIL_LINUX_OPTUTILS_H

+#include "c.h"
+#include "nls.h"
+
 static inline const char *option_to_longopt(int c, const struct option *opts)
 {
 	const struct option *o;
@@ -11,5 +14,21 @@ static inline const char *option_to_longopt(int c,
const struct option *opts)
 	return NULL;
 }

+#ifndef OPTUTILS_EXIT_CODE
+# define OPTUTILS_EXIT_CODE EXIT_FAILURE
+#endif
+static inline void exclusive_option(int *what, const int how,
+				    const char *errmesg)
+{
+	if (*what == 0) {
+		*what = how;
+		return;
+	}
+	if (*what == how)
+		return;
+	errx(OPTUTILS_EXIT_CODE,
+	     _("options %s are mutually exclusive"), errmesg);
+}
+
 #endif

diff --git a/lib/mbsalign.c b/lib/mbsalign.c
index 468e35b..d97bbd5 100644
--- a/lib/mbsalign.c
+++ b/lib/mbsalign.c
@@ -271,6 +271,8 @@ mbsalign_unibyte:
           start_spaces = n_spaces;
           end_spaces = 0;
           break;
+	default:
+	  abort();
         }

       dest = mbs_align_pad (dest, dest_end, start_spaces);
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 840cfe4..579ad27 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -44,6 +44,9 @@ extern int optind;

 #define STRTOXX_EXIT_CODE	BLKID_EXIT_OTHER	/* strtoxx_or_err() */
 #include "strutils.h"
+#define OPTUTILS_EXIT_CODE	BLKID_EXIT_OTHER	/* exclusive_option() */
+#include "optutils.h"
+
 #include "closestream.h"
 #include "ttyutils.h"

@@ -672,6 +675,13 @@ int main(int argc, char **argv)
 	int c;
 	uintmax_t offset = 0, size = 0;

+	enum {
+		EXCL_NONE,
+		EXCL_NAMES,
+		EXCL_USAGE
+	};
+	int excl_opt = EXCL_NONE;
+
 	show[0] = NULL;
 	atexit(close_stdout);

@@ -692,17 +702,11 @@ int main(int argc, char **argv)
 			search_type = strdup("LABEL");
 			break;
 		case 'n':
-			if (fltr_usage) {
-				fprintf(stderr, "error: -u and -n options are mutually exclusive\n");
-				exit(BLKID_EXIT_OTHER);
-			}
+			exclusive_option(&excl_opt, EXCL_NAMES, "-{u,n}");
 			fltr_type = list_to_types(optarg, &fltr_flag);
 			break;
 		case 'u':
-			if (fltr_type) {
-				fprintf(stderr, "error: -u and -n options are mutually exclusive\n");
-				exit(BLKID_EXIT_OTHER);
-			}
+			exclusive_option(&excl_opt, EXCL_USAGE, "-{u,n}");
 			fltr_usage = list_to_usage(optarg, &fltr_flag);
 			break;
 		case 'U':
diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index eab224a..c4cebf8 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -42,6 +42,7 @@
 #include "tt.h"
 #include "strutils.h"
 #include "xalloc.h"
+#include "optutils.h"

 /* flags */
 enum {
@@ -1010,12 +1011,6 @@ static void __attribute__((__noreturn__))
usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }

-static void __attribute__((__noreturn__))
-errx_mutually_exclusive(const char *opts)
-{
-	errx(EXIT_FAILURE, "%s %s", opts, _("options are mutually exclusive"));
-}
-
 int main(int argc, char *argv[])
 {
 	struct libmnt_table *tb = NULL;
@@ -1024,6 +1019,20 @@ int main(int argc, char *argv[])
 	int i, c, rc = -1, timeout = -1;
 	int ntabfiles = 0, tabtype = 0;

+	enum {
+		EXCL_NONE,
+
+		EXCL_FSTAB,
+		EXCL_KERNEL,
+		EXCL_MTAB,
+
+		EXCL_RAW,
+		EXCL_LIST,
+		EXCL_PAIRS
+	};
+	int excl_fmk = EXCL_NONE;
+	int excl_rlP = EXCL_NONE;
+
 	/* table.h */
 	struct tt *tt = NULL;

@@ -1136,37 +1145,34 @@ int main(int argc, char *argv[])
 			tt_flags &= ~TT_FL_TREE;
 			break;
 		case 'P':
+			exclusive_option(&excl_rlP, EXCL_PAIRS, "--{raw,list,pairs}");
 			tt_flags |= TT_FL_EXPORT;
 			tt_flags &= ~TT_FL_TREE;
 			break;
 		case 'm':		/* mtab */
-			if (tabtype)
-				errx_mutually_exclusive("--{fstab,mtab,kernel}");
+			exclusive_option(&excl_fmk, EXCL_MTAB, "--{fstab,mtab,kernel}");
 			tabtype = TABTYPE_MTAB;
 			tt_flags &= ~TT_FL_TREE;
 			break;
 		case 's':		/* fstab */
-			if (tabtype)
-				errx_mutually_exclusive("--{fstab,mtab,kernel}");
+			exclusive_option(&excl_fmk, EXCL_FSTAB, "--{fstab,mtab,kernel}");
 			tabtype = TABTYPE_FSTAB;
 			tt_flags &= ~TT_FL_TREE;
 			break;
 		case 'k':		/* kernel (mountinfo) */
-			if (tabtype)
-				 errx_mutually_exclusive("--{fstab,mtab,kernel}");
+			exclusive_option(&excl_fmk, EXCL_KERNEL, "--{fstab,mtab,kernel}");
 			tabtype = TABTYPE_KERNEL;
 			break;
 		case 't':
 			set_match(COL_FSTYPE, optarg);
 			break;
 		case 'r':
+			exclusive_option(&excl_rlP, EXCL_RAW, "--{raw,list,pairs}");
 			tt_flags &= ~TT_FL_TREE;	/* disable the default */
 			tt_flags |= TT_FL_RAW;		/* enable raw */
 			break;
 		case 'l':
-			if ((tt_flags & TT_FL_RAW) && (tt_flags & TT_FL_EXPORT))
-				errx_mutually_exclusive("--{raw,list,pairs}");
-
+			exclusive_option(&excl_rlP, EXCL_LIST, "--{raw,list,pairs}");
 			tt_flags &= ~TT_FL_TREE; /* disable the default */
 			break;
 		case 'n':
@@ -1224,7 +1230,7 @@ int main(int argc, char *argv[])

 	if (flags & FL_POLL) {
 		if (tabtype != TABTYPE_KERNEL)
-			errx_mutually_exclusive("--{poll,fstab,mtab}");
+			exclusive_option(&tabtype, tabtype + 1, "--{poll,fstab,mtab}");
 		if (ntabfiles > 1)
 			errx(EXIT_FAILURE, _("--poll accepts only one file, but more
specified by --tab-file"));
 	}
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 24fb44f..ec1ca37 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -60,6 +60,7 @@
 #include "sysfs.h"
 #include "closestream.h"
 #include "mangle.h"
+#include "optutils.h"

 /* column IDs */
 enum {
@@ -1140,12 +1141,6 @@ static void __attribute__((__noreturn__)) help(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }

-static void __attribute__((__noreturn__))
-errx_mutually_exclusive(const char *opts)
-{
-	errx(EXIT_FAILURE, "%s %s", opts, _("options are mutually exclusive"));
-}
-
 static void check_sysdevblock(void)
 {
 	if (access(_PATH_SYS_DEVBLOCK, R_OK) != 0)
@@ -1159,6 +1154,19 @@ int main(int argc, char *argv[])
 	int tt_flags = TT_FL_TREE;
 	int i, c, status = EXIT_FAILURE;

+	enum {
+		EXCL_NONE,
+
+		EXCL_RAW,
+		EXCL_LIST,
+		EXCL_PAIRS,
+
+		EXCL_ALL,
+		EXCL_EXCLUDE
+	};
+	int excl_rlP = EXCL_NONE;
+	int excl_ae = EXCL_NONE;
+
 	static const struct option longopts[] = {
 		{ "all",	0, 0, 'a' },
 		{ "bytes",      0, 0, 'b' },
@@ -1191,6 +1199,7 @@ int main(int argc, char *argv[])
 	while((c = getopt_long(argc, argv, "abdDe:fhlnmo:PirstV", longopts,
NULL)) != -1) {
 		switch(c) {
 		case 'a':
+			exclusive_option(&excl_ae, EXCL_ALL, "--{all,exclude}");
 			lsblk->all_devices = 1;
 			break;
 		case 'b':
@@ -1207,15 +1216,14 @@ int main(int argc, char *argv[])
 			columns[ncolumns++] = COL_DZERO;
 			break;
 		case 'e':
+			exclusive_option(&excl_ae, EXCL_EXCLUDE, "--{all,exclude}");
 			parse_excludes(optarg);
 			break;
 		case 'h':
 			help(stdout);
 			break;
 		case 'l':
-			if ((tt_flags & TT_FL_RAW)|| (tt_flags & TT_FL_EXPORT))
-				errx_mutually_exclusive("--{raw,list,export}");
-
+			exclusive_option(&excl_rlP, EXCL_LIST, "--{raw,list,pairs}");
 			tt_flags &= ~TT_FL_TREE; /* disable the default */
 			break;
 		case 'n':
@@ -1229,6 +1237,7 @@ int main(int argc, char *argv[])
 				return EXIT_FAILURE;
 			break;
 		case 'P':
+			exclusive_option(&excl_rlP, EXCL_PAIRS, "--{raw,list,pairs}");
 			tt_flags |= TT_FL_EXPORT;
 			tt_flags &= ~TT_FL_TREE;	/* disable the default */
 			break;
@@ -1236,6 +1245,7 @@ int main(int argc, char *argv[])
 			tt_flags |= TT_FL_ASCII;
 			break;
 		case 'r':
+			exclusive_option(&excl_rlP, EXCL_RAW, "--{raw,list,pairs}");
 			tt_flags &= ~TT_FL_TREE;	/* disable the default */
 			tt_flags |= TT_FL_RAW;		/* enable raw */
 			break;
@@ -1288,9 +1298,7 @@ int main(int argc, char *argv[])
 		columns[ncolumns++] = COL_TARGET;
 	}

-	if (nexcludes && lsblk->all_devices)
-		errx_mutually_exclusive("--{all,exclude}");
-	else if (!nexcludes)
+	if (!nexcludes)
 		excludes[nexcludes++] = 1;	/* default: ignore RAM disks */

 	mnt_init_debug(0);
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index 259ca37..f10b5ee 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -39,6 +39,7 @@
 #include "match.h"
 #include "c.h"
 #include "closestream.h"
+#include "optutils.h"

 struct wipe_desc {
 	loff_t		offset;		/* magic string offset */
@@ -382,6 +383,13 @@ main(int argc, char **argv)
 	int c, all = 0, has_offset = 0, noact = 0, quiet = 0;
 	int mode = WP_MODE_PRETTY;

+	enum {
+		EXCL_NONE,
+		EXCL_ALL,
+		EXCL_OFFSET
+	};
+	int excl_any = EXCL_NONE;
+
 	static const struct option longopts[] = {
 	    { "all",       0, 0, 'a' },
 	    { "help",      0, 0, 'h' },
@@ -402,6 +410,7 @@ main(int argc, char **argv)
 	while ((c = getopt_long(argc, argv, "ahno:pqt:V", longopts, NULL)) != -1) {
 		switch(c) {
 		case 'a':
+			exclusive_option(&excl_any, EXCL_ALL, "--{all,offset}");
 			all++;
 			break;
 		case 'h':
@@ -411,6 +420,7 @@ main(int argc, char **argv)
 			noact++;
 			break;
 		case 'o':
+			exclusive_option(&excl_any, EXCL_OFFSET, "--{all,offset}");
 			wp0 = add_offset(wp0, strtosize_or_err(optarg,
 					 _("invalid offset argument")), 1);
 			has_offset++;
@@ -434,9 +444,6 @@ main(int argc, char **argv)
 		}
 	}

-	if (wp0 && all)
-		errx(EXIT_FAILURE, _("--offset and --all are mutually exclusive"));
-
 	if (optind == argc)
 		usage(stderr);

diff --git a/partx/partx.c b/partx/partx.c
index 68246db..fd8e440 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -34,6 +34,7 @@
 #include "loopdev.h"
 #include "at.h"
 #include "closestream.h"
+#include "optutils.h"

 /* this is the default upper limit, could be modified by --nr */
 #define SLICES_MAX	256
@@ -52,8 +53,10 @@ enum {
 	COL_SCHEME,
 };

+#define ACT_ERROR "--{add,delete,show,list,raw,pairs}"
 enum {
-	ACT_LIST = 1,
+	ACT_NONE,
+	ACT_LIST,
 	ACT_SHOW,
 	ACT_ADD,
 	ACT_DELETE
@@ -632,15 +635,9 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }

-static void __attribute__((__noreturn__))
-errx_mutually_exclusive(const char *opts)
-{
-	errx(EXIT_FAILURE, _("the options %s are mutually exclusive"), opts);
-}
-
 int main(int argc, char **argv)
 {
-	int fd, c, what = 0, lower = 0, upper = 0, rc = 0;
+	int fd, c, what = ACT_NONE, lower = 0, upper = 0, rc = 0;
 	int tt_flags = 0;
 	char *type = NULL;
 	char *device = NULL; /* pointer to argv[], ie: /dev/sda1 */
@@ -672,34 +669,21 @@ int main(int argc, char **argv)

 	while ((c = getopt_long(argc, argv,
 				"abdglrsvn:t:o:PhV", long_opts, NULL)) != -1) {
-
 		switch(c) {
 		case 'a':
-		case 'd':
-		case 'l':
-		case 'r':
-		case 'P':
-		case 's':
-			if (what)
-				 errx_mutually_exclusive("--{add,delete,show,list,raw,pairs}");
-			break;
-		}
-
-		switch(c) {
-		case 'a':
-			what = ACT_ADD;
+			exclusive_option(&what, ACT_ADD, ACT_ERROR);
 			break;
 		case 'b':
 			partx_flags |= FL_BYTES;
 			break;
 		case 'd':
-			what = ACT_DELETE;
+			exclusive_option(&what, ACT_DELETE, ACT_ERROR);
 			break;
 		case 'g':
 			tt_flags |= TT_FL_NOHEADINGS;
 			break;
 		case 'l':
-			what = ACT_LIST;
+			exclusive_option(&what, ACT_LIST, ACT_ERROR);
 			break;
 		case 'n':
 			if (parse_range(optarg, &lower, &upper, 0))
@@ -711,17 +695,18 @@ int main(int argc, char **argv)
 						column_name_to_id);
 			if (ncolumns < 0)
 				return EXIT_FAILURE;
+			exclusive_option(&what, ACT_SHOW, ACT_ERROR);
 			break;
 		case 'P':
 			tt_flags |= TT_FL_EXPORT;
-			what = ACT_SHOW;
+			exclusive_option(&what, ACT_SHOW, ACT_ERROR);
 			break;
 		case 'r':
 			tt_flags |= TT_FL_RAW;
-			what = ACT_SHOW;
+			exclusive_option(&what, ACT_SHOW, ACT_ERROR);
 			break;
 		case 's':
-			what = ACT_SHOW;
+			exclusive_option(&what, ACT_SHOW, ACT_ERROR);
 			break;
 		case 't':
 			type = optarg;
@@ -740,11 +725,7 @@ int main(int argc, char **argv)
 		}
 	}

-	/* -o <list> enables --show mode by default */
-	if (ncolumns && !what)
-		what = ACT_SHOW;
-
-	if (!what)
+	if (what == ACT_NONE)
 		what = ACT_SHOW;

 	/* --show default, could by modified by -o  */
@@ -869,7 +850,7 @@ int main(int argc, char **argv)
 			if (lower > upper) {
 				warnx(_("specified range <%d:%d> "
 					"does not make sense"), lower, upper);
-				rc = -1, what = 0;
+				rc = -1, what = ACT_NONE;
 			}

 			switch (what) {
@@ -882,6 +863,10 @@ int main(int argc, char **argv)
 			case ACT_ADD:
 				rc = add_parts(fd, wholedisk, ls, lower, upper);
 				break;
+			case ACT_NONE:
+				break;
+			default:
+				abort();
 			}
 		}
 		blkid_free_probe(pr);
diff --git a/sys-utils/chcpu.c b/sys-utils/chcpu.c
index 1865592..999ea56 100644
--- a/sys-utils/chcpu.c
+++ b/sys-utils/chcpu.c
@@ -41,6 +41,9 @@
 #include "bitops.h"
 #include "path.h"
 #include "closestream.h"
+#include "optutils.h"
+
+#define EXCL_ERROR "--{configure,deconfigure,disable,dispatch,enable}"

 #define _PATH_SYS_CPU		"/sys/devices/system/cpu"
 #define _PATH_SYS_CPU_ONLINE	_PATH_SYS_CPU "/online"
@@ -232,6 +235,16 @@ int main(int argc, char *argv[])
 	int cmd = -1;
 	int c;

+	enum {
+		EXCL_NONE,
+		EXCL_CONFIGURE,
+		EXCL_DECONFIGURE,
+		EXCL_DISABLE,
+		EXCL_DISPATCH,
+		EXCL_ENABLE
+	};
+	int excl_any = EXCL_NONE;
+
 	static const struct option longopts[] = {
 		{ "configure",	required_argument, 0, 'c' },
 		{ "deconfigure",required_argument, 0, 'g' },
@@ -260,30 +273,31 @@ int main(int argc, char *argv[])
 		err(EXIT_FAILURE, _("cpuset_alloc failed"));

 	while ((c = getopt_long(argc, argv, "c:d:e:g:hp:rV", longopts, NULL)) != -1) {
-		if (cmd != -1 && strchr("cdegpr", c))
-			errx(EXIT_FAILURE,
-			     _("configure, deconfigure, disable, dispatch, enable "
-			       "and rescan are mutually exclusive"));
 		switch (c) {
 		case 'c':
+			exclusive_option(&excl_any, EXCL_CONFIGURE, EXCL_ERROR);
 			cmd = CMD_CPU_CONFIGURE;
 			cpu_parse(argv[optind - 1], cpu_set, setsize);
 			break;
 		case 'd':
+			exclusive_option(&excl_any, EXCL_DISABLE, EXCL_ERROR);
 			cmd = CMD_CPU_DISABLE;
 			cpu_parse(argv[optind - 1], cpu_set, setsize);
 			break;
 		case 'e':
+			exclusive_option(&excl_any, EXCL_ENABLE, EXCL_ERROR);
 			cmd = CMD_CPU_ENABLE;
 			cpu_parse(argv[optind - 1], cpu_set, setsize);
 			break;
 		case 'g':
+			exclusive_option(&excl_any, EXCL_DECONFIGURE, EXCL_ERROR);
 			cmd = CMD_CPU_DECONFIGURE;
 			cpu_parse(argv[optind - 1], cpu_set, setsize);
 			break;
 		case 'h':
 			usage(stdout);
 		case 'p':
+			exclusive_option(&excl_any, EXCL_DISPATCH, EXCL_ERROR);
 			if (strcmp("horizontal", argv[optind - 1]) == 0)
 				cmd = CMD_CPU_DISPATCH_HORIZONTAL;
 			else if (strcmp("vertical", argv[optind - 1]) == 0)
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 8549903..9fc7982 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -30,6 +30,7 @@
 #include "all-io.h"
 #include "bitops.h"
 #include "closestream.h"
+#include "optutils.h"

 /* Close the log.  Currently a NOP. */
 #define SYSLOG_ACTION_CLOSE          0
@@ -54,6 +55,8 @@
 /* Return size of the log buffer */
 #define SYSLOG_ACTION_SIZE_BUFFER   10

+#define EXCL_ERROR "--{clear,read-clear,console-level,console-on,console-off}"
+
 /*
  * Priority and facility names
  */
@@ -664,6 +667,16 @@ int main(int argc, char *argv[])
 	int  cmd = -1;
 	static struct dmesg_control ctl;

+	enum {
+		EXCL_NONE,
+		EXCL_CLEAR,
+		EXCL_READ_CLEAR,
+		EXCL_CONSOLE_LEVEL,
+		EXCL_CONSOLE_ON,
+		EXCL_CONSOLE_OFF
+	};
+	int excl_any = EXCL_NONE;
+
 	static const struct option longopts[] = {
 		{ "buffer-size",   required_argument, NULL, 's' },
 		{ "clear",         no_argument,	      NULL, 'C' },
@@ -693,26 +706,24 @@ int main(int argc, char *argv[])

 	while ((c = getopt_long(argc, argv, "CcDdEF:f:hkl:n:rs:TtuVx",
 				longopts, NULL)) != -1) {
-
-		if (cmd != -1 && strchr("CcnDE", c))
-			errx(EXIT_FAILURE, _("clear, read-clear, console-level, "
-			     "console-on, and console-off options are mutually "
-			     "exclusive"));
-
 		switch (c) {
 		case 'C':
+			exclusive_option(&excl_any, EXCL_CLEAR, EXCL_ERROR);
 			cmd = SYSLOG_ACTION_CLEAR;
 			break;
 		case 'c':
+			exclusive_option(&excl_any, EXCL_READ_CLEAR, EXCL_ERROR);
 			cmd = SYSLOG_ACTION_READ_CLEAR;
 			break;
 		case 'D':
+			exclusive_option(&excl_any, EXCL_CONSOLE_OFF, EXCL_ERROR);
 			cmd = SYSLOG_ACTION_CONSOLE_OFF;
 			break;
 		case 'd':
 			ctl.delta = 1;
 			break;
 		case 'E':
+			exclusive_option(&excl_any, EXCL_CONSOLE_ON, EXCL_ERROR);
 			cmd = SYSLOG_ACTION_CONSOLE_ON;
 			break;
 		case 'F':
@@ -738,6 +749,7 @@ int main(int argc, char *argv[])
 				return EXIT_FAILURE;
 			break;
 		case 'n':
+			exclusive_option(&excl_any, EXCL_CONSOLE_LEVEL, EXCL_ERROR);
 			cmd = SYSLOG_ACTION_CONSOLE_LEVEL;
 			console_level = parse_level(optarg, 0);
 			break;
diff --git a/sys-utils/losetup.c b/sys-utils/losetup.c
index 3c32299..bc9e6c6 100644
--- a/sys-utils/losetup.c
+++ b/sys-utils/losetup.c
@@ -20,6 +20,9 @@
 #include "loopdev.h"
 #include "xgetpass.h"
 #include "closestream.h"
+#include "optutils.h"
+
+#define EXCL_ERROR "--{all,associated,set-capacity,detach,detach-all,find}"

 enum {
 	A_CREATE = 1,		/* setup a new device */
@@ -212,6 +215,17 @@ int main(int argc, char **argv)
 	int res = 0, showdev = 0, lo_flags = 0;

 	enum {
+		EXCL_NONE,
+		EXCL_ALL,
+		EXCL_ASSOCIATED,
+		EXCL_SET_CAPACITY,
+		EXCL_DETACH,
+		EXCL_DETACH_ALL,
+		EXCL_FIND
+	};
+	int excl_any = EXCL_NONE;
+
+	enum {
 		OPT_SIZELIMIT = CHAR_MAX + 1,
 		OPT_SHOW
 	};
@@ -245,17 +259,13 @@ int main(int argc, char **argv)

 	while ((c = getopt_long(argc, argv, "ac:d:De:E:fhj:o:p:PrvV",
 				longopts, NULL)) != -1) {
-
-		if (act && strchr("acdDfj", c))
-			errx(EXIT_FAILURE,
-				_("the options %s are mutually exclusive"),
-				"--{all,associated,set-capacity,detach,detach-all,find}");
-
 		switch (c) {
 		case 'a':
+			exclusive_option(&excl_any, EXCL_ALL, EXCL_ERROR);
 			act = A_SHOW;
 			break;
 		case 'c':
+			exclusive_option(&excl_any, EXCL_SET_CAPACITY, EXCL_ERROR);
 			act = A_SET_CAPACITY;
 			loopcxt_set_device(&lc, optarg);
 			break;
@@ -263,10 +273,12 @@ int main(int argc, char **argv)
 			lo_flags |= LO_FLAGS_READ_ONLY;
 			break;
 		case 'd':
+			exclusive_option(&excl_any, EXCL_DETACH, EXCL_ERROR);
 			act = A_DELETE;
 			loopcxt_set_device(&lc, optarg);
 			break;
 		case 'D':
+			exclusive_option(&excl_any, EXCL_DETACH_ALL, EXCL_ERROR);
 			act = A_DELETE_ALL;
 			break;
 		case 'E':
@@ -274,12 +286,14 @@ int main(int argc, char **argv)
 			encryption = optarg;
 			break;
 		case 'f':
+			exclusive_option(&excl_any, EXCL_FIND, EXCL_ERROR);
 			act = A_FIND_FREE;
 			break;
 		case 'h':
 			usage(stdout);
 			break;
 		case 'j':
+			exclusive_option(&excl_any, EXCL_ASSOCIATED, EXCL_ERROR);
 			act = A_SHOW;
 			file = optarg;
 			break;
diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index 1adc92b..bfb1343 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -42,6 +42,7 @@
 #include "tt.h"
 #include "path.h"
 #include "closestream.h"
+#include "optutils.h"

 #define CACHE_MAX 100

@@ -408,7 +409,7 @@ static int
 has_pci_device(int vendor, int device)
 {
 	FILE *f;
-	int num, fn, ven, dev;
+	unsigned int num, fn, ven, dev;
 	int res = 1;

 	f = path_fopen("r", 0, _PATH_PROC_PCIDEVS);
@@ -1242,6 +1243,19 @@ int main(int argc, char *argv[])
 	int c, i;
 	int columns[ARRAY_SIZE(coldescs)], ncolumns = 0;

+	enum {
+		EXCL_NONE,
+
+		EXCL_ALL,
+		EXCL_ONLINE,
+		EXCL_OFFLINE,
+
+		EXCL_EXTENDED,
+		EXCL_PARSE
+	};
+	int excl_ep = EXCL_NONE;
+	int excl_abc = EXCL_NONE;
+
 	static const struct option longopts[] = {
 		{ "all",        no_argument,       0, 'a' },
 		{ "online",     no_argument,       0, 'b' },
@@ -1261,28 +1275,27 @@ int main(int argc, char *argv[])
 	atexit(close_stdout);

 	while ((c = getopt_long(argc, argv, "abce::hp::s:xV", longopts,
NULL)) != -1) {
-
-		if (mod->mode != OUTPUT_SUMMARY && strchr("ep", c))
-			errx(EXIT_FAILURE,
-			     _("extended and parsable formats are mutually exclusive"));
-		if ((mod->online || mod->offline) && strchr("abc", c))
-			errx(EXIT_FAILURE,
-			     _("--all, --online and --offline options are mutually exclusive"));
-
 		switch (c) {
 		case 'a':
+			exclusive_option(&excl_abc, EXCL_ALL, "--{all,online,offline}");
 			mod->online = mod->offline = 1;
 			break;
 		case 'b':
+			exclusive_option(&excl_abc, EXCL_ONLINE, "--{all,online,offline}");
 			mod->online = 1;
 			break;
 		case 'c':
+			exclusive_option(&excl_abc, EXCL_OFFLINE, "--{all,online,offline}");
 			mod->offline = 1;
 			break;
 		case 'h':
 			usage(stdout);
 		case 'p':
+			exclusive_option(&excl_ep, EXCL_PARSE, "--{extended,parse}");
+			goto hop_over;
 		case 'e':
+			exclusive_option(&excl_ep, EXCL_EXTENDED, "--{extended,parse}");
+			hop_over:
 			if (optarg) {
 				if (*optarg == '=')
 					optarg++;
diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 9cc2db3..9116e80 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -34,13 +34,17 @@
 #include "nls.h"
 #include "c.h"
 #include "env.h"
-#include "optutils.h"
 #include "strutils.h"
 #include "xgetpass.h"
 #include "exitcodes.h"
 #include "xalloc.h"
 #include "closestream.h"

+#define OPTUTILS_EXIT_CODE MOUNT_EX_USAGE
+#include "optutils.h"
+
+#define EXCL_ERROR "--{bind,make-*}"
+
 /*** TODO: DOCS:
  *
  *  --guess-fstype	is unsupported
@@ -678,6 +682,20 @@ int main(int argc, char **argv)
 		MOUNT_OPT_RUNBINDABLE
 	};

+	enum {
+	        EXCL_NONE,
+	        EXCL_BIND,
+	        EXCL_MAKE_SHARED,
+	        EXCL_MAKE_SLAVE,
+	        EXCL_MAKE_PRIVATE,
+	        EXCL_MAKE_UNBINDABLE,
+	        EXCL_MAKE_RSHARED,
+	        EXCL_MAKE_RSLAVE,
+	        EXCL_MAKE_RPRIVATE,
+	        EXCL_MAKE_RUNBINDABLE
+	};
+	int excl_any = EXCL_NONE;
+
 	static const struct option longopts[] = {
 		{ "all", 0, 0, 'a' },
 		{ "fake", 0, 0, 'f' },
@@ -806,6 +824,7 @@ int main(int argc, char **argv)
 			mnt_context_enable_sloppy(cxt, TRUE);
 			break;
 		case 'B':
+			exclusive_option(&excl_any, EXCL_BIND, EXCL_ERROR);
 			oper |= MS_BIND;
 			break;
 		case 'M':
@@ -815,27 +834,35 @@ int main(int argc, char **argv)
 			oper |= (MS_BIND | MS_REC);
 			break;
 		case MOUNT_OPT_SHARED:
+			exclusive_option(&excl_any, EXCL_MAKE_SHARED, EXCL_ERROR);
 			oper |= MS_SHARED;
 			break;
 		case MOUNT_OPT_SLAVE:
+			exclusive_option(&excl_any, EXCL_MAKE_SLAVE, EXCL_ERROR);
 			oper |= MS_SLAVE;
 			break;
 		case MOUNT_OPT_PRIVATE:
+			exclusive_option(&excl_any, EXCL_MAKE_PRIVATE, EXCL_ERROR);
 			oper |= MS_PRIVATE;
 			break;
 		case MOUNT_OPT_UNBINDABLE:
+			exclusive_option(&excl_any, EXCL_MAKE_UNBINDABLE, EXCL_ERROR);
 			oper |= MS_UNBINDABLE;
 			break;
 		case MOUNT_OPT_RSHARED:
+			exclusive_option(&excl_any, EXCL_MAKE_RSHARED, EXCL_ERROR);
 			oper |= (MS_SHARED | MS_REC);
 			break;
 		case MOUNT_OPT_RSLAVE:
+			exclusive_option(&excl_any, EXCL_MAKE_RSLAVE, EXCL_ERROR);
 			oper |= (MS_SLAVE | MS_REC);
 			break;
 		case MOUNT_OPT_RPRIVATE:
+			exclusive_option(&excl_any, EXCL_MAKE_RPRIVATE, EXCL_ERROR);
 			oper |= (MS_PRIVATE | MS_REC);
 			break;
 		case MOUNT_OPT_RUNBINDABLE:
+			exclusive_option(&excl_any, EXCL_MAKE_RUNBINDABLE, EXCL_ERROR);
 			oper |= (MS_UNBINDABLE | MS_REC);
 			break;
 		default:
@@ -902,12 +929,6 @@ int main(int argc, char **argv)
 		usage(stderr);

 	if (oper) {
-		if (!is_power_of_2(oper & ~MS_REC))
-			errx(MOUNT_EX_USAGE, _("propagation flags (--make-* or --bind
options) are mutually exclusive"));
-
-		if (oper != MS_BIND && mnt_context_get_options(cxt))
-			errx(MOUNT_EX_USAGE, _("propagation flags (--make-* options)
cannot be mixed with another mount options"));
-
 		/* MS_PROPAGATION operations, let's set the mount flags */
 		mnt_context_set_mflags(cxt, oper);

diff --git a/sys-utils/prlimit.c b/sys-utils/prlimit.c
index 58e189c..cd9a96c 100644
--- a/sys-utils/prlimit.c
+++ b/sys-utils/prlimit.c
@@ -34,6 +34,7 @@
 #include "strutils.h"
 #include "list.h"
 #include "closestream.h"
+#include "optutils.h"

 #ifndef RLIMIT_RTTIME
 # define RLIMIT_RTTIME 15
@@ -483,6 +484,12 @@ int main(int argc, char **argv)
 		RAW_OPTION,
 		NOHEADINGS_OPTION
 	};
+	enum {
+		EXCL_NONE,
+		EXCL_COMMAND,
+		EXCL_PID
+	};
+	int excl_pcom = EXCL_NONE;

 	static const struct option longopts[] = {
 		{ "pid",	required_argument, NULL, 'p' },
@@ -578,9 +585,7 @@ int main(int argc, char **argv)
 			break;

 		case 'p':
-			if (pid) /* we only work one pid at a time */
-				errx(EXIT_FAILURE, _("only use one PID at a time"));
-
+			exclusive_option(&excl_pcom, EXCL_PID + optind, _("--pid and --pid"));
 			pid = strtos32_or_err(optarg, _("invalid PID argument"));
 			break;
 		case 'h':
@@ -611,9 +616,8 @@ int main(int argc, char **argv)
 		}
 	}
 	if (argc > optind && pid)
-		errx(EXIT_FAILURE,
-			_("--pid option and COMMAND are mutually exclusive"));
-
+		exclusive_option(&excl_pcom, EXCL_COMMAND,
+				 _("--pid and COMMAND"));
 	if (!ncolumns) {
 		/* default columns */
 		columns[ncolumns++] = COL_RES;
diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index a0c6ea8..f2315a6 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -122,7 +122,10 @@ show_help(void)
 static void __attribute__((__noreturn__))
 show_usage(const char *s)
 {
-  errx(EXIT_FAILURE, _("%s\nTry `%s --help' for more information."),
s, program_invocation_short_name);
+  if (s)
+    errx(EXIT_FAILURE, _("%s\nTry `%s --help' for more
information."), s, program_invocation_short_name);
+  else
+    errx(EXIT_FAILURE, _("Try `%s --help' for more information."),
program_invocation_short_name);
 }

 static void __attribute__((__noreturn__))
@@ -325,6 +328,8 @@ int main(int argc, char *argv[])
     case OPT_UNAME26:
 	turn_on(UNAME26, options);
 	break;
+    default:
+        show_usage(NULL);
     }
   }

diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index 2c9ca27..7d31d41 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -29,6 +29,7 @@
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
+#include "optutils.h"
 #include "pathnames.h"
 #include "strutils.h"
 #include "tt.h"
@@ -167,7 +168,7 @@ static void usage(FILE *out)
 	for (i = 0; i < ARRAY_SIZE(infos); i++)
 		fprintf(out, " %13s  %s\n", infos[i].name, _(infos[i].help));

-	fprintf(out, USAGE_MAN_TAIL("wdctl(1)"));
+	fprintf(out, USAGE_MAN_TAIL("wdctl(8)"));

 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -381,6 +382,13 @@ int main(int argc, char *argv[])
 	char noflags = 0, noident = 0, notimeouts = 0, oneline = 0;
 	uint32_t wanted = 0;

+	enum {
+		EXCL_NONE,
+		EXCL_FLAGS,
+		EXCL_NOFLAGS
+	};
+	int excl_flag = EXCL_NONE;
+
 	static const struct option long_opts[] = {
 		{ "flags",      required_argument, NULL, 'f' },
 		{ "flags-only", no_argument,       NULL, 'x' },
@@ -412,6 +420,7 @@ int main(int argc, char *argv[])
 				return EXIT_FAILURE;
 			break;
 		case 'f':
+			exclusive_option(&excl_flag, EXCL_FLAGS, "--{flags,noflags}");
 			if (string_to_bitmask(optarg, (unsigned long *) &wanted, name2bit) != 0)
 				return EXIT_FAILURE;
 			break;
@@ -421,6 +430,7 @@ int main(int argc, char *argv[])
 		case 'h':
 			usage(stdout);
 		case 'F':
+			exclusive_option(&excl_flag, EXCL_NOFLAGS, "--{flags,noflags}");
 			noflags = 1;
 			break;
 		case 'I':
@@ -449,9 +459,6 @@ int main(int argc, char *argv[])
 		}
 	}

-	if (wanted && noflags)
-		errx(EXIT_FAILURE, _("--flags and --noflags are mutually exclusive"));
-
 	if (!ncolumns) {
 		/* default columns */
 		columns[ncolumns++] = COL_FLAG;
diff --git a/term-utils/scriptreplay.c b/term-utils/scriptreplay.c
index 63dc6fc..91c55c3 100644
--- a/term-utils/scriptreplay.c
+++ b/term-utils/scriptreplay.c
@@ -206,8 +206,7 @@ main(int argc, char *argv[])
 		double delay;
 		size_t blk;
 		char nl;
-
-		if (fscanf(tfile, "%lf %zd%c\n", &delay, &blk, &nl) != 3 ||
+		if (fscanf(tfile, "%lf %zu%c\n", &delay, &blk, &nl) != 3 ||
 				                                 nl != '\n') {
 			if (feof(tfile))
 				break;
diff --git a/text-utils/display.c b/text-utils/display.c
index 717565e..1f9a11b 100644
--- a/text-utils/display.c
+++ b/text-utils/display.c
@@ -42,6 +42,7 @@
 #include "hexdump.h"
 #include "xalloc.h"
 #include "c.h"
+#include "nls.h"

 static void doskip(const char *, int);
 static u_char *get(void);
@@ -257,6 +258,10 @@ get(void)
 			eaddress = address + nread;
 			return(curp);
 		}
+		if (fileno(stdin) == -1) {
+			warnx(_("all input file arguments failed"));
+			return(NULL);
+		}
 		n = fread((char *)curp + nread, sizeof(unsigned char),
 		    length == -1 ? need : min(length, need), stdin);
 		if (!n) {
diff --git a/text-utils/more.c b/text-utils/more.c
index b759859..4cf090f 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -177,6 +177,7 @@ int		soglitch;		/* terminal has standout mode glitch */
 int		ulglitch;		/* terminal has underline mode glitch */
 int		pstate = 0;		/* current UL state */
 static int	magic(FILE *, char *);
+char		*previousre;		/* previous search() buf[] item */
 struct {
     long chrctr, line;
 } context, screen_start;
@@ -317,7 +318,6 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 int main(int argc, char **argv) {
     FILE	*f;
     char	*s;
-    char	*p;
     int		ch;
     int		left;
     int		prnames = 0;
@@ -325,7 +325,7 @@ int main(int argc, char **argv) {
     int		srchopt = 0;
     int		clearit = 0;
     int		initline = 0;
-    char	initbuf[INIT_BUF];
+    char	*initbuf = NULL;

     setlocale(LC_ALL, "");
     bindtextdomain(PACKAGE, LOCALEDIR);
@@ -358,9 +358,7 @@ int main(int argc, char **argv) {
 	    s = *fnames;
 	    if (*++s == '/') {
 		srchopt++;
-		for (++s, p = initbuf; p < initbuf + (INIT_BUF - 1) && *s != '\0';)
-		    *p++ = *s++;
-		*p = '\0';
+		initbuf = xstrdup(s + 1);
 	    }
 	    else {
 		initopt++;
@@ -420,6 +418,7 @@ int main(int argc, char **argv) {
 	    }
 	    if (srchopt)
 	    {
+		previousre = xstrdup(initbuf);
 		search (initbuf, stdin, 1);
 		if (noscroll)
 		    left--;
@@ -441,6 +440,7 @@ int main(int argc, char **argv) {
 	    if (firstf) {
 		firstf = 0;
 		if (srchopt) {
+		    previousre = xstrdup(initbuf);
 		    search (initbuf, f, 1);
 		    if (noscroll)
 			left--;
@@ -492,6 +492,8 @@ int main(int argc, char **argv) {
 	fnum++;
 	firstf = 0;
     }
+    free (previousre);
+    free (initbuf);
     reset_tty ();
     exit(EXIT_SUCCESS);
 }
@@ -1332,6 +1334,10 @@ int command (char *filename, register FILE *f)
 	    fflush (stdout);
 	    break;
 	case 'n':
+	    if (!previousre) {
+	        more_error (_("No previous regular expression"));
+	        break;
+            }
 	    lastp++;
 	    /* fallthrough */
 	case '/':
@@ -1342,11 +1348,13 @@ int command (char *filename, register FILE *f)
 	    fflush (stdout);
 	    if (lastp) {
 		putcerr('\r');
-		search (NULL, f, nlines);	/* Use previous r.e. */
+		search (previousre, f, nlines);
 	    }
 	    else {
 		ttyin (cmdbuf, sizeof(cmdbuf)-2, '/');
 		putcerr('\r');
+		free (previousre);
+		previousre = xstrdup(cmdbuf);
 		search (cmdbuf, f, nlines);
 	    }
 	    ret (dlines-1);
@@ -1647,6 +1655,8 @@ void search(char buf[], FILE *file, register int n)
 	    end_it (0);
 	}
 	more_error (_("Pattern not found"));
+	free (previousre);
+	previousre = NULL;
     }
 }

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
