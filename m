Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:35678 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934182AbaEKT1W (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:27:22 -0400
Received: by mail-we0-f172.google.com with SMTP id k48so6038314wev.31
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:27:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/12] setterm: convert remaining magic values to symbolic references
Date: Sun, 11 May 2014 20:26:49 +0100
Message-Id: <1399836409-7769-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 65 ++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 20 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 2de555e..5950d2a 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -171,6 +171,31 @@ enum {
 };
 #endif
 
+/* Powersave modes */
+enum {
+	VESA_BLANK_MODE_OFF = 0,
+	VESA_BLANK_MODE_SUSPENDV,
+	VESA_BLANK_MODE_SUSPENDH,
+	VESA_BLANK_MODE_POWERDOWN
+};
+
+/* klogctl() actions */
+enum {
+	SYSLOG_ACTION_CONSOLE_OFF	= 6,
+	SYSLOG_ACTION_CONSOLE_ON	= 7,
+	SYSLOG_ACTION_CONSOLE_LEVEL	= 8
+};
+
+/* Various numbers  */
+enum {
+	CONSOLE_LEVEL_MIN = 1,
+	CONSOLE_LEVEL_MAX = 8,
+	DEFAULT_TAB_LEN = 8,
+	BLANK_MAX = 60,
+	TABS_MAX = 160,
+	BLENGTH_MAX = 2000,
+};
+
 /* Static variables. */
 
 /* Option flags.  Set if the option is to be invoked. */
@@ -198,7 +223,7 @@ int opt_blength_l;
 int opt_bfreq_f;
 int opt_sn_num;			/* Snap screen. */
 int opt_rt_len;			/* regular tab length */
-int opt_tb_array[161];		/* Array for tab list */
+int opt_tb_array[TABS_MAX + 1];	/* Array for tab list */
 int opt_msglevel_num;
 int opt_ps_mode, opt_pd_min;	/* powersave mode/powerdown time */
 
@@ -410,7 +435,7 @@ parse_blank(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
 			*opt_all = UNBLANKSCREEN;
 		else {
 			*opt_all = atoi(argv[0]);
-			if ((*opt_all > 60) || (*opt_all < 0))
+			if (*opt_all < 0 || BLANK_MAX < *opt_all)
 				*bad_arg = TRUE;
 		}
 	} else {
@@ -433,19 +458,19 @@ parse_powersave(int argc, char **argv, int *option, int *opt_mode, int *bad_arg)
 	*option = TRUE;
 	if (argc == 1) {
 		if (strcmp(argv[0], "on") == 0)
-			*opt_mode = 1;
+			*opt_mode = VESA_BLANK_MODE_SUSPENDV;
 		else if (strcmp(argv[0], "vsync") == 0)
-			*opt_mode = 1;
+			*opt_mode = VESA_BLANK_MODE_SUSPENDV;
 		else if (strcmp(argv[0], "hsync") == 0)
-			*opt_mode = 2;
+			*opt_mode = VESA_BLANK_MODE_SUSPENDH;
 		else if (strcmp(argv[0], "powerdown") == 0)
-			*opt_mode = 3;
+			*opt_mode = VESA_BLANK_MODE_POWERDOWN;
 		else if (strcmp(argv[0], "off") == 0)
-			*opt_mode = 0;
+			*opt_mode = VESA_BLANK_MODE_OFF;
 		else
 			*bad_arg = TRUE;
 	} else {
-		*opt_mode = 0;
+		*opt_mode = VESA_BLANK_MODE_OFF;
 	}
 }
 
