Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:46069 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751184Ab2FJVLf convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Jun 2012 17:11:35 -0400
Received: by wibhj8 with SMTP id hj8so2199323wib.1
        for <util-linux@vger.kernel.org>; Sun, 10 Jun 2012 14:11:34 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Sun, 10 Jun 2012 23:11:34 +0200
Message-ID: <CAG27Bk1p9gqdiZSjmHcsWvTTs9WKU=vx0dYvtZVLCGJ1iuAnyg@mail.gmail.com>
Subject: [pull] require C99, add robustness and small fixes
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel et.al.

Here is bunch of patches which are result of reading compiler warnings,
and thinking what could be done to them.  Most of the fixes are
straight forward, but then again there are some which affect more.  I
suspect requiring C99 is one of such.

Few last patches might be more interesting than others.  The partx fix
will make command behave more explicit manner.  The eject and lsblk
fixes are all about dealing what system call might return.


The following changes since commit 0e60bc9b152a3414c04c50523b5bf555665a6cea:

  build-sys: add compiler warnings (2012-06-06 12:10:41 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git 2012wk23

for you to fetch changes up to e8089b7a0378117c7285d1def395bff905f62c60:

  lsblk: print hex code when unknown block device type is found
(2012-06-10 22:58:05 +0200)

----------------------------------------------------------------
Sami Kerola (14):
      setarch: do not use -1 as array index [cppcheck]
      blkid: fix realloc memory leak [cppcheck]
      uuidd: use output redirection which works [checkbashisms]
      build-sys: expect C99 compliant compiler
      include: fix spurious list.h warnings
      build: fix redundant redeclaration warnings
      build: fix unused parameter warnings
      sysfs: fix printf format warnings
      include: fix void pointer arithmetics warnings
      partx: clarify up exclusive option handling
      docs: clean up partx.8 manual
      eject: inform if CD-ROM drive is not ready
      wipefs: use symbolic value for markup mode
      lsblk: print hex code when unknown block device type is found

 configure.ac          |   28 ++++++
 getopt/getopt.c       |    1 -
 include/all-io.h      |    4 +-
 include/list.h        |    4 +-
 lib/env.c             |    2 +
 lib/pager.c           |    3 +-
 lib/randutils.c       |    3 +-
 lib/sysfs.c           |    2 +-
 libmount/src/mountP.h |    2 -
 libmount/src/optstr.c |    5 +-
 login-utils/su.c      |    2 +
 misc-utils/blkid.c    |    4 +-
 misc-utils/kill.c     |    3 -
 misc-utils/lsblk.c    |    6 ++
 misc-utils/uuidd.rc   |    2 +-
 misc-utils/wipefs.c   |   11 ++-
 mount/fstab.c         |    2 +
 partx/partx.8         |  231 +++++++++++++++++++++++++++++--------------------
 partx/partx.c         |   54 ++++++------
 sys-utils/eject.c     |    8 ++
 sys-utils/setarch.c   |    6 +-
 term-utils/agetty.c   |    2 -
 term-utils/script.c   |    1 -
 term-utils/wall.c     |    1 -
 24 files changed, 238 insertions(+), 149 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2280e7e..13c9637 100644
--- a/configure.ac
+++ b/configure.ac
@@ -80,6 +80,24 @@ AC_CANONICAL_HOST
 AC_C_CONST
 AC_C_VOLATILE
 AC_C_BIGENDIAN
+if test "$cross_compiling" = no; then
+  if test "x$ac_cv_prog_cc_c99" = "xno" || test "x$ac_cv_prog_cc_c99"
= "x"; then
+  # We might be on RHEL5 with a git checkout and so broken
+  # autoconf. Check if CC is gcc and if it bails when given -std=gnu99.
+  # If not, use that.  Yuck.
+    if test "x$ac_cv_c_compiler_gnu" = "xyes"; then
+       CC="$CC -std=gnu99"
+       AC_RUN_IFELSE(
+          [AC_LANG_PROGRAM([],[[
+  return 0;
+      ]])],
+      [],
+      [AC_MSG_ERROR([Could not find a C99 compatible compiler])])
+    else
+      AC_MSG_ERROR([Could not find a C99 compatible compiler])
+    fi
+  fi
+fi

 dnl Compiler warnings
 UL_WARN_ADD([-Wextra])
@@ -262,6 +280,16 @@ AC_CHECK_DECL([lseek64],
 	 #define _LARGEFILE64_SOURCE
 	 #include <unistd.h>])

+AC_CHECK_DECL([environ],
+	[AC_DEFINE(HAVE_ENVIRON_DECL, 1,
+		[Define to 1 if have **environ prototype])],
+)
+
+AC_CHECK_DECL([strsignal],
+	[AC_DEFINE(HAVE_STRSIGNAL_DECL, 1,
+		[Define to 1 if have strsignal function prototype])],
+)
+
 AC_CHECK_FUNCS([ \
 	__fpending \
 	__secure_getenv \
diff --git a/getopt/getopt.c b/getopt/getopt.c
index dcc55b6..4ba3401 100644
--- a/getopt/getopt.c
+++ b/getopt/getopt.c
@@ -86,7 +86,6 @@ int (*getopt_long_fp) (int argc, char *const *argv,
const char *optstr,
 static const char *normalize(const char *arg);
 static int generate_output(char *argv[], int argc, const char *optstr,
 			   const struct option *longopts);
-int main(int argc, char *argv[]);
 static void parse_error(const char *message);
 static void add_long_options(char *options);
 static void add_longopt(const char *name, int has_arg);
diff --git a/include/all-io.h b/include/all-io.h
index b79d702..38a760f 100644
--- a/include/all-io.h
+++ b/include/all-io.h
@@ -15,7 +15,7 @@ static inline int write_all(int fd, const void *buf,
size_t count)
 		if (tmp > 0) {
 			count -= tmp;
 			if (count)
-				buf += tmp;
+				buf = (void *) ((char *) buf + tmp);
 		} else if (errno != EINTR && errno != EAGAIN)
 			return -1;
 		if (errno == EAGAIN)	/* Try later, *sigh* */
@@ -35,7 +35,7 @@ static inline int fwrite_all(const void *ptr, size_t size,
 		if (tmp > 0) {
 			nmemb -= tmp;
 			if (nmemb)
-				ptr += (tmp * size);
+				ptr = (void *) ((char *) ptr + (tmp * size));
 		} else if (errno != EINTR && errno != EAGAIN)
 			return -1;
 		if (errno == EAGAIN)	/* Try later, *sigh* */
diff --git a/include/list.h b/include/list.h
index d8c3bf0..1824af0 100644
--- a/include/list.h
+++ b/include/list.h
@@ -221,7 +221,7 @@ _INLINE_ struct list_head *merge(int (*cmp)(struct
list_head *a,
 		}
 		tail = tail->next;
 	}
-	tail->next = a?:b;
+	tail->next = a ? a : b;
 	return head.next;
 }

@@ -252,7 +252,7 @@ _INLINE_ void merge_and_restore_back_links(int
(*cmp)(struct list_head *a,
 		}
 		tail = tail->next;
 	}
-	tail->next = a ? : b;
+	tail->next = a ? a : b;

 	do {
 		/*
diff --git a/lib/env.c b/lib/env.c
index e6d119f..04e0f0b 100644
--- a/lib/env.c
+++ b/lib/env.c
@@ -21,7 +21,9 @@

 #include "env.h"

+#ifndef HAVE_ENVIRON_DECL
 extern char **environ;
+#endif

 static char * const forbid[] = {
         "_RLD_=",
diff --git a/lib/pager.c b/lib/pager.c
index f02d55d..4c50de4 100644
--- a/lib/pager.c
+++ b/lib/pager.c
@@ -200,7 +200,8 @@ void setup_pager(void)

 #define MAX 255

-int main(int argc, char *argv[])
+int main(int argc __attribute__ ((__unused__)),
+	 char *argv[] __attribute__ ((__unused__)))
 {
 	int i;

diff --git a/lib/randutils.c b/lib/randutils.c
index b90c886..85cb1a9 100644
--- a/lib/randutils.c
+++ b/lib/randutils.c
@@ -105,7 +105,8 @@ void random_get_bytes(void *buf, size_t nbytes)
 }

 #ifdef TEST_PROGRAM
-int main(int argc, char *argv[])
+int main(int argc __attribute__ ((__unused__)),
+         char *argv[] __attribute__ ((__unused__)))
 {
 	unsigned int v, i;

diff --git a/lib/sysfs.c b/lib/sysfs.c
index 3b5d045..312191f 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -90,7 +90,7 @@ dev_t sysfs_devname_to_devno(const char *name, const
char *parent)
 		if (!f)
 			return 0;

-		if (fscanf(f, "%u:%u", &maj, &min) == 2)
+		if (fscanf(f, "%d:%d", &maj, &min) == 2)
 			dev = makedev(maj, min);
 		fclose(f);
 	}
diff --git a/libmount/src/mountP.h b/libmount/src/mountP.h
index c7d378e..f7cd7d5 100644
--- a/libmount/src/mountP.h
+++ b/libmount/src/mountP.h
@@ -380,7 +380,6 @@ extern int mnt_context_guess_fstype(struct
libmnt_context *cxt);
 extern int mnt_context_prepare_helper(struct libmnt_context *cxt,
 				      const char *name, const char *type);
 extern int mnt_context_prepare_update(struct libmnt_context *cxt);
-extern struct libmnt_fs *mnt_context_get_fs(struct libmnt_context *cxt);
 extern int mnt_context_merge_mflags(struct libmnt_context *cxt);
 extern int mnt_context_update_tabs(struct libmnt_context *cxt);

@@ -395,7 +394,6 @@ extern int mnt_context_clear_loopdev(struct
libmnt_context *cxt);
 extern int mnt_fork_context(struct libmnt_context *cxt);

 /* tab_update.c */
-extern struct libmnt_fs *mnt_update_get_fs(struct libmnt_update *upd);
 extern int mnt_update_set_filename(struct libmnt_update *upd,
 				   const char *filename, int userspace_only);

diff --git a/libmount/src/optstr.c b/libmount/src/optstr.c
index 66d2a06..75d0263 100644
--- a/libmount/src/optstr.c
+++ b/libmount/src/optstr.c
@@ -771,7 +771,10 @@ err:
  *
  * Returns: 0 on success, negative number in case of error.
  */
-int mnt_optstr_fix_secontext(char **optstr, char *value, size_t
valsz, char **next)
+int mnt_optstr_fix_secontext(char **optstr __attribute__ ((__unused__)),
+			     char *value   __attribute__ ((__unused__)),
+			     size_t valsz  __attribute__ ((__unused__)),
+			     char **next   __attribute__ ((__unused__)))
 {
 	int rc = 0;

diff --git a/login-utils/su.c b/login-utils/su.c
index 0f535b9..2622209 100644
--- a/login-utils/su.c
+++ b/login-utils/su.c
@@ -78,7 +78,9 @@ enum
 /* The user to become if none is specified.  */
 #define DEFAULT_USER "root"

+#ifndef HAVE_ENVIRON_DECL
 extern char **environ;
+#endif

 static void run_shell (char const *, char const *, char **, size_t)
      __attribute__ ((__noreturn__));
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 25e6c00..7b2170f 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -365,8 +365,10 @@ static int append_str(char **res, size_t *sz,
const char *a, const char *b)
 		return -1;

 	str = realloc(str, len + 1);
-	if (!str)
+	if (!str) {
+		free(res);
 		return -1;
+	}

 	*res = str;
 	str += *sz;
diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index c592f52..8e2a1d8 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -139,7 +139,6 @@ struct signv {
 #endif
 };

-int main (int argc, char *argv[]);
 extern char *mybasename(char *);
 int signame_to_signum (char *sig);
 int arg_to_signum (char *arg, int mask);
@@ -149,8 +148,6 @@ void printsignals (FILE *fp);
 int usage (int status);
 int kill_verbose (char *procname, int pid, int sig);

-extern int *get_pids (char *, int);
-
 static char *progname;

 #ifdef HAVE_SIGQUEUE
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 9e894ef..f9e05b6 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -527,6 +527,12 @@ static char *get_type(struct blkdev_cxt *cxt)
 				type = "mo-disk"; break;
 			case 0x0e: /* TYPE_RBC */
 				type = "rbc"; break;
+			default:
+				/* Perhaps include/scsi/scsi.h in
+				 * kernel git section 'DEVICE TYPES'
+				 * will know what was found.  */
+				sprintf(type, "0x%02x", x);
+				break;
 		}

 		res = xstrdup(type);
diff --git a/misc-utils/uuidd.rc b/misc-utils/uuidd.rc
index dbdd5f5..d10fced 100644
--- a/misc-utils/uuidd.rc
+++ b/misc-utils/uuidd.rc
@@ -49,7 +49,7 @@ case "$1" in
 	log_end_msg $?
     ;;
   status)
-	if pidofproc -p $PIDFILE $DAEMON >& /dev/null ; then
+	if pidofproc -p $PIDFILE $DAEMON >/dev/null 2>&1; then
 	    echo "$DAEMON is running";
 	    exit 0;
 	else
diff --git a/misc-utils/wipefs.c b/misc-utils/wipefs.c
index e0ced2f..259ca37 100644
--- a/misc-utils/wipefs.c
+++ b/misc-utils/wipefs.c
@@ -56,8 +56,10 @@ struct wipe_desc {
 	struct wipe_desc	*next;
 };

-#define WP_MODE_PRETTY		0		/* default */
-#define WP_MODE_PARSABLE	1
+enum {
+	WP_MODE_PRETTY,		/* default */
+	WP_MODE_PARSABLE
+};

 static const char *type_pattern;

@@ -117,6 +119,8 @@ print_all(struct wipe_desc *wp, int mode)
 		case WP_MODE_PARSABLE:
 			print_parsable(wp, n++);
 			break;
+		default:
+			abort();
 		}
 		wp = wp->next;
 	}
@@ -375,7 +379,8 @@ int
 main(int argc, char **argv)
 {
 	struct wipe_desc *wp0 = NULL, *wp;
-	int c, all = 0, has_offset = 0, noact = 0, mode = 0, quiet = 0;
+	int c, all = 0, has_offset = 0, noact = 0, quiet = 0;
+	int mode = WP_MODE_PRETTY;

 	static const struct option longopts[] = {
 	    { "all",       0, 0, 'a' },
diff --git a/mount/fstab.c b/mount/fstab.c
index 043cc43..a394591 100644
--- a/mount/fstab.c
+++ b/mount/fstab.c
@@ -578,7 +578,9 @@ static int lockfile_fd = -1;
 static int signals_have_been_setup = 0;

 /* Ensure that the lock is released if we are interrupted.  */
+#ifndef HAVE_STRSIGNAL_DECL
 extern char *strsignal(int sig);	/* not always in <string.h> */
+#endif

 static void
 handler (int sig) {
diff --git a/partx/partx.8 b/partx/partx.8
index dd5ebe7..86350c4 100644
--- a/partx/partx.8
+++ b/partx/partx.8
@@ -3,132 +3,171 @@
 .\" Copyright 2007 Red Hat, Inc.
 .\" Copyright 2010 Davidlohr Bueso <dave@gnu.org>
 .\" May be distributed under the GNU General Public License
-.TH PARTX 8 "February 2011" "util-linux" "System Administration"
+.TH PARTX "8" "June 2012" "util-linux" "System Administration"
 .SH NAME
-partx \-
-tell the Linux kernel about the presence and numbering of on-disk partitions
+partx \- tell the Linux kernel about the presence and numbering of
+on-disk partitions
 .SH SYNOPSIS
-.B partx
-.RB [ \-a | \-d | \-s ]
-.RB [ \-t
-.IR TYPE ]
-.RB [ \-n
-.IR M:N ]
-.RI [ \- ]
-.I disk
-
-.B partx
-.RB [ \-a | \-d | \-s ]
-.RB [ \-t
-.IR TYPE ]
-.I partition
-.RI [ disk ]
-
+partx [\-a|\-d|\-s] [\-t TYPE] [\-n M:N] [\-] disk
+.br
+partx [\-a|\-d|\-s] [\-t TYPE] partition [disk]
 .SH DESCRIPTION
-Given a device or disk-image, \fBpartx\fP tries to parse the
partition table and
-list its contents.  It optionally adds or removes partitions.
-
+Given a device or disk-image,
+.B partx
+tries to parse the partition table and list its contents.  It
+optionally adds or removes partitions.
+.PP
 The
 .I disk
-argument is optional when a
-.I partition
-argument is provided.  To force scanning a partition as if it were a whole disk
-(for example to list nested subpartitions), use the argument "-".  For example:
-
-.RS
-.br
-.B partx \-\-show \- /dev/sda3
+argument is optional when a
+.I partition
+argument is provided.  To force scanning a partition as if it were a
+whole disk (for example to list nested subpartitions), use the argument
+"-".  For example:
+.RS 7
+.TP
+partx \-\-show \- /dev/sda3
 .RE
-
+.PP
 This will see sda3 as a whole-disk rather than a partition.
-
-.B This is not an fdisk program
-\-\- adding and removing partitions
-does not change the disk, it just tells the kernel
-about the presence and numbering of on-disk partitions.
-
+.PP
+The
+.B partx is not an fdisk program
+\-\- adding and removing partitions does not change the disk, it just
+tells the kernel about the presence and numbering of on-disk
+partitions.
 .SH OPTIONS
-.IP "\fB\-a, \-\-add\fP"
+.IP "\fB\-a\fR, \fB\-\-add\fP"
 Add the specified partitions, or read the disk and add all partitions.
-.IP "\fB\-b, \-\-bytes\fP"
+.IP "\fB\-b\fR, \fB\-\-bytes\fP"
 Print the SIZE column in bytes rather than in human-readable format.
-.IP "\fB\-d, \-\-delete\fP"
+.IP "\fB\-d\fR, \fB\-\-delete\fP"
 Delete the specified partitions or all partitions.
-.IP "\fB\-g, \-\-noheadings\fP"
+.IP "\fB\-g\fR, \fB\-\-noheadings\fP"
 Do not print a header line.
-.IP "\fB\-h, \-\-help\fP"
+.IP "\fB\-h\fR, \fB\-\-help\fP"
 Print a help text and exit.
-.IP "\fB\-l, \-\-list\fP"
-List the partitions.  Note that all numbers are in 512-byte sectors.
This output
-format is DEPRECATED in favour of \fB\-\-show\fP.  Don't use it in
newly written
-scripts.
-.IP "\fB\-o, \-\-output \fIlist\fP"
-Define the output columns to use for \fB\-\-show\fP and  \fB\-\-raw\fP output.
-If no output arrangement is specified, then a default set is used.
-Use \fB\-\-help\fP to  get list of all supported columns.
-.IP "\fB\-P, \-\-pairs\fP"
-Use key="value" output format.
-.IP "\fB\-n, \-\-nr \fIM:N\fP"
-Specify the range of partitions.  For backward compatibility also the format
-<M-N> is supported.  The range may contain negative
-numbers, for example "--nr :-1" means the last partition, and "--nr
-2:-1" means
-the last two partitions.  Supported range specifications are:
-.RS
+.IP "\fB\-l\fR, \fB\-\-list\fP"
+List the partitions.  Note that all numbers are in 512-byte sectors.
+This output format is DEPRECATED in favour of
+.BR \-\-show .
+Do not use it in newly written scripts.
+.IP "\fB\-o\fR, \fB\-\-output \fIlist\fP"
+Define the output columns to use for
+.B \-\-show
+and
+.B \-\-raw
+output.  If no output arrangement is specified, then a default set is
+used.  Use
+.B \-\-help
+to get
+.I list
+of all supported columns.  This option cannot be combined with
+.BR \-\-add ,
+.B \-\-delete
+or
+.B \-\-list
+options.
+.IP "\fB\-P\fR, \fB\-\-pairs\fP"
+Output using key="value" format.
+.IP "\fB\-n\fR, \fB\-\-nr \fIM:N\fP"
+Specify the range of partitions.  For backward compatibility also the
+format
+.I M-N
+is supported.  The range may contain negative numbers, for example
+.BI \-\-nr \ :\-1
+means the last partition, and
+.BI \-\-nr \ \-2:\-1
+means the last two partitions.  Supported range specifications are:
+.RS 14
 .TP
-.B <M>
-Specifies just one partition (e.g. --nr 3).
+.I M
+Specifies just one partition (e.g. \fB\-\-nr\fR
+.IR 3 ).
 .TP
-.B <M:>
-Specifies lower limit only (e.g. --nr 2:).
+.I M:
+Specifies lower limit only (e.g. \fB\-\-nr\fR
+.IR 2: ).
 .TP
-.B <:N>
-Specifies upper limit only (e.g. --nr :4).
+.I :N
+Specifies upper limit only (e.g. \fB\-\-nr\fR
+.IR :4 ).
 .TP
-.B <M:N>
-or
-.B <M-N>
-Specifies lower and upper limits (e.g. --nr 2:4).
+.IR M:N \ or
+.TQ
+.I M-N
+Specifies lower and upper limits (e.g. \fB--nr\fR
+.IR 2:4 ).
 .RE
-.IP "\fB\-r, \-\-raw\fP"
+.IP "\fB\-r\fR, \fB\-\-raw\fP"
 Use the raw output format.
-.IP "\fB\-s, \-\-show\fP"
-List the partitions.  All numbers (except SIZE) are in 512-byte
sectors.  The output
-columns can be rearranged with the \fB\-\-output\fP option.
-.IP "\fB\-t, \-\-type \fItype\fP"
-Specify the partition table type -- aix, bsd, dos, gpt, mac, minix,
sgi, solaris_x86,
-sun, ultrix or unixware.
-.IP "\fB\-v, \-\-verbose\fP"
+.IP "\fB\-s\fR, \fB\-\-show\fP"
+List the partitions.  All numbers (except SIZE) are in 512-byte
+sectors.  The output columns can be rearranged with the
+.B \-\-output
+option.
+.IP "\fB\-t\fR, \fB\-\-type \fItype\fP"
+Specify the partition table type
+.IR aix ,
+.IR bsd ,
+.IR dos ,
+.IR gpt ,
+.IR mac ,
+.IR minix ,
+.IR sgi ,
+.IR solaris_x86 ,
+.IR sun ,
+.I ultrix
+or
+.IR unixware .
+.IP "\fB\-v\fR, \fB\-\-verbose\fP"
 Verbose mode.
 .SH EXAMPLES
-.IP "\fBpartx \-\-show /dev/sdb3\fP"
-.IP "\fBpartx \-\-show --nr 3 /dev/sdb\fP"
-.IP "\fBpartx \-\-show /dev/sdb3 /dev/sdb\fP"
+.TP
+partx \-\-show /dev/sdb3
+.TQ
+partx \-\-show --nr 3 /dev/sdb
+.TQ
+partx \-\-show /dev/sdb3 /dev/sdb
 All three commands list partition 3 of /dev/sdb.
-.IP "\fBpartx \-\-show \- /dev/sdb3\fP"
-Lists all subpartitions on /dev/sdb3 (the device is used as whole-disk).
-.IP "\fBpartx \-o START -g --nr 3 /dev/sdb\fP"
-Prints the start sector of partition 5 on /dev/sda without header.
-.IP "\fBpartx \-o SECTORS,SIZE /dev/sda5 /dev/sda\fP"
-Lists the length in sectors and human-readable size of partition 5 on /dev/sda.
-.IP "\fBpartx \-\-add --nr 3:5 /dev/sdd\fP"
+.TP
+partx \-\-show \- /dev/sdb3
+Lists all subpartitions on /dev/sdb3 (the device is used as
+whole-disk).
+.TP
+partx \-o START -g --nr 5 /dev/sdb
+Prints the start sector of partition 5 on /dev/sdb without header.
+.TP
+partx \-o SECTORS,SIZE /dev/sda5 /dev/sda
+Lists the length in sectors and human-readable size of partition 5 on
+/dev/sda.
+.TP
+partx \-\-add --nr 3:5 /dev/sdd
 Adds all available partitions from 3 to 5 (inclusive) on /dev/sdd.
-.IP "\fBpartx \-d --nr :-1 /dev/sdd\fP"
+.TP
+partx \-d --nr :-1 /dev/sdd
 Removes the last partition on /dev/sdd.
-
 .SH SEE ALSO
 .BR addpart (8),
 .BR delpart (8),
 .BR fdisk (8),
 .BR parted (8),
 .BR partprobe (8)
-
 .SH AUTHORS
-.nf
-Davidlohr Bueso <dave@gnu.org>
-Karel Zak <kzak@redhat.com>
-.fi
-
-The original version was written by Andries E. Brouwer <aeb@cwi.nl>.
+.MT dave@gnu.org
+Davidlohr Bueso
+.ME
+.br
+.MT kzak@redhat.com
+Karel Zak
+.ME
+.PP
+The original version was written by
+.MT aeb@cwi.nl
+Andries E. Brouwer
+.ME .
 .SH AVAILABILITY
 The partx command is part of the util-linux package and is available from
-ftp://ftp.kernel.org/pub/linux/utils/util-linux/.
+.UR ftp://\:ftp.kernel.org\:/pub\:/linux\:/utils\:/util-linux/
+Linux Kernel Archive
+.UE .
diff --git a/partx/partx.c b/partx/partx.c
index f19b919..3375784 100644
--- a/partx/partx.c
+++ b/partx/partx.c
@@ -53,7 +53,8 @@ enum {
 };

 enum {
-	ACT_LIST = 1,
+	ACT_NONE,
+	ACT_LIST,
 	ACT_SHOW,
 	ACT_ADD,
 	ACT_DELETE
@@ -638,9 +639,20 @@ errx_mutually_exclusive(const char *opts)
 	errx(EXIT_FAILURE, _("the options %s are mutually exclusive"), opts);
 }

+static void set_exclusive(int *what, int how)
+{
+	if (*what == ACT_NONE) {
+		*what = how;
+		return;
+	}
+	if (*what == how)
+		return;
+	errx_mutually_exclusive("--{add,delete,show,list,raw,pairs}");
+}
+
 int main(int argc, char **argv)
 {
-	int fd, c, what = 0, lower = 0, upper = 0, rc = 0;
+	int fd, c, what = ACT_NONE, lower = 0, upper = 0, rc = 0;
 	int tt_flags = 0;
 	char *type = NULL;
 	char *device = NULL; /* pointer to argv[], ie: /dev/sda1 */
@@ -672,34 +684,21 @@ int main(int argc, char **argv)

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
+			set_exclusive(&what, ACT_ADD);
 			break;
 		case 'b':
 			partx_flags |= FL_BYTES;
 			break;
 		case 'd':
-			what = ACT_DELETE;
+			set_exclusive(&what, ACT_DELETE);
 			break;
 		case 'g':
 			tt_flags |= TT_FL_NOHEADINGS;
 			break;
 		case 'l':
-			what = ACT_LIST;
+			set_exclusive(&what, ACT_LIST);
 			break;
 		case 'n':
 			if (parse_range(optarg, &lower, &upper, 0))
@@ -711,17 +710,18 @@ int main(int argc, char **argv)
 						column_name_to_id);
 			if (ncolumns < 0)
 				return EXIT_FAILURE;
+			set_exclusive(&what, ACT_SHOW);
 			break;
 		case 'P':
 			tt_flags |= TT_FL_EXPORT;
-			what = ACT_SHOW;
+			set_exclusive(&what, ACT_SHOW);
 			break;
 		case 'r':
 			tt_flags |= TT_FL_RAW;
-			what = ACT_SHOW;
+			set_exclusive(&what, ACT_SHOW);
 			break;
 		case 's':
-			what = ACT_SHOW;
+			set_exclusive(&what, ACT_SHOW);
 			break;
 		case 't':
 			type = optarg;
@@ -740,12 +740,8 @@ int main(int argc, char **argv)
 		}
 	}

-	/* -o <list> enables --show mode by default */
-	if (ncolumns && !what)
-		what = ACT_SHOW;
-
 	/* backwardly compatible default */
-	if (!what)
+	if (what == ACT_NONE)
 		what = ACT_LIST;

 	/* --show default, could by modified by -o  */
@@ -870,7 +866,7 @@ int main(int argc, char **argv)
 			if (lower > upper) {
 				warnx(_("specified range <%d:%d> "
 					"does not make sense"), lower, upper);
-				rc = -1, what = 0;
+				rc = -1, what = ACT_NONE;
 			}

 			switch (what) {
@@ -883,6 +879,10 @@ int main(int argc, char **argv)
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
diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index 4f3fb83..68f1f85 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -429,6 +429,14 @@ static void toggle_tray(int fd)
 		if (eject_cdrom(fd))
 			err(EXIT_FAILURE, _("CD-ROM eject command failed"));
 		return;
+	case CDS_NO_INFO:
+		warnx(_("no CD-ROM information available"));
+		return;
+	case CDS_DRIVE_NOT_READY:
+		warnx(_("CD-ROM drive is not ready"));
+		return;
+	default:
+		abort();
 	}
 #endif

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 97269f4..a0c6ea8 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -259,12 +259,12 @@ int main(int argc, char *argv[])

   p = program_invocation_short_name;
   if (!strcmp(p, "setarch")) {
-    argv++;
     argc--;
     if (argc < 1)
       show_usage(_("Not enough arguments"));
-    p = argv[0];
-    argv[0] = argv[-1];      /* for getopt_long() to get the program name */
+    p = argv[1];
+    argv[1] = argv[0];		/* for getopt_long() to get the program name */
+    argv++;
     if (!strcmp(p, "-h") || !strcmp(p, "--help"))
       show_help();
     else if (!strcmp(p, "-V") || !strcmp(p, "--version"))
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 9101e7f..862b8c4 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -533,8 +533,6 @@ static void login_options_to_argv(char *argv[], int *argc,
 /* Parse command-line arguments. */
 static void parse_args(int argc, char **argv, struct options *op)
 {
-	extern char *optarg;
-	extern int optind;
 	int c;

 	enum {
diff --git a/term-utils/script.c b/term-utils/script.c
index 07be7e9..05d9f85 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -158,7 +158,6 @@ int
 main(int argc, char **argv) {
 	sigset_t block_mask, unblock_mask;
 	struct sigaction sa;
-	extern int optind;
 	int ch;
 	FILE *timingfd = stderr;

diff --git a/term-utils/wall.c b/term-utils/wall.c
index 3255a51..9966506 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -93,7 +93,6 @@ static void __attribute__((__noreturn__)) usage(FILE *out)

 int
 main(int argc, char **argv) {
-	extern int optind;
 	int ch;
 	struct iovec iov;
 	struct utmp *utmpptr;

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
