Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:49445 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751450AbdIRQKL (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 18 Sep 2017 12:10:11 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 0DCE3AC3E
        for <util-linux@vger.kernel.org>; Mon, 18 Sep 2017 16:10:10 +0000 (UTC)
To: util-linux@vger.kernel.org
From: Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] If using wide nscurses, use wide tinfo (tinfow)
Message-ID: <89952e72-6858-5a11-8157-995f75b3774b@suse.cz>
Date: Mon, 18 Sep 2017 18:10:09 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

util-linux checks for libtinfo, even if libncursesw is used. It can cause
ugly crashes inside ncurses, e. g. in cfdisk.

To prevent these crashes, never link non-wide libtinfo together with
libncursesw.

This change can cause non-detection of tinfo on some systems with
ncursesw but without tinfow. It would be easy to fix, but I am not sure
whether to check for a combination that can cause crash.

Signed-off-by: Stanislav Brabec <sbrabec@suse.cz>
---
 configure.ac | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index c534b49f2..02276eaf4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -905,18 +905,19 @@ AC_ARG_WITH([tinfo], AS_HELP_STRING([--without-tinfo], [compile without libtinfo
   [], [with_tinfo=auto]
 )
 have_tinfo=no
+AS_IF([test "x$have_ncursesw" = xyes], [tinfo_name=tinfow], [tinfo_name=tinfo])
 AS_IF([test "x$with_tinfo" != xno], [
   dnl Try pkg-config for libtinfo
-  PKG_CHECK_MODULES(TINFO, [tinfo], [
+  PKG_CHECK_MODULES(TINFO, [$tinfo_name], [
     dnl pkg-config success
     have_tinfo=yes
-    UL_PKG_STATIC([TINFO_LIBS_STATIC], [tinfo])], [
+    UL_PKG_STATIC([TINFO_LIBS_STATIC], [$tinfo_name])], [
 
     dnl If pkg-config failed, fall back to classic searching.
-    AC_CHECK_LIB([tinfo], [tgetent], [
+    AC_CHECK_LIB([$tinfo_name], [tgetent], [
        have_tinfo=yes
-       TINFO_LIBS="-ltinfo"
-       TINFO_LIBS_STATIC="-ltinfo"
+       TINFO_LIBS="-l$tinfo_name"
+       TINFO_LIBS_STATIC="-l$tinfo_name"
        TINFO_CFLAGS=""])
   ])
 ])
-- 
2.14.1

-- 
Best Regards / S pozdravem,

Stanislav Brabec
software developer
---------------------------------------------------------------------
SUSE LINUX, s. r. o.                         e-mail: sbrabec@suse.com
Køi¾íkova 148/34 (Corso IIa)                  tel: +49 911 7405384547
186 00 Praha 8-Karlín                          fax:  +420 284 084 001
Czech Republic                                    http://www.suse.cz/
PGP: 830B 40D5 9E05 35D8 5E27 6FA3 717C 209F A04F CD76
