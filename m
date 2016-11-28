Return-Path: util-linux-owner@vger.kernel.org
Received: from canardo.mork.no ([148.122.252.1]:57089 "EHLO canardo.mork.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932468AbcK1QLw (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 28 Nov 2016 11:11:52 -0500
From: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Bj=C3=B8rn=20Mork?= <bjorn@mork.no>
Subject: [PATCH 1/2] sulogin: make --timeout actually time out
Date: Mon, 28 Nov 2016 17:11:27 +0100
Message-Id: <20161128161128.2657-2-bjorn@mork.no>
In-Reply-To: <20161128161128.2657-1-bjorn@mork.no>
References: <20161128161128.2657-1-bjorn@mork.no>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Bjørn Mork <bjorn@mork.no>
---
 login-utils/sulogin.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 1c4313af4647..6a3890e80a16 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -644,7 +644,7 @@ static char *getpasswd(struct console *con)
 	eightbit = ((con->flags & CON_SERIAL) == 0 || (tty.c_cflag & (PARODD|PARENB)) == 0);
 	while (cp->eol == '\0') {
 		if (read(fd, &c, 1) < 1) {
-			if (errno == EINTR || errno == EAGAIN) {
+			if ((errno == EINTR && !alarm_rised) || errno == EAGAIN) {
 				xusleep(250000);
 				continue;
 			}
-- 
2.10.2

