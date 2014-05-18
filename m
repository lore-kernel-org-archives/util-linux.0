Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:42371 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349AbaEROGI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:06:08 -0400
Received: by mail-wi0-f170.google.com with SMTP id bs8so4091948wib.3
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:06:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 06/17] setterm: add option control structure
Date: Sun, 18 May 2014 15:05:30 +0100
Message-Id: <1400421941-14244-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 394 +++++++++++++++++++++++++--------------------------
 1 file changed, 195 insertions(+), 199 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 268ddec..63c912b 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -144,36 +144,36 @@ enum {
 #define	TABS_MAX	160
 #define BLENGTH_MAX	2000
 
-/* Option flags.  Set if the option is to be invoked. */
-int opt_term, opt_reset, opt_initialize, opt_cursor;
-int opt_linewrap, opt_default, opt_foreground;
-int opt_background, opt_bold, opt_blink, opt_reverse, opt_underline;
-int opt_store, opt_clear, opt_blank, opt_snap, opt_snapfile;
-int opt_append, opt_ulcolor, opt_hbcolor, opt_halfbright, opt_repeat;
-int opt_tabs, opt_clrtabs, opt_regtabs, opt_appcursorkeys, opt_inversescreen;
-int opt_msg, opt_msglevel, opt_powersave, opt_powerdown;
-int opt_blength, opt_bfreq;
-
-/* Option controls.  The variable names have been contracted to ensure
- * uniqueness.
- */
-char *opt_te_terminal_name;	/* Terminal name. */
-int opt_cu_on, opt_li_on, opt_bo_on, opt_hb_on, opt_bl_on;
-int opt_re_on, opt_un_on, opt_rep_on, opt_appck_on, opt_invsc_on;
-int opt_msg_on;			/* Boolean switches. */
-int opt_fo_color, opt_ba_color;	/* Colors. */
-int opt_ul_color, opt_hb_color;
-int opt_cl_all;			/* Clear all or rest. */
-int opt_bl_min;			/* Blank screen. */
-int opt_blength_l;
-int opt_bfreq_f;
-int opt_sn_num;			/* Snap screen. */
-int opt_rt_len;			/* regular tab length */
-int opt_tb_array[TABS_MAX + 1];	/* Array for tab list */
-int opt_msglevel_num;
-int opt_ps_mode, opt_pd_min;	/* powersave mode/powerdown time */
-
-char opt_sn_name[PATH_MAX] = "screen.dump";
+/* Option controls. */
+struct setterm_control {
+	char *opt_te_terminal_name;	/* terminal name */
+	int opt_bl_min;		/* blank screen */
+	int opt_blength_l;	/* bell duration in milliseconds */
+	int opt_bfreq_f;	/* bell frequency in Hz */
+	int opt_sn_num;		/* console number to be snapshoted */
+	char *opt_sn_name;	/* path to write snap */
+	int opt_msglevel_num;	/* printk() loging level */
+	int opt_ps_mode;	/* powersave mode */
+	int opt_pd_min;		/* powerdown time */
+	int opt_rt_len;		/* regular tab length */
+	int opt_tb_array[TABS_MAX + 1];	/* array for tab list */
+	/* colors */
+	int opt_fo_color:4, opt_ba_color:4, opt_ul_color:4, opt_hb_color:4;
+	/* boolean options */
+	int opt_cu_on:1, opt_li_on:1, opt_bo_on:1, opt_hb_on:1, opt_bl_on:1,
+	    opt_re_on:1, opt_un_on:1, opt_rep_on:1, opt_appck_on:1,
+	    opt_invsc_on:1, opt_msg_on:1, opt_cl_all:1, vcterm:1;
+	/* Option flags.  Set when an option is invoked. */
+	uint64_t opt_term:1, opt_reset:1, opt_initialize:1, opt_cursor:1,
+	    opt_linewrap:1, opt_default:1, opt_foreground:1,
+	    opt_background:1, opt_bold:1, opt_blink:1, opt_reverse:1,
+	    opt_underline:1, opt_store:1, opt_clear:1, opt_blank:1,
+	    opt_snap:1, opt_snapfile:1, opt_append:1, opt_ulcolor:1,
+	    opt_hbcolor:1, opt_halfbright:1, opt_repeat:1, opt_tabs:1,
+	    opt_clrtabs:1, opt_regtabs:1, opt_appcursorkeys:1,
+	    opt_inversescreen:1, opt_msg:1, opt_msglevel:1, opt_powersave:1,
+	    opt_powerdown:1, opt_blength:1, opt_bfreq:1;
+};
 
 /* Command line parsing routines.
  *
@@ -458,14 +458,14 @@ usage(FILE *out) {
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static void set_opt_flag(int *opt)
+static int __attribute__((__pure__)) set_opt_flag(int opt)
 {
-	if (*opt)
+	if (opt)
 		errx(EXIT_FAILURE, "duplicate use of an option");
-	*opt = 1;
+	return 1;
 }
 
-static void parse_option(int argc, char **argv)
+static void parse_option(struct setterm_control *ctl, int argc, char **argv)
 {
 	int c;
 	enum {
@@ -549,132 +549,132 @@ static void parse_option(int argc, char **argv)
 	while ((c = getopt_long_only(argc, argv, "", longopts, NULL)) != -1) {
 		switch (c) {
 		case OPT_TERM:
-			set_opt_flag(&opt_term);
-			opt_te_terminal_name = optarg;
+			ctl->opt_term = set_opt_flag(ctl->opt_term);
+			ctl->opt_te_terminal_name = optarg;
 			break;
 		case OPT_RESET:
-			set_opt_flag(&opt_reset);
+			ctl->opt_reset = set_opt_flag(ctl->opt_reset);
 			break;
 		case OPT_INITIALIZE:
-			set_opt_flag(&opt_initialize);
+			ctl->opt_initialize = set_opt_flag(ctl->opt_initialize);
 			break;
 		case OPT_CURSOR:
-			set_opt_flag(&opt_cursor);
-			opt_cu_on = parse_switch(optarg, "on", "off");
+			ctl->opt_cursor = set_opt_flag(ctl->opt_cursor);
+			ctl->opt_cu_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_REPEAT:
-			set_opt_flag(&opt_repeat);
-			opt_rep_on = parse_switch(optarg, "on", "off");
+			ctl->opt_repeat = set_opt_flag(ctl->opt_repeat);
+			ctl->opt_rep_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_APPCURSORKEYS:
-			set_opt_flag(&opt_appcursorkeys);
-			opt_appck_on = parse_switch(optarg, "on", "off");
+			ctl->opt_appcursorkeys = set_opt_flag(ctl->opt_appcursorkeys);
+			ctl->opt_appck_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_LINEWRAP:
-			set_opt_flag(&opt_linewrap);
-			opt_li_on = parse_switch(optarg, "on", "off");
+			ctl->opt_linewrap = set_opt_flag(ctl->opt_linewrap);
+			ctl->opt_li_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_DEFAULT:
-			set_opt_flag(&opt_default);
+			ctl->opt_default = set_opt_flag(ctl->opt_default);
 			break;
 		case OPT_FOREGROUND:
-			set_opt_flag(&opt_foreground);
-			opt_fo_color = parse_febg_color(optarg);
+			ctl->opt_foreground = set_opt_flag(ctl->opt_foreground);
+			ctl->opt_fo_color = parse_febg_color(optarg);
 			break;
 		case OPT_BACKGROUND:
-			set_opt_flag(&opt_background);
-			opt_ba_color = parse_febg_color(optarg);
+			ctl->opt_background = set_opt_flag(ctl->opt_background);
+			ctl->opt_ba_color = parse_febg_color(optarg);
 			break;
 		case OPT_ULCOLOR:
-			set_opt_flag(&opt_ulcolor);
-			opt_ul_color = parse_ulhb_color(argv, &optind);
+			ctl->opt_ulcolor = set_opt_flag(ctl->opt_ulcolor);
+			ctl->opt_ul_color = parse_ulhb_color(argv, &optind);
 			break;
 		case OPT_HBCOLOR:
-			set_opt_flag(&opt_hbcolor);
-			opt_hb_color = parse_ulhb_color(argv, &optind);
+			ctl->opt_hbcolor = set_opt_flag(ctl->opt_hbcolor);
+			ctl->opt_hb_color = parse_ulhb_color(argv, &optind);
 			break;
 		case OPT_INVERSESCREEN:
-			set_opt_flag(&opt_inversescreen);
-			opt_invsc_on = parse_switch(optarg, "on", "off");
+			ctl->opt_inversescreen = set_opt_flag(ctl->opt_inversescreen);
+			ctl->opt_invsc_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_BOLD:
-			set_opt_flag(&opt_bold);
-			opt_bo_on = parse_switch(optarg, "on", "off");
+			ctl->opt_bold = set_opt_flag(ctl->opt_bold);
+			ctl->opt_bo_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_HALF_BRIGHT:
-			set_opt_flag(&opt_halfbright);
-			opt_hb_on = parse_switch(optarg, "on", "off");
+			ctl->opt_halfbright = set_opt_flag(ctl->opt_halfbright);
+			ctl->opt_hb_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_BLINK:
-			set_opt_flag(&opt_blink);
-			opt_bl_on = parse_switch(optarg, "on", "off");
+			ctl->opt_blink = set_opt_flag(ctl->opt_blink);
+			ctl->opt_bl_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_REVERSE:
-			set_opt_flag(&opt_reverse);
-			opt_re_on = parse_switch(optarg, "on", "off");
+			ctl->opt_reverse = set_opt_flag(ctl->opt_reverse);
+			ctl->opt_re_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_UNDERLINE:
-			set_opt_flag(&opt_underline);
-			opt_un_on = parse_switch(optarg, "on", "off");
+			ctl->opt_underline = set_opt_flag(ctl->opt_underline);
+			ctl->opt_un_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_STORE:
-			set_opt_flag(&opt_store);
+			ctl->opt_store = set_opt_flag(ctl->opt_store);
 			break;
 		case OPT_CLEAR:
-			set_opt_flag(&opt_clear);
-			opt_cl_all = parse_switch(optarg, "all", "reset");
+			ctl->opt_clear = set_opt_flag(ctl->opt_clear);
+			ctl->opt_cl_all = parse_switch(optarg, "all", "reset");
 			break;
 		case OPT_TABS:
-			set_opt_flag(&opt_tabs);
-			parse_tabs(argv, optarg, &optind, opt_tb_array);
+			ctl->opt_tabs = set_opt_flag(ctl->opt_tabs);
+			parse_tabs(argv, optarg, &optind, ctl->opt_tb_array);
 			break;
 		case OPT_CLRTABS:
-			set_opt_flag(&opt_clrtabs);
-			parse_tabs(argv, optarg, &optind, opt_tb_array);
+			ctl->opt_clrtabs = set_opt_flag(ctl->opt_clrtabs);
+			parse_tabs(argv, optarg, &optind, ctl->opt_tb_array);
 			break;
 		case OPT_REGTABS:
-			set_opt_flag(&opt_regtabs);
-			opt_rt_len = parse_regtabs(argv, optarg, &optind);
+			ctl->opt_regtabs = set_opt_flag(ctl->opt_regtabs);
+			ctl->opt_rt_len = parse_regtabs(argv, optarg, &optind);
 			break;
 		case OPT_BLANK:
-			set_opt_flag(&opt_blank);
-			opt_bl_min = parse_blank(argv, optarg, &optind);
+			ctl->opt_blank = set_opt_flag(ctl->opt_blank);
+			ctl->opt_bl_min = parse_blank(argv, optarg, &optind);
 			break;
 		case OPT_DUMP:
-			set_opt_flag(&opt_snap);
-			opt_sn_num = parse_snap(argv, optarg, &optind);
+			ctl->opt_snap = set_opt_flag(ctl->opt_snap);
+			ctl->opt_sn_num = parse_snap(argv, optarg, &optind);
 			break;
 		case OPT_APPEND:
-			set_opt_flag(&opt_append);
-			opt_sn_num = parse_snap(argv, optarg, &optind);
+			ctl->opt_append = set_opt_flag(ctl->opt_append);
+			ctl->opt_sn_num = parse_snap(argv, optarg, &optind);
 			break;
 		case OPT_FILE:
-			set_opt_flag(&opt_snapfile);
-			xstrncpy(opt_sn_name, optarg, PATH_MAX);
+			ctl->opt_snapfile = set_opt_flag(ctl->opt_snapfile);
+			ctl->opt_sn_name = optarg;
 			break;
 		case OPT_MSG:
-			set_opt_flag(&opt_msg);
-			opt_msg_on = parse_switch(optarg, "on", "off");
+			ctl->opt_msg = set_opt_flag(ctl->opt_msg);
+			ctl->opt_msg_on = parse_switch(optarg, "on", "off");
 			break;
 		case OPT_MSGLEVEL:
-			set_opt_flag(&opt_msglevel);
-			opt_msglevel_num = parse_msglevel(optarg);
+			ctl->opt_msglevel = set_opt_flag(ctl->opt_msglevel);
+			ctl->opt_msglevel_num = parse_msglevel(optarg);
 			break;
 		case OPT_POWERSAVE:
-			set_opt_flag(&opt_powersave);
-			opt_ps_mode = parse_powersave(optarg);
+			ctl->opt_powersave = set_opt_flag(ctl->opt_powersave);
+			ctl->opt_ps_mode = parse_powersave(optarg);
 			break;
 		case OPT_POWERDOWN:
-			set_opt_flag(&opt_powerdown);
-			opt_pd_min = parse_blank(argv, optarg, &optind);
+			ctl->opt_powerdown = set_opt_flag(ctl->opt_powerdown);
+			ctl->opt_pd_min = parse_blank(argv, optarg, &optind);
 			break;
 		case OPT_BLENGTH:
-			set_opt_flag(&opt_blength);
-			opt_blength_l = parse_blength(argv, optarg, &optind);
+			ctl->opt_blength = set_opt_flag(ctl->opt_blength);
+			ctl->opt_blength_l = parse_blength(argv, optarg, &optind);
 			break;
 		case OPT_BFREQ:
-			set_opt_flag(&opt_bfreq);
-			opt_bfreq_f = parse_bfreq(argv, optarg, &optind);
+			ctl->opt_bfreq = set_opt_flag(ctl->opt_bfreq);
+			ctl->opt_bfreq_f = parse_bfreq(argv, optarg, &optind);
 			break;
 		case OPT_VERSION:
 			printf(UTIL_LINUX_VERSION);
@@ -721,7 +721,7 @@ static void show_tabs(void)
 	}
 }
 
-static void screendump(int vcnum, FILE *F)
+static void screendump(struct setterm_control *ctl, FILE *F)
 {
 	char infile[MAXPATHLEN];
 	unsigned char header[4];
@@ -731,21 +731,21 @@ static void screendump(int vcnum, FILE *F)
 	ssize_t rc;
 	char *inbuf = NULL, *outbuf = NULL, *p, *q;
 
-	sprintf(infile, "/dev/vcsa%d", vcnum);
+	sprintf(infile, "/dev/vcsa%d", ctl->opt_sn_num);
 	fd = open(infile, O_RDONLY);
-	if (fd < 0 && vcnum == 0) {
+	if (fd < 0 && ctl->opt_sn_num == 0) {
 		/* vcsa0 is often called vcsa */
 		sprintf(infile, "/dev/vcsa");
 		fd = open(infile, O_RDONLY);
 	}
 	if (fd < 0) {
-		/* try devfs name - for zero vcnum just /dev/vcc/a */
+		/* try devfs name - for zero ctl->opt_sn_num just /dev/vcc/a */
 		/* some gcc's warn for %.u - add 0 */
-		sprintf(infile, "/dev/vcc/a%.0u", vcnum);
+		sprintf(infile, "/dev/vcc/a%.0u", ctl->opt_sn_num);
 		fd = open(infile, O_RDONLY);
 	}
 	if (fd < 0) {
-		sprintf(infile, "/dev/vcsa%d", vcnum);
+		sprintf(infile, "/dev/vcsa%d", ctl->opt_sn_num);
 		goto read_error;
 	}
 	if (read(fd, header, 4) != 4)
