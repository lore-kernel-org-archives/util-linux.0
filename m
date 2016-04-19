Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36502 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbcDSUfu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2016 16:35:50 -0400
Received: by mail-wm0-f66.google.com with SMTP id l6so8272695wml.3
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 13:35:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/5] build-sys: test functions does not return void
Date: Tue, 19 Apr 2016 21:35:41 +0100
Message-Id: <1461098145-2988-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
References: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Found using scan-build.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 5a00403..b48a24a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -491,7 +491,7 @@ AC_COMPILE_IFELSE([AC_LANG_PROGRAM([[
 
 AC_MSG_CHECKING([whether __progname is defined])
 AC_LINK_IFELSE([AC_LANG_PROGRAM([extern char *__progname;],
-	   [if (*__progname == 0) return;])],
+	   [if (*__progname == 0) return 1;])],
 	   AC_DEFINE([HAVE___PROGNAME], [1], [Define if __progname is defined])
 	   AC_MSG_RESULT([yes]),
 	   AC_MSG_RESULT([no]))
-- 
2.8.0

