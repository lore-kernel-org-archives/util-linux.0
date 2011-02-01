Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-bw0-f46.google.com ([209.85.214.46]:48877 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750951Ab1BALNh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 1 Feb 2011 06:13:37 -0500
Received: by bwz15 with SMTP id 15so6189381bwz.19
        for <util-linux@vger.kernel.org>; Tue, 01 Feb 2011 03:13:36 -0800 (PST)
From: Marek Otahal <markotahal@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] configure.ac : remove enable_foo checks for non-linux OSs
Date: Tue, 1 Feb 2011 12:12:45 +0100
Cc: Karel Zak <kzak@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart6829151.s1GsRS97JQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201102011213.23641.markotahal@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart6829151.s1GsRS97JQ
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,=20

I implemented this idea from the TODO list, basically it sets some enable_f=
oo=20
constants for non-linux systems to "no" at start and then we can skip if-te=
sts=20
on different places.=20

=46rom the todo:=20

build-sys
=2D-------

 - we use something like

        AC_ARG_ENABLE(...., enable_foo=3Dcheck)
        build_foo=3Dyes
        if test "x$enable_foo" =3D xcheck; then
                if test "x$linux_os" =3D xno; then
                        build_foo=3Dno
                fi
        fi
        AM_CONDITIONAL(BUILD_LIBMOUNT, test "x$build_foo" =3D xyes)

   for Linux-only utils in configure.ac. It would be nice to set all defaul=
ts
   for all $enable_ variables at begin of the configure script according to
   $linux_os. Something like:

        if test "x$linux_os" =3D xno
                enable_mount=3Dno
                enable_libmount=3Dno
                enable_lsblk=3Dno
        fi

   then we can remove all "if test "x$enable_foo" =3D xcheck;" stuff from t=
he=20
rest
   of the configure script.


Thanks, Marek

PS: The TODO list is a good thing, if you write the task more detailed (lik=
e=20
this one), more people can easily implement it.=20



Signed-off-by: Marek Otahal <markotahal@gmail.com>
=2D--
diff -Nruw util-linux/configure.ac util-linux-mmm/configure.ac

=2D-- util-linux/configure.ac     2011-02-01 00:26:23.603333351 +0100
+++ util-linux-mmm/configure.ac 2011-02-01 11:20:08.860000019 +0100
@@ -334,13 +334,52 @@
   AS_HELP_STRING([--disable-mount], [do not build mount utilities]),
   [], enable_mount=3Dcheck
 )
=2Dbuild_mount=3Dyes
=2Dif test "x$enable_mount" =3D xcheck; then
=2D  if test "x$linux_os" =3D xno; then
+
+AC_ARG_ENABLE([libmount],
+  AS_HELP_STRING([--disable-libmount], [do not build libmount]),
+  [], enable_libmount=3Dcheck
+)
+
+C_ARG_ENABLE([switch_root],
+  AS_HELP_STRING([--disable-switch_root], [do not build switch_root]),
+  [], enable_switch_root=3Dcheck
+)
+
+AC_ARG_ENABLE([pivot_root],
+  AS_HELP_STRING([--disable-pivot_root], [do not build pivot_root]),
+  [], enable_pivot_root=3Dcheck
+)
+
+AC_ARG_ENABLE([fallocate],
+  AS_HELP_STRING([--disable-fallocate], [do not build fallocate]),
+  [], enable_fallocate=3Dcheck
+)
+
+AC_ARG_ENABLE([unshare],
+  AS_HELP_STRING([--disable-unshare], [do not build unshare]),
+  [], enable_unshare=3Dcheck
+)
+
+
+# we do not build these for non-linux os
+if test "x$linux_os" =3D xno
     AC_MSG_WARN([non-linux system; do not build mount utilities])
     build_mount=3Dno
+  AC_MSG_WARN([non-linux system; do not build libmount])
+  build_libmount=3Dno
+  AC_MSG_WARN([non-linux system; do not build switch_root])
+  build_switch_root=3Dno
+  AC_MSG_WARN([non-linux system; do not build pivot_root])
+  build_pivot_root=3Dno
+  AC_MSG_WARN([non-linux system; do not build fallocate])
+  build_fallocate=3Dno
+  AC_MSG_WARN([non-linux system; do not build unshare])
+  build_unshare=3Dno
   fi
