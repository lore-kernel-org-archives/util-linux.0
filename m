Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:51419 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:23 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so4502216wes.27
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/17] setterm: tell user when options does not effect
Date: Sun, 18 May 2014 15:05:37 +0100
Message-Id: <1400421941-14244-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 83 ++++++++++++++++++++++++++++------------------------
 1 file changed, 45 insertions(+), 38 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index f1ed862..2a0162e 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -792,6 +792,17 @@ static void screendump(struct setterm_control *ctl)
 	return;
 }
 
+/* Some options are applicable when terminal is virtual console. */
+static int vc_only(struct setterm_control *ctl, const char *err)
+{
+	if (!ctl->vcterm) {
+		if (err)
+			warnx(_("terminal %s does not support %s"),
+			      ctl->opt_te_terminal_name, err);
+	}
+	return ctl->vcterm;
+}
+
 static void perform_sequence(struct setterm_control *ctl)
 {
 	int result;
@@ -812,49 +823,45 @@ static void perform_sequence(struct setterm_control *ctl)
 			putp(ti_entry("civis"));
 	}
 
-	/* -linewrap [on|off]. Vc only (vt102) */
-	if (ctl->opt_linewrap && ctl->vcterm)
+	/* -linewrap [on|off]. */
+	if (ctl->opt_linewrap && vc_only(ctl, "-linewrap"))
 		fputs(ctl->opt_li_on ? "\033[?7h" : "\033[?7l", stdout);
 
-	/* -repeat [on|off]. Vc only (vt102) */
-	if (ctl->opt_repeat && ctl->vcterm)
+	/* -repeat [on|off]. */
+	if (ctl->opt_repeat && vc_only(ctl, "-repeat"))
 		fputs(ctl->opt_rep_on ? "\033[?8h" : "\033[?8l", stdout);
 
-	/* -appcursorkeys [on|off]. Vc only (vt102) */
-	if (ctl->opt_appcursorkeys && ctl->vcterm)
+	/* -appcursorkeys [on|off]. */
+	if (ctl->opt_appcursorkeys && vc_only(ctl, "-appcursorkeys"))
 		fputs(ctl->opt_appck_on ? "\033[?1h" : "\033[?1l", stdout);
 
 	/* -default.  Vc sets default rendition, otherwise clears all
 	 * attributes. */
 	if (ctl->opt_default) {
-		if (ctl->vcterm)
+		if (vc_only(ctl, NULL))
 			printf("\033[0m");
 		else
 			putp(ti_entry("sgr0"));
 	}
 
-	/* -foreground black|red|green|yellow|blue|magenta|cyan|white|default.
-	 * Vc only (ANSI). */
-	if (ctl->opt_foreground && ctl->vcterm)
+	/* -foreground black|red|green|yellow|blue|magenta|cyan|white|default. */
+	if (ctl->opt_foreground && vc_only(ctl, "-foreground"))
 		printf("\033[3%c%s", '0' + ctl->opt_fo_color, "m");
 
-	/* -background black|red|green|yellow|blue|magenta|cyan|white|default.
-	 * Vc only (ANSI). */
-	if (ctl->opt_background && ctl->vcterm)
+	/* -background black|red|green|yellow|blue|magenta|cyan|white|default. */
+	if (ctl->opt_background && vc_only(ctl, "-background"))
 		printf("\033[4%c%s", '0' + ctl->opt_ba_color, "m");
 
-	/* -ulcolor black|red|green|yellow|blue|magenta|cyan|white|default.
-	 * Vc only. */
-	if (ctl->opt_ulcolor && ctl->vcterm)
+	/* -ulcolor black|red|green|yellow|blue|magenta|cyan|white|default. */
+	if (ctl->opt_ulcolor && vc_only(ctl, "-ulcolor"))
 		printf("\033[1;%d]", ctl->opt_ul_color);
 
-	/* -hbcolor black|red|green|yellow|blue|magenta|cyan|white|default.
-	 * Vc only. */
-	if (ctl->opt_hbcolor && ctl->vcterm)
+	/* -hbcolor black|red|green|yellow|blue|magenta|cyan|white|default. */
+	if (ctl->opt_hbcolor && vc_only(ctl, "-hbcolor"))
 		printf("\033[2;%d]", ctl->opt_hb_color);
 
