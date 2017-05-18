Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33061 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756053AbdERVT5 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 18 May 2017 17:19:57 -0400
Received: by mail-wm0-f65.google.com with SMTP id y10so14090035wmh.0
        for <util-linux@vger.kernel.org>; Thu, 18 May 2017 14:19:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/3] chsh: make readline completion to propose valid shells
Date: Thu, 18 May 2017 22:19:36 +0100
Message-Id: <20170518211936.28153-4-kerolasa@iki.fi>
In-Reply-To: <20170518211936.28153-1-kerolasa@iki.fi>
References: <20170518211936.28153-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is better than default readline completion, that gives paths from
current directory onwards.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chsh.c | 117 ++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 90 insertions(+), 27 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 1fb377593..c6eab1554 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -67,6 +67,8 @@ struct sinfo {
 	char *shell;
 };
 
+/* global due readline completion */
+static char **global_shells = NULL;
 
 static void __attribute__((__noreturn__)) usage (FILE *fp)
 {
@@ -87,24 +89,31 @@ static void __attribute__((__noreturn__)) usage (FILE *fp)
 }
 
 /*
- *  get_shell_list () -- if the given shell appears in /etc/shells,
- *	return true.  if not, return false.
- *	if the given shell is NULL, /etc/shells is outputted to stdout.
+ *  free_shells () -- free shells allocations.
  */
