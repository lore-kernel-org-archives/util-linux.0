Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:48341 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752430Ab2BZVpn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 Feb 2012 16:45:43 -0500
Received: by eaah12 with SMTP id h12so1948179eaa.19
        for <util-linux@vger.kernel.org>; Sun, 26 Feb 2012 13:45:42 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] docs: do not overwrite ddate.1 manual
Date: Sun, 26 Feb 2012 22:45:40 +0100
Message-Id: <1330292740-7737-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following warning meant either english manual page overwrote ru
version, or otherway around.  Neither way that not intented.  This
patch will change ru version of the manual page to be installed to
<prefix><mandir>/ru/man1 directory.

man/ru/Makefile.am:4: warning: mandir was already defined in condition TRUE, which includes condition BUILD_DDATE ...
configure.ac:1: ... `mandir' previously defined here

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac       |    2 ++
 man/ru/Makefile.am |    5 ++---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index d3b298c..be9da27 100644
--- a/configure.ac
+++ b/configure.ac
@@ -833,6 +833,8 @@ AC_ARG_ENABLE([ddate],
 )
 UL_BUILD_INIT([ddate])
 AM_CONDITIONAL(BUILD_DDATE, test "x$build_ddate" = xyes)
+rumandir='${mandir}/ru/man1'
+AC_SUBST([rumandir])
 
 
 AC_ARG_ENABLE([agetty],
diff --git a/man/ru/Makefile.am b/man/ru/Makefile.am
index 31fafb9..64e88fd 100644
--- a/man/ru/Makefile.am
+++ b/man/ru/Makefile.am
@@ -1,7 +1,6 @@
 include $(top_srcdir)/config/include-Makefile.am
 
 if BUILD_DDATE
-mandir = @mandir@/ru
-dist_man_MANS =
-dist_man_MANS += ddate.1
+ruman_DATA = ddate.1
+EXTRA_DIST = $(ruman_DATA)
 endif
-- 
1.7.9.2

