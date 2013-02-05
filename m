Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gh0-f177.google.com ([209.85.160.177]:34127 "EHLO
	mail-gh0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750786Ab3BEFcm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 5 Feb 2013 00:32:42 -0500
Received: by mail-gh0-f177.google.com with SMTP id g22so1741670ghb.8
        for <util-linux@vger.kernel.org>; Mon, 04 Feb 2013 21:32:41 -0800 (PST)
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH] Test for secure_getenv too.
Date: Tue,  5 Feb 2013 02:08:03 -0300
Message-Id: <1360040883-29778-1-git-send-email-crrodriguez@opensuse.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In current glibc versions, internal __secure_getenv
no longer exists and was replaced by secure_getenv()

Signed-off-by: Cristian Rodríguez <crrodriguez@opensuse.org>
---
 configure.ac | 1 +
 lib/env.c    | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9024809..39c7f20 100644
--- a/configure.ac
+++ b/configure.ac
@@ -298,6 +298,7 @@ AC_CHECK_DECL([strsignal],
 
 AC_CHECK_FUNCS([ \
 	__fpending \
+	secure_getenv \
 	__secure_getenv \
 	err \
 	errx \
diff --git a/lib/env.c b/lib/env.c
index 04e0f0b..9f81b44 100644
--- a/lib/env.c
+++ b/lib/env.c
@@ -100,8 +100,9 @@ char *safe_getenv(const char *arg)
 		return NULL;
 #endif
 #endif
-
-#ifdef HAVE___SECURE_GETENV
+#ifdef HAVE_SECURE_GETENV
+return secure_getenv(arg);
+#elif HAVE___SECURE_GETENV
 	return __secure_getenv(arg);
 #else
 	return getenv(arg);
-- 
1.8.1.1