=2Delif test "x$enable_mount" =3D xno; then
+
+
+build_mount=3Dyes
+if test "x$enable_mount" =3D xno; then
     build_mount=3Dno
 fi
 AM_CONDITIONAL(BUILD_MOUNT, test "x$build_mount" =3D xyes)
@@ -459,17 +498,8 @@
 AC_ARG_VAR([BLKID_LIBS_STATIC], [-l options for linking statically with=20
blkid])
=20
=20
=2DAC_ARG_ENABLE([libmount],
=2D  AS_HELP_STRING([--disable-libmount], [do not build libmount]),
=2D  [], enable_libmount=3Dcheck
=2D)
 build_libmount=3Dyes
=2Dif test "x$enable_libmount" =3D xcheck; then
=2D  if test "x$linux_os" =3D xno; then
=2D    AC_MSG_WARN([non-linux system; do not build libmount])
=2D    build_libmount=3Dno
=2D  fi
=2Delif test "x$enable_libmount" =3D xno; then
+if test "x$enable_libmount" =3D xno; then
     build_libmount=3Dno
 fi
=20
@@ -872,19 +902,10 @@
 AM_CONDITIONAL(BUILD_CRAMFS, test "x$build_cramfs" =3D xyes)
=20
=20
=2DAC_ARG_ENABLE([switch_root],
=2D  AS_HELP_STRING([--disable-switch_root], [do not build switch_root]),
=2D  [], enable_switch_root=3Dcheck
=2D)
+build_switch_root=3Dyes
 if test "x$enable_switch_root" =3D xno; then
   build_switch_root=3Dno
=2Delse
=2D  build_switch_root=3Dyes
=2D  case $enable_switch_root:$linux_os in
=2D  yes:no) AC_MSG_ERROR([switch_root selected for non-linux system]);;
=2D  check:no) AC_MSG_WARN([non-linux system; do not build switch_root])
=2D            build_switch_root=3Dno;;
=2D  esac
+fi
   if test "x$build_switch_root" =3D xyes; then
     case $enable_switch_root:$have_openat in
     yes:no) AC_MSG_ERROR([switch_root selected but openat() function not=20
found]);;
@@ -892,23 +913,13 @@
               build_switch_root=3Dno;;
     esac
   fi
=2Dfi
 AM_CONDITIONAL(BUILD_SWITCH_ROOT, test "x$build_switch_root" =3D xyes)
=20
=20
=2DAC_ARG_ENABLE([pivot_root],
=2D  AS_HELP_STRING([--disable-pivot_root], [do not build pivot_root]),
=2D  [], enable_pivot_root=3Dcheck
=2D)
+build_pivot_root=3Dyes
 if test "x$enable_pivot_root" =3D xno; then
   build_pivot_root=3Dno
=2Delse
=2D  build_pivot_root=3Dyes
=2D  case $enable_pivot_root:$linux_os in
=2D  yes:no) AC_MSG_ERROR([pivot_root selected for non-linux system]);;
=2D  check:no) AC_MSG_WARN([non-linux system; do not build pivot_root])
=2D            build_pivot_root=3Dno;;
=2D  esac
+fi
   if test "x$build_pivot_root" =3D xyes; then
     case $enable_pivot_root:$util_cv_syscall_pivot_root in
     yes:no) AC_MSG_ERROR([pivot_root selected but pivot_root syscall not=20
found]);;
@@ -916,23 +927,13 @@
               build_pivot_root=3Dno;;
     esac
   fi
=2Dfi
 AM_CONDITIONAL(BUILD_PIVOT_ROOT, test "x$build_pivot_root" =3D xyes)
=20
=20
=2DAC_ARG_ENABLE([fallocate],
=2D  AS_HELP_STRING([--disable-fallocate], [do not build fallocate]),
=2D  [], enable_fallocate=3Dcheck
=2D)
+build_fallocate=3Dyes
 if test "x$enable_fallocate" =3D xno; then
   build_fallocate=3Dno
