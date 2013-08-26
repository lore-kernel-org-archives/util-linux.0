Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f176.google.com ([209.85.215.176]:46223 "EHLO
	mail-ea0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751554Ab3HZMUn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 Aug 2013 08:20:43 -0400
Received: by mail-ea0-f176.google.com with SMTP id q16so1578379ead.35
        for <util-linux@vger.kernel.org>; Mon, 26 Aug 2013 05:20:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] build-sys: pylibmount will not work when python3 is present
Date: Mon, 26 Aug 2013 13:20:29 +0100
Message-Id: <1377519629-7063-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

While compiling with up to date Archlinux I notice the recently added
pylibmount does not link correctly.  Failures inform fundamental types
such as PyFileObject and PyFile_Type being missing.

It seems automake AM_PATH_PYTHON will prefer the python in path, which
for this distribution right now is python3.  As some sort of go-around
one can install older python, and symlink it to earlier in PATH lookup.

$ ln -s /usr/bin/python2 $HOME/bin/python
$ export PATH=$HOME/bin:$PATH

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 982606e..35e1eab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1387,6 +1387,12 @@ AS_IF([test "x$with_python" = xyes], [
   ])
 ])
 
+dnl FIXME: the python3 should be fixed in future.
+AS_CASE([$PYTHON_VERSION],
+	[2.*], [],
+	[3.*], [AC_MSG_ERROR([pylibmount will not work with python3])],
+	[AC_MSG_ERROR([unanticipated python version])]
+)
 
 UL_BUILD_INIT([pylibmount], [check])
 UL_REQUIRES_HAVE([pylibmount], [python])
-- 
1.8.4

