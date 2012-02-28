Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48599 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qpk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:40 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so2644946vcq.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:40 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 08/13] sulogin: use size_t for iterator to avoid cast
Date: Tue, 28 Feb 2012 11:45:16 -0500
Message-Id: <1330447521-886-9-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index b6cbd05..5894f85 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -292,7 +292,7 @@ static char *getpasswd(char *crypted)
 	struct termios old, tty;
 	static char pass[128];
 	char *ret = pass;
-	int i;
+	size_t i;
 
 	if (crypted[0])
 		printf("Give root password for maintenance\n");
@@ -318,7 +318,7 @@ static char *getpasswd(char *crypted)
 	if (read(0, pass, sizeof(pass) - 1) <= 0)
 		ret = NULL;
 	else {
-		for (i = 0; i < (int)sizeof(pass) && pass[i]; i++)
+		for (i = 0; i < sizeof(pass) && pass[i]; i++)
 			if (pass[i] == '\r' || pass[i] == '\n') {
 				pass[i] = 0;
 				break;
-- 
1.7.9.2