=2Delse
=2D  build_fallocate=3Dyes
=2D  case $enable_fallocate:$linux_os in
=2D  yes:no) AC_MSG_ERROR([fallocate selected for non-linux system]);;
=2D  check:no) AC_MSG_WARN([non-linux system; do not build fallocate])
=2D            build_fallocate=3Dno;;
=2D  esac
+fi
   if test "x$build_fallocate" =3D xyes; then
     case $enable_fallocate:$util_cv_syscall_fallocate in
     yes:no) AC_MSG_ERROR([fallocate selected but fallocate syscall not=20
found]);;
@@ -940,23 +941,13 @@
               build_fallocate=3Dno;;
     esac
   fi
=2Dfi
 AM_CONDITIONAL(BUILD_FALLOCATE, test "x$build_fallocate" =3D xyes)
=20
=20
=2DAC_ARG_ENABLE([unshare],
=2D  AS_HELP_STRING([--disable-unshare], [do not build unshare]),
=2D  [], enable_unshare=3Dcheck
=2D)
+build_unshare=3Dyes
 if test "x$enable_unshare" =3D xno; then
   build_unshare=3Dno
=2Delse
=2D  build_unshare=3Dyes
=2D  case $enable_unshare:$linux_os in
=2D  yes:no) AC_MSG_ERROR([unshare selected for non-linux system]);;
=2D  check:no) AC_MSG_WARN([non-linux system; do not build unshare])
=2D            build_unshare=3Dno;;
=2D  esac
+fi
   if test "x$build_unshare" =3D xyes; then
     case $enable_unshare:$util_cv_syscall_unshare in
     yes:no) AC_MSG_ERROR([unshare selected but unshare syscall not found])=
;;
@@ -964,11 +955,9 @@
               build_unshare=3Dno;;
     esac
   fi
=2Dfi
 AM_CONDITIONAL(BUILD_UNSHARE, test "x$build_unshare" =3D xyes)
=20
=20
=2D
 AC_ARG_ENABLE([elvtune],
   AS_HELP_STRING([--enable-elvtune], [build elvtune (only works with 2.2 a=
nd=20
2.4 kernels)]),
   [], enable_elvtune=3Dno

=2D-=20
Marek Otahal :o)

--nextPart6829151.s1GsRS97JQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAABAgAGBQJNR+quAAoJEKvC5zPWx/wKzsAP/2B6ijZU5TUPb6vwW4pHo0Tx
uJpK9dY6743OppRQR3uo1JoJVn0pLlCtJVZiDJyR6wBWe/1ocgnBFM17NGWrnNcq
Vz6Sw2kDGX3MwPi5Wk3BJZBzD/RW2/HkuR+nfqbN4OVusuZy/o0GPVFlpNbChjyN
yipFCvBHdRmOpq9nJsHZBrByeRhx2sxDVY53KUlS3YCPGHZ+4vYKUx99f/tEWYGV
Xt87SEmQhoasheAOQGvia3VU2u/MHHSlvRVduYDxXHUJW81DzU1/+q581VMmvb0p
RtLf+fqIocloz8IJLmv+YF7vkeO6quN6q/HhRtwB3gTvIbVLrFGtbsmVA8i2/Dkm
jXwbSSKRcYADfmvgtXgVXCUkZ7B5o9Rcm+I2iiulczgx6oqDuBp9z3pbkDRsrHmy
NWkvIMEt3lzifW/KOFQlTt/CDgiRdoT4z5K8aDa4sEPVZ08qxSTLC5vGwX3fzfyj
cS1aVQPyg36k14HllHhfDdFn3JA4z585sQHFTchNSTvudYwEr5sUb15saUH12MA7
AjG8dfP3TMFGCMIjqt/LfTwI1QAFHAPE4beV5iqkvhhSeZJ8UV6l2nruCueIX5fo
1PNQguFWnYCZRWh/gT3E9c2pQNUqo4WblWc+AMy/xH8zQ2fsu6nWEwV3JIhd2ez5
NyjmqcEkLWAX/92mwqJ2
=CsQB
-----END PGP SIGNATURE-----

--nextPart6829151.s1GsRS97JQ--