-static int get_shell_list(const char *shell_name)
+static void free_shells(void)
+{
+	char **s;
+
+	for (s = global_shells; *s; s++)
+		free(*s);
+	free(global_shells);
+}
+
+/*
+ *  init_shells () -- fill shells variable from /etc/shells,
+ */
+static int init_shells(char ***shells)
 {
 	FILE *fp;
-	int found = 0;
 	char *buf = NULL;
-	size_t sz = 0;
+	size_t sz = 0, shellsz = 8, n = 0;
 	ssize_t len;
 
+	*shells = xmalloc(sizeof(char *) * shellsz);
 	fp = fopen(_PATH_SHELLS, "r");
-	if (!fp) {
-		if (!shell_name)
-			warnx(_("No known shells."));
-		return 0;
-	}
+	if (!fp)
+		return 1;
 	while ((len = getline(&buf, &sz, fp)) != -1) {
 		/* ignore comments and blank lines */
 		if (*buf == '#' || len < 2)
@@ -112,26 +121,77 @@ static int get_shell_list(const char *shell_name)
 		/* strip the ending newline */
 		if (buf[len - 1] == '\n')
 			buf[len - 1] = 0;
-		/* check or output the shell */
+		(*shells)[n++] = buf;
+		if (shellsz < n) {
+			shellsz *= 2;
+			shells = xrealloc(shells, sizeof(char *) * shellsz);
+		}
+		buf = NULL;
+	}
+	free(buf);
+	(*shells)[n] = NULL;
+	fclose(fp);
+	atexit(free_shells);
+	return 0;
+}
+
+/*
+ *  get_shell_list () -- if the given shell appears in /etc/shells,
+ *	return true.  if not, return false.
+ *	if the given shell is NULL, /etc/shells is outputted to stdout.
+ */
+static int get_shell_list(const char *shell_name, char ***shells)
+{
+	char **s;
+	int found = 0;
+
+	if (!shells)
+		return found;
+	s = *shells;
+	for (s = *shells; *s; s++) {
 		if (shell_name) {
-			if (!strcmp(shell_name, buf)) {
+			if (!strcmp(shell_name, *s)) {
 				found = 1;
 				break;
 			}
 		} else
-			printf("%s\n", buf);
+			printf("%s\n", *s);
 	}
-	fclose(fp);
-	free(buf);
 	return found;
 }
 
+#ifdef HAVE_LIBREADLINE
+static char *shell_name_generator(const char *text, int state)
+{
+	static size_t len, idx;
+	char *s;
+
+	if (!state) {
+		idx = 0;
+		len = strlen(text);
+	}
+	while ((s = global_shells[idx++])) {
+		if (strncmp(s, text, len) == 0)
+			return xstrdup(s);
+	}
+	return NULL;
+}
+
+static char **shell_name_completion(const char *text,
+				    int start __attribute__((__unused__)),
+				    int end __attribute__((__unused__)))
+{
+	rl_attempted_completion_over = 1;
+	return rl_completion_matches(text, shell_name_generator);
+}
+#endif
+
 /*
  *  parse_argv () --
  *	parse the command line arguments, and fill in "pinfo" with any
  *	information from the command line.
  */
-static void parse_argv(int argc, char **argv, struct sinfo *pinfo)
+static void parse_argv(int argc, char **argv, struct sinfo *pinfo, char ***shells)
 {
 	static const struct option long_options[] = {
 		{"shell",       required_argument, NULL, 's'},
@@ -151,7 +211,8 @@ static void parse_argv(int argc, char **argv, struct sinfo *pinfo)
 		case 'h':
 			usage(stdout);
 		case 'l':
-			get_shell_list(NULL);
+			init_shells(shells);
+			get_shell_list(NULL, shells);
 			exit(EXIT_SUCCESS);
 		case 's':
 			if (!optarg)
@@ -178,15 +239,16 @@ static char *ask_new_shell(char *question, char *oldshell)
 {
 	int len;
 	char *ans = NULL;
-#ifndef HAVE_LIBREADLINE
+#ifdef HAVE_LIBREADLINE
+	rl_attempted_completion_function = shell_name_completion;
+#else
 	size_t dummy = 0;
 #endif
-
 	if (!oldshell)
 		oldshell = "";
-	printf("%s [%s]: ", question, oldshell);
+	printf("%s [%s]\n", question, oldshell);
 #ifdef HAVE_LIBREADLINE
-	if ((ans = readline(NULL)) == NULL)
+	if ((ans = readline("> ")) == NULL)
 #else
 	if (getline(&ans, &dummy, stdin) < 0)
 #endif
@@ -203,7 +265,7 @@ static char *ask_new_shell(char *question, char *oldshell)
  *  check_shell () -- if the shell is completely invalid, print
  *	an error and exit.
  */
-static void check_shell(const char *shell)
+static void check_shell(const char *shell, char ***shells)
 {
 	if (*shell != '/')
 		errx(EXIT_FAILURE, _("shell must be a full path name"));
@@ -213,7 +275,7 @@ static void check_shell(const char *shell)
 		errx(EXIT_FAILURE, _("\"%s\" is not executable"), shell);
 	if (illegal_passwd_chars(shell))
 		errx(EXIT_FAILURE, _("%s: has illegal characters"), shell);
-	if (!get_shell_list(shell)) {
+	if (!get_shell_list(shell, shells)) {
 #ifdef ONLY_LISTED_SHELLS
 		if (!getuid())
 			warnx(_("Warning: \"%s\" is not listed in %s."), shell,
@@ -245,7 +307,7 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	parse_argv(argc, argv, &info);
+	parse_argv(argc, argv, &info, &global_shells);
 	if (!info.username) {
 		pw = getpwuid(uid);
 		if (!pw)
@@ -304,7 +366,8 @@ int main(int argc, char **argv)
 		    _("running UID doesn't match UID of user we're "
 		      "altering, shell change denied"));
 	}
-	if (uid != 0 && !get_shell_list(oldshell)) {
+	init_shells(&global_shells);
+	if (uid != 0 && !get_shell_list(oldshell, &global_shells)) {
 		errno = EACCES;
 		err(EXIT_FAILURE, _("your shell is not in %s, "
 				    "shell change denied"), _PATH_SHELLS);
@@ -323,7 +386,7 @@ int main(int argc, char **argv)
 			return EXIT_SUCCESS;
 	}
 
-	check_shell(info.shell);
+	check_shell(info.shell, &global_shells);
 
 	if (!nullshell && strcmp(oldshell, info.shell) == 0)
 		errx(EXIT_SUCCESS, _("Shell not changed."));
-- 
2.13.0

