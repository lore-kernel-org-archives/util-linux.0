Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.vodafone.ie ([213.233.128.44]:26862 "EHLO
	mail2.vodafone.ie" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbbATCBY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 19 Jan 2015 21:01:24 -0500
Message-ID: <54BDB6E9.4070500@draigBrady.com>
Date: Tue, 20 Jan 2015 02:01:13 +0000
From: =?UTF-8?B?UMOhZHJhaWcgQnJhZHk=?= <P@draigBrady.com>
MIME-Version: 1.0
To: Bernhard Voelker <mail@bernhard-voelker.de>, Coreutils <coreutils@gnu.org>,
        bug-gnulib <bug-gnulib@gnu.org>,
        util-linux <util-linux@vger.kernel.org>,
        Fridolin Pokorny <fpokorny@redhat.com>
Subject: large overhead in libmount
References: <54A321DC.4020300@bernhard-voelker.de>
In-Reply-To: <54A321DC.4020300@bernhard-voelker.de>
Content-Type: multipart/mixed;
 boundary="------------030509030700010204070607"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------030509030700010204070607
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On 30/12/14 22:06, Bernhard Voelker wrote:
> I just pulled the recent gnulib update, and now the above, expensive
> test fails:
> 
>    + ulimit -v 40000
>    + du -sh d
>    du: fts_read failed: d: Cannot allocate memory
>    + fail=1
> 
> I guess this due to the inclusion of libmount?

Yes I get the same issue in that test:
http://git.sv.gnu.org/gitweb/?p=coreutils.git;a=blob;f=tests/rm/many-dir-entries-vs-OOM.sh

Indeed there is significant overhead in using libmount as shown below.
This is a crazy amount of overhead just to read /proc/self/mountinfo,
and is the sort of creeping dependencies I hate.  The proposed solution
in the attached gnulib patch, is to require ./configure --with-libmount
to enable this feature. I.E. it's disabled by default.

cheers,
Pádraig

======= without =========
$ (ulimit -v 5380; du -s .)

$ ldd /usr/bin/du
linux-vdso.so.1 =>  (0x00007fff0d7fe000)
libc.so.6 => /lib64/libc.so.6 (0x00007fd414a32000)
/lib64/ld-linux-x86-64.so.2 (0x00007fd414e0b000)

$ time du -s src/du.c >/dev/null
real    0m0.003s
user    0m0.000s
sys     0m0.003s

======= with =========
$ (ulimit -v 23250; src/du -s .)

$ ldd src/du
linux-vdso.so.1 =>  (0x00007fff76ca8000)
libc.so.6 => /lib64/libc.so.6 (0x00007f2a1f742000)
/lib64/ld-linux-x86-64.so.2 (0x00007f2a1fd61000)
 libmount.so.1 => /lib64/libmount.so.1 (0x00007f2a1faff000)
  libblkid.so.1 => /lib64/libblkid.so.1 (0x00007f2a1f501000)
  libuuid.so.1 => /lib64/libuuid.so.1 (0x00007f2a1f2fc000)
  libselinux.so.1 => /lib64/libselinux.so.1 (0x00007f2a1f0d7000)
  libpcre.so.1 => /lib64/libpcre.so.1 (0x00007f2a1ee69000)
  liblzma.so.5 => /lib64/liblzma.so.5 (0x00007f2a1ec44000)
  libdl.so.2 => /lib64/libdl.so.2 (0x00007f2a1ea40000)
  libpthread.so.0 => /lib64/libpthread.so.0 (0x00007f2a1e823000)

$ time src/du -s src/du.c >/dev/null
real    0m0.006s
user    0m0.001s
sys     0m0.005s


--------------030509030700010204070607
Content-Type: text/x-patch;
 name="gnulib-optional-libmount.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="gnulib-optional-libmount.patch"

=46rom dcfce9422ae2b1e9eb0c8c0bc70562f48b54fad4 Mon Sep 17 00:00:00 2001
From: =3D?UTF-8?q?P=3DC3=3DA1draig=3D20Brady?=3D <P@draigBrady.com>
Date: Tue, 20 Jan 2015 01:40:54 +0000
Subject: [PATCH] mountlist: only use libmount when specified

libmount can propagate device IDs provided by Linux in
/proc/self/mountinfo.  However there are currently many
shared libs dependencies introduced by libmount with
associated runtime and virt mem overhead.  Therefore don't
enable by default.

* m4/ls-mntd-fs.m4: Use --with-libmount to enable at build time.
Note the ac_cv_lib_libmount_mnt_table_parse_stream cache variable
had a typo and so was ineffective, thus there is no backwards
compatibility issue.
---
 ChangeLog        |  8 ++++++++
 m4/ls-mntd-fs.m4 | 26 ++++++++++++++++----------
 2 files changed, 24 insertions(+), 10 deletions(-)

diff --git a/ChangeLog b/ChangeLog
index 3a7ee14..801f7c0 100644
--- a/ChangeLog
+++ b/ChangeLog
@@ -1,3 +1,11 @@
+2015-01-20  P=C3=A1draig Brady  <P@draigBrady.com>
+
+	mountlist: only use libmount when specified
+	There are currently many shared libs dependencies introduced by
+	libmount with associated runtime and virt mem overhead.
+	Therefore don't enable by default.
+	* m4/ls-mntd-fs.m4: Use --with-libmount to enable at build time.
+
 2015-01-15  Paul Eggert  <eggert@cs.ucla.edu>
=20
 	time: port to MinGW32 3.21
diff --git a/m4/ls-mntd-fs.m4 b/m4/ls-mntd-fs.m4
index 0cc7ae2..59a951e 100644
--- a/m4/ls-mntd-fs.m4
+++ b/m4/ls-mntd-fs.m4
@@ -153,17 +153,23 @@ if test $ac_cv_func_getmntent =3D yes; then
          (4.3BSD, SunOS, HP-UX, Dynix, Irix)])
       AC_CHECK_FUNCS([hasmntopt])
