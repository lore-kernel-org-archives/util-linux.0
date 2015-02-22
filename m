Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:65483 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752255AbbBVOos (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:44:48 -0500
Received: by mail-wg0-f53.google.com with SMTP id a1so21139860wgh.12
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:44:47 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 29/31] more: remove unnecessary variable
Date: Sun, 22 Feb 2015 14:43:25 +0000
Message-Id: <1424616207-747-30-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
References: <1424616207-747-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

No longer needed when siglongjmp() magic is gone.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/more.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/text-utils/more.c b/text-utils/more.c
index 84c2108..449f9cd 100644
--- a/text-utils/more.c
+++ b/text-utils/more.c
@@ -181,7 +181,6 @@ struct more_control {
 		ul_glitch:1,		/* terminal is underlining in glitch mode */
 		ul_opt:1,		/* underline as best we can */
 		underlining:1,		/* is underlining going on */
-		within:1,		/* true if we are within a file, false if we are between files */
 		wrap_margin:1;		/* set if automargins */
 };
 
@@ -791,8 +790,7 @@ static void change_file(struct more_control *ctl, int nskip)
 	if (nskip > 0) {
 		if (ctl->argv_position + nskip > ctl->nfiles - 1)
 			nskip = ctl->nfiles - ctl->argv_position - 1;
-	} else if (ctl->within)
-		ctl->argv_position++;
+	}
 	ctl->argv_position += nskip;
 	if (ctl->argv_position < 0)
 		ctl->argv_position = 0;
@@ -1952,11 +1950,8 @@ static void display_file(struct more_control *ctl, FILE *f, char *initbuf, int l
 		}
 		if (ctl->no_tty)
 			copy_file(f);
-		else {
-			ctl->within = 1;
+		else
 			screen(ctl, f, left);
-			ctl->within = 0;
-		}
 	}
 	fflush(stdout);
 	fclose(f);
-- 
2.3.0

