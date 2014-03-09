Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f172.google.com ([209.85.214.172]:57052 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaCIUam (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Mar 2014 16:30:42 -0400
Received: by mail-ob0-f172.google.com with SMTP id wm4so6196974obc.31
        for <util-linux@vger.kernel.org>; Sun, 09 Mar 2014 13:30:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/10] kill: add parse_arguments() function
Date: Sun,  9 Mar 2014 15:30:22 -0500
Message-Id: <1394397023-7050-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Long main() is difficult to read, so moving argument parsing to separate
function should make sense.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 113 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 53 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 30c209f..e5ec01e 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -155,6 +155,7 @@ struct signv {
 #endif
 };
 
+static char **parse_arguments(int argc, char **argv, struct kill_control *ctl);
 static int arg_to_signum(char *arg, int mask);
 static void nosig(char *name);
 static void printsig(const struct kill_control *ctl);
@@ -170,7 +171,6 @@ static union sigval sigdata;
 int main(int argc, char **argv)
 {
 	struct kill_control ctl;
-	char *arg;
 	int errors = EXIT_SUCCESS;
 
 	setlocale(LC_ALL, "");
@@ -183,6 +183,42 @@ int main(int argc, char **argv)
 	ctl.do_pid = (!strcmp(program_invocation_short_name, "pid"));	/* Yecch */
 	if (ctl.do_pid)
 		warnx(_("use of 'kill --pid' option as command name will be deprecated in future"));
+	argv = parse_arguments(argc, argv, &ctl);
+	/* We are done with the options.  The rest of the arguments
+	 * should be process ids and names, kill them.  */
+	for (/* nothing */; (ctl.arg = *argv) != NULL; argv++) {
+		char *ep;
+
+		ctl.pid = strtol(ctl.arg, &ep, 10);
+		if (!*ep)
+			errors |= kill_verbose(&ctl);
+		else {
+			struct proc_processes *ps = proc_open_processes();
+			int ct = 0;
+
+			if (!ps)
+				continue;
+			if (ctl.check_all)
+				proc_processes_filter_by_uid(ps, getuid());
+			proc_processes_filter_by_name(ps, ctl.arg);
+			while (proc_next_pid(ps, &(ctl.pid)) == 0) {
+				errors |= kill_verbose(&ctl);
+				ct++;
+			}
+			if (!ct) {
+				errors = EXIT_FAILURE;
+				warnx(_("cannot find process \"%s\""), ctl.arg);
+			}
+			proc_close_processes(ps);
+		}
+	}
+	return errors;
+}
+
+static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
+{
+	char *arg;
+
 	/* Loop through the arguments.  Actually, -a is the only option
 	 * can be used with other options.  The 'kill' is basically a
 	 * one-option-at-most program. */
@@ -197,59 +233,59 @@ int main(int argc, char **argv)
 		if (!strcmp(arg, "-v") || !strcmp(arg, "-V") ||
 		    !strcmp(arg, "--version")) {
 			printf(UTIL_LINUX_VERSION);
-			return EXIT_SUCCESS;
+			exit(EXIT_SUCCESS);
 		}
 		if (!strcmp(arg, "-h") || !strcmp(arg, "--help"))
 			usage(stdout);
 
 		if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
-			ctl.check_all = 1;
+			ctl->check_all = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-l") || !strcmp(arg, "--list")) {
 			if (argc < 2) {
 				printsignals(stdout, 0);
-				return EXIT_SUCCESS;
+				exit(EXIT_SUCCESS);
 			}
 			if (2 < argc)
 				errx(EXIT_FAILURE, _("too many arguments"));
 			/* argc == 2, accept "kill -l $?" */
 			arg = argv[1];
-			if ((ctl.numsig = arg_to_signum(arg, 1)) < 0)
+			if ((ctl->numsig = arg_to_signum(arg, 1)) < 0)
 				errx(EXIT_FAILURE, _("unknown signal: %s"),
 				     arg);
-			printsig(&ctl);
-			return EXIT_SUCCESS;
+			printsig(ctl);
+			exit(EXIT_SUCCESS);
 		}
 		/* for compatibility with procps kill(1) */
 		if (!strncmp(arg, "--list=", 7) || !strncmp(arg, "-l=", 3)) {
 			char *p = strchr(arg, '=') + 1;
-			if ((ctl.numsig = arg_to_signum(p, 1)) < 0)
+			if ((ctl->numsig = arg_to_signum(p, 1)) < 0)
 				errx(EXIT_FAILURE, _("unknown signal: %s"), p);
-			printsig(&ctl);
-			return EXIT_SUCCESS;
+			printsig(ctl);
+			exit(EXIT_SUCCESS);
 		}
 		if (!strcmp(arg, "-L") || !strcmp(arg, "--table")) {
 			printsignals(stdout, 1);
-			return EXIT_SUCCESS;
+			exit(EXIT_SUCCESS);
 		}
 		if (!strcmp(arg, "-p") || !strcmp(arg, "--pid")) {
-			ctl.do_pid = 1;
-			if (ctl.do_kill)
+			ctl->do_pid = 1;
+			if (ctl->do_kill)
 				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--signal");
 			continue;
 		}
 		if (!strcmp(arg, "-s") || !strcmp(arg, "--signal")) {
 			if (argc < 2)
 				errx(EXIT_FAILURE, _("not enough arguments"));
-			ctl.do_kill = 1;
-			if (ctl.do_pid)
+			ctl->do_kill = 1;
+			if (ctl->do_pid)
 				errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--signal");
 			argc--, argv++;
 			arg = *argv;
-			if ((ctl.numsig = arg_to_signum(arg, 0)) < 0) {
+			if ((ctl->numsig = arg_to_signum(arg, 0)) < 0) {
 				nosig(arg);
-				return EXIT_FAILURE;
+				exit(EXIT_FAILURE);
 			}
 			continue;
 		}
@@ -273,50 +309,21 @@ int main(int argc, char **argv)
 		 * number).  In case of doubt POSIX tells us to assume a
 		 * signal.  If a signal has been parsed, assume it is a
 		 * pid, break.  */
-		if (ctl.do_kill)
+		if (ctl->do_kill)
 			break;
 		arg++;
-		if ((ctl.numsig = arg_to_signum(arg, 0)) < 0)
+		if ((ctl->numsig = arg_to_signum(arg, 0)) < 0)
 			errx(EXIT_FAILURE, _("invalid sigval argument"));
-		ctl.do_kill = 1;
-		if (ctl.do_pid)
+		ctl->do_kill = 1;
+		if (ctl->do_pid)
 			errx(EXIT_FAILURE, _("%s and %s are mutually exclusive"), "--pid", "--signal");
 		continue;
 	}
 	if (!*argv)
 		errx(EXIT_FAILURE, _("not enough arguments"));
-	if (ctl.do_pid)
-		ctl.numsig = -1;
-
-	/* We are done with the options.  The rest of the arguments
-	 * should be process ids and names, kill them.  */
-	for (/* nothing */; (ctl.arg = *argv) != NULL; argv++) {
-		char *ep;
-
-		ctl.pid = strtol(ctl.arg, &ep, 10);
-		if (!*ep)
-			errors |= kill_verbose(&ctl);
-		else {
-			struct proc_processes *ps = proc_open_processes();
-			int ct = 0;
-
-			if (!ps)
-				continue;
-			if (ctl.check_all)
-				proc_processes_filter_by_uid(ps, getuid());
-			proc_processes_filter_by_name(ps, ctl.arg);
-			while (proc_next_pid(ps, &(ctl.pid)) == 0) {
-				errors |= kill_verbose(&ctl);
-				ct++;
-			}
-			if (!ct) {
-				errors = EXIT_FAILURE;
-				warnx(_("cannot find process \"%s\""), ctl.arg);
-			}
-			proc_close_processes(ps);
-		}
-	}
-	return errors;
+	if (ctl->do_pid)
+		ctl->numsig = -1;
+	return argv;
 }
 
 #ifdef SIGRTMIN
-- 
1.9.0

