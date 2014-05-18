Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:58937 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:24 -0400
Received: by mail-wg0-f44.google.com with SMTP id a1so6850458wgh.27
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 14/17] setterm: improve error messages
Date: Sun, 18 May 2014 15:05:38 +0100
Message-Id: <1400421941-14244-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reuse messages to make translation work easier.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 2a0162e..2b1901f 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -262,7 +262,7 @@ static int parse_ulhb_color(char **argv, int *optind)
 	else {
 		color = strtoint_or_err(color_name);
 		if (color < BLACK || DEFAULT < color)
-			errx(EXIT_FAILURE, _("argument error"));
+			errx(EXIT_FAILURE, _("argument error: %s"), color_name);
 	}
 	if (bright && (color == BLACK || color == GREY))
 		errx(EXIT_FAILURE, _("argument error: bright %s is not supported"), color_name);
@@ -720,7 +720,7 @@ static void show_tabs(void)
 
 static void __attribute__((__noreturn__)) read_error(struct setterm_control *ctl)
 {
-	err(EXIT_DUMPFILE, _("Couldn't read %s"), ctl->in_device);
+	err(EXIT_DUMPFILE, _("cannot read %s"), ctl->in_device);
 }
 
 static int open_snapshot_device(struct setterm_control *ctl)
-- 
1.9.2

