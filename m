Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f177.google.com ([209.85.214.177]:42283 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751130AbaCHRCN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Mar 2014 12:02:13 -0500
Received: by mail-ob0-f177.google.com with SMTP id wo20so5216066obc.22
        for <util-linux@vger.kernel.org>; Sat, 08 Mar 2014 09:02:13 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/5] build-sys: sort gitignore files
Date: Sat,  8 Mar 2014 11:01:55 -0600
Message-Id: <1394298117-16531-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394298117-16531-1-git-send-email-kerolasa@iki.fi>
References: <1394298117-16531-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use 'LC_ALL=C sort -fu' order for all lists.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 .gitignore                  | 67 ++++++++++++++++++++++-----------------------
 libblkid/docs/.gitignore    | 16 +++++------
 libblkid/samples/.gitignore |  4 +--
 libmount/docs/.gitignore    | 16 +++++------
 po/.gitignore               | 24 ++++++++--------
 sys-utils/.gitignore        |  8 +++---
 6 files changed, 67 insertions(+), 68 deletions(-)

diff --git a/.gitignore b/.gitignore
index 91b625f..bafe258 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,59 +1,58 @@
 #
 # generic stuff
 #
-*~
-*.[ao]
-*.static
-*.so
-*.lo
-*.la
-*.so.*
-*.pc
 *.gcda
 *.gcno
 *.gcov
+*.la
+*.lo
+*.pc
 *.pyc
+*.so
+*.so.*
+*.static
 *.vim
-Makefile
+*.[ao]
+*~
+.clang_complete
+.deps
+.dirstamp
+.libs
+.tarball-version
+.version
+ABOUT-NLS
 aclocal.m4
 autom4te.cache
-stamp-h.in
-Makefile.in
-configure
+compile
 config.cache
+config.guess
 config.h
 config.h.in
 config.log
-config.guess
+config.rpath
 config.status
 config.sub
-stamp-h
-stamp-h1
-update.log
-m4/*.m4
-aclocal.m4
-ABOUT-NLS
-config.rpath
-mkinstalldirs
-compile
+config/ltmain.sh
+config/test-driver
+configure
+cscope.out
 depcomp
-install-sh
 INSTALL
-missing
+install-sh
 libtool
-cscope.out
+m4/*.m4
+Makefile
+Makefile.in
+missing
+mkinstalldirs
+stamp-h
+stamp-h.in
+stamp-h1
 tags
-.deps
-.libs
-.tarball-version
-.version
-.dirstamp
-.clang_complete
-config/ltmain.sh
-config/test-driver
 test-suite.log
 tests/run.sh.log
 tests/run.sh.trs
+update.log
 
 # libuuid depends on AX_TLS macro
 !m4/tls.m4
@@ -70,6 +69,7 @@ tests/run.sh.trs
 #
 /addpart
 /agetty
+/blkdiscard
 /blkid
 /blockdev
 /cal
@@ -98,7 +98,6 @@ tests/run.sh.trs
 /fsck.minix
 /fsfreeze
 /fstrim
-/blkdiscard
 /getopt
 /hexdump
 /hwclock
diff --git a/libblkid/docs/.gitignore b/libblkid/docs/.gitignore
index e40d782..f91f93d 100644
--- a/libblkid/docs/.gitignore
+++ b/libblkid/docs/.gitignore
@@ -1,18 +1,18 @@
-*.args
-*.bak
-*.types
 *-decl-list.txt
 *-decl.txt
+*-overrides.txt
+*-undeclared.txt
+*-undocumented.txt
+*-unused.txt
+*.args
+*.bak
 *.hierarchy
-html/*
 *.interfaces
-*-overrides.txt
 *.prerequisites
 *.signals
 *.stamp
+*.types
+html/*
 tmpl/*
-*-undeclared.txt
-*-undocumented.txt
-*-unused.txt
 version.xml
 xml/*
diff --git a/libblkid/samples/.gitignore b/libblkid/samples/.gitignore
index 409e5cf..4efeb62 100644
--- a/libblkid/samples/.gitignore
+++ b/libblkid/samples/.gitignore
@@ -1,4 +1,4 @@
-topology
-partitions
 mkfs
+partitions
 superblocks
+topology
diff --git a/libmount/docs/.gitignore b/libmount/docs/.gitignore
index e40d782..f91f93d 100644
--- a/libmount/docs/.gitignore
+++ b/libmount/docs/.gitignore
@@ -1,18 +1,18 @@
-*.args
-*.bak
-*.types
 *-decl-list.txt
 *-decl.txt
+*-overrides.txt
+*-undeclared.txt
+*-undocumented.txt
+*-unused.txt
+*.args
+*.bak
 *.hierarchy
-html/*
 *.interfaces
-*-overrides.txt
 *.prerequisites
 *.signals
 *.stamp
+*.types
+html/*
 tmpl/*
-*-undeclared.txt
-*-undocumented.txt
-*-unused.txt
 version.xml
 xml/*
diff --git a/po/.gitignore b/po/.gitignore
index 8263386..432d9c1 100644
--- a/po/.gitignore
+++ b/po/.gitignore
@@ -1,16 +1,16 @@
-stamp-po
-remove-potcdate.sin
-remove-potcdate.sed
-quot.sed
-insert-header.sin
 *.gmo
-en@quot.header
-en@boldquot.header
 boldquot.sed
-Rules-quot
+en@boldquot.header
+en@quot.header
+insert-header.sin
+Makefile
+Makefile.in
+Makefile.in.in
+Makevars.template
 POTFILES
 POTFILES.in
-Makevars.template
-Makefile.in.in
-Makefile.in
-Makefile
+quot.sed
+remove-potcdate.sed
+remove-potcdate.sin
+Rules-quot
+stamp-po
diff --git a/sys-utils/.gitignore b/sys-utils/.gitignore
index 97e6e60..8d8737a 100644
--- a/sys-utils/.gitignore
+++ b/sys-utils/.gitignore
@@ -2,19 +2,19 @@ i386.8
 ia64.8
 linux32.8
 linux64.8
+mips.8
 mips32.8
 mips64.8
-mips.8
+parisc.8
 parisc32.8
 parisc64.8
-parisc.8
+ppc.8
 ppc32.8
 ppc64.8
-ppc.8
 s390.8
 s390x.8
+sparc.8
 sparc32.8
 sparc32bash.8
 sparc64.8
-sparc.8
 x86_64.8
-- 
1.9.0