@@ -462,7 +487,7 @@ parse_msglevel(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
 	*option = TRUE;
 	if (argc == 1) {
 		*opt_all = atoi(argv[0]);
-		if (*opt_all < 0 || *opt_all > 8)
+		if (*opt_all < CONSOLE_LEVEL_MIN || CONSOLE_LEVEL_MAX <  *opt_all)
 			*bad_arg = TRUE;
 	} else {
 		*opt_all = -1;
@@ -517,13 +542,13 @@ parse_tabs(int argc, char **argv, int *option, int *tab_array, int *bad_arg) {
 	/* tab_array: Array of tabs */
 	/* bad_arg: Set to true if an error is detected. */
 
-	if (*option || argc > 160)
+	if (*option || TABS_MAX < argc)
 		*bad_arg = TRUE;
 	*option = TRUE;
 	tab_array[argc] = -1;
 	while(argc--) {
 		tab_array[argc] = atoi(argv[argc]);
-		if(tab_array[argc] < 1 || tab_array[argc] > 160) {
+		if (tab_array[argc] < 1 || TABS_MAX < tab_array[argc]) {
 			*bad_arg = TRUE;
 			return;
 		}
@@ -538,7 +563,7 @@ parse_clrtabs(int argc, char **argv, int *option, int *tab_array, int *bad_arg)
 	/* tab_array: Array of tabs */
 	/* bad_arg: Set to true if an error is detected. */
 
-	if (*option || argc > 160)
+	if (*option || TABS_MAX < argc)
 		*bad_arg = TRUE;
 	*option = TRUE;
 	if(argc == 0) {
@@ -548,7 +573,7 @@ parse_clrtabs(int argc, char **argv, int *option, int *tab_array, int *bad_arg)
 	tab_array[argc] = -1;
 	while(argc--) {
 		tab_array[argc] = atoi(argv[argc]);
-		if(tab_array[argc] < 1 || tab_array[argc] > 160) {
+		if(tab_array[argc] < 1 || TABS_MAX < tab_array[argc]) {
 			*bad_arg = TRUE;
 			return;
 		}
@@ -567,11 +592,11 @@ parse_regtabs(int argc, char **argv, int *option, int *opt_len, int *bad_arg) {
 		*bad_arg = TRUE;
 	*option = TRUE;
 	if(argc == 0) {
-		*opt_len = 8;
+		*opt_len = DEFAULT_TAB_LEN;
 		return;
 	}
 	*opt_len = atoi(argv[0]);
-	if(*opt_len < 1 || *opt_len > 160) {
+	if(*opt_len < 1 || TABS_MAX < *opt_len) {
 		*bad_arg = TRUE;
 		return;
 	}
@@ -593,7 +618,7 @@ parse_blength(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
 	*option = TRUE;
 	if (argc == 1) {
 		*opt_all = atoi(argv[0]);
-		if (*opt_all > 2000)
+		if (BLENGTH_MAX < *opt_all)
 			*bad_arg = TRUE;
 	} else {
 		*opt_all = 0;
@@ -1004,7 +1029,7 @@ perform_sequence(int vcterm) {
 		int i;
 
 		printf("%s[3g\r", ESC);
-		for(i=opt_rt_len+1; i<=160; i+=opt_rt_len)
+		for(i=opt_rt_len+1; i<=TABS_MAX; i+=opt_rt_len)
 			printf("%s[%dC%sH", ESC, opt_rt_len, ESC);
 		putchar('\r');
 	}
@@ -1063,10 +1088,10 @@ perform_sequence(int vcterm) {
 	if (opt_msg && vcterm) {
 		if (opt_msg_on)
 			/* 7 -- Enable printk's to console */
-			result = klogctl(7, NULL, 0);
+			result = klogctl(SYSLOG_ACTION_CONSOLE_ON, NULL, 0);
 		else
 			/*  6 -- Disable printk's to console */
-			result = klogctl(6, NULL, 0);
+			result = klogctl(SYSLOG_ACTION_CONSOLE_OFF, NULL, 0);
 
 		if (result != 0)
 			warn(_("klogctl error"));
@@ -1075,7 +1100,7 @@ perform_sequence(int vcterm) {
 	/* -msglevel [0-8] */
 	if (opt_msglevel && vcterm) {
 		/* 8 -- Set level of messages printed to console */
-		result = klogctl(8, NULL, opt_msglevel_num);
+		result = klogctl(SYSLOG_ACTION_CONSOLE_LEVEL, NULL, opt_msglevel_num);
 		if (result != 0)
 			warn(_("klogctl error"));
 	}
-- 
1.9.2