@@ -782,7 +782,7 @@ static void screendump(int vcnum, FILE *F)
 	return;
 
  read_error:
-	if (vcnum != 0)
+	if (ctl->opt_sn_num != 0)
 		warnx(_("Couldn't read %s"), infile);
 	else
 		warnx(_("Couldn't read neither /dev/vcsa0 nor /dev/vcsa"));
@@ -795,48 +795,46 @@ static void screendump(int vcnum, FILE *F)
 	exit(EXIT_FAILURE);
 }
 
-static void
-perform_sequence(int vcterm) {
-	/* vcterm: Set if terminal is a virtual console. */
-
+static void perform_sequence(struct setterm_control *ctl)
+{
 	int result;
 /* Perform the selected options. */
 
 	/* -reset. */
-	if (opt_reset) {
+	if (ctl->opt_reset) {
 		putp(ti_entry("rs1"));
 	}
 
 	/* -initialize. */
-	if (opt_initialize) {
+	if (ctl->opt_initialize) {
 		putp(ti_entry("is2"));
 	}
 
 	/* -cursor [on|off]. */
-	if (opt_cursor) {
-		if (opt_cu_on)
+	if (ctl->opt_cursor) {
+		if (ctl->opt_cu_on)
 			putp(ti_entry("cnorm"));
 		else
 			putp(ti_entry("civis"));
 	}
 
 	/* -linewrap [on|off]. Vc only (vt102) */
-	if (opt_linewrap && vcterm)
-		fputs(opt_li_on ? "\033[?7h" : "\033[?7l", stdout);
+	if (ctl->opt_linewrap && ctl->vcterm)
+		fputs(ctl->opt_li_on ? "\033[?7h" : "\033[?7l", stdout);
 
 	/* -repeat [on|off]. Vc only (vt102) */
-	if (opt_repeat && vcterm)
-		fputs(opt_rep_on ? "\033[?8h" : "\033[?8l", stdout);
+	if (ctl->opt_repeat && ctl->vcterm)
+		fputs(ctl->opt_rep_on ? "\033[?8h" : "\033[?8l", stdout);
 
 	/* -appcursorkeys [on|off]. Vc only (vt102) */
-	if (opt_appcursorkeys && vcterm)
-		fputs(opt_appck_on ? "\033[?1h" : "\033[?1l", stdout);
+	if (ctl->opt_appcursorkeys && ctl->vcterm)
+		fputs(ctl->opt_appck_on ? "\033[?1h" : "\033[?1l", stdout);
 
 	/* -default.  Vc sets default rendition, otherwise clears all
 	 * attributes.
 	 */
-	if (opt_default) {
-		if (vcterm)
+	if (ctl->opt_default) {
+		if (ctl->vcterm)
 			printf("\033[0m");
 		else
 			putp(ti_entry("sgr0"));
@@ -845,42 +843,42 @@ perform_sequence(int vcterm) {
 	/* -foreground black|red|green|yellow|blue|magenta|cyan|white|default.
 	 * Vc only (ANSI).
 	 */
-	if (opt_foreground && vcterm)
-		printf("\033[3%c%s", '0' + opt_fo_color, "m");
+	if (ctl->opt_foreground && ctl->vcterm)
+		printf("\033[3%c%s", '0' + ctl->opt_fo_color, "m");
 
 	/* -background black|red|green|yellow|blue|magenta|cyan|white|default.
 	 * Vc only (ANSI).
 	 */
-	if (opt_background && vcterm)
-		printf("\033[4%c%s", '0' + opt_ba_color, "m");
+	if (ctl->opt_background && ctl->vcterm)
+		printf("\033[4%c%s", '0' + ctl->opt_ba_color, "m");
 
 	/* -ulcolor black|red|green|yellow|blue|magenta|cyan|white|default.
 	 * Vc only.
 	 */
-	if (opt_ulcolor && vcterm) {
-		printf("\033[1;%d]", opt_ul_color);
+	if (ctl->opt_ulcolor && ctl->vcterm) {
+		printf("\033[1;%d]", ctl->opt_ul_color);
 	}
 
 	/* -hbcolor black|red|green|yellow|blue|magenta|cyan|white|default.
 	 * Vc only.
 	 */
-	if (opt_hbcolor && vcterm) {
-		printf("\033[2;%d]", opt_hb_color);
+	if (ctl->opt_hbcolor && ctl->vcterm) {
+		printf("\033[2;%d]", ctl->opt_hb_color);
 	}
 
 	/* -inversescreen [on|off].  Vc only (vt102).
 	 */
-	if (opt_inversescreen && vcterm)
-		fputs(opt_invsc_on ? "\033[?5h" : "\033[?5l", stdout);
+	if (ctl->opt_inversescreen && ctl->vcterm)
+		fputs(ctl->opt_invsc_on ? "\033[?5h" : "\033[?5l", stdout);
 
 	/* -bold [on|off].  Vc behaves as expected, otherwise off turns off
 	 * all attributes.
 	 */
-	if (opt_bold) {
-		if (opt_bo_on)
+	if (ctl->opt_bold) {
+		if (ctl->opt_bo_on)
 			putp(ti_entry("bold"));
 		else {
-			if (vcterm)
+			if (ctl->vcterm)
 				fputs("\033[22m", stdout);
 			else
 				putp(ti_entry("sgr0"));
@@ -890,11 +888,11 @@ perform_sequence(int vcterm) {
 	/* -half-bright [on|off].  Vc behaves as expected, otherwise off turns off
 	 * all attributes.
 	 */
-	if (opt_halfbright) {
-		if (opt_hb_on)
+	if (ctl->opt_halfbright) {
+		if (ctl->opt_hb_on)
 			putp(ti_entry("dim"));
 		else {
-			if (vcterm)
+			if (ctl->vcterm)
 				fputs("\033[22m", stdout);
 			else
 				putp(ti_entry("sgr0"));
@@ -904,11 +902,11 @@ perform_sequence(int vcterm) {
 	/* -blink [on|off].  Vc behaves as expected, otherwise off turns off
 	 * all attributes.
 	 */
-	if (opt_blink) {
-		if (opt_bl_on)
+	if (ctl->opt_blink) {
+		if (ctl->opt_bl_on)
 			putp(ti_entry("blink"));
 		else {
-			if (vcterm)
+			if (ctl->vcterm)
 				fputs("\033[25m", stdout);
 			else
 				putp(ti_entry("sgr0"));
@@ -918,11 +916,11 @@ perform_sequence(int vcterm) {
 	/* -reverse [on|off].  Vc behaves as expected, otherwise off turns
 	 * off all attributes.
 	 */
-	if (opt_reverse) {
-		if (opt_re_on)
+	if (ctl->opt_reverse) {
+		if (ctl->opt_re_on)
 			putp(ti_entry("rev"));
 		else {
-			if (vcterm)
+			if (ctl->vcterm)
 				fputs("\033[27m", stdout);
 			else
 				putp(ti_entry("sgr0"));
@@ -930,65 +928,65 @@ perform_sequence(int vcterm) {
 	}
 
 	/* -underline [on|off]. */
-	if (opt_underline)
-		putp(ti_entry(opt_un_on ? "smul" : "rmul"));
+	if (ctl->opt_underline)
+		putp(ti_entry(ctl->opt_un_on ? "smul" : "rmul"));
 
 	/* -store.  Vc only. */
-	if (opt_store && vcterm)
+	if (ctl->opt_store && ctl->vcterm)
 		fputs("\033[8]", stdout);
 
 	/* -clear [all|rest]. */
-	if (opt_clear)
-		putp(ti_entry(opt_cl_all ? "clear" : "ed"));
+	if (ctl->opt_clear)
+		putp(ti_entry(ctl->opt_cl_all ? "clear" : "ed"));
 
 	/* -tabs Vc only. */
-	if (opt_tabs && vcterm) {
+	if (ctl->opt_tabs && ctl->vcterm) {
 		int i;
 
-		if (opt_tb_array[0] == -1)
+		if (ctl->opt_tb_array[0] == -1)
 			show_tabs();
 		else {
-			for(i=0; opt_tb_array[i] > 0; i++)
-				printf("\033[%dG\033H", opt_tb_array[i]);
+			for(i=0; ctl->opt_tb_array[i] > 0; i++)
+				printf("\033[%dG\033H", ctl->opt_tb_array[i]);
 			putchar('\r');
 		}
 	}
 
 	/* -clrtabs Vc only. */
-	if (opt_clrtabs && vcterm) {
+	if (ctl->opt_clrtabs && ctl->vcterm) {
 		int i;
 
-		if (opt_tb_array[0] == -1)
+		if (ctl->opt_tb_array[0] == -1)
 			fputs("\033[3g", stdout);
 		else
-			for(i=0; opt_tb_array[i] > 0; i++)
-				printf("\033[%dG\033[g", opt_tb_array[i]);
+			for(i=0; ctl->opt_tb_array[i] > 0; i++)
+				printf("\033[%dG\033[g", ctl->opt_tb_array[i]);
 		putchar('\r');
 	}
 
 	/* -regtabs Vc only. */
-	if (opt_regtabs && vcterm) {
+	if (ctl->opt_regtabs && ctl->vcterm) {
 		int i;
 
 		fputs("\033[3g\r", stdout);
-		for(i=opt_rt_len+1; i<=TABS_MAX; i+=opt_rt_len)
-			printf("\033[%dC\033H",opt_rt_len);
+		for(i=ctl->opt_rt_len+1; i<=TABS_MAX; i+=ctl->opt_rt_len)
+			printf("\033[%dC\033H",ctl->opt_rt_len);
 		putchar('\r');
 	}
 
 	/* -blank [0-60]. */
-	if (opt_blank && vcterm) {
-		if (opt_bl_min >= 0)
-			printf("\033[9;%d]", opt_bl_min);
-		else if (opt_bl_min == BLANKSCREEN) {
+	if (ctl->opt_blank && ctl->vcterm) {
+		if (ctl->opt_bl_min >= 0)
+			printf("\033[9;%d]", ctl->opt_bl_min);
+		else if (ctl->opt_bl_min == BLANKSCREEN) {
 			char ioctlarg = TIOCL_BLANKSCREEN;
 			if (ioctl(0,TIOCLINUX,&ioctlarg))
 				warn(_("cannot force blank"));
-		} else if (opt_bl_min == UNBLANKSCREEN) {
+		} else if (ctl->opt_bl_min == UNBLANKSCREEN) {
 			char ioctlarg = TIOCL_UNBLANKSCREEN;
 			if (ioctl(0,TIOCLINUX,&ioctlarg))
 				warn(_("cannot force unblank"));
-		} else if (opt_bl_min == BLANKEDSCREEN) {
+		} else if (ctl->opt_bl_min == BLANKEDSCREEN) {
 			char ioctlarg = TIOCL_BLANKEDSCREEN;
 			int ret;
 			ret = ioctl(0,TIOCLINUX,&ioctlarg);
@@ -1000,35 +998,38 @@ perform_sequence(int vcterm) {
 	}
 
 	/* -powersave [on|vsync|hsync|powerdown|off] (console) */
-	if (opt_powersave) {
+	if (ctl->opt_powersave) {
 		char ioctlarg[2];
 		ioctlarg[0] = TIOCL_SETVESABLANK;
-		ioctlarg[1] = opt_ps_mode;
+		ioctlarg[1] = ctl->opt_ps_mode;
 		if (ioctl(0,TIOCLINUX,ioctlarg))
 			warn(_("cannot (un)set powersave mode"));
 	}
 
 	/* -powerdown [0-60]. */
-	if (opt_powerdown) {
-		printf("\033[14;%d]", opt_pd_min);
+	if (ctl->opt_powerdown) {
+		printf("\033[14;%d]", ctl->opt_pd_min);
 	}
 
 	/* -snap [1-NR_CONS]. */
-	if (opt_snap || opt_append) {
+	if (ctl->opt_snap || ctl->opt_append) {
 		FILE *F;
+		char dump_default[] = "screen.dump";
 
-		F = fopen(opt_sn_name, opt_snap ? "w" : "a");
+		if (!ctl->opt_sn_name)
+			ctl->opt_sn_name = dump_default;
+		F = fopen(ctl->opt_sn_name, ctl->opt_snap ? "w" : "a");
 		if (!F)
 			err(EXIT_DUMPFILE, _("can not open dump file %s for output"),
-				opt_sn_name); 
-		screendump(opt_sn_num, F);
+				ctl->opt_sn_name);
+		screendump(ctl, F);
 		if (close_stream(F) != 0)
 			errx(EXIT_FAILURE, _("write error"));
 	}
 
 	/* -msg [on|off]. */
-	if (opt_msg && vcterm) {
-		if (opt_msg_on)
+	if (ctl->opt_msg && ctl->vcterm) {
+		if (ctl->opt_msg_on)
 			/* 7 -- Enable printk's to console */
 			result = klogctl(SYSLOG_ACTION_CONSOLE_ON, NULL, 0);
 		else
@@ -1040,31 +1041,31 @@ perform_sequence(int vcterm) {
 	}
 
 	/* -msglevel [0-8] */
-	if (opt_msglevel && vcterm) {
+	if (ctl->opt_msglevel && ctl->vcterm) {
 		/* 8 -- Set level of messages printed to console */
-		result = klogctl(SYSLOG_ACTION_CONSOLE_LEVEL, NULL, opt_msglevel_num);
+		result = klogctl(SYSLOG_ACTION_CONSOLE_LEVEL, NULL, ctl->opt_msglevel_num);
 		if (result != 0)
 			warn(_("klogctl error"));
 	}
 
 	/* -blength [0-2000] */
-	if (opt_blength && vcterm) {
-		printf("\033[11;%d]", opt_blength_l);
+	if (ctl->opt_blength && ctl->vcterm) {
+		printf("\033[11;%d]", ctl->opt_blength_l);
 	}
 
 	/* -bfreq freqnumber */
-	if (opt_bfreq && vcterm) {
-		printf("\033[10;%d]", opt_bfreq_f);
+	if (ctl->opt_bfreq && ctl->vcterm) {
+		printf("\033[10;%d]", ctl->opt_bfreq_f);
 	}
 
 }
 
-int
-main(int argc, char **argv) {
-	char *term;			/* Terminal type. */
-	int vcterm;			/* Set if terminal is a virtual console. */
-	int errret;
+int main(int argc, char **argv)
+{
+	struct setterm_control ctl;
+	int term_errno;
 
+	memset(&ctl, 0, sizeof (ctl));
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
@@ -1074,37 +1075,32 @@ main(int argc, char **argv) {
 		usage(stderr);
 
 	/* Parse arguments. */
-	parse_option(argc, argv);
+	parse_option(&ctl, argc, argv);
 
 	/* Find out terminal name. */
-
-	if (opt_term) {
-		term = opt_te_terminal_name;
-	} else {
-		term = getenv("TERM");
-		if (term == NULL)
+	if (!ctl.opt_te_terminal_name) {
+		ctl.opt_te_terminal_name = getenv("TERM");
+		if (ctl.opt_te_terminal_name == NULL)
 			errx(EXIT_FAILURE, _("$TERM is not defined."));
 	}
 
 	/* Find terminfo entry. */
-
-	if (setupterm(term, 1, &errret))
-		switch(errret) {
+	if (setupterm(ctl.opt_te_terminal_name, 1, &term_errno))
+		switch(term_errno) {
 		case -1:
 			errx(EXIT_FAILURE, _("terminfo database cannot be found"));
 		case 0:
-			errx(EXIT_FAILURE, _("%s: unknown terminal type"), term);
+			errx(EXIT_FAILURE, _("%s: unknown terminal type"), ctl.opt_te_terminal_name);
 		case 1:
 			errx(EXIT_FAILURE, _("terminal is hardcopy"));
 		}
 
 	/* See if the terminal is a virtual console terminal. */
-
-	vcterm = (!strncmp(term, "con", 3) || !strncmp(term, "linux", 5));
+	ctl.vcterm = (!strncmp(ctl.opt_te_terminal_name, "con", 3) ||
+		      !strncmp(ctl.opt_te_terminal_name, "linux", 5));
 
 	/* Perform the selected options. */
-
-	perform_sequence(vcterm);
+	perform_sequence(&ctl);
 
 	return EXIT_SUCCESS;
 }
-- 
1.9.2

