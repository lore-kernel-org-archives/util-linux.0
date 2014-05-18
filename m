Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:45668 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaEROF7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:05:59 -0400
Received: by mail-wg0-f48.google.com with SMTP id b13so6705844wgh.31
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:05:58 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/17] setterm: use string utils to numeric parsing
Date: Sun, 18 May 2014 15:05:27 +0100
Message-Id: <1400421941-14244-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Check the input numbers are numbers, which makes also the code shorter,
and user experience better as half invalid imputs will error.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/Makemodule.am |  2 +-
 term-utils/setterm.c     | 70 +++++++++++++++++++++++-------------------------
 2 files changed, 35 insertions(+), 37 deletions(-)

diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index e53471f..39fddc9 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -29,7 +29,7 @@ usrbin_exec_PROGRAMS += setterm
 dist_man_MANS += term-utils/setterm.1
 setterm_SOURCES = term-utils/setterm.c
 setterm_CFLAGS = $(AM_CFLAGS)
-setterm_LDADD = $(LDADD)
+setterm_LDADD = $(LDADD) libcommon.la
 if HAVE_TINFO
 setterm_LDADD += $(TINFO_LIBS)
 setterm_CFLAGS += $(TINFO_CFLAGS)
diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 25baff7..c4753d0 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -124,6 +124,7 @@
 #include "c.h"
 #include "closestream.h"
 #include "nls.h"
+#include "strutils.h"
 #include "xalloc.h"
 
 /* Constants. */
@@ -227,6 +228,15 @@ static void screendump(int vcnum, FILE *F);
  * Note that it is an error for a given option to be invoked more than once.
  */
 
