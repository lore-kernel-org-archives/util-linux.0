Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35691 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751761AbcGQNAm (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id i5so8764000wmg.2
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/13] setterm: fix declarations shadowing variables in the global scope [oclint]
Date: Sun, 17 Jul 2016 14:00:13 +0100
Message-Id: <20160717130015.31760-12-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 80 ++++++++++++++++++++++++++--------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 704fc59..e2c627a 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -217,18 +217,18 @@ static int parse_febg_color(const char *arg)
 	return color;
 }
 
-static int parse_ulhb_color(char **argv, int *optind)
+static int parse_ulhb_color(char **av, int *oi)
 {
 	char *color_name;
 	int bright = 0;
 	int color = -1;
 
-	if (argv[*optind] && strcmp(argv[*optind - 1], "bright") == 0) {
+	if (av[*oi] && strcmp(av[*oi - 1], "bright") == 0) {
 		bright = 1;
-		color_name = argv[*optind];
-		(*optind)++;
+		color_name = av[*oi];
+		(*oi)++;
 	} else
-		color_name = argv[*optind - 1];
+		color_name = av[*oi - 1];
 
 	color = parse_color(color_name);
 	if (color < 0)
@@ -241,25 +241,25 @@ static int parse_ulhb_color(char **argv, int *optind)
 	return color;
 }
 
-static char *find_optional_arg(char **argv, char *optarg, int *optind)
+static char *find_optional_arg(char **av, char *oa, int *oi)
 {
 	char *arg;
-	if (optarg)
-		return optarg;
+	if (oa)
+		return oa;
 	else {
-		arg = argv[*optind];
+		arg = av[*oi];
 		if (!arg || arg[0] == '-')
 			return NULL;
 	}
-	(*optind)++;
+	(*oi)++;
 	return arg;
 }
 
-static int parse_blank(char **argv, char *optarg, int *optind)
+static int parse_blank(char **av, char *oa, int *oi)
 {
 	char *arg;
 
-	arg = find_optional_arg(argv, optarg, optind);
+	arg = find_optional_arg(av, oa, oi);
 	if (!arg)
 		return BLANKEDSCREEN;
 	if (!strcmp(arg, "force"))
@@ -301,12 +301,12 @@ static int parse_msglevel(const char *arg)
 	return ret;
 }
 
-static int parse_snap(char **argv, char *optarg, int *optind)
+static int parse_snap(char **av, char *oa, int *oi)
 {
 	int ret;
 	char *arg;
 
-	arg = find_optional_arg(argv, optarg, optind);
+	arg = find_optional_arg(av, oa, oi);
 	if (!arg)
 		return 0;
 	ret = strtos32_or_err(arg, _("argument error"));
@@ -315,32 +315,32 @@ static int parse_snap(char **argv, char *optarg, int *optind)
 	return ret;
 }
 
-static void parse_tabs(char **argv, char *optarg, int *optind, int *tab_array)
+static void parse_tabs(char **av, char *oa, int *oi, int *tab_array)
 {
 	int i = 0;
 
-	if (optarg) {
-		tab_array[i] = strtos32_or_err(optarg, _("argument error"));
+	if (oa) {
+		tab_array[i] = strtos32_or_err(oa, _("argument error"));
 		i++;
 	}
-	while (argv[*optind]) {
+	while (av[*oi]) {
 		if (TABS_MAX < i)
 			errx(EXIT_FAILURE, _("too many tabs"));
-		if (argv[*optind][0] == '-')
+		if (av[*oi][0] == '-')
 			break;
-		tab_array[i] = strtos32_or_err(argv[*optind], _("argument error"));
-		(*optind)++;
+		tab_array[i] = strtos32_or_err(av[*oi], _("argument error"));
+		(*oi)++;
 		i++;
 	}
 	tab_array[i] = -1;
 }
 
-static int parse_regtabs(char **argv, char *optarg, int *optind)
+static int parse_regtabs(char **av, char *oa, int *oi)
 {
 	int ret;
 	char *arg;
 
-	arg = find_optional_arg(argv, optarg, optind);
+	arg = find_optional_arg(av, oa, oi);
 	if (!arg)
 		return DEFAULT_TAB_LEN;
 	ret = strtos32_or_err(arg, _("argument error"));
@@ -349,12 +349,12 @@ static int parse_regtabs(char **argv, char *optarg, int *optind)
 	return ret;
 }
 
-static int parse_blength(char **argv, char *optarg, int *optind)
+static int parse_blength(char **av, char *oa, int *oi)
 {
 	int ret = -1;
 	char *arg;
 
-	arg = find_optional_arg(argv, optarg, optind);
+	arg = find_optional_arg(av, oa, oi);
 	if (!arg)
 		return 0;
 	ret = strtos32_or_err(arg, _("argument error"));
@@ -363,11 +363,11 @@ static int parse_blength(char **argv, char *optarg, int *optind)
 	return ret;
 }
 
-static int parse_bfreq(char **argv, char *optarg, int *optind)
+static int parse_bfreq(char **av, char *oa, int *oi)
 {
 	char *arg;
 
-	arg = find_optional_arg(argv, optarg, optind);
+	arg = find_optional_arg(av, oa, oi);
 	if (!arg)
 		return 0;
 	return strtos32_or_err(arg, _("argument error"));
@@ -431,7 +431,7 @@ static int __attribute__((__pure__)) set_opt_flag(int opt)
 	return 1;
 }
 
-static void parse_option(struct setterm_control *ctl, int argc, char **argv)
+static void parse_option(struct setterm_control *ctl, int ac, char **av)
 {
 	int c;
 	enum {
@@ -517,7 +517,7 @@ static void parse_option(struct setterm_control *ctl, int argc, char **argv)
 	};
 	int excl_st[ARRAY_SIZE(excl)] = UL_EXCL_STATUS_INIT;
 
-	while ((c = getopt_long_only(argc, argv, "", longopts, NULL)) != -1) {
+	while ((c = getopt_long_only(ac, av, "", longopts, NULL)) != -1) {
 		err_exclusive_options(c, longopts, excl, excl_st);
 		switch (c) {
 		case OPT_TERM:
@@ -563,11 +563,11 @@ static void parse_option(struct setterm_control *ctl, int argc, char **argv)
 			break;
 		case OPT_ULCOLOR:
 			ctl->opt_ulcolor = set_opt_flag(ctl->opt_ulcolor);
-			ctl->opt_ul_color = parse_ulhb_color(argv, &optind);
+			ctl->opt_ul_color = parse_ulhb_color(av, &optind);
 			break;
 		case OPT_HBCOLOR:
 			ctl->opt_hbcolor = set_opt_flag(ctl->opt_hbcolor);
-			ctl->opt_hb_color = parse_ulhb_color(argv, &optind);
+			ctl->opt_hb_color = parse_ulhb_color(av, &optind);
 			break;
 		case OPT_INVERSESCREEN:
 			ctl->opt_inversescreen = set_opt_flag(ctl->opt_inversescreen);
@@ -609,27 +609,27 @@ static void parse_option(struct setterm_control *ctl, int argc, char **argv)
 			break;
 		case OPT_TABS:
 			ctl->opt_tabs = set_opt_flag(ctl->opt_tabs);
-			parse_tabs(argv, optarg, &optind, ctl->opt_tb_array);
+			parse_tabs(av, optarg, &optind, ctl->opt_tb_array);
 			break;
 		case OPT_CLRTABS:
 			ctl->opt_clrtabs = set_opt_flag(ctl->opt_clrtabs);
-			parse_tabs(argv, optarg, &optind, ctl->opt_tb_array);
+			parse_tabs(av, optarg, &optind, ctl->opt_tb_array);
 			break;
 		case OPT_REGTABS:
 			ctl->opt_regtabs = set_opt_flag(ctl->opt_regtabs);
-			ctl->opt_rt_len = parse_regtabs(argv, optarg, &optind);
+			ctl->opt_rt_len = parse_regtabs(av, optarg, &optind);
 			break;
 		case OPT_BLANK:
 			ctl->opt_blank = set_opt_flag(ctl->opt_blank);
-			ctl->opt_bl_min = parse_blank(argv, optarg, &optind);
+			ctl->opt_bl_min = parse_blank(av, optarg, &optind);
 			break;
 		case OPT_DUMP:
 			ctl->opt_snap = set_opt_flag(ctl->opt_snap);
-			ctl->opt_sn_num = parse_snap(argv, optarg, &optind);
+			ctl->opt_sn_num = parse_snap(av, optarg, &optind);
 			break;
 		case OPT_APPEND:
 			ctl->opt_append = set_opt_flag(ctl->opt_append);
-			ctl->opt_sn_num = parse_snap(argv, optarg, &optind);
+			ctl->opt_sn_num = parse_snap(av, optarg, &optind);
 			break;
 		case OPT_FILE:
 			ctl->opt_snapfile = set_opt_flag(ctl->opt_snapfile);
@@ -654,15 +654,15 @@ static void parse_option(struct setterm_control *ctl, int argc, char **argv)
 			break;
 		case OPT_POWERDOWN:
 			ctl->opt_powerdown = set_opt_flag(ctl->opt_powerdown);
-			ctl->opt_pd_min = parse_blank(argv, optarg, &optind);
+			ctl->opt_pd_min = parse_blank(av, optarg, &optind);
 			break;
 		case OPT_BLENGTH:
 			ctl->opt_blength = set_opt_flag(ctl->opt_blength);
-			ctl->opt_blength_l = parse_blength(argv, optarg, &optind);
+			ctl->opt_blength_l = parse_blength(av, optarg, &optind);
 			break;
 		case OPT_BFREQ:
 			ctl->opt_bfreq = set_opt_flag(ctl->opt_bfreq);
-			ctl->opt_bfreq_f = parse_bfreq(argv, optarg, &optind);
+			ctl->opt_bfreq_f = parse_bfreq(av, optarg, &optind);
 			break;
 		case OPT_VERSION:
 			printf(UTIL_LINUX_VERSION);
-- 
2.9.0

