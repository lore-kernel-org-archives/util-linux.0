Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36528 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750835AbdDBIOn (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 2 Apr 2017 04:14:43 -0400
Received: by mail-wm0-f66.google.com with SMTP id x124so5825446wmf.3
        for <util-linux@vger.kernel.org>; Sun, 02 Apr 2017 01:14:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] agetty: remove variable that is set but not read
Date: Sun,  2 Apr 2017 09:14:34 +0100
Message-Id: <20170402081436.861-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/agetty.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index da6c9e5e3..6a2085a3c 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -1279,15 +1279,10 @@ static void termio_init(struct options *op, struct termios *tp)
 
 	/* Check for terminal size and if not found set default */
 	if (ioctl(STDIN_FILENO, TIOCGWINSZ, &ws) == 0) {
-		int set = 0;
-		if (ws.ws_row == 0) {
+		if (ws.ws_row == 0)
 			ws.ws_row = 24;
-			set++;
-		}
-		if (ws.ws_col == 0) {
+		if (ws.ws_col == 0)
 			ws.ws_col = 80;
-			set++;
-		}
 		if (ioctl(STDIN_FILENO, TIOCSWINSZ, &ws))
 			debug("TIOCSWINSZ ioctl failed\n");
 	}
-- 
2.12.2

