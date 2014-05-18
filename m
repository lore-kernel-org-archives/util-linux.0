Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:44516 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaEROF5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:05:57 -0400
Received: by mail-wi0-f175.google.com with SMTP id f8so2944872wiw.8
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:05:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/17] setterm: use getopt_long_only() for option parsing
Date: Sun, 18 May 2014 15:05:26 +0100
Message-Id: <1400421941-14244-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The getopt_long_only() has advantage of allowing one and two hyphen
versions of options, for example -help and --help.  Secondly the getopt
function family from libc can ensure some options requiring arguments,
while other are optional, and some should not accept argument at all.
That makes option parsing more robust.

Unfortunately retiring the old option parsing makes this change greater
than preferred.  Assuming not mistakes happen the new code works
functionally exactly as the old did.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 916 ++++++++++++++++++++++++---------------------------
 1 file changed, 426 insertions(+), 490 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index e6385ac..25baff7 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -95,6 +95,7 @@
 #include <ctype.h>
 #include <errno.h>
 #include <fcntl.h>
+#include <getopt.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -217,7 +218,7 @@ int opt_tb_array[TABS_MAX + 1];	/* Array for tab list */
 int opt_msglevel_num;
 int opt_ps_mode, opt_pd_min;	/* powersave mode/powerdown time */
 
-char opt_sn_name[PATH_MAX + 1] = "screen.dump";
+char opt_sn_name[PATH_MAX] = "screen.dump";
 
 static void screendump(int vcnum, FILE *F);
 
@@ -226,416 +227,231 @@ static void screendump(int vcnum, FILE *F);
  * Note that it is an error for a given option to be invoked more than once.
  */
 