-	/* -inversescreen [on|off].  Vc only (vt102). */
-	if (ctl->opt_inversescreen && ctl->vcterm)
+	/* -inversescreen [on|off]. */
+	if (ctl->opt_inversescreen && vc_only(ctl, "-inversescreen"))
 		fputs(ctl->opt_invsc_on ? "\033[?5h" : "\033[?5l", stdout);
 
 	/* -bold [on|off].  Vc behaves as expected, otherwise off turns off
@@ -863,7 +870,7 @@ static void perform_sequence(struct setterm_control *ctl)
 		if (ctl->opt_bo_on)
 			putp(ti_entry("bold"));
 		else {
-			if (ctl->vcterm)
+			if (vc_only(ctl, NULL))
 				fputs("\033[22m", stdout);
 			else
 				putp(ti_entry("sgr0"));
@@ -876,7 +883,7 @@ static void perform_sequence(struct setterm_control *ctl)
 		if (ctl->opt_hb_on)
 			putp(ti_entry("dim"));
 		else {
-			if (ctl->vcterm)
+			if (vc_only(ctl, NULL))
 				fputs("\033[22m", stdout);
 			else
 				putp(ti_entry("sgr0"));
@@ -889,7 +896,7 @@ static void perform_sequence(struct setterm_control *ctl)
 		if (ctl->opt_bl_on)
 			putp(ti_entry("blink"));
 		else {
-			if (ctl->vcterm)
+			if (vc_only(ctl, NULL))
 				fputs("\033[25m", stdout);
 			else
 				putp(ti_entry("sgr0"));
@@ -902,7 +909,7 @@ static void perform_sequence(struct setterm_control *ctl)
 		if (ctl->opt_re_on)
 			putp(ti_entry("rev"));
 		else {
-			if (ctl->vcterm)
+			if (vc_only(ctl, NULL))
 				fputs("\033[27m", stdout);
 			else
 				putp(ti_entry("sgr0"));
@@ -913,16 +920,16 @@ static void perform_sequence(struct setterm_control *ctl)
 	if (ctl->opt_underline)
 		putp(ti_entry(ctl->opt_un_on ? "smul" : "rmul"));
 
-	/* -store.  Vc only. */
-	if (ctl->opt_store && ctl->vcterm)
+	/* -store. */
+	if (ctl->opt_store && vc_only(ctl, "-store"))
 		fputs("\033[8]", stdout);
 
 	/* -clear [all|rest]. */
 	if (ctl->opt_clear)
 		putp(ti_entry(ctl->opt_cl_all ? "clear" : "ed"));
 
-	/* -tabs Vc only. */
-	if (ctl->opt_tabs && ctl->vcterm) {
+	/* -tabs. */
+	if (ctl->opt_tabs && vc_only(ctl, "-tabs")) {
 		int i;
 
 		if (ctl->opt_tb_array[0] == -1)
@@ -934,8 +941,8 @@ static void perform_sequence(struct setterm_control *ctl)
 		}
 	}
 
-	/* -clrtabs Vc only. */
-	if (ctl->opt_clrtabs && ctl->vcterm) {
+	/* -clrtabs. */
+	if (ctl->opt_clrtabs && vc_only(ctl, "-clrtabs")) {
 		int i;
 
 		if (ctl->opt_tb_array[0] == -1)
@@ -946,8 +953,8 @@ static void perform_sequence(struct setterm_control *ctl)
 		putchar('\r');
 	}
 
-	/* -regtabs Vc only. */
-	if (ctl->opt_regtabs && ctl->vcterm) {
+	/* -regtabs. */
+	if (ctl->opt_regtabs && vc_only(ctl, "-regtabs")) {
 		int i;
 
 		fputs("\033[3g\r", stdout);
@@ -957,7 +964,7 @@ static void perform_sequence(struct setterm_control *ctl)
 	}
 
 	/* -blank [0-60]. */
-	if (ctl->opt_blank && ctl->vcterm) {
+	if (ctl->opt_blank && vc_only(ctl, "-blank")) {
 		if (ctl->opt_bl_min >= 0)
 			printf("\033[9;%d]", ctl->opt_bl_min);
 		else if (ctl->opt_bl_min == BLANKSCREEN) {
@@ -997,7 +1004,7 @@ static void perform_sequence(struct setterm_control *ctl)
 		screendump(ctl);
 
 	/* -msg [on|off].  Controls printk's to console. */
-	if (ctl->opt_msg && ctl->vcterm) {
+	if (ctl->opt_msg && vc_only(ctl, "-msg")) {
 		if (ctl->opt_msg_on)
 			result = klogctl(SYSLOG_ACTION_CONSOLE_ON, NULL, 0);
 		else
@@ -1008,7 +1015,7 @@ static void perform_sequence(struct setterm_control *ctl)
 	}
 
 	/* -msglevel [0-8].  Console printk message level. */
-	if (ctl->opt_msglevel_num && ctl->vcterm) {
+	if (ctl->opt_msglevel_num && vc_only(ctl, "-msglevel")) {
 		result =
 		    klogctl(SYSLOG_ACTION_CONSOLE_LEVEL, NULL,
 			    ctl->opt_msglevel_num);
@@ -1017,12 +1024,12 @@ static void perform_sequence(struct setterm_control *ctl)
 	}
 
 	/* -blength [0-2000] */
-	if (ctl->opt_blength && ctl->vcterm) {
+	if (ctl->opt_blength && vc_only(ctl, "-blength")) {
 		printf("\033[11;%d]", ctl->opt_blength_l);
 	}
 
 	/* -bfreq freqnumber */
-	if (ctl->opt_bfreq && ctl->vcterm) {
+	if (ctl->opt_bfreq && vc_only(ctl, "-bfreq")) {
 		printf("\033[10;%d]", ctl->opt_bfreq_f);
 	}
 }
-- 
1.9.2

