Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f51.google.com ([209.85.219.51]:44848 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752623AbaCIUak (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Mar 2014 16:30:40 -0400
Received: by mail-oa0-f51.google.com with SMTP id i4so6254292oah.10
        for <util-linux@vger.kernel.org>; Sun, 09 Mar 2014 13:30:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/10] kill: use control structure to pass user input to functions
Date: Sun,  9 Mar 2014 15:30:20 -0500
Message-Id: <1394397023-7050-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This should make it easier to understand how the program works.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 109 +++++++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 50 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 11c8cd2..34bd00e 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -62,6 +62,16 @@ enum {
 	KILL_OUTPUT_WIDTH = 72
 };
 
+struct kill_control {
+	char *arg;
+	pid_t pid;
+	int numsig;
+	unsigned int
+		check_all:1,
+		do_kill:1,
+		do_pid:1;
+};
+
 struct signv {
 	const char *name;
 	int val;
@@ -147,10 +157,10 @@ struct signv {
 
 static int arg_to_signum(char *arg, int mask);
 static void nosig(char *name);
-static void printsig(int sig);
+static void printsig(const struct kill_control *ctl);
 static void printsignals(FILE *fp, int pretty);
 static void __attribute__((__noreturn__)) usage(FILE *out);
-static int kill_verbose(char *procname, int pid, int sig);
+static int kill_verbose(const struct kill_control *ctl);
 
 #ifdef HAVE_SIGQUEUE
 static int use_sigval;
@@ -159,21 +169,20 @@ static union sigval sigdata;
 
 int main(int argc, char **argv)
 {
-	int errors, numsig, pid;
-	char *ep, *arg;
-	int do_pid, do_kill, check_all;
+	struct kill_control ctl;
+	char *arg;
+	int errors = EXIT_SUCCESS;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
+	memset(&ctl, 0, sizeof(ctl));
 
-	numsig = SIGTERM;
-	do_pid = (!strcmp(program_invocation_short_name, "pid"));	/* Yecch */
-	if (do_pid)
+	ctl.numsig = SIGTERM;
+	ctl.do_pid = (!strcmp(program_invocation_short_name, "pid"));	/* Yecch */
+	if (ctl.do_pid)
 		warnx(_("use of 'kill --pid' option as command name will be deprecated in future"));
-	do_kill = 0;
-	check_all = 0;
 	/* Loop through the arguments.  Actually, -a is the only option
 	 * can be used with other options.  The 'kill' is basically a
 	 * one-option-at-most program. */
@@ -194,7 +203,7 @@ int main(int argc, char **argv)
 			usage(stdout);
 
 		if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
-			check_all++;
+			ctl.check_all = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-l") || !strcmp(arg, "--list")) {
@@ -206,18 +215,18 @@ int main(int argc, char **argv)
 				usage(stderr);
 			/* argc == 2, accept "kill -l $?" */
 			arg = argv[1];
-			if ((numsig = arg_to_signum(arg, 1)) < 0)
+			if ((ctl.numsig = arg_to_signum(arg, 1)) < 0)
 				errx(EXIT_FAILURE, _("unknown signal: %s"),
 				     arg);
-			printsig(numsig);
+			printsig(&ctl);
 			return EXIT_SUCCESS;
 		}
 		/* for compatibility with procps kill(1) */
 		if (!strncmp(arg, "--list=", 7) || !strncmp(arg, "-l=", 3)) {
 			char *p = strchr(arg, '=') + 1;
-			if ((numsig = arg_to_signum(p, 1)) < 0)
+			if ((ctl.numsig = arg_to_signum(p, 1)) < 0)
 				errx(EXIT_FAILURE, _("unknown signal: %s"), p);
-			printsig(numsig);
+			printsig(&ctl);
 			return EXIT_SUCCESS;
 		}
 		if (!strcmp(arg, "-L") || !strcmp(arg, "--table")) {
@@ -225,20 +234,20 @@ int main(int argc, char **argv)
 			return EXIT_SUCCESS;
 		}
 		if (!strcmp(arg, "-p") || !strcmp(arg, "--pid")) {
-			do_pid++;
-			if (do_kill)
+			ctl.do_pid = 1;
+			if (ctl.do_kill)
 				usage(stderr);
 			continue;
 		}
 		if (!strcmp(arg, "-s") || !strcmp(arg, "--signal")) {
 			if (argc < 2)
 				usage(stderr);
-			do_kill++;
-			if (do_pid)
+			ctl.do_kill = 1;
+			if (ctl.do_pid)
 				usage(stderr);
 			argc--, argv++;
 			arg = *argv;
-			if ((numsig = arg_to_signum(arg, 0)) < 0) {
+			if ((ctl.numsig = arg_to_signum(arg, 0)) < 0) {
 				nosig(arg);
 				return EXIT_FAILURE;
 			}
@@ -264,49 +273,49 @@ int main(int argc, char **argv)
 		 * number).  In case of doubt POSIX tells us to assume a
 		 * signal.  If a signal has been parsed, assume it is a
 		 * pid, break.  */
-		if (do_kill)
+		if (ctl.do_kill)
 			break;
 		arg++;
-		if ((numsig = arg_to_signum(arg, 0)) < 0)
+		if ((ctl.numsig = arg_to_signum(arg, 0)) < 0)
 			usage(stderr);
-		do_kill++;
-		if (do_pid)
+		ctl.do_kill = 1;
+		if (ctl.do_pid)
 			usage(stderr);
 		continue;
 	}
 	if (!*argv)
 		usage(stderr);
-	if (do_pid)
-		numsig = -1;
+	if (ctl.do_pid)
+		ctl.numsig = -1;
 
 	/* We are done with the options.  The rest of the arguments
 	 * should be process ids and names, kill them.  */
-	for (errors = 0; (arg = *argv) != NULL; argv++) {
-		pid = strtol(arg, &ep, 10);
+	for (/* nothing */; (ctl.arg = *argv) != NULL; argv++) {
+		char *ep;
+
+		ctl.pid = strtol(ctl.arg, &ep, 10);
 		if (!*ep)
-			errors += kill_verbose(arg, pid, numsig);
+			errors |= kill_verbose(&ctl);
 		else {
 			struct proc_processes *ps = proc_open_processes();
 			int ct = 0;
 
 			if (!ps)
 				continue;
-			if (!check_all)
+			if (ctl.check_all)
 				proc_processes_filter_by_uid(ps, getuid());
-			proc_processes_filter_by_name(ps, arg);
-			while (proc_next_pid(ps, &pid) == 0) {
-				errors += kill_verbose(arg, pid, numsig);
+			proc_processes_filter_by_name(ps, ctl.arg);
+			while (proc_next_pid(ps, &(ctl.pid)) == 0) {
+				errors |= kill_verbose(&ctl);
 				ct++;
 			}
 			if (!ct) {
-				errors++;
-				warnx(_("cannot find process \"%s\""), arg);
+				errors = EXIT_FAILURE;
+				warnx(_("cannot find process \"%s\""), ctl.arg);
 			}
 			proc_close_processes(ps);
 		}
 	}
-	if (errors != 0)
-		errors = EXIT_FAILURE;
 	return errors;
 }
 
@@ -376,23 +385,23 @@ static void nosig(char *name)
 	printsignals(stderr, 1);
 }
 
-static void printsig(int sig)
+static void printsig(const struct kill_control *ctl)
 {
 	size_t n;
 
 	for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
-		if (sys_signame[n].val == sig) {
+		if (sys_signame[n].val == ctl->numsig) {
 			printf("%s\n", sys_signame[n].name);
 			return;
 		}
 	}
 #ifdef SIGRTMIN
-	if (SIGRTMIN <= sig && sig <= SIGRTMAX) {
-		printf("RT%d\n", sig - SIGRTMIN);
+	if (SIGRTMIN <= ctl->numsig && ctl->numsig <= SIGRTMAX) {
+		printf("RT%d\n", ctl->numsig - SIGRTMIN);
 		return;
 	}
 #endif
-	printf("%d\n", sig);
+	printf("%d\n", ctl->numsig);
 }
 
 static void pretty_print_signal(FILE *fp, size_t term_width, size_t *lpos,
@@ -462,23 +471,23 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static int kill_verbose(char *procname, pid_t pid, int sig)
+static int kill_verbose(const struct kill_control *ctl)
 {
 	int rc = 0;
 
-	if (sig < 0) {
-		printf("%ld\n", (long)pid);
+	if (ctl->numsig < 0) {
+		printf("%ld\n", (long) ctl->pid);
 		return 0;
 	}
 #ifdef HAVE_SIGQUEUE
 	if (use_sigval)
-		rc = sigqueue(pid, sig, sigdata);
+		rc = sigqueue(ctl->pid, ctl->numsig, sigdata);
 	else
 #endif
-		rc = kill(pid, sig);
+		rc = kill(ctl->pid, ctl->numsig);
 	if (rc < 0) {
-		warn(_("sending signal to %s failed"), procname);
-		return 1;
+		warn(_("sending signal to %s failed"), ctl->arg);
+		return EXIT_FAILURE;
 	}
-	return 0;
+	return EXIT_SUCCESS;
 }
-- 
1.9.0

