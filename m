Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:36397 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbbJaTVg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:36 -0400
Received: by wicfx6 with SMTP id fx6so28544031wic.1
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/12] agetty: fix chown(3), chmod(3) and open(3) race
Date: Sat, 31 Oct 2015 19:21:16 +0000
Message-Id: <1446319284-24778-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 0237b79..a9c8785 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1004,23 +1004,23 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 		     (int)sizeof(buf)) || (len < 0))
 			log_err(_("/dev/%s: cannot open as standard input: %m"), tty);
 
+		/* Open the tty as standard input. */
+		if ((fd = open(buf, O_RDWR|O_NOCTTY|O_NONBLOCK, 0)) < 0)
+			log_err(_("/dev/%s: cannot open as standard input: %m"), tty);
+
 		/*
 		 * There is always a race between this reset and the call to
 		 * vhangup() that s.o. can use to get access to your tty.
 		 * Linux login(1) will change tty permissions. Use root owner and group
 		 * with permission -rw------- for the period between getty and login.
 		 */
-		if (chown(buf, 0, gid) || chmod(buf, (gid ? 0620 : 0600))) {
+		if (fchown(fd, 0, gid) || fchmod(fd, (gid ? 0620 : 0600))) {
 			if (errno == EROFS)
 				log_warn("%s: %m", buf);
 			else
 				log_err("%s: %m", buf);
 		}
 
-		/* Open the tty as standard input. */
-		if ((fd = open(buf, O_RDWR|O_NOCTTY|O_NONBLOCK, 0)) < 0)
-			log_err(_("/dev/%s: cannot open as standard input: %m"), tty);
-
 		/* Sanity checks... */
 		if (fstat(fd, &st) < 0)
 			log_err("%s: %m", buf);
-- 
2.6.2

