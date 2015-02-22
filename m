Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:53486 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752224AbbBVOo0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:26 -0500
Received: by mail-wg0-f43.google.com with SMTP id z12so21336062wgg.2
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:24 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 15/31] more: check open(3) return value
Date: Sun, 22 Feb 2015 14:43:11 +0000
Message-Id: <1424616207-747-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 0c1bc96..2813ce7 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -1082,7 +1082,10 @@ static void execute(struct more_control *ctl, char *filename, char *cmd, ...)
 	if (id == 0) {
 		if (!isatty(STDIN_FILENO)) {
 			close(STDIN_FILENO);
-			open("/dev/tty", 0);
+			if (open("/dev/tty", 0) < 0) {
+				fprintf(stderr, _("cannot open %s"), "/dev/tty\n");
+				goto err;
+			}
 		}
 
 		va_start(argp, cmd);
@@ -1125,6 +1128,7 @@ static void execute(struct more_control *ctl, char *filename, char *cmd, ...)
 		fputs(_("can't fork\n"), stderr);
 	set_tty(ctl);
 	puts("------------------------");
+err:
 	prompt(ctl, filename);
 }
 
-- 
2.3.0

