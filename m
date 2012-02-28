Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48599 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qph (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:37 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so2644946vcq.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:37 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 06/13] sulogin: remove CHECK_{DES,MD5} defines
Date: Tue, 28 Feb 2012 11:45:14 -0500
Message-Id: <1330447521-886-7-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Remove these always-true defines along with their #ifdef statements.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.c |    7 -------
 1 file changed, 7 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 27099ab..218b17e 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -51,9 +51,6 @@
 #  include <selinux/get_context_list.h>
 #endif
 
-#define CHECK_DES	1
-#define CHECK_MD5	1
-
 #define F_PASSWD	"/etc/passwd"
 #define F_SHADOW	"/etc/shadow"
 #define BINSH		"/bin/sh"
@@ -179,7 +176,6 @@ static int valid(const char *pass)
 
 	if (pass[0] == 0)
 		return 1;
-#if CHECK_MD5
 	if (pass[0] != '$')
 		goto check_des;
 
@@ -233,8 +229,6 @@ static int valid(const char *pass)
 	 */
 	return 1;
 check_des:
-#endif
-#if CHECK_DES
 	if (strlen(pass) != 13)
 		return 0;
 
@@ -245,7 +239,6 @@ check_des:
 		    *s != '.' && *s != '/')
 			return 0;
 	}
-#endif
 	return 1;
 }
 
-- 
1.7.9.2

