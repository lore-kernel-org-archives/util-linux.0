Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:48113 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753447Ab3DMTz0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:26 -0400
Received: by mail-wi0-f174.google.com with SMTP id hj8so509669wib.1
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/33] build-sys: add --disable-setterm to ./configure
Date: Sat, 13 Apr 2013 20:54:35 +0100
Message-Id: <1365882901-11429-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac             | 6 ++++++
 term-utils/Makemodule.am | 3 ++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index dd5d3e1..497850c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1290,6 +1290,12 @@ UL_BUILD_INIT([pg])
 UL_REQUIRES_HAVE([pg], [ncurses], [ncurses or ncursesw library])
 AM_CONDITIONAL(BUILD_PG, test "x$build_pg" = xyes)
 
+AC_ARG_ENABLE([setterm],
+  AS_HELP_STRING([--disable-setterm], [do not build setterm]),
+  [], enable_setterm=yes
+)
+UL_BUILD_INIT([setterm])
+AM_CONDITIONAL(BUILD_SETTERM, test "x$build_setterm" = xyes)
 
 AC_ARG_ENABLE([schedutils],
   AS_HELP_STRING([--disable-schedutils], [do not build chrt, ionice, teskset]),
diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index f4fa92d..fdf4d98 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -24,7 +24,7 @@ agetty_LDADD = $(LDADD) libcommon.la
 endif # BUILD_AGETTY
 
 
-# TODO: add BUILD_SETTERM to configure.am
+if BUILD_SETTERM
 if HAVE_NCURSES
 if LINUX
 usrbin_exec_PROGRAMS += setterm
@@ -37,6 +37,7 @@ else
 setterm_LDADD = $(LDADD) @NCURSES_LIBS@
 endif
 endif
+endif
 
 
 if BUILD_RESET
-- 
1.8.2.1

