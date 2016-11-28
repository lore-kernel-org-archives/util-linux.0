Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:56138
        "EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754549AbcK1Qdv (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 28 Nov 2016 11:33:51 -0500
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] sulogin: make getpasswd(...) return NULL on ^D
Date: Mon, 28 Nov 2016 17:24:49 +0100
Message-Id: <1480350290-7875-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This makes the caller bail out early instead of evaluating the
input as a password.

Reported-by: Bjørn Mork <bjorn@mork.no>
Addresses: http://bugs.debian.org/846112
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 login-utils/sulogin.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 1c4313a..43117b2 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -695,6 +695,7 @@ static char *getpasswd(struct console *con)
 				ptr--;
 			break;
 		case CEOF:
+			ret = NULL;
 			goto quit;
 		default:
 			if ((size_t)(ptr - &pass[0]) >= (sizeof(pass) -1 )) {
-- 
2.10.2

