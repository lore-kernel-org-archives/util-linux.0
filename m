Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:56140
        "EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754549AbcK1Qdy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 28 Nov 2016 11:33:54 -0500
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] sulogin: bail out from getpasswd(...) on timeout
Date: Mon, 28 Nov 2016 17:24:50 +0100
Message-Id: <1480350290-7875-2-git-send-email-andreas@fatal.se>
In-Reply-To: <1480350290-7875-1-git-send-email-andreas@fatal.se>
References: <1480350290-7875-1-git-send-email-andreas@fatal.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If timeout happens while waiting in prompt, bail out instead
of retrying.

Reported-by: Bjørn Mork <bjorn@mork.no>
Addresses: http://bugs.debian.org/846107
Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 login-utils/sulogin.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 43117b2..79a9274 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -645,6 +645,10 @@ static char *getpasswd(struct console *con)
 	while (cp->eol == '\0') {
 		if (read(fd, &c, 1) < 1) {
 			if (errno == EINTR || errno == EAGAIN) {
+				if (alarm_rised) {
+					ret = NULL;
+					goto quit;
+				}
 				xusleep(250000);
 				continue;
 			}
-- 
2.10.2

