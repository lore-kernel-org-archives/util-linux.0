Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f54.google.com ([74.125.82.54]:62359 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753148AbaLGKOI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:08 -0500
Received: by mail-wg0-f54.google.com with SMTP id l2so4086100wgh.41
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 05/11] getopt: add struct getopt_control and remove global variables
Date: Sun,  7 Dec 2014 10:13:49 +0000
Message-Id: <1417947235-24229-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 164 ++++++++++++++++++++++++++--------------------------
 1 file changed, 83 insertions(+), 81 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 383bbd1..fcc016c 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -76,12 +76,20 @@
 /* The shells recognized. */
 typedef enum { BASH, TCSH } shell_t;
 
-
-/* Some global variables that tells us how to parse. */
-static shell_t shell = BASH;	/* The shell we generate output for. */
-static int quiet_errors = 0;	/* 0 is not quiet. */
-static int quiet_output = 0;	/* 0 is not quiet. */
-static int quote = 1;		/* 1 is do quote. */
+struct getopt_control {
+	shell_t shell;			/* the shell we generate output for */
+	char *optstr;			/* getopt(3) optstring */
+	struct option *long_options;	/* long options */
+	int long_options_length;	/* length of options array */
+	int long_options_nr;		/* number of used elements in array */
+	unsigned int
+		compatible:1,		/* compatibility mode for 'difficult' programs */
+		quiet_errors:1,		/* print errors */
+		quiet_output:1,		/* print output */
+		quote:1;		/* quote output */
+};
+
+enum { REALLOC_INCREMENT = 8 };
 
 /* Allow changing which getopt is in use with function pointer */
 int (*getopt_long_fp) (int argc, char *const *argv, const char *optstr,
@@ -96,7 +104,7 @@ int (*getopt_long_fp) (int argc, char *const *argv, const char *optstr,
  * exclamation marks within single quotes, and nukes whitespace. This
  * function returns a pointer to a buffer that is overwritten by each call.
  */
-static const char *normalize(const char *arg)
+static const char *normalize(const struct getopt_control *ctl, const char *arg)
 {
 	static char *BUFFER = NULL;
 	const char *argptr = arg;
@@ -104,7 +112,7 @@ static const char *normalize(const char *arg)
 
 	free(BUFFER);
 
-	if (!quote) {
+	if (!ctl->quote) {
 		/* Just copy arg */
 		BUFFER = xmalloc(strlen(arg) + 1);
 		strcpy(BUFFER, arg);
@@ -129,21 +137,21 @@ static const char *normalize(const char *arg)
 			*bufptr++ = '\\';
 			*bufptr++ = '\'';
 			*bufptr++ = '\'';
-		} else if (shell == TCSH && *argptr == '\\') {
+		} else if (ctl->shell == TCSH && *argptr == '\\') {
 			/* Backslash: replace it with: '\\' */
 			*bufptr++ = '\\';
 			*bufptr++ = '\\';
-		} else if (shell == TCSH && *argptr == '!') {
+		} else if (ctl->shell == TCSH && *argptr == '!') {
 			/* Exclamation mark: replace it with: \! */
 			*bufptr++ = '\'';
 			*bufptr++ = '\\';
 			*bufptr++ = '!';
 			*bufptr++ = '\'';
-		} else if (shell == TCSH && *argptr == '\n') {
+		} else if (ctl->shell == TCSH && *argptr == '\n') {
 			/* Newline: replace it with: \n */
 			*bufptr++ = '\\';
 			*bufptr++ = 'n';
-		} else if (shell == TCSH && isspace(*argptr)) {
+		} else if (ctl->shell == TCSH && isspace(*argptr)) {
 			/* Non-newline whitespace: replace it with \<ws> */
 			*bufptr++ = '\'';
 			*bufptr++ = '\\';
@@ -166,44 +174,43 @@ static const char *normalize(const char *arg)
  * optstr must contain the short options, and longopts the long options.
  * Other settings are found in global variables.
  */
-static int generate_output(char *argv[], int argc, const char *optstr,
-			   const struct option *longopts)
+static int generate_output(const struct getopt_control *ctl, char *argv[], int argc)
 {
 	int exit_code = EXIT_SUCCESS;	/* Assume everything will be OK */
 	int opt;
 	int longindex;
 	const char *charptr;
 
-	if (quiet_errors)
+	if (ctl->quiet_errors)
 		/* No error reporting from getopt(3) */
 		opterr = 0;
 	/* Reset getopt(3) */
 	optind = 0;
 
 	while ((opt =
-		(getopt_long_fp(argc, argv, optstr, longopts, &longindex)))
+		(getopt_long_fp(argc, argv, ctl->optstr, ctl->long_options, &longindex)))
 	       != EOF)
 		if (opt == '?' || opt == ':')
 			exit_code = GETOPT_EXIT_CODE;
-		else if (!quiet_output) {
+		else if (!ctl->quiet_output) {
 			if (opt == LONG_OPT) {
-				printf(" --%s", longopts[longindex].name);
-				if (longopts[longindex].has_arg)
-					printf(" %s", normalize(optarg ? optarg : ""));
+				printf(" --%s", ctl->long_options[longindex].name);
+				if (ctl->long_options[longindex].has_arg)
+					printf(" %s", normalize(ctl, optarg ? optarg : ""));
 			} else if (opt == NON_OPT)
-				printf(" %s", normalize(optarg ? optarg : ""));
+				printf(" %s", normalize(ctl, optarg ? optarg : ""));
 			else {
 				printf(" -%c", opt);
-				charptr = strchr(optstr, opt);
+				charptr = strchr(ctl->optstr, opt);
 				if (charptr != NULL && *++charptr == ':')
-					printf(" %s", normalize(optarg ? optarg : ""));
+					printf(" %s", normalize(ctl, optarg ? optarg : ""));
 			}
 		}
 
-	if (!quiet_output) {
+	if (!ctl->quiet_output) {
 		printf(" --");
 		while (optind < argc)
-			printf(" %s", normalize(argv[optind++]));
+			printf(" %s", normalize(ctl, argv[optind++]));
 		printf("\n");
 	}
 	return exit_code;
@@ -222,48 +229,43 @@ static void __attribute__ ((__noreturn__)) parse_error(const char *message)
 	exit(PARAMETER_EXIT_CODE);
 }
 
-static struct option *long_options = NULL;
-static int long_options_length = 0;	/* Length of array */
-static int long_options_nr = 0;		/* Nr of used elements in array */
-#define LONG_OPTIONS_INCR 10
-#define init_longopt() add_longopt(NULL,0)
 
 /* Register a long option. The contents of name is copied. */
-static void add_longopt(const char *name, int has_arg)
+static void add_longopt(struct getopt_control *ctl, const char *name, int has_arg)
 {
 	char *tmp;
 	static int flag;
 
 	if (!name) {
 		/* init */
-		free(long_options);
-		long_options = NULL;
-		long_options_length = 0;
-		long_options_nr = 0;
+		free(ctl->long_options);
+		ctl->long_options = NULL;
+		ctl->long_options_length = 0;
+		ctl->long_options_nr = 0;
 	}
 
-	if (long_options_nr == long_options_length) {
-		long_options_length += LONG_OPTIONS_INCR;
-		long_options = xrealloc(long_options,
-					sizeof(struct option) *
-					long_options_length);
+	if (ctl->long_options_nr == ctl->long_options_length) {
+		ctl->long_options_length += REALLOC_INCREMENT;
+		ctl->long_options = xrealloc(ctl->long_options,
+					     sizeof(struct option) *
+					     ctl->long_options_length);
 	}
 
-	long_options[long_options_nr].name = NULL;
-	long_options[long_options_nr].has_arg = 0;
-	long_options[long_options_nr].flag = NULL;
-	long_options[long_options_nr].val = 0;
+	ctl->long_options[ctl->long_options_nr].name = NULL;
+	ctl->long_options[ctl->long_options_nr].has_arg = 0;
+	ctl->long_options[ctl->long_options_nr].flag = NULL;
+	ctl->long_options[ctl->long_options_nr].val = 0;
 
-	if (long_options_nr && name) {
+	if (ctl->long_options_nr && name) {
 		/* Not for init! */
-		long_options[long_options_nr - 1].has_arg = has_arg;
-		long_options[long_options_nr - 1].flag = &flag;
-		long_options[long_options_nr - 1].val = long_options_nr;
+		ctl->long_options[ctl->long_options_nr - 1].has_arg = has_arg;
+		ctl->long_options[ctl->long_options_nr - 1].flag = &flag;
+		ctl->long_options[ctl->long_options_nr - 1].val = ctl->long_options_nr;
 		tmp = xmalloc(strlen(name) + 1);
 		strcpy(tmp, name);
-		long_options[long_options_nr - 1].name = tmp;
+		ctl->long_options[ctl->long_options_nr - 1].name = tmp;
 	}
-	long_options_nr++;
+	ctl->long_options_nr++;
 }
 
 
@@ -271,7 +273,7 @@ static void add_longopt(const char *name, int has_arg)
  * Register several long options. options is a string of long options,
  * separated by commas or whitespace. This nukes options!
  */
-static void add_long_options(char *options)
+static void add_long_options(struct getopt_control *ctl, char *options)
 {
 	int arg_opt;
 	char *tokptr = strtok(options, ", \t\n");
@@ -291,22 +293,22 @@ static void add_long_options(char *options)
 						    ("empty long option after "
 						     "-l or --long argument"));
 			}
-			add_longopt(tokptr, arg_opt);
+			add_longopt(ctl, tokptr, arg_opt);
 		}
 		tokptr = strtok(NULL, ", \t\n");
 	}
 }
 
-static void set_shell(const char *new_shell)
+static void set_shell(struct getopt_control *ctl, const char *new_shell)
 {
 	if (!strcmp(new_shell, "bash"))
-		shell = BASH;
+		ctl->shell = BASH;
 	else if (!strcmp(new_shell, "tcsh"))
-		shell = TCSH;
+		ctl->shell = TCSH;
 	else if (!strcmp(new_shell, "sh"))
-		shell = BASH;
+		ctl->shell = BASH;
 	else if (!strcmp(new_shell, "csh"))
-		shell = TCSH;
+		ctl->shell = TCSH;
 	else
 		parse_error(_
 			    ("unknown shell after -s or --shell argument"));
@@ -340,10 +342,12 @@ static void __attribute__ ((__noreturn__)) print_help(void)
 
 int main(int argc, char *argv[])
 {
-	char *optstr = NULL;
+	struct getopt_control ctl = {
+		.shell = BASH,
+		.quote = 1
+	};
 	char *name = NULL;
 	int opt;
-	int compatible = 0;
 
 	/* Stop scanning as soon as a non-option argument is found! */
 	static const char *shortopts = "+ao:l:n:qQs:TuhV";
@@ -367,14 +371,14 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	init_longopt();
+	add_longopt(&ctl, NULL, 0);	/* init */
 	getopt_long_fp = getopt_long;
 
 	if (getenv("GETOPT_COMPATIBLE"))
-		compatible = 1;
+		ctl.compatible = 1;
 
 	if (argc == 1) {
-		if (compatible) {
+		if (ctl.compatible) {
 			/*
 			 * For some reason, the original getopt gave no
 			 * error when there were no arguments.
@@ -385,13 +389,12 @@ int main(int argc, char *argv[])
 			parse_error(_("missing optstring argument"));
 	}
 
-	if (argv[1][0] != '-' || compatible) {
-		quote = 0;
-		optstr = xmalloc(strlen(argv[1]) + 1);
-		strcpy(optstr, argv[1] + strspn(argv[1], "-+"));
+	if (argv[1][0] != '-' || ctl.compatible) {
+		ctl.quote = 0;
+		ctl.optstr = xmalloc(strlen(argv[1]) + 1);
+		strcpy(ctl.optstr, argv[1] + strspn(argv[1], "-+"));
 		argv[1] = argv[0];
-		return generate_output(argv + 1, argc - 1, optstr,
-				       long_options);
+		return generate_output(&ctl, argv + 1, argc - 1);
 	}
 
 	while ((opt =
@@ -403,12 +406,12 @@ int main(int argc, char *argv[])
 		case 'h':
 			print_help();
 		case 'o':
-			free(optstr);
-			optstr = xmalloc(strlen(optarg) + 1);
-			strcpy(optstr, optarg);
+			free(ctl.optstr);
+			ctl.optstr = xmalloc(strlen(optarg) + 1);
+			strcpy(ctl.optstr, optarg);
 			break;
 		case 'l':
-			add_long_options(optarg);
+			add_long_options(&ctl, optarg);
 			break;
 		case 'n':
 			free(name);
@@ -416,18 +419,18 @@ int main(int argc, char *argv[])
 			strcpy(name, optarg);
 			break;
 		case 'q':
-			quiet_errors = 1;
+			ctl.quiet_errors = 1;
 			break;
 		case 'Q':
-			quiet_output = 1;
+			ctl.quiet_output = 1;
 			break;
 		case 's':
-			set_shell(optarg);
+			set_shell(&ctl, optarg);
 			break;
 		case 'T':
 			return TEST_EXIT_CODE;
 		case 'u':
-			quote = 0;
+			ctl.quote = 0;
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -439,12 +442,12 @@ int main(int argc, char *argv[])
 			parse_error(_("internal error, contact the author."));
 		}
 
-	if (!optstr) {
+	if (!ctl.optstr) {
 		if (optind >= argc)
 			parse_error(_("missing optstring argument"));
 		else {
-			optstr = xmalloc(strlen(argv[optind]) + 1);
-			strcpy(optstr, argv[optind]);
+			ctl.optstr = xmalloc(strlen(argv[optind]) + 1);
+			strcpy(ctl.optstr, argv[optind]);
 			optind++;
 		}
 	}
@@ -453,6 +456,5 @@ int main(int argc, char *argv[])
 	else
 		argv[optind - 1] = argv[0];
 
-	return generate_output(argv + optind - 1, argc-optind + 1,
-			       optstr, long_options);
+	return generate_output(&ctl, argv + optind - 1, argc - optind + 1);
 }
-- 
2.1.3

