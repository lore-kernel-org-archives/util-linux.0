Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:50119 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab2LPKo1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:27 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq7so1464953wib.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:26 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/14] tunelp: deprecation: remove command from default build
Date: Sun, 16 Dec 2012 10:43:56 +0000
Message-Id: <1355654642-22106-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is difficult to think think tunelp command being in use a lot.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/deprecated.txt |  4 ++++
 configure.ac                 | 10 ++++++++++
 sys-utils/Makemodule.am      |  2 ++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index 7d2dac1..666ed63 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -41,6 +41,10 @@ What:   losetup output format without --list
 
 --------------------------
 
+What:	tunelp
+Why:	parallel port printers are probably almost extinct devices
+
+--------------------------
 
 What:	elvtune
 Why:	useless for kernel >= 2.6.9
diff --git a/configure.ac b/configure.ac
index 3be3715..3e4f23c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -671,6 +671,7 @@ AC_ARG_ENABLE([most-builds],
 if test "x$enable_most_builds" = xyes; then
   enable_arch=check
   enable_elvtune=check
+  enable_tunelp=yes
   enable_last=yes
   enable_line=yes
   enable_mesg=yes
@@ -989,6 +990,15 @@ UL_REQUIRES_LINUX([elvtune])
 AM_CONDITIONAL(BUILD_ELVTUNE, test "x$build_elvtune" = xyes)
 
 
+AC_ARG_ENABLE([tunelp],
+  AS_HELP_STRING([--enable-tunelp], [build tunelp]),
+  [], enable_tunelp=no
+)
+UL_BUILD_INIT([tunelp])
+UL_REQUIRES_LINUX([tunelp])
+AM_CONDITIONAL(BUILD_TUNELP, test "x$build_tunelp" = xyes)
+
+
 AC_ARG_ENABLE([kill],
   AS_HELP_STRING([--disable-kill], [do not build kill]),
   [], enable_kill=check
diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index c7b1eb3..33112fb 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -73,9 +73,11 @@ dist_man_MANS += sys-utils/ldattach.8
 ldattach_SOURCES = sys-utils/ldattach.c
 ldattach_LDADD = $(LDADD) libcommon.la
 
+if BUILD_TUNELP
 usrsbin_exec_PROGRAMS += tunelp
 dist_man_MANS += sys-utils/tunelp.8
 tunelp_SOURCES = sys-utils/tunelp.c sys-utils/lp.h
+endif
 
 usrsbin_exec_PROGRAMS += rtcwake
 dist_man_MANS += sys-utils/rtcwake.8
-- 
1.8.0.2

