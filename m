Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:50020 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750873Ab3I2JvT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 29 Sep 2013 05:51:19 -0400
Received: by mail-we0-f181.google.com with SMTP id p61so4299011wes.40
        for <util-linux@vger.kernel.org>; Sun, 29 Sep 2013 02:51:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] build-sys: simplify python detection
Date: Sun, 29 Sep 2013 10:51:13 +0100
Message-Id: <1380448273-13445-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows './configure --enable-most-builds' and 'make distcheck' to
work when both python2 and python3 are installed, and user has set python
version preference using symlink and PATH order.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/configure.ac b/configure.ac
index 553228a..1f02bd8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1386,20 +1386,14 @@ AS_IF([test "x$with_python" != xno], [
   # (minimal version is 2) but if major version is explicitly specified by
   # --with-python=2 or --with-python=3 then we look for PKG module "python2" or
   # "python3".
-  pymajor="2"
-  modname="python"
-  AS_IF([test "x$withval" != xno -a "x$withval" != xyes], [
-    pymajor="$withval"
-    modname="python${pymajor}"
-  ])
-  PKG_CHECK_MODULES(PYTHON,[${modname} >= $pymajor],
-		           [have_python=yes
-			    AM_PATH_PYTHON([$pymajor])],
-			   [have_python=no])
+  AS_IF([test "x$withval" != xno -a "x$withval" != xyes],
+	[pymajor="$withval"; PYTHON=python${pymajor}], [pymajor="2"])
+  AM_PATH_PYTHON([$pymajor], [have_python=yes], [have_python=no])
   AS_CASE([$with_python:$have_python],
     [yes:no],
-      [AC_MSG_ERROR([python selected but libpython not found])],
+      [AC_MSG_ERROR([python selected but libpython not found])]
   )
+  PKG_CHECK_MODULES([PYTHON], [python-$PYTHON_VERSION])
 
   UL_BUILD_INIT([pylibmount], [check])
   UL_REQUIRES_HAVE([pylibmount], [python], [libpython])
@@ -1541,7 +1535,8 @@ AC_MSG_RESULT([
 	ldflags:           ${LDFLAGS}
 	suid ldflags:      ${SUID_LDFLAGS}
 
-	Python:            ${PYTHON_VERSION}
+	Python:            ${PYTHON}
+	Python version:    ${PYTHON_VERSION}
 	Python libs:       ${pyexecdir}
 
 	Bash completions:  ${with_bashcompletiondir}
-- 
1.8.4