-static void
-parse_term(int argc, char **argv, int *option, char **ttyname, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Term flag to set. */
-	/* ttyname: Terminal name to set. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a -term specification. */
-
-	if (argc != 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1)
-		*ttyname = argv[0];
-}
-
-static void
-parse_none(int argc, char **argv __attribute__ ((__unused__)), int *option, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Term flag to set. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a parameterless specification. */
-
-	if (argc != 0 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-}
-
-static void
-parse_switch(int argc, char **argv, int *option, int *opt_on, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Option flag to set. */
-	/* opt_on: Boolean option switch to set or reset. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a boolean (on/off) specification. */
-
-	if (argc > 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1) {
-		if (strcmp(argv[0], "on") == 0)
-			*opt_on = TRUE;
-		else if (strcmp(argv[0], "off") == 0)
-			*opt_on = FALSE;
-		else
-			*bad_arg = TRUE;
-	} else {
-		*opt_on = TRUE;
-	}
+static int parse_switch(const char *arg, const char *t, const char *f)
+{
+	if (strcmp(arg, t) == 0)
+		return 1;
+	else if (strcmp(arg, f) == 0)
+		return 0;
+	errx(EXIT_FAILURE, _("argument error: %s"), arg);
 }
 
-static void
-par_color(int argc, char **argv, int *option, int *opt_color, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Color flag to set. */
-	/* opt_color: Color to set. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a -foreground or -background specification. */
-
-	if (argc != 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1) {
-		if (strcmp(argv[0], "black") == 0)
-			*opt_color = BLACK;
-		else if (strcmp(argv[0], "red") == 0)
-			*opt_color = RED;
-		else if (strcmp(argv[0], "green") == 0)
-			*opt_color = GREEN;
-		else if (strcmp(argv[0], "yellow") == 0)
-			*opt_color = YELLOW;
-		else if (strcmp(argv[0], "blue") == 0)
-			*opt_color = BLUE;
-		else if (strcmp(argv[0], "magenta") == 0)
-			*opt_color = MAGENTA;
-		else if (strcmp(argv[0], "cyan") == 0)
-			*opt_color = CYAN;
-		else if (strcmp(argv[0], "white") == 0)
-			*opt_color = WHITE;
-		else if (strcmp(argv[0], "default") == 0)
-			*opt_color = DEFAULT;
-		else if (isdigit(argv[0][0]))
-			*opt_color = atoi(argv[0]);
-		else
-			*bad_arg = TRUE;
-
-		if(*opt_color < BLACK || DEFAULT < *opt_color || *opt_color == GREY)
-			*bad_arg = TRUE;
+static int parse_febg_color(const char *arg)
+{
+	if (strcmp(arg, "black") == 0)
+		return BLACK;
+	else if (strcmp(arg, "red") == 0)
+		return RED;
+	else if (strcmp(arg, "green") == 0)
+		return GREEN;
+	else if (strcmp(arg, "yellow") == 0)
+		return YELLOW;
+	else if (strcmp(arg, "blue") == 0)
+		return BLUE;
+	else if (strcmp(arg, "magenta") == 0)
+		return MAGENTA;
+	else if (strcmp(arg, "cyan") == 0)
+		return CYAN;
+	else if (strcmp(arg, "white") == 0)
+		return WHITE;
+	else if (strcmp(arg, "default") == 0)
+		return DEFAULT;
+	else if (isdigit(arg[0])) {
+		int color;
+
+		color = atoi(arg);
+		if (color < BLACK || DEFAULT < color || color == GREY)
+			errx(EXIT_FAILURE, _("argument error: %s"), arg);
+		return color;
 	}
+	errx(EXIT_FAILURE, _("argument error: %s"), arg);
 }
 
-static void
-par_color2(int argc, char **argv, int *option, int *opt_color, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Color flag to set. */
-	/* opt_color: Color to set. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a -ulcolor or -hbcolor specification. */
-
-	if (!argc || argc > 2 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	*opt_color = 0;
-	if (argc == 2) {
-		if (strcmp(argv[0], "bright") == 0)
-			*opt_color = GREY;
-		else {
-			*bad_arg = TRUE;
-			return;
-		}
-	}
-	if (argc) {
-		if (strcmp(argv[argc-1], "black") == 0) {
-			if(*opt_color)
-				*bad_arg = TRUE;
-			else
-				*opt_color = BLACK;
-		} else if (strcmp(argv[argc-1], "grey") == 0) {
-			if(*opt_color)
-				*bad_arg = TRUE;
-			else
-				*opt_color = GREY;
-		} else if (strcmp(argv[argc-1], "red") == 0)
-			*opt_color |= RED;
-		else if (strcmp(argv[argc-1], "green") == 0)
-			*opt_color |= GREEN;
-		else if (strcmp(argv[argc-1], "yellow") == 0)
-			*opt_color |= YELLOW;
-		else if (strcmp(argv[argc-1], "blue") == 0)
-			*opt_color |= BLUE;
-		else if (strcmp(argv[argc-1], "magenta") == 0)
-			*opt_color |= MAGENTA;
-		else if (strcmp(argv[argc-1], "cyan") == 0)
-			*opt_color |= CYAN;
-		else if (strcmp(argv[argc-1], "white") == 0)
-			*opt_color |= WHITE;
-		else if (isdigit(argv[argc-1][0]))
-			*opt_color = atoi(argv[argc-1]);
-		else
-			*bad_arg = TRUE;
-		if(*opt_color < BLACK || DEFAULT < *opt_color )
-			*bad_arg = TRUE;
-	}
+static int parse_ulhb_color(char **argv, int *optind)
+{
+	char *color_name;
+	int bright = 0;
+	int color = -1;
+
+	if (argv[*optind] && strcmp(argv[*optind - 1], "bright") == 0) {
+		bright = 1;
+		color_name = argv[*optind];
+		(*optind)++;
+	} else
+		color_name = argv[*optind - 1];
+
+	if (strcmp(color_name, "black") == 0)
+		color = BLACK;
+	else if (strcmp(color_name, "grey") == 0)
+		color = GREY;
+	else if (strcmp(color_name, "red") == 0)
+		color = RED;
+	else if (strcmp(color_name, "green") == 0)
+		color = GREEN;
+	else if (strcmp(color_name, "yellow") == 0)
+		color = YELLOW;
+	else if (strcmp(color_name, "blue") == 0)
+		color = BLUE;
+	else if (strcmp(color_name, "magenta") == 0)
+		color = MAGENTA;
+	else if (strcmp(color_name, "cyan") == 0)
+		color = CYAN;
+	else if (strcmp(color_name, "white") == 0)
+		color = WHITE;
+	else if (isdigit(color_name[0]))
+		color = atoi(color_name);
+
+	if (color < BLACK || DEFAULT < color)
+		errx(EXIT_FAILURE, _("argument error: %s"), color_name);
+	if (bright && (color == BLACK || color == GREY))
+		errx(EXIT_FAILURE, _("argument error: bright %s is not supported"), color_name);
+
+	return color;
 }
 
-static void
-parse_clear(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* opt_all: Clear all switch to set or reset. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a -clear specification. */
-
-	if (argc > 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1) {
-		if (strcmp(argv[0], "all") == 0)
-			*opt_all = TRUE;
-		else if (strcmp(argv[0], "rest") == 0)
-			*opt_all = FALSE;
-		else
-			*bad_arg = TRUE;
-	} else {
-		*opt_all = TRUE;
+static char *find_optional_arg(char **argv, char *optarg, int *optind)
+{
+	char *arg;
+	if (optarg)
+		return optarg;
+	else {
+		arg = argv[*optind];
+		if (!arg || arg[0] == '-')
+			return NULL;
 	}
+	(*optind)++;
+	return arg;
 }
 
-static void
-parse_blank(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* opt_all: Clear all switch to set or reset. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a -blank specification. */
-
-	if (argc > 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1) {
-		if (!strcmp(argv[0], "force"))
-			*opt_all = BLANKSCREEN;
-		else if (!strcmp(argv[0], "poke"))
-			*opt_all = UNBLANKSCREEN;
-		else {
-			*opt_all = atoi(argv[0]);
-			if (*opt_all < 0 || BLANK_MAX < *opt_all)
-				*bad_arg = TRUE;
-		}
-	} else {
-		*opt_all = BLANKEDSCREEN;
+static int parse_blank(char **argv, char *optarg, int *optind)
+{
+	char *arg;
+
+	arg = find_optional_arg(argv, optarg, optind);
+	if (!arg)
+		return BLANKEDSCREEN;
+	if (!strcmp(arg, "force"))
+		return BLANKSCREEN;
+	else if (!strcmp(arg, "poke"))
+		return UNBLANKSCREEN;
+	else {
+		int ret = -1;
+
+		if (isdigit(arg[0]))
+			ret = atoi(arg);
+		if (ret < 0 || BLANK_MAX < ret)
+			errx(EXIT_FAILURE, _("argument error: %s"), arg);
+		return ret;
 	}
+	/* should be impossible to reach */
+	abort();
 }
 
-static void
-parse_powersave(int argc, char **argv, int *option, int *opt_mode, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: powersave flag to set. */
-	/* opt_mode: Powersaving mode, defined in vesa_blank.c */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a -powersave mode specification. */
-
-	if (argc > 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1) {
-		if (strcmp(argv[0], "on") == 0)
-			*opt_mode = VESA_BLANK_MODE_SUSPENDV;
-		else if (strcmp(argv[0], "vsync") == 0)
-			*opt_mode = VESA_BLANK_MODE_SUSPENDV;
-		else if (strcmp(argv[0], "hsync") == 0)
-			*opt_mode = VESA_BLANK_MODE_SUSPENDH;
-		else if (strcmp(argv[0], "powerdown") == 0)
-			*opt_mode = VESA_BLANK_MODE_POWERDOWN;
-		else if (strcmp(argv[0], "off") == 0)
-			*opt_mode = VESA_BLANK_MODE_OFF;
-		else
-			*bad_arg = TRUE;
-	} else {
-		*opt_mode = VESA_BLANK_MODE_OFF;
-	}
+static int parse_powersave(const char *arg)
+{
+	if (strcmp(arg, "on") == 0)
+		return VESA_BLANK_MODE_SUSPENDV;
+	else if (strcmp(arg, "vsync") == 0)
+		return VESA_BLANK_MODE_SUSPENDV;
+	else if (strcmp(arg, "hsync") == 0)
+		return VESA_BLANK_MODE_SUSPENDH;
+	else if (strcmp(arg, "powerdown") == 0)
+		return VESA_BLANK_MODE_POWERDOWN;
+	else if (strcmp(arg, "off") == 0)
+		return VESA_BLANK_MODE_OFF;
+	errx(EXIT_FAILURE, _("argument error: %s"), arg);
 }
 
-static void
-parse_msglevel(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* opt_all: Clear all switch to set or reset. */
-	/* bad_arg: Set to true if an error is detected. */
-
-	if (argc > 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1) {
-		*opt_all = atoi(argv[0]);
-		if (*opt_all < CONSOLE_LEVEL_MIN || CONSOLE_LEVEL_MAX <  *opt_all)
-			*bad_arg = TRUE;
-	} else {
-		*opt_all = -1;
-	}
-}
+static int parse_msglevel(const char *arg)
+{
+	int ret = CONSOLE_LEVEL_MIN - 1;
 
-static void
-parse_snap(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* opt_all: Clear all switch to set or reset. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a -dump or -append specification. */
-
-	if (argc > 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1) {
-		*opt_all = atoi(argv[0]);
-		if ((*opt_all <= 0))
-			*bad_arg = TRUE;
-	} else {
-		*opt_all = 0;
-	}
+	if (isdigit(arg[0]))
+		ret = atoi(arg);
+	if (ret < CONSOLE_LEVEL_MIN || CONSOLE_LEVEL_MAX < ret)
+		errx(EXIT_FAILURE, _("argument error: %s"), arg);
+	return ret;
 }
 
-static void
-parse_snapfile(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* opt_all: Clear all switch to set or reset. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a -file specification. */
-
-	if (argc != 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	memset(opt_all, 0, PATH_MAX + 1);
-	if (argc == 1)
-		strncpy((char *)opt_all, argv[0], PATH_MAX);
+static int parse_snap(char **argv, char *optarg, int *optind)
+{
+	int ret = 0;
+	char *arg;
+
+	arg = find_optional_arg(argv, optarg, optind);
+	if (!arg)
+		return 0;
+	if (isdigit(arg[0]))
+		ret = atoi(arg);
+	if (ret < 1)
+		errx(EXIT_FAILURE, _("argument error: %s"), arg);
+	return ret;
 }
 
-static void
-parse_tabs(int argc, char **argv, int *option, int *tab_array, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* tab_array: Array of tabs */
-	/* bad_arg: Set to true if an error is detected. */
-
-	if (*option || TABS_MAX < argc)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	tab_array[argc] = -1;
-	while(argc--) {
-		tab_array[argc] = atoi(argv[argc]);
-		if (tab_array[argc] < 1 || TABS_MAX < tab_array[argc]) {
-			*bad_arg = TRUE;
-			return;
-		}
-	}
-}
+static void parse_tabs(char **argv, char *optarg, int *optind, int *tab_array)
+{
+	int i = 0;
 
-static void
-parse_clrtabs(int argc, char **argv, int *option, int *tab_array, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* tab_array: Array of tabs */
-	/* bad_arg: Set to true if an error is detected. */
-
-	if (*option || TABS_MAX < argc)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if(argc == 0) {
-		tab_array[0] = -1;
-		return;
+	if (optarg) {
+		tab_array[i] = atoi(optarg);
+		i++;
 	}
-	tab_array[argc] = -1;
-	while(argc--) {
-		tab_array[argc] = atoi(argv[argc]);
-		if(tab_array[argc] < 1 || TABS_MAX < tab_array[argc]) {
-			*bad_arg = TRUE;
-			return;
-		}
+	while (argv[*optind]) {
+		if (TABS_MAX < i)
+			errx(EXIT_FAILURE, _("too many tabs"));
+		if (argv[*optind][0] == '-')
+			break;
+		if (isdigit(argv[*optind][0]))
+			tab_array[i] = atoi(argv[*optind]);
+		else
+			break;
+		(*optind)++;
+		i++;
 	}
+	tab_array[i] = -1;
 }
 
-static void
-parse_regtabs(int argc, char **argv, int *option, int *opt_len, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* opt_len: Regular tab length. */
-	/* bad_arg: Set to true if an error is detected. */
-
-	if (*option || argc > 1)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if(argc == 0) {
-		*opt_len = DEFAULT_TAB_LEN;
-		return;
-	}
-	*opt_len = atoi(argv[0]);
-	if(*opt_len < 1 || TABS_MAX < *opt_len) {
-		*bad_arg = TRUE;
-		return;
-	}
+static int parse_regtabs(char **argv, char *optarg, int *optind)
+{
+	int ret;
+	char *arg;
+
+	arg = find_optional_arg(argv, optarg, optind);
+	if (!arg)
+		return DEFAULT_TAB_LEN;
+	ret = atoi(arg);
+	if (ret < 1 || TABS_MAX < ret)
+		errx(EXIT_FAILURE, _("argument error: %s"), arg);
+	return ret;
 }
 
-
-static void
-parse_blength(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* opt_all */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse  -blength specification. */
-
-	if (argc > 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1) {
-		*opt_all = atoi(argv[0]);
-		if (BLENGTH_MAX < *opt_all)
-			*bad_arg = TRUE;
-	} else {
-		*opt_all = 0;
-	}
+static int parse_blength(char **argv, char *optarg, int *optind)
+{
+	int ret = -1;
+	char *arg;
+
+	arg = find_optional_arg(argv, optarg, optind);
+	if (!arg)
+		return 0;
+	if (isdigit(arg[0]))
+		ret = atoi(arg);
+	if (ret < 0 || BLENGTH_MAX < ret)
+		errx(EXIT_FAILURE, _("argument error: %s"), arg);
+	return ret;
 }
 
-static void
-parse_bfreq(int argc, char **argv, int *option, int *opt_all, int *bad_arg) {
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* option: Clear flag to set. */
-	/* opt_all */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse  -bfreq specification. */
-
-	if (argc > 1 || *option)
-		*bad_arg = TRUE;
-	*option = TRUE;
-	if (argc == 1) {
-		*opt_all = atoi(argv[0]);
-	} else {
-		*opt_all = 0;
-	}
+static int parse_bfreq(char **argv, char *optarg, int *optind)
+{
+	char *arg;
+
+	arg = find_optional_arg(argv, optarg, optind);
+	if (!arg)
+		return 0;
+	if (isdigit(arg[0]))
+		return atoi(arg);
+	return 0;
 }
 
-
 static void
 show_tabs(void) {
 	int i, co = tigetnum("cols");
@@ -696,7 +512,7 @@ usage(FILE *out) {
 	fputs(_(" -append <1-NR_CONSOLES>\n"), out);
 	fputs(_(" -file dumpfilename\n"), out);
 	fputs(_(" -msg <on|off>\n"), out);
-	fputs(_(" -msglevel <0-8>\n"), out);
+	fputs(_(" -msglevel <0-8>\n"), out);	/* FIXME: klogctl console_log range is 1-8 */
 	fputs(_(" -powersave <on|vsync|hsync|powerdown|off>\n"), out);
 	fputs(_(" -powerdown <0-60>\n"), out);
 	fputs(_(" -blength <0-2000>\n"), out);
@@ -709,91 +525,234 @@ usage(FILE *out) {
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-#define STRCMP(str1,str2) strncmp(str1,str2,strlen(str1))
+static void set_opt_flag(int *opt)
+{
+	if (*opt)
+		errx(EXIT_FAILURE, "duplicate use of an option");
+	*opt = 1;
+}
 
-static void
-parse_option(char *option, int argc, char **argv, int *bad_arg) {
-	/* option: Option with leading '-' removed. */
-	/* argc: Number of arguments for this option. */
-	/* argv: Arguments for this option. */
-	/* bad_arg: Set to true if an error is detected. */
-
-/* Parse a single specification. */
-
-	if (STRCMP(option, "term") == 0)
-		parse_term(argc, argv, &opt_term, &opt_te_terminal_name, bad_arg);
-	else if (STRCMP(option, "reset") == 0)
-		parse_none(argc, argv, &opt_reset, bad_arg);
-	else if (STRCMP(option, "initialize") == 0)
-		parse_none(argc, argv, &opt_initialize, bad_arg);
-	else if (STRCMP(option, "cursor") == 0)
-		parse_switch(argc, argv, &opt_cursor, &opt_cu_on, bad_arg);
-	else if (STRCMP(option, "repeat") == 0)
-		parse_switch(argc, argv, &opt_repeat, &opt_rep_on, bad_arg);
-	else if (STRCMP(option, "appcursorkeys") == 0)
-		parse_switch(argc, argv, &opt_appcursorkeys, &opt_appck_on, bad_arg);
-	else if (STRCMP(option, "linewrap") == 0)
-		parse_switch(argc, argv, &opt_linewrap, &opt_li_on, bad_arg);
-	else if (STRCMP(option, "default") == 0)
-		parse_none(argc, argv, &opt_default, bad_arg);
-	else if (STRCMP(option, "foreground") == 0)
-		par_color(argc, argv, &opt_foreground, &opt_fo_color, bad_arg);
-	else if (STRCMP(option, "background") == 0)
-		par_color(argc, argv, &opt_background, &opt_ba_color, bad_arg);
-	else if (STRCMP(option, "ulcolor") == 0)
-		par_color2(argc, argv, &opt_ulcolor, &opt_ul_color, bad_arg);
-	else if (STRCMP(option, "hbcolor") == 0)
-		par_color2(argc, argv, &opt_hbcolor, &opt_hb_color, bad_arg);
-	else if (STRCMP(option, "inversescreen") == 0)
-		parse_switch(argc, argv, &opt_inversescreen, &opt_invsc_on, bad_arg);
-	else if (STRCMP(option, "bold") == 0)
-		parse_switch(argc, argv, &opt_bold, &opt_bo_on, bad_arg);
-	else if (STRCMP(option, "half-bright") == 0)
-		parse_switch(argc, argv, &opt_halfbright, &opt_hb_on, bad_arg);
-	else if (STRCMP(option, "blink") == 0)
-		parse_switch(argc, argv, &opt_blink, &opt_bl_on, bad_arg);
-	else if (STRCMP(option, "reverse") == 0)
-		parse_switch(argc, argv, &opt_reverse, &opt_re_on, bad_arg);
-	else if (STRCMP(option, "underline") == 0)
-		parse_switch(argc, argv, &opt_underline, &opt_un_on, bad_arg);
-	else if (STRCMP(option, "store") == 0)
-		parse_none(argc, argv, &opt_store, bad_arg);
-	else if (STRCMP(option, "clear") == 0)
-		parse_clear(argc, argv, &opt_clear, &opt_cl_all, bad_arg);
-	else if (STRCMP(option, "tabs") == 0)
-		parse_tabs(argc, argv, &opt_tabs, opt_tb_array, bad_arg);
-	else if (STRCMP(option, "clrtabs") == 0)
-		parse_clrtabs(argc, argv, &opt_clrtabs, opt_tb_array, bad_arg);
-	else if (STRCMP(option, "regtabs") == 0)
-		parse_regtabs(argc, argv, &opt_regtabs, &opt_rt_len, bad_arg);
-	else if (STRCMP(option, "blank") == 0)
-		parse_blank(argc, argv, &opt_blank, &opt_bl_min, bad_arg);
-	else if (STRCMP(option, "dump") == 0)
-		parse_snap(argc, argv, &opt_snap, &opt_sn_num, bad_arg);
-	else if (STRCMP(option, "append") == 0)
-		parse_snap(argc, argv, &opt_append, &opt_sn_num, bad_arg);
-	else if (STRCMP(option, "file") == 0)
-		parse_snapfile(argc, argv, &opt_snapfile, (int *)opt_sn_name, bad_arg);
-	else if (STRCMP(option, "msg") == 0)
-		parse_switch(argc, argv, &opt_msg, &opt_msg_on, bad_arg);
-	else if (STRCMP(option, "msglevel") == 0)
-		parse_msglevel(argc, argv, &opt_msglevel, &opt_msglevel_num, bad_arg);
-	else if (STRCMP(option, "powersave") == 0)
-		parse_powersave(argc, argv, &opt_powersave, &opt_ps_mode, bad_arg);
-	else if (STRCMP(option, "powerdown") == 0)
-		parse_blank(argc, argv, &opt_powerdown, &opt_pd_min, bad_arg);
-	else if (STRCMP(option, "blength") == 0)
-		parse_blength(argc, argv, &opt_blength, &opt_blength_l, bad_arg);
-	else if (STRCMP(option, "bfreq") == 0)
-		parse_bfreq(argc, argv, &opt_bfreq, &opt_bfreq_f, bad_arg);
-	else if (STRCMP(option, "version") == 0) {
-		printf(_("%s from %s\n"), program_invocation_short_name,
-					  PACKAGE_STRING);
-		exit(EXIT_SUCCESS);
-	} else if (STRCMP(option, "help") == 0)
-		usage(stdout);
-	else
-		*bad_arg = TRUE;
+static void parse_option(int argc, char **argv)
+{
+	int c;
+	enum {
+		OPT_TERM = CHAR_MAX + 1,
+		OPT_RESET,
+		OPT_INITIALIZE,
+		OPT_CURSOR,
+		OPT_REPEAT,
+		OPT_APPCURSORKEYS,
+		OPT_LINEWRAP,
+		OPT_DEFAULT,
+		OPT_FOREGROUND,
+		OPT_BACKGROUND,
+		OPT_ULCOLOR,
+		OPT_HBCOLOR,
+		OPT_INVERSESCREEN,
+		OPT_BOLD,
+		OPT_HALF_BRIGHT,
+		OPT_BLINK,
+		OPT_REVERSE,
+		OPT_UNDERLINE,
+		OPT_STORE,
+		OPT_CLEAR,
+		OPT_TABS,
+		OPT_CLRTABS,
+		OPT_REGTABS,
+		OPT_BLANK,
+		OPT_DUMP,
+		OPT_APPEND,
+		OPT_FILE,
+		OPT_MSG,
+		OPT_MSGLEVEL,
+		OPT_POWERSAVE,
+		OPT_POWERDOWN,
+		OPT_BLENGTH,
+		OPT_BFREQ,
+		OPT_VERSION,
+		OPT_HELP
+	};
+	static const struct option longopts[] = {
+		{"term", required_argument, NULL, OPT_TERM},
+		{"reset", no_argument, NULL, OPT_RESET},
+		{"initialize", no_argument, NULL, OPT_INITIALIZE},
+		{"cursor", required_argument, NULL, OPT_CURSOR},
+		{"repeat", required_argument, NULL, OPT_REPEAT},
+		{"appcursorkeys", required_argument, NULL, OPT_APPCURSORKEYS},
+		{"linewrap", required_argument, NULL, OPT_LINEWRAP},
+		{"default", no_argument, NULL, OPT_DEFAULT},
+		{"foreground", required_argument, NULL, OPT_FOREGROUND},
+		{"background", required_argument, NULL, OPT_BACKGROUND},
+		{"ulcolor", required_argument, NULL, OPT_ULCOLOR},
+		{"ulcolor", required_argument, NULL, OPT_ULCOLOR},
+		{"hbcolor", required_argument, NULL, OPT_HBCOLOR},
+		{"hbcolor", required_argument, NULL, OPT_HBCOLOR},
+		{"inversescreen", required_argument, NULL, OPT_INVERSESCREEN},
+		{"bold", required_argument, NULL, OPT_BOLD},
+		{"half-bright", required_argument, NULL, OPT_HALF_BRIGHT},
+		{"blink", required_argument, NULL, OPT_BLINK},
+		{"reverse", required_argument, NULL, OPT_REVERSE},
+		{"underline", required_argument, NULL, OPT_UNDERLINE},
+		{"store", no_argument, NULL, OPT_STORE},
+		{"clear", required_argument, NULL, OPT_CLEAR},
+		{"tabs", optional_argument, NULL, OPT_TABS},
+		{"clrtabs", optional_argument, NULL, OPT_CLRTABS},
+		{"regtabs", optional_argument, NULL, OPT_REGTABS},
+		{"blank", optional_argument, NULL, OPT_BLANK},
+		{"dump", optional_argument, NULL, OPT_DUMP},
+		{"append", required_argument, NULL, OPT_APPEND},
+		{"file", required_argument, NULL, OPT_FILE},
+		{"msg", required_argument, NULL, OPT_MSG},
+		{"msglevel", required_argument, NULL, OPT_MSGLEVEL},
+		{"powersave", required_argument, NULL, OPT_POWERSAVE},
+		{"powerdown", optional_argument, NULL, OPT_POWERDOWN},
+		{"blength", optional_argument, NULL, OPT_BLENGTH},
+		{"bfreq", optional_argument, NULL, OPT_BFREQ},
+		{"version", no_argument, NULL, OPT_VERSION},
+		{"help", no_argument, NULL, OPT_HELP},
+		{NULL, 0, NULL, 0}
+	};
+
+	while ((c = getopt_long_only(argc, argv, "", longopts, NULL)) != -1) {
+		switch (c) {
+		case OPT_TERM:
+			set_opt_flag(&opt_term);
+			opt_te_terminal_name = optarg;
+			break;
+		case OPT_RESET:
+			set_opt_flag(&opt_reset);
+			break;
+		case OPT_INITIALIZE:
+			set_opt_flag(&opt_initialize);
+			break;
+		case OPT_CURSOR:
+			set_opt_flag(&opt_cursor);
+			opt_cu_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_REPEAT:
+			set_opt_flag(&opt_repeat);
+			opt_rep_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_APPCURSORKEYS:
+			set_opt_flag(&opt_appcursorkeys);
+			opt_appck_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_LINEWRAP:
+			set_opt_flag(&opt_linewrap);
+			opt_li_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_DEFAULT:
+			set_opt_flag(&opt_default);
+			break;
+		case OPT_FOREGROUND:
+			set_opt_flag(&opt_foreground);
+			opt_fo_color = parse_febg_color(optarg);
+			break;
+		case OPT_BACKGROUND:
+			set_opt_flag(&opt_background);
+			opt_ba_color = parse_febg_color(optarg);
+			break;
+		case OPT_ULCOLOR:
+			set_opt_flag(&opt_ulcolor);
+			opt_ul_color = parse_ulhb_color(argv, &optind);
+			break;
+		case OPT_HBCOLOR:
+			set_opt_flag(&opt_hbcolor);
+			opt_hb_color = parse_ulhb_color(argv, &optind);
+			break;
+		case OPT_INVERSESCREEN:
+			set_opt_flag(&opt_inversescreen);
+			opt_invsc_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_BOLD:
+			set_opt_flag(&opt_bold);
+			opt_bo_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_HALF_BRIGHT:
+			set_opt_flag(&opt_halfbright);
+			opt_hb_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_BLINK:
+			set_opt_flag(&opt_blink);
+			opt_bl_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_REVERSE:
+			set_opt_flag(&opt_reverse);
+			opt_re_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_UNDERLINE:
+			set_opt_flag(&opt_underline);
+			opt_un_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_STORE:
+			set_opt_flag(&opt_store);
+			break;
+		case OPT_CLEAR:
+			set_opt_flag(&opt_clear);
+			opt_cl_all = parse_switch(optarg, "all", "reset");
+			break;
+		case OPT_TABS:
+			set_opt_flag(&opt_tabs);
+			parse_tabs(argv, optarg, &optind, opt_tb_array);
+			break;
+		case OPT_CLRTABS:
+			set_opt_flag(&opt_clrtabs);
+			parse_tabs(argv, optarg, &optind, opt_tb_array);
+			break;
+		case OPT_REGTABS:
+			set_opt_flag(&opt_regtabs);
+			opt_rt_len = parse_regtabs(argv, optarg, &optind);
+			break;
+		case OPT_BLANK:
+			set_opt_flag(&opt_blank);
+			opt_bl_min = parse_blank(argv, optarg, &optind);
+			break;
+		case OPT_DUMP:
+			set_opt_flag(&opt_snap);
+			opt_sn_num = parse_snap(argv, optarg, &optind);
+			break;
+		case OPT_APPEND:
+			set_opt_flag(&opt_append);
+			opt_sn_num = parse_snap(argv, optarg, &optind);
+			break;
+		case OPT_FILE:
+			set_opt_flag(&opt_snapfile);
+			strncpy(opt_sn_name, optarg, PATH_MAX);	/* FIXME: should use xstrncpy() */
+			opt_sn_name[PATH_MAX - 1] = 0;
+			break;
+		case OPT_MSG:
+			set_opt_flag(&opt_msg);
+			opt_msg_on = parse_switch(optarg, "on", "off");
+			break;
+		case OPT_MSGLEVEL:
+			set_opt_flag(&opt_msglevel);
+			opt_msglevel_num = parse_msglevel(optarg);
+			break;
+		case OPT_POWERSAVE:
+			set_opt_flag(&opt_powersave);
+			opt_ps_mode = parse_powersave(optarg);
+			break;
+		case OPT_POWERDOWN:
+			set_opt_flag(&opt_powerdown);
+			opt_pd_min = parse_blank(argv, optarg, &optind);
+			break;
+		case OPT_BLENGTH:
+			set_opt_flag(&opt_blength);
+			opt_blength_l = parse_blength(argv, optarg, &optind);
+			break;
+		case OPT_BFREQ:
+			set_opt_flag(&opt_bfreq);
+			opt_bfreq_f = parse_bfreq(argv, optarg, &optind);
+			break;
+		case OPT_VERSION:
+			printf(UTIL_LINUX_VERSION);
+			exit(EXIT_SUCCESS);
+		case OPT_HELP:
+			usage(stdout);
+		default:
+			usage(stderr);
+		}
+	}
 }
 
 /* End of command line parsing routines. */
@@ -1153,8 +1112,6 @@ error:
 
 int
 main(int argc, char **argv) {
-	int bad_arg = FALSE;		/* Set if error in arguments. */
-	int arg, modifier;
 	char *term;			/* Terminal type. */
 	int vcterm;			/* Set if terminal is a virtual console. */
 	int errret;
@@ -1165,31 +1122,10 @@ main(int argc, char **argv) {
 	atexit(close_stdout);
 
 	if (argc < 2)
-		bad_arg = TRUE;
+		usage(stderr);
 
 	/* Parse arguments. */
-
-	for (arg = 1; arg < argc;) {
-		if (*argv[arg] == '-') {
-
-			/* Parse a single option. */
-
-			for (modifier = arg + 1; modifier < argc; modifier++) {
-				if (*argv[modifier] == '-') break;
-			}
-			parse_option(argv[arg] + 1, modifier - arg - 1,
-				     &argv[arg + 1], &bad_arg);
-			arg = modifier;
-		} else {
-			bad_arg = TRUE;
-			arg++;
-		}
-	}
-
-	/* Display syntax message if error in arguments. */
-
-	if (bad_arg)
-		usage(stderr);
+	parse_option(argc, argv);
 
 	/* Find out terminal name. */
 
-- 
1.9.2

