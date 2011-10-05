Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:50748 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754674Ab1JEUmj convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 5 Oct 2011 16:42:39 -0400
Received: by vcbfk10 with SMTP id fk10so1679666vcb.19
        for <util-linux@vger.kernel.org>; Wed, 05 Oct 2011 13:42:38 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Date: Wed, 5 Oct 2011 22:42:38 +0200
Message-ID: <CAG27Bk0ACb_sAmTiBaEpGRxgeVDJ7-tWhx9N9Ok47ZE3bTD4Zg@mail.gmail.com>
Subject: [pull] build-sys and lsblk enhancements
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

The libtoolize thing does not really require any explanation. The
definition change is align with this package being independent from
kernel headers, alternative would be to trust the definition in kernel
header to be suitable and define only if that would exist. Last two
patches where outcome of me knowing that this package has nice block
device utilities, and a try to make a oracle storage migration on
quite old system at work easier. Obviously that did not work, but as a
outcome I thought that for others understanding what is wrong, how,
where and what to do about it could be made easier.

The following changes since commit fd96508a27d60abbe2574ce852cc1526d6529029:

  docs: add prlimit to the TODO file (2011-09-30 12:40:44 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit build-sys

Sami Kerola (4):
      build-sys: enhance error message for missing libtoolize
      build-sys: rename BUILD_BUG_ON_ZERO definition
      build-sys: check scanf %ms modifier
      lsblk: inform about depencency to /sys/dev/block

 autogen.sh               |    1 +
 configure.ac             |   34 ++++++++++++++++++++++++++++++++++
 include/c.h              |    4 ++--
 libmount/src/tab_parse.c |   20 +++++++++++++++++++-
 misc-utils/lsblk.8       |    9 +++++++++
 misc-utils/lsblk.c       |   12 ++++++++++++
 6 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/autogen.sh b/autogen.sh
index c07984b..14a795f 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -55,6 +55,7 @@ test -f mount/mount.c || {
 }

 ltver=$(libtoolize --version | awk '/^libtoolize/ { print $4 }')
+ltver=${ltver:-"none"}
 test ${ltver##2.} = "$ltver" && {
 	echo "You must have libtool version >= 2.x.x, but you have $ltver."
 	DIE=1
diff --git a/configure.ac b/configure.ac
index fb0b0eb..62664b9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -477,6 +477,40 @@ elif test "x$enable_libmount" = xno; then
     build_libmount=no
 fi

+AC_DEFUN([UTIL_SCANF_TYPE_MODIFIER], [dnl
+# include <stdio.h>
+int main()
+{
+	int i;
+	char *s;
+	i = sscanf("x", $1, &s);
+	if (i == 1)
+		return 0;
+	return 1;
+}])
+AC_MSG_CHECKING([needed scanf type modifiers])
+AC_CACHE_VAL([scanf_cv_type_modifier],
+  AC_RUN_IFELSE([AC_LANG_SOURCE([UTIL_SCANF_TYPE_MODIFIER(["%ms"])])],
+    [scanf_cv_type_modifier=ms],
+    AC_RUN_IFELSE([AC_LANG_SOURCE([UTIL_SCANF_TYPE_MODIFIER(["%as"])])],
+      [scanf_cv_type_modifier=as],
+      [scanf_cv_type_modifier=no]
+    )
+  )
+)
+if test "x$scanf_cv_type_modifier" = "xms"; then
+  AC_MSG_RESULT([yes])
+  AC_DEFINE([HAVE_SCANF_MS_MODIFIER], [1], [scanf %ms modifier])
+else
+  if test "x$scanf_cv_type_modifier" = "xas"; then
+    AC_MSG_RESULT([yes])
+    AC_DEFINE([HAVE_SCANF_AS_MODIFIER], [1], [scanf %as modifier])
+  else
+    build_libmount=no
+    AC_MSG_RESULT([no])
+  fi
+fi
+
 case "$enable_libblkid:$build_libmount" in
 no:yes)
   AC_MSG_ERROR([cannot enable libmount when libblkid is disabled]) ;;
diff --git a/include/c.h b/include/c.h
index f5b4bcd..259e6b6 100644
--- a/include/c.h
+++ b/include/c.h
@@ -33,7 +33,7 @@

 /* &a[0] degrades to a pointer: a different type from an array */
 # define __must_be_array(a) \
-	BUILD_BUG_ON_ZERO(__builtin_types_compatible_p(__typeof__(a),
__typeof__(&a[0])))
+	UL_BUILD_BUG_ON_ZERO(__builtin_types_compatible_p(__typeof__(a),
__typeof__(&a[0])))

 # define ignore_result(x) ({ \
 	__typeof__(x) __dummy __attribute__((__unused__)) = (x); (void) __dummy; \
@@ -69,7 +69,7 @@
  * e.g. in a structure initializer (or where-ever else comma expressions
  * aren't permitted).
  */
-#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
+#define UL_BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e); }))
 #define BUILD_BUG_ON_NULL(e) ((void *)sizeof(struct { int:-!!(e); }))

 #ifndef ARRAY_SIZE
diff --git a/libmount/src/tab_parse.c b/libmount/src/tab_parse.c
index dba6002..7859e36 100644
--- a/libmount/src/tab_parse.c
+++ b/libmount/src/tab_parse.c
@@ -54,10 +54,17 @@ static int mnt_parse_table_line(struct libmnt_fs
*fs, char *s)
 	int rc, n = 0;
 	char *src, *fstype, *optstr;

+#ifdef HAVE_SCANF_MS_MODIFIER
 	rc = sscanf(s,	"%ms "	/* (1) source */
 			"%ms "	/* (2) target */
 			"%ms "	/* (3) FS type */
 			"%ms "  /* (4) options */
+#elif defined(HAVE_SCANF_AS_MODIFIER)
+	rc = sscanf(s,	"%as "	/* (1) source */
+			"%as "	/* (2) target */
+			"%as "	/* (3) FS type */
+			"%as "  /* (4) options */
+#endif
 			"%n",	/* byte count */
 			&src,
 			&fs->target,
@@ -114,9 +121,15 @@ static int mnt_parse_mountinfo_line(struct
libmnt_fs *fs, char *s)
 	rc = sscanf(s,	"%u "		/* (1) id */
 			"%u "		/* (2) parent */
 			"%u:%u "	/* (3) maj:min */
+#ifdef HAVE_SCANF_MS_MODIFIER
 			"%ms "		/* (4) mountroot */
 			"%ms "		/* (5) target */
 			"%ms"		/* (6) vfs options (fs-independent) */
+#elif defined(HAVE_SCANF_AS_MODIFIER)
+			"%as "		/* (4) mountroot */
+			"%as "		/* (5) target */
+			"%as"		/* (6) vfs options (fs-independent) */
+#endif
 			"%n",		/* number of read bytes */

 			&fs->id,
@@ -138,10 +151,15 @@ static int mnt_parse_mountinfo_line(struct
libmnt_fs *fs, char *s)
 	}
 	s = p + 3;

+#ifdef HAVE_SCANF_MS_MODIFIER
 	rc += sscanf(s,	"%ms "		/* (8) FS type */
 			"%ms "		/* (9) source */
 			"%ms",		/* (10) fs options (fs specific) */
-
+#elif defined(HAVE_SCANF_AS_MODIFIER)
+	rc += sscanf(s,	"%as "		/* (8) FS type */
+			"%as "		/* (9) source */
+			"%as",		/* (10) fs options (fs specific) */
+#endif
 			&fstype,
 			&src,
 			&fs->fs_optstr);
diff --git a/misc-utils/lsblk.8 b/misc-utils/lsblk.8
index 72085ac..028b19f 100644
--- a/misc-utils/lsblk.8
+++ b/misc-utils/lsblk.8
@@ -63,6 +63,15 @@ This option is equivalent to "-o
NAME,ALIGNMENT,MIN-IO,OPT-IO,PHY-SEC,LOG-SEC,RO
 .SH NOTES
 For the partitions are some information (e.g. queue attributes) inherited from
 parental device.
+.PP
+The
+.B lsblk
+needs to be able to lookup sysfs path by major:minor, which is done
+done by using
+.BR /sys/dev/block .
+The block sysfs appeared in kernel 2.6.27 (October 2008).  In case of
+problem with new enough kernel check that CONFIG_SYSFS was enabled at
+the time of kernel build.
 .SH AUTHORS
 .nf
 Milan Broz <mbroz@redhat.com>
diff --git a/misc-utils/lsblk.c b/misc-utils/lsblk.c
index 3c4555d..48b0b25 100644
--- a/misc-utils/lsblk.c
+++ b/misc-utils/lsblk.c
@@ -906,6 +906,16 @@ errx_mutually_exclusive(const char *opts)
 	errx(EXIT_FAILURE, "%s %s", opts, _("options are mutually exclusive"));
 }

+static void check_sysdevblock(void)
+{
+	DIR *dir;
+	if (!(dir = opendir(_PATH_SYS_DEVBLOCK)))
+		err(EXIT_FAILURE, _("failed to open sysfs directory: %s"),
+		    _PATH_SYS_DEVBLOCK);
+	closedir(dir);
+	return;
+}
+
 int main(int argc, char *argv[])
 {
 	struct lsblk _ls;
@@ -1018,6 +1028,8 @@ int main(int argc, char *argv[])
 		}
 	}

+	check_sysdevblock();
+
 	if (!ncolumns) {
 		columns[ncolumns++] = COL_NAME;
 		columns[ncolumns++] = COL_MAJMIN;

-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