+static int strtoint_or_err(const char *str)
+{
+	int64_t num = strtos64_or_err(str, _("argument error"));
+
+	if (num < INT_MIN || INT_MAX < num)
+		errx(EXIT_FAILURE, _("argument error: %s"), str);
+	return num;
+}
+
 static int parse_switch(const char *arg, const char *t, const char *f)
 {
 	if (strcmp(arg, t) == 0)
@@ -238,6 +248,8 @@ static int parse_switch(const char *arg, const char *t, const char *f)
 
 static int parse_febg_color(const char *arg)
 {
+	int color;
+
 	if (strcmp(arg, "black") == 0)
 		return BLACK;
 	else if (strcmp(arg, "red") == 0)
@@ -256,15 +268,11 @@ static int parse_febg_color(const char *arg)
 		return WHITE;
 	else if (strcmp(arg, "default") == 0)
 		return DEFAULT;
-	else if (isdigit(arg[0])) {
-		int color;
-
-		color = atoi(arg);
-		if (color < BLACK || DEFAULT < color || color == GREY)
-			errx(EXIT_FAILURE, _("argument error: %s"), arg);
-		return color;
-	}
-	errx(EXIT_FAILURE, _("argument error: %s"), arg);
+	else
+		color = strtoint_or_err(arg);
+	if (color < BLACK || DEFAULT < color || color == GREY)
+		errx(EXIT_FAILURE, _("argument error: %s"), arg);
+	return color;
 }
 
 static int parse_ulhb_color(char **argv, int *optind)
@@ -298,11 +306,11 @@ static int parse_ulhb_color(char **argv, int *optind)
 		color = CYAN;
 	else if (strcmp(color_name, "white") == 0)
 		color = WHITE;
-	else if (isdigit(color_name[0]))
-		color = atoi(color_name);
-
-	if (color < BLACK || DEFAULT < color)
-		errx(EXIT_FAILURE, _("argument error: %s"), color_name);
+	else {
+		color = strtoint_or_err(color_name);
+		if (color < BLACK || DEFAULT < color)
+			errx(EXIT_FAILURE, _("argument error"));
+	}
 	if (bright && (color == BLACK || color == GREY))
 		errx(EXIT_FAILURE, _("argument error: bright %s is not supported"), color_name);
 
@@ -335,10 +343,9 @@ static int parse_blank(char **argv, char *optarg, int *optind)
 	else if (!strcmp(arg, "poke"))
 		return UNBLANKSCREEN;
 	else {
-		int ret = -1;
+		int ret;
 
-		if (isdigit(arg[0]))
-			ret = atoi(arg);
+		ret = strtoint_or_err(arg);
 		if (ret < 0 || BLANK_MAX < ret)
 			errx(EXIT_FAILURE, _("argument error: %s"), arg);
 		return ret;
@@ -364,10 +371,9 @@ static int parse_powersave(const char *arg)
 
 static int parse_msglevel(const char *arg)
 {
-	int ret = CONSOLE_LEVEL_MIN - 1;
+	int ret;
 
-	if (isdigit(arg[0]))
-		ret = atoi(arg);
+	ret = strtoint_or_err(arg);
 	if (ret < CONSOLE_LEVEL_MIN || CONSOLE_LEVEL_MAX < ret)
 		errx(EXIT_FAILURE, _("argument error: %s"), arg);
 	return ret;
@@ -375,14 +381,13 @@ static int parse_msglevel(const char *arg)
 
 static int parse_snap(char **argv, char *optarg, int *optind)
 {
-	int ret = 0;
+	int ret;
 	char *arg;
 
 	arg = find_optional_arg(argv, optarg, optind);
 	if (!arg)
 		return 0;
-	if (isdigit(arg[0]))
-		ret = atoi(arg);
+	ret = strtoint_or_err(arg);
 	if (ret < 1)
 		errx(EXIT_FAILURE, _("argument error: %s"), arg);
 	return ret;
@@ -393,7 +398,7 @@ static void parse_tabs(char **argv, char *optarg, int *optind, int *tab_array)
 	int i = 0;
 
 	if (optarg) {
-		tab_array[i] = atoi(optarg);
+		tab_array[i] = strtoint_or_err(optarg);
 		i++;
 	}
 	while (argv[*optind]) {
@@ -401,10 +406,7 @@ static void parse_tabs(char **argv, char *optarg, int *optind, int *tab_array)
 			errx(EXIT_FAILURE, _("too many tabs"));
 		if (argv[*optind][0] == '-')
 			break;
-		if (isdigit(argv[*optind][0]))
-			tab_array[i] = atoi(argv[*optind]);
-		else
-			break;
+		tab_array[i] = strtoint_or_err(argv[*optind]);
 		(*optind)++;
 		i++;
 	}
@@ -419,7 +421,7 @@ static int parse_regtabs(char **argv, char *optarg, int *optind)
 	arg = find_optional_arg(argv, optarg, optind);
 	if (!arg)
 		return DEFAULT_TAB_LEN;
-	ret = atoi(arg);
+	ret = strtoint_or_err(arg);
 	if (ret < 1 || TABS_MAX < ret)
 		errx(EXIT_FAILURE, _("argument error: %s"), arg);
 	return ret;
@@ -433,8 +435,7 @@ static int parse_blength(char **argv, char *optarg, int *optind)
 	arg = find_optional_arg(argv, optarg, optind);
 	if (!arg)
 		return 0;
-	if (isdigit(arg[0]))
-		ret = atoi(arg);
+	ret = strtoint_or_err(arg);
 	if (ret < 0 || BLENGTH_MAX < ret)
 		errx(EXIT_FAILURE, _("argument error: %s"), arg);
 	return ret;
@@ -447,9 +448,7 @@ static int parse_bfreq(char **argv, char *optarg, int *optind)
 	arg = find_optional_arg(argv, optarg, optind);
 	if (!arg)
 		return 0;
-	if (isdigit(arg[0]))
-		return atoi(arg);
-	return 0;
+	return strtoint_or_err(arg);
 }
 
 static void
@@ -717,8 +716,7 @@ static void parse_option(int argc, char **argv)
 			break;
 		case OPT_FILE:
 			set_opt_flag(&opt_snapfile);
-			strncpy(opt_sn_name, optarg, PATH_MAX);	/* FIXME: should use xstrncpy() */
-			opt_sn_name[PATH_MAX - 1] = 0;
+			xstrncpy(opt_sn_name, optarg, PATH_MAX);
 			break;
 		case OPT_MSG:
 			set_opt_flag(&opt_msg);
-- 
1.9.2

