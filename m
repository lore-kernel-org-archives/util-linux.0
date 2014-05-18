Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:40665 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:20 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so4380956wes.41
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/17] setterm: improve perform_sequence() coding style
Date: Sun, 18 May 2014 15:05:36 +0100
Message-Id: <1400421941-14244-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Delete pointless braces, new lines, and add spacing between operators.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 92 ++++++++++++++++++++--------------------------------
 1 file changed, 35 insertions(+), 57 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 3b4ab56..f1ed862 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -689,13 +689,10 @@ static void parse_option(struct setterm_control *ctl, int argc, char **argv)
 
 /* End of command line parsing routines. */
 
-static char *ti_entry(const char *name) {
-	/* name: Terminfo capability string to lookup. */
-
-/* Return the specified terminfo string, or an empty string if no such terminfo
- * capability exists.
- */
-
+/* Return the specified terminfo string, or an empty string if no such
+ * terminfo capability exists.  */
+static char *ti_entry(const char *name)
+{
 	char *buf_ptr;
 
 	if ((buf_ptr = tigetstr((char *)name)) == (char *)-1)
@@ -798,17 +795,14 @@ static void screendump(struct setterm_control *ctl)
 static void perform_sequence(struct setterm_control *ctl)
 {
 	int result;
-/* Perform the selected options. */
 
 	/* -reset. */
-	if (ctl->opt_reset) {
+	if (ctl->opt_reset)
 		putp(ti_entry("rs1"));
-	}
 
 	/* -initialize. */
-	if (ctl->opt_initialize) {
+	if (ctl->opt_initialize)
 		putp(ti_entry("is2"));
-	}
 
 	/* -cursor [on|off]. */
 	if (ctl->opt_cursor) {
@@ -831,8 +825,7 @@ static void perform_sequence(struct setterm_control *ctl)
 		fputs(ctl->opt_appck_on ? "\033[?1h" : "\033[?1l", stdout);
 
 	/* -default.  Vc sets default rendition, otherwise clears all
-	 * attributes.
-	 */
+	 * attributes. */
 	if (ctl->opt_default) {
 		if (ctl->vcterm)
 			printf("\033[0m");
@@ -841,39 +834,31 @@ static void perform_sequence(struct setterm_control *ctl)
 	}
 
 	/* -foreground black|red|green|yellow|blue|magenta|cyan|white|default.
-	 * Vc only (ANSI).
-	 */
+	 * Vc only (ANSI). */
 	if (ctl->opt_foreground && ctl->vcterm)
 		printf("\033[3%c%s", '0' + ctl->opt_fo_color, "m");
 
 	/* -background black|red|green|yellow|blue|magenta|cyan|white|default.
-	 * Vc only (ANSI).
-	 */
+	 * Vc only (ANSI). */
 	if (ctl->opt_background && ctl->vcterm)
 		printf("\033[4%c%s", '0' + ctl->opt_ba_color, "m");
 
 	/* -ulcolor black|red|green|yellow|blue|magenta|cyan|white|default.
-	 * Vc only.
-	 */
-	if (ctl->opt_ulcolor && ctl->vcterm) {
+	 * Vc only. */
+	if (ctl->opt_ulcolor && ctl->vcterm)
 		printf("\033[1;%d]", ctl->opt_ul_color);
-	}
 
 	/* -hbcolor black|red|green|yellow|blue|magenta|cyan|white|default.
-	 * Vc only.
-	 */
-	if (ctl->opt_hbcolor && ctl->vcterm) {
+	 * Vc only. */
+	if (ctl->opt_hbcolor && ctl->vcterm)
 		printf("\033[2;%d]", ctl->opt_hb_color);
-	}
 
-	/* -inversescreen [on|off].  Vc only (vt102).
-	 */
+	/* -inversescreen [on|off].  Vc only (vt102). */
 	if (ctl->opt_inversescreen && ctl->vcterm)
 		fputs(ctl->opt_invsc_on ? "\033[?5h" : "\033[?5l", stdout);
 
 	/* -bold [on|off].  Vc behaves as expected, otherwise off turns off
-	 * all attributes.
-	 */
+	 * all attributes. */
 	if (ctl->opt_bold) {
 		if (ctl->opt_bo_on)
 			putp(ti_entry("bold"));
@@ -885,9 +870,8 @@ static void perform_sequence(struct setterm_control *ctl)
 		}
 	}
 
-	/* -half-bright [on|off].  Vc behaves as expected, otherwise off turns off
-	 * all attributes.
-	 */
+	/* -half-bright [on|off].  Vc behaves as expected, otherwise off
+	 * turns off all attributes.  */
 	if (ctl->opt_halfbright) {
 		if (ctl->opt_hb_on)
 			putp(ti_entry("dim"));
@@ -900,8 +884,7 @@ static void perform_sequence(struct setterm_control *ctl)
 	}
 
 	/* -blink [on|off].  Vc behaves as expected, otherwise off turns off
-	 * all attributes.
-	 */
+	 * all attributes. */
 	if (ctl->opt_blink) {
 		if (ctl->opt_bl_on)
 			putp(ti_entry("blink"));
@@ -914,8 +897,7 @@ static void perform_sequence(struct setterm_control *ctl)
 	}
 
 	/* -reverse [on|off].  Vc behaves as expected, otherwise off turns
-	 * off all attributes.
-	 */
+	 * off all attributes. */
 	if (ctl->opt_reverse) {
 		if (ctl->opt_re_on)
 			putp(ti_entry("rev"));
@@ -946,7 +928,7 @@ static void perform_sequence(struct setterm_control *ctl)
 		if (ctl->opt_tb_array[0] == -1)
 			show_tabs();
 		else {
-			for(i=0; ctl->opt_tb_array[i] > 0; i++)
+			for (i = 0; ctl->opt_tb_array[i] > 0; i++)
 				printf("\033[%dG\033H", ctl->opt_tb_array[i]);
 			putchar('\r');
 		}
@@ -959,7 +941,7 @@ static void perform_sequence(struct setterm_control *ctl)
 		if (ctl->opt_tb_array[0] == -1)
 			fputs("\033[3g", stdout);
 		else
-			for(i=0; ctl->opt_tb_array[i] > 0; i++)
+			for (i = 0; ctl->opt_tb_array[i] > 0; i++)
 				printf("\033[%dG\033[g", ctl->opt_tb_array[i]);
 		putchar('\r');
 	}
@@ -969,8 +951,8 @@ static void perform_sequence(struct setterm_control *ctl)
 		int i;
 
 		fputs("\033[3g\r", stdout);
-		for(i=ctl->opt_rt_len+1; i<=TABS_MAX; i+=ctl->opt_rt_len)
-			printf("\033[%dC\033H",ctl->opt_rt_len);
+		for (i = ctl->opt_rt_len + 1; i <= TABS_MAX; i += ctl->opt_rt_len)
+			printf("\033[%dC\033H", ctl->opt_rt_len);
 		putchar('\r');
 	}
 
@@ -980,20 +962,20 @@ static void perform_sequence(struct setterm_control *ctl)
 			printf("\033[9;%d]", ctl->opt_bl_min);
 		else if (ctl->opt_bl_min == BLANKSCREEN) {
 			char ioctlarg = TIOCL_BLANKSCREEN;
-			if (ioctl(0,TIOCLINUX,&ioctlarg))
+			if (ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg))
 				warn(_("cannot force blank"));
 		} else if (ctl->opt_bl_min == UNBLANKSCREEN) {
 			char ioctlarg = TIOCL_UNBLANKSCREEN;
-			if (ioctl(0,TIOCLINUX,&ioctlarg))
+			if (ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg))
 				warn(_("cannot force unblank"));
 		} else if (ctl->opt_bl_min == BLANKEDSCREEN) {
 			char ioctlarg = TIOCL_BLANKEDSCREEN;
 			int ret;
-			ret = ioctl(0,TIOCLINUX,&ioctlarg);
+			ret = ioctl(STDIN_FILENO, TIOCLINUX, &ioctlarg);
 			if (ret < 0)
 				warn(_("cannot get blank status"));
 			else
-				printf("%d\n",ret);
+				printf("%d\n", ret);
 		}
 	}
 