=20
+      AC_ARG_WITH([libmount],
+        [AS_HELP_STRING([--with-libmount],
+          [use libmount if available to parse the system mount list.])],=

+        [],
+        dnl libmount has the advantage of propagating accurate device ID=
s for
+        dnl each entry, but the disadvantage of many dependent shared li=
bs
+        dnl with associated runtime startup overhead and virt mem usage.=

+        [with_libmount=3Dno])
+
       # Check for libmount to support /proc/self/mountinfo on Linux
-      AC_CACHE_VAL([ac_cv_lib_libmount_mnt_table_parse_stream],
-        [AC_CHECK_LIB([mount], [mnt_new_table_from_file],
-          ac_cv_lib_mount_mnt_table_parse_stream=3Dyes,
-          ac_cv_lib_mount_mnt_table_parse_stream=3Dno)])
-      if test $ac_cv_lib_mount_mnt_table_parse_stream =3D yes; then
-         AC_DEFINE([MOUNTED_PROC_MOUNTINFO], [1],
-           [Define if want to use /proc/self/mountinfo on Linux.])
-         LIBS=3D"-lmount $LIBS"
-      elif test -f /proc/self/mountinfo; then
-         AC_MSG_WARN([/proc/self/mountinfo present but libmount is missi=
ng.])
+      if test "x$with_libmount" !=3D xno; then
+        AC_CHECK_LIB([mount], [mnt_new_table_from_file],
+           [AC_DEFINE([MOUNTED_PROC_MOUNTINFO], [1],
+             [Define if want to use /proc/self/mountinfo on Linux.])
+            LIBS=3D"-lmount $LIBS"],
+           [test -f /proc/self/mountinfo &&
+             AC_MSG_WARN([/proc/self/mountinfo present but libmount miss=
ing.])])
       fi
     fi
   fi
--=20
2.1.0


--------------030509030700010204070607--
