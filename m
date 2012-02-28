Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33189 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qpm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:42 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so1997660vbb.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:42 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 09/13] sulogin: get rid of calls to /bin/sash
Date: Tue, 28 Feb 2012 11:45:17 -0500
Message-Id: <1330447521-886-10-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This probably doesn't exist on most systems, and if the root's shell and
/bin/sh fail to execute, it seems unlikely that /bin/sash will save us.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 5894f85..451bca4 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -54,7 +54,6 @@
 #define F_PASSWD	"/etc/passwd"
 #define F_SHADOW	"/etc/shadow"
 #define BINSH		"/bin/sh"
-#define STATICSH	"/bin/sash"
 
 static int timeout;
 static int profile;
@@ -400,12 +399,6 @@ static void sushell(struct passwd *pwd)
 	setenv("SHELL", BINSH, 1);
 	execl(BINSH, profile ? "-sh" : "sh", NULL);
 	perror(BINSH);
-
-	/* Fall back to staticly linked shell if both the users shell
-	   and /bin/sh failed to execute. */
-	setenv("SHELL", STATICSH, 1);
-	execl(STATICSH, STATICSH, NULL);
-	perror(STATICSH);
 }
 
 static void usage(void)
-- 
1.7.9.2

