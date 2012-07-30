Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:49572 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108Ab2G3HV3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 30 Jul 2012 03:21:29 -0400
Received: by wgbdr13 with SMTP id dr13so4575315wgb.1
        for <util-linux@vger.kernel.org>; Mon, 30 Jul 2012 00:21:28 -0700 (PDT)
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
In-Reply-To: <20120727115523.GA22051@foxbat.suse.cz>
References: <20120727115523.GA22051@foxbat.suse.cz>
Date: Mon, 30 Jul 2012 09:21:27 +0200
Message-ID: <CAG27Bk2UuPG3++nU5dZzKjJgAiNRP0PEFhFLZ0QBSDDU=tXNMg@mail.gmail.com>
Subject: Re: 2.22-rc1 build fails if configured with --disable-static
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Jul 27, 2012 at 1:55 PM, Petr Uzel <petr.uzel@suse.cz> wrote:
> I just encountered that 2.22-rc1 build fails if
>
> ./configure --disable-static
> make
>
> The error I'm getting is:

[snip]

> Anyone else getting this?

Yes, this seems to happen on all systems.  I am not sure if my
proposed fix is what is wanted.  Maybe there is a way to make
tests to compile, but I do not how with the current set up;
meaning tests mixed with lib code.


The following changes since commit 506eb04c3ddfda6257cfb332454fe7ce273a3230:

  docs: add note about partx output change (2012-07-27 10:17:10 +0200)

are available in the git repository at:

  git://github.com/kerolasa/lelux-utiliteetit.git disable-static

for you to fetch changes up to 2d0c4a51d7963286f785953eb292ba1d125f6b9f:


>From 2d0c4a51d7963286f785953eb292ba1d125f6b9f Mon Sep 17 00:00:00 2001
From: Sami Kerola <kerolasa@iki.fi>
Date: Mon, 30 Jul 2012 09:03:08 +0200
Subject: [PATCH] build-sys: do not build library tests when --disable-static
 is in use
Organization: TomTom International B.V.

Code for tests is in same directory with library code, which
means LDFLAGS=-static is needed to separate objects.  That also
means when configure has option --disable-static building of the
tests fail.

Alternatively code for tests could be moved to tests/helpers/
directory, which may happen in future.

Reported-by: Petr Uzel <petr.uzel@suse.cz>
References: http://www.spinics.net/lists/util-linux-ng/msg06648.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac               |    6 ++++++
 libblkid/src/Makemodule.am |    4 ++++
 libmount/src/Makemodule.am |    2 ++
 3 files changed, 12 insertions(+)

diff --git a/configure.ac b/configure.ac
index e32a1c1..d129bac 100644
--- a/configure.ac
+++ b/configure.ac
@@ -856,6 +856,12 @@ if test "x$build_fallocate" = xyes; then
 fi


+if test "$enable_shared" = no; then
+  AC_MSG_WARN([Disabling shared libraries is incompatible with
building library tests.])
+fi
+AM_CONDITIONAL(BUILD_LIBRARY_TESTS, test "x$enable_shared" = xyes)
+
+
 AC_ARG_ENABLE([unshare],
   AS_HELP_STRING([--disable-unshare], [do not build unshare]),
   [], enable_unshare=check
diff --git a/libblkid/src/Makemodule.am b/libblkid/src/Makemodule.am
index af1764c..7a1fe6c 100644
--- a/libblkid/src/Makemodule.am
+++ b/libblkid/src/Makemodule.am
@@ -131,6 +131,8 @@ EXTRA_DIST += \
 	libblkid/src/blkid.sym \
 	libblkid/src/blkid.h.in

+if !BUILD_LIBRARY_TESTS
+
 noinst_PROGRAMS += \
 	test_blkid_cache \
 	test_blkid_config \
@@ -210,6 +212,8 @@ test_blkid_verify_CFLAGS = $(blkid_tests_cflags)
 test_blkid_verify_LDFLAGS = $(blkid_tests_ldflags)
 test_blkid_verify_LDADD = $(blkid_tests_ldadd)

+endif	# BUILD_LIBRARY_TESTS
+
 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libblkid:
 	if test "$(usrlib_execdir)" != "$(libdir)"; then \
diff --git a/libmount/src/Makemodule.am b/libmount/src/Makemodule.am
index 211834e..a82f7a4 100644
--- a/libmount/src/Makemodule.am
+++ b/libmount/src/Makemodule.am
@@ -50,6 +50,7 @@ EXTRA_DIST += \
 	libmount/src/libmount.sym \
 	libmount/src/libmount.h.in

+if !BUILD_LIBRARY_TESTS
 noinst_PROGRAMS += \
 	test_mount_cache \
 	test_mount_context \
@@ -114,6 +115,7 @@ test_mount_version_CFLAGS = $(libmount_tests_cflags)
 test_mount_version_LDFLAGS = $(libmount_tests_ldflags)
 test_mount_version_LDADD = $(libmount_tests_ldadd)

+endif	# BUILD_LIBRARY_TESTS

 # move lib from $(usrlib_execdir) to $(libdir) if needed
 install-exec-hook-libmount:
-- 
1.7.9.5



-- 
   Sami Kerola
   http://www.iki.fi/kerolasa/