@@ -1002,37 +984,34 @@ static void perform_sequence(struct setterm_control *ctl)
 		char ioctlarg[2];
 		ioctlarg[0] = TIOCL_SETVESABLANK;
 		ioctlarg[1] = ctl->opt_ps_mode;
-		if (ioctl(0,TIOCLINUX,ioctlarg))
+		if (ioctl(STDIN_FILENO, TIOCLINUX, ioctlarg))
 			warn(_("cannot (un)set powersave mode"));
 	}
 
 	/* -powerdown [0-60]. */
-	if (ctl->opt_powerdown) {
+	if (ctl->opt_powerdown)
 		printf("\033[14;%d]", ctl->opt_pd_min);
-	}
 
 	/* -snap [1-NR_CONS]. */
-	if (ctl->opt_snap || ctl->opt_append) {
+	if (ctl->opt_snap || ctl->opt_append)
 		screendump(ctl);
-	}
 
-	/* -msg [on|off]. */
+	/* -msg [on|off].  Controls printk's to console. */
 	if (ctl->opt_msg && ctl->vcterm) {
 		if (ctl->opt_msg_on)
-			/* 7 -- Enable printk's to console */
 			result = klogctl(SYSLOG_ACTION_CONSOLE_ON, NULL, 0);
 		else
-			/*  6 -- Disable printk's to console */
 			result = klogctl(SYSLOG_ACTION_CONSOLE_OFF, NULL, 0);
 
 		if (result != 0)
 			warn(_("klogctl error"));
 	}
 
-	/* -msglevel [0-8] */
+	/* -msglevel [0-8].  Console printk message level. */
 	if (ctl->opt_msglevel_num && ctl->vcterm) {
-		/* 8 -- Set level of messages printed to console */
-		result = klogctl(SYSLOG_ACTION_CONSOLE_LEVEL, NULL, ctl->opt_msglevel_num);
+		result =
+		    klogctl(SYSLOG_ACTION_CONSOLE_LEVEL, NULL,
+			    ctl->opt_msglevel_num);
 		if (result != 0)
 			warn(_("klogctl error"));
 	}
@@ -1046,7 +1025,6 @@ static void perform_sequence(struct setterm_control *ctl)
 	if (ctl->opt_bfreq && ctl->vcterm) {
 		printf("\033[10;%d]", ctl->opt_bfreq_f);
 	}
-
 }
 
 static void init_terminal(struct setterm_control *ctl)
-- 
1.9.2

