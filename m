Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:49745 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934141AbaEKT1P (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:27:15 -0400
Received: by mail-wg0-f51.google.com with SMTP id x13so6035532wgg.10
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:27:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/12] setterm: remove unused code
Date: Sun, 11 May 2014 20:26:46 +0100
Message-Id: <1399836409-7769-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
References: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 71 +++-------------------------------------------------
 1 file changed, 3 insertions(+), 68 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index f179ea8..01fe27e 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -140,12 +140,6 @@ extern int klogctl(int type, char *buf, int len);
 /* Non-standard return values. */
 #define EXIT_DUMPFILE	-1
 
-/* Keyboard types. */
-#define PC	 0
-#define OLIVETTI 1
-#define DUTCH    2
-#define EXTENDED 3
-
 /* Colors. */
 #define BLACK   0
 #define RED     1
@@ -173,16 +167,14 @@ extern int klogctl(int type, char *buf, int len);
 
 /* Control sequences. */
 #define ESC "\033"
-#define DCS "\033P"
-#define ST  "\033\\"
 
 /* Static variables. */
 
 /* Option flags.  Set if the option is to be invoked. */
 int opt_term, opt_reset, opt_initialize, opt_cursor;
-int opt_linewrap, opt_snow, opt_softscroll, opt_default, opt_foreground;
+int opt_linewrap, opt_default, opt_foreground;
 int opt_background, opt_bold, opt_blink, opt_reverse, opt_underline;
-int opt_store, opt_clear, opt_blank, opt_snap, opt_snapfile, opt_standout;
+int opt_store, opt_clear, opt_blank, opt_snap, opt_snapfile;
 int opt_append, opt_ulcolor, opt_hbcolor, opt_halfbright, opt_repeat;
 int opt_tabs, opt_clrtabs, opt_regtabs, opt_appcursorkeys, opt_inversescreen;
 int opt_msg, opt_msglevel, opt_powersave, opt_powerdown;
@@ -192,10 +184,9 @@ int opt_blength, opt_bfreq;
  * uniqueness.
  */
 char *opt_te_terminal_name;	/* Terminal name. */
-int opt_cu_on, opt_li_on, opt_sn_on, opt_so_on, opt_bo_on, opt_hb_on, opt_bl_on;
+int opt_cu_on, opt_li_on, opt_bo_on, opt_hb_on, opt_bl_on;
 int opt_re_on, opt_un_on, opt_rep_on, opt_appck_on, opt_invsc_on;
 int opt_msg_on;			/* Boolean switches. */
-int opt_ke_type;		/* Keyboard type. */
 int opt_fo_color, opt_ba_color;	/* Colors. */
 int opt_ul_color, opt_hb_color;
 int opt_cl_all;			/* Clear all or rest. */
@@ -203,7 +194,6 @@ int opt_bl_min;			/* Blank screen. */
 int opt_blength_l;
 int opt_bfreq_f;
 int opt_sn_num;			/* Snap screen. */
-int opt_st_attr;
 int opt_rt_len;			/* regular tab length */
 int opt_tb_array[161];		/* Array for tab list */
 int opt_msglevel_num;
@@ -456,27 +446,6 @@ parse_powersave(int argc, char **argv, int *option, int *opt_mode, int *bad_arg)
 	}
 }
 
-#if 0
-static void
-parse_standout(int argc, char *argv, int *option, int *opt_all, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* opt_all: Clear all switch to set or reset. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a -standout specification. */
-
-	if (argc > 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1)
-		*opt_all = atoi(argv[0]);
-	else
-		*opt_all = -1;
-}
-#endif
-
 static void
 parse_msglevel(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
 	/* argc: Number of arguments for this option. */
@@ -747,12 +716,6 @@ parse_option(char *option, int argc, char **argv, int *bad_arg) {
 		parse_switch(argc, argv, &opt_appcursorkeys, &opt_appck_on, bad_arg);
 	else if (STRCMP(option, "linewrap") == 0)
 		parse_switch(argc, argv, &opt_linewrap, &opt_li_on, bad_arg);
-#if 0
-	else if (STRCMP(option, "snow") == 0)
-		parse_switch(argc, argv, &opt_snow, &opt_sn_on, bad_arg);
-	else if (STRCMP(option, "softscroll") == 0)
-		parse_switch(argc, argv, &opt_softscroll, &opt_so_on, bad_arg);
-#endif
 	else if (STRCMP(option, "default") == 0)
 		parse_none(argc, argv, &opt_default, bad_arg);
 	else if (STRCMP(option, "foreground") == 0)
@@ -805,10 +768,6 @@ parse_option(char *option, int argc, char **argv, int *bad_arg) {
 		parse_blength(argc, argv, &opt_blength, &opt_blength_l, bad_arg);
 	else if (STRCMP(option, "bfreq") == 0)
 		parse_bfreq(argc, argv, &opt_bfreq, &opt_bfreq_f, bad_arg);
-#if 0
-	else if (STRCMP(option, "standout") == 0)
-		parse_standout(argc, argv, &opt_standout, &opt_st_attr, bad_arg);
-#endif
 	else if (STRCMP(option, "version") == 0) {
 		printf(_("%s from %s\n"), program_invocation_short_name,
 					  PACKAGE_STRING);
@@ -884,24 +843,6 @@ perform_sequence(int vcterm) {
 			printf("\033[?1l");
 	}
 
-#if 0
-	/* -snow [on|off].  Vc only. */
-	if (opt_snow && vcterm) {
-		if (opt_sn_on)
-			printf("%s%s%s", DCS, "snow.on", ST);
-		else
-			printf("%s%s%s", DCS, "snow.off", ST);
-	}
-
-	/* -softscroll [on|off].  Vc only. */
-	if (opt_softscroll && vcterm) {
-		if (opt_so_on)
-			printf("%s%s%s", DCS, "softscroll.on", ST);
-		else
-			printf("%s%s%s", DCS, "softscroll.off", ST);
-	}
-#endif
-
 	/* -default.  Vc sets default rendition, otherwise clears all
 	 * attributes.
 	 */
@@ -1100,12 +1041,6 @@ perform_sequence(int vcterm) {
 		printf("\033[14;%d]", opt_pd_min);
 	}
 
-#if 0
-	/* -standout [num]. */
-	if (opt_standout)
-		/* nothing */;
-#endif
-
 	/* -snap [1-NR_CONS]. */
 	if (opt_snap || opt_append) {
 		FILE *F;
-- 
1.9.2

