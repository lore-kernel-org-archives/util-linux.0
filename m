Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:48169 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755786Ab3BJVdq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 10 Feb 2013 16:33:46 -0500
Received: by mail-wi0-f177.google.com with SMTP id hm14so2515579wib.4
        for <util-linux@vger.kernel.org>; Sun, 10 Feb 2013 13:33:45 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] build-sys: use AC_COMPILE_IFELSE
Date: Sun, 10 Feb 2013 21:33:39 +0000
Message-Id: <1360532021-23647-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The AC_TRY_COMPILE is obsolete.

Addresses: http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/Obsolete-Macros.html#index-AC_005fTRY_005fCOMPILE-2203
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/configure.ac b/configure.ac
index d26a686..7ec8bd7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -375,13 +375,19 @@ no:no)
 esac
 
 
-AC_MSG_CHECKING(whether program_invocation_short_name is defined)
-AC_TRY_COMPILE([#include <argp.h>],
-	       [program_invocation_short_name = "test";],
-	       AC_DEFINE(HAVE_PROGRAM_INVOCATION_SHORT_NAME, 1,
-			 [Define if program_invocation_short_name is defined])
-	       AC_MSG_RESULT(yes),
-	       AC_MSG_RESULT(no))
+AC_MSG_CHECKING([whether program_invocation_short_name is defined])
+AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
+	#include <argp.h>
+]], [[
+	program_invocation_short_name = "test";
+]])], [
+	AC_MSG_RESULT([yes])
+	AC_DEFINE([HAVE_PROGRAM_INVOCATION_SHORT_NAME], [1],
+		[Define if program_invocation_short_name is defined])
+], [
+	AC_MSG_RESULT([no])
+])
+
 
 AC_MSG_CHECKING([whether __progname is defined])
 AC_LINK_IFELSE([AC_LANG_PROGRAM([extern char *__progname;],
-- 
1.8.1.3

