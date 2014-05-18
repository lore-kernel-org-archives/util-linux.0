Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:62361 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751461AbaEROG0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:26 -0400
Received: by mail-we0-f178.google.com with SMTP id u56so4386194wes.37
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/17] setterm: various visual terminal effects are not console specific
Date: Sun, 18 May 2014 15:05:39 +0100
Message-Id: <1400421941-14244-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Setting colors, making line not to wrap, and so on can be attempted in
other than consoles.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 2b1901f..10ca021 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -824,7 +824,7 @@ static void perform_sequence(struct setterm_control *ctl)
 	}
 
 	/* -linewrap [on|off]. */
-	if (ctl->opt_linewrap && vc_only(ctl, "-linewrap"))
+	if (ctl->opt_linewrap)
 		fputs(ctl->opt_li_on ? "\033[?7h" : "\033[?7l", stdout);
 
 	/* -repeat [on|off]. */
@@ -845,11 +845,11 @@ static void perform_sequence(struct setterm_control *ctl)
 	}
 
 	/* -foreground black|red|green|yellow|blue|magenta|cyan|white|default. */
-	if (ctl->opt_foreground && vc_only(ctl, "-foreground"))
+	if (ctl->opt_foreground)
 		printf("\033[3%c%s", '0' + ctl->opt_fo_color, "m");
 
 	/* -background black|red|green|yellow|blue|magenta|cyan|white|default. */
-	if (ctl->opt_background && vc_only(ctl, "-background"))
+	if (ctl->opt_background)
 		printf("\033[4%c%s", '0' + ctl->opt_ba_color, "m");
 
 	/* -ulcolor black|red|green|yellow|blue|magenta|cyan|white|default. */
@@ -857,11 +857,11 @@ static void perform_sequence(struct setterm_control *ctl)
 		printf("\033[1;%d]", ctl->opt_ul_color);
 
 	/* -hbcolor black|red|green|yellow|blue|magenta|cyan|white|default. */
-	if (ctl->opt_hbcolor && vc_only(ctl, "-hbcolor"))
+	if (ctl->opt_hbcolor)
 		printf("\033[2;%d]", ctl->opt_hb_color);
 
 	/* -inversescreen [on|off]. */
-	if (ctl->opt_inversescreen && vc_only(ctl, "-inversescreen"))
+	if (ctl->opt_inversescreen)
 		fputs(ctl->opt_invsc_on ? "\033[?5h" : "\033[?5l", stdout);
 
 	/* -bold [on|off].  Vc behaves as expected, otherwise off turns off
@@ -929,12 +929,12 @@ static void perform_sequence(struct setterm_control *ctl)
 		putp(ti_entry(ctl->opt_cl_all ? "clear" : "ed"));
 
 	/* -tabs. */
-	if (ctl->opt_tabs && vc_only(ctl, "-tabs")) {
-		int i;
-
+	if (ctl->opt_tabs) {
 		if (ctl->opt_tb_array[0] == -1)
 			show_tabs();
 		else {
+			int i;
+
 			for (i = 0; ctl->opt_tb_array[i] > 0; i++)
 				printf("\033[%dG\033H", ctl->opt_tb_array[i]);
 			putchar('\r');
-- 
1.9.2

