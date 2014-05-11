Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:50433 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934158AbaEKT1R (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:27:17 -0400
Received: by mail-wg0-f50.google.com with SMTP id x12so5883076wgg.33
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:27:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/12] setterm: use string constant rather than #define
Date: Sun, 11 May 2014 20:26:47 +0100
Message-Id: <1399836409-7769-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There is no need to repeat same string in compiled code everywhere.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 47 +++++++++++++++++++++++------------------------
 1 file changed, 23 insertions(+), 24 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 01fe27e..ef820b3 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -165,9 +165,6 @@ extern int klogctl(int type, char *buf, int len);
 # define TIOCL_BLANKEDSCREEN	15	/* return which vt was blanked */
 #endif
 
-/* Control sequences. */
-#define ESC "\033"
-
 /* Static variables. */
 
 /* Option flags.  Set if the option is to be invoked. */
@@ -796,6 +793,8 @@ static char *ti_entry(const char *name) {
 
 static void
 perform_sequence(int vcterm) {
+	static const char *ESC = "\033";
+
 	/* vcterm: Set if terminal is a virtual console. */
 
 	int result;
@@ -822,25 +821,25 @@ perform_sequence(int vcterm) {
 	/* -linewrap [on|off]. Vc only (vt102) */
 	if (opt_linewrap && vcterm) {
 		if (opt_li_on)
-			printf("\033[?7h");
+			printf("%s[?7h", ESC);
 		else
-			printf("\033[?7l");
+			printf("%s[?7l", ESC);
 	}
 
 	/* -repeat [on|off]. Vc only (vt102) */
 	if (opt_repeat && vcterm) {
 		if (opt_rep_on)
-			printf("\033[?8h");
+			printf("%s[?8h", ESC);
 		else
-			printf("\033[?8l");
+			printf("%s[?8l", ESC);
 	}
 
 	/* -appcursorkeys [on|off]. Vc only (vt102) */
 	if (opt_appcursorkeys && vcterm) {
 		if (opt_appck_on)
-			printf("\033[?1h");
+			printf("%s[?1h", ESC);
 		else
-			printf("\033[?1l");
+			printf("%s[?1l", ESC);
 	}
 
 	/* -default.  Vc sets default rendition, otherwise clears all
@@ -848,7 +847,7 @@ perform_sequence(int vcterm) {
 	 */
 	if (opt_default) {
 		if (vcterm)
-			printf("\033[0m");
+			printf("%s[0m", ESC);
 		else
 			putp(ti_entry("sgr0"));
 	}
@@ -871,14 +870,14 @@ perform_sequence(int vcterm) {
 	 * Vc only.
 	 */
 	if (opt_ulcolor && vcterm) {
-		printf("\033[1;%d]", opt_ul_color);
+		printf("%s[1;%d]", ESC, opt_ul_color);
 	}
 
 	/* -hbcolor black|red|green|yellow|blue|magenta|cyan|white|default.
 	 * Vc only.
 	 */
 	if (opt_hbcolor && vcterm) {
-		printf("\033[2;%d]", opt_hb_color);
+		printf("%s[2;%d]", ESC, opt_hb_color);
 	}
 
 	/* -inversescreen [on|off].  Vc only (vt102).
@@ -886,9 +885,9 @@ perform_sequence(int vcterm) {
 	if (opt_inversescreen) {
 		if (vcterm) {
 			if (opt_invsc_on)
-				printf("\033[?5h");
+				printf("%s[?5h", ESC);
 			else
-				printf("\033[?5l");
+				printf("%s[?5l", ESC);
 		}
 	}
 
@@ -958,7 +957,7 @@ perform_sequence(int vcterm) {
 
 	/* -store.  Vc only. */
 	if (opt_store && vcterm) {
-		printf("\033[8]");
+		printf("%s[8]", ESC);
 	}
 
 	/* -clear [all|rest]. */
@@ -977,7 +976,7 @@ perform_sequence(int vcterm) {
 			show_tabs();
 		else {
 			for(i=0; opt_tb_array[i] > 0; i++)
-				printf("\033[%dG\033H", opt_tb_array[i]);
+				printf("%s[%dG%sH", ESC, opt_tb_array[i], ESC);
 			putchar('\r');
 		}
 	}
@@ -987,10 +986,10 @@ perform_sequence(int vcterm) {
 		int i;
 
 		if (opt_tb_array[0] == -1)
-			printf("\033[3g");
+			printf("%s[3g", ESC);
 		else
 			for(i=0; opt_tb_array[i] > 0; i++)
-				printf("\033[%dG\033[g", opt_tb_array[i]);
+				printf("%s[%dG%s[g", ESC, opt_tb_array[i], ESC);
 		putchar('\r');
 	}
 
@@ -998,16 +997,16 @@ perform_sequence(int vcterm) {
 	if (opt_regtabs && vcterm) {
 		int i;
 
-		printf("\033[3g\r");
+		printf("%s[3g\r", ESC);
 		for(i=opt_rt_len+1; i<=160; i+=opt_rt_len)
-			printf("\033[%dC\033H",opt_rt_len);
+			printf("%s[%dC%sH", ESC, opt_rt_len, ESC);
 		putchar('\r');
 	}
 
 	/* -blank [0-60]. */
 	if (opt_blank && vcterm) {
 		if (opt_bl_min >= 0)
-			printf("\033[9;%d]", opt_bl_min);
+			printf("%s[9;%d]", ESC, opt_bl_min);
 		else if (opt_bl_min == BLANKSCREEN) {
 			char ioctlarg = TIOCL_BLANKSCREEN;
 			if (ioctl(0,TIOCLINUX,&ioctlarg))
@@ -1038,7 +1037,7 @@ perform_sequence(int vcterm) {
 
 	/* -powerdown [0-60]. */
 	if (opt_powerdown) {
-		printf("\033[14;%d]", opt_pd_min);
+		printf("%s[14;%d]", ESC, opt_pd_min);
 	}
 
 	/* -snap [1-NR_CONS]. */
@@ -1077,12 +1076,12 @@ perform_sequence(int vcterm) {
 
 	/* -blength [0-2000] */
 	if (opt_blength && vcterm) {
-		printf("\033[11;%d]", opt_blength_l);
+		printf("%s[11;%d]", ESC, opt_blength_l);
 	}
 
 	/* -bfreq freqnumber */
 	if (opt_bfreq && vcterm) {
-		printf("\033[10;%d]", opt_bfreq_f);
+		printf("%s[10;%d]", ESC, opt_bfreq_f);
 	}
 
 }
-- 
1.9.2

