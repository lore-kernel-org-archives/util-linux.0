Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ob0-f170.google.com ([209.85.214.170]:61177 "EHLO
	mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaCIUac (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Mar 2014 16:30:32 -0400
Received: by mail-ob0-f170.google.com with SMTP id uz6so6214093obc.29
        for <util-linux@vger.kernel.org>; Sun, 09 Mar 2014 13:30:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/10] kill: fix coding style
Date: Sun,  9 Mar 2014 15:30:15 -0500
Message-Id: <1394397023-7050-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The kill was deprecated at the time lot of other tools got style
unification.  Now when deprecation is lifted it is time to get kill
cleaner.  This commit does not modify code, only various spacing issues,
removal of unecessary braces, and such are dealt.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 536 ++++++++++++++++++++++++++----------------------------
 1 file changed, 259 insertions(+), 277 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 63fc2ac..e7bf5f4 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -42,16 +42,16 @@
  *
  */
 
+#include <ctype.h>		/* for isdigit() */
+#include <signal.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <ctype.h>		/* for isdigit() */
 #include <unistd.h>
-#include <signal.h>
 
 #include "c.h"
-#include "nls.h"
 #include "closestream.h"
+#include "nls.h"
 #include "procutils.h"
 #include "strutils.h"
 #include "ttyutils.h"
@@ -63,38 +63,38 @@ struct signv {
 } sys_signame[] = {
 	/* POSIX signals */
 	{ "HUP",	SIGHUP },	/* 1 */
-	{ "INT",	SIGINT }, 	/* 2 */
-	{ "QUIT",	SIGQUIT }, 	/* 3 */
-	{ "ILL",	SIGILL }, 	/* 4 */
+	{ "INT",	SIGINT },	/* 2 */
+	{ "QUIT",	SIGQUIT },	/* 3 */
+	{ "ILL",	SIGILL },	/* 4 */
 #ifdef SIGTRAP
 	{ "TRAP",	SIGTRAP },	/* 5 */
 #endif
-	{ "ABRT",	SIGABRT }, 	/* 6 */
+	{ "ABRT",	SIGABRT },	/* 6 */
 #ifdef SIGIOT
-	{ "IOT",	SIGIOT }, 	/* 6, same as SIGABRT */
+	{ "IOT",	SIGIOT },	/* 6, same as SIGABRT */
 #endif
 #ifdef SIGEMT
-	{ "EMT",	SIGEMT }, 	/* 7 (mips,alpha,sparc*) */
+	{ "EMT",	SIGEMT },	/* 7 (mips,alpha,sparc*) */
 #endif
 #ifdef SIGBUS
 	{ "BUS",	SIGBUS },	/* 7 (arm,i386,m68k,ppc), 10 (mips,alpha,sparc*) */
 #endif
-	{ "FPE",	SIGFPE }, 	/* 8 */
-	{ "KILL",	SIGKILL }, 	/* 9 */
-	{ "USR1",	SIGUSR1 }, 	/* 10 (arm,i386,m68k,ppc), 30 (alpha,sparc*), 16 (mips) */
-	{ "SEGV",	SIGSEGV }, 	/* 11 */
-	{ "USR2",	SIGUSR2 }, 	/* 12 (arm,i386,m68k,ppc), 31 (alpha,sparc*), 17 (mips) */
-	{ "PIPE",	SIGPIPE }, 	/* 13 */
-	{ "ALRM",	SIGALRM }, 	/* 14 */
-	{ "TERM",	SIGTERM }, 	/* 15 */
+	{ "FPE",	SIGFPE },	/* 8 */
+	{ "KILL",	SIGKILL },	/* 9 */
+	{ "USR1",	SIGUSR1 },	/* 10 (arm,i386,m68k,ppc), 30 (alpha,sparc*), 16 (mips) */
+	{ "SEGV",	SIGSEGV },	/* 11 */
+	{ "USR2",	SIGUSR2 },	/* 12 (arm,i386,m68k,ppc), 31 (alpha,sparc*), 17 (mips) */
+	{ "PIPE",	SIGPIPE },	/* 13 */
+	{ "ALRM",	SIGALRM },	/* 14 */
+	{ "TERM",	SIGTERM },	/* 15 */
 #ifdef SIGSTKFLT
 	{ "STKFLT",	SIGSTKFLT },	/* 16 (arm,i386,m68k,ppc) */
 #endif
-	{ "CHLD",	SIGCHLD }, 	/* 17 (arm,i386,m68k,ppc), 20 (alpha,sparc*), 18 (mips) */
+	{ "CHLD",	SIGCHLD },	/* 17 (arm,i386,m68k,ppc), 20 (alpha,sparc*), 18 (mips) */
 #ifdef SIGCLD
 	{ "CLD",	SIGCLD },	/* same as SIGCHLD (mips) */
 #endif
-	{ "CONT",	SIGCONT }, 	/* 18 (arm,i386,m68k,ppc), 19 (alpha,sparc*), 25 (mips) */
+	{ "CONT",	SIGCONT },	/* 18 (arm,i386,m68k,ppc), 19 (alpha,sparc*), 25 (mips) */
 	{ "STOP",	SIGSTOP },	/* 19 (arm,i386,m68k,ppc), 17 (alpha,sparc*), 23 (mips) */
 	{ "TSTP",	SIGTSTP },	/* 20 (arm,i386,m68k,ppc), 18 (alpha,sparc*), 24 (mips) */
 	{ "TTIN",	SIGTTIN },	/* 21 (arm,i386,m68k,ppc,alpha,sparc*), 26 (mips) */
@@ -127,7 +127,7 @@ struct signv {
 	{ "INFO",	SIGINFO },	/* 29 (alpha) */
 #endif
 #ifdef SIGLOST
-	{ "LOST",	SIGLOST }, 	/* 29 (arm,i386,m68k,ppc,sparc*) */
+	{ "LOST",	SIGLOST },	/* 29 (arm,i386,m68k,ppc,sparc*) */
 #endif
 #ifdef SIGPWR
 	{ "PWR",	SIGPWR },	/* 30 (arm,i386,m68k,ppc), 29 (alpha,sparc*), 19 (mips) */
@@ -136,179 +136,171 @@ struct signv {
 	{ "UNUSED",	SIGUNUSED },	/* 31 (arm,i386,m68k,ppc) */
 #endif
 #ifdef SIGSYS
-	{ "SYS",	SIGSYS }, 	/* 31 (mips,alpha,sparc*) */
+	{ "SYS",	SIGSYS },	/* 31 (mips,alpha,sparc*) */
 #endif
 };
 
-static int arg_to_signum (char *arg, int mask);
-static void nosig (char *name);
-static void printsig (int sig);
-static void printsignals (FILE *fp, int pretty);
-static int usage (int status);
-static int kill_verbose (char *procname, int pid, int sig);
+static int arg_to_signum(char *arg, int mask);
+static void nosig(char *name);
+static void printsig(int sig);
+static void printsignals(FILE *fp, int pretty);
+static int usage(int status);
+static int kill_verbose(char *procname, int pid, int sig);
 
 #ifdef HAVE_SIGQUEUE
 static int use_sigval;
 static union sigval sigdata;
 #endif
 
-int main (int argc, char *argv[])
+int main(int argc, char **argv)
 {
-    int errors, numsig, pid;
-    char *ep, *arg;
-    int do_pid, do_kill, check_all;
-
-    setlocale(LC_ALL, "");
-    bindtextdomain(PACKAGE, LOCALEDIR);
-    textdomain(PACKAGE);
-    atexit(close_stdout);
-
-    numsig = SIGTERM;
-    do_pid = (! strcmp (program_invocation_short_name, "pid")); 	/* Yecch */
-    do_kill = 0;
-    check_all = 0;
-
-    /*  loop through the arguments.
-	actually, -a is the only option can be used with other options.
-	`kill' is basically a one-option-at-most program.  */
-    for (argc--, argv++; argc > 0; argc--, argv++) {
-	arg = *argv;
-	if (*arg != '-') {
-	    break;
-	}
-	if (! strcmp (arg, "--")) {
-	    argc--, argv++;
-	    break;
-	}
-	if (! strcmp (arg, "-v") || ! strcmp (arg, "-V") ||
-	    ! strcmp (arg, "--version")) {
-	    printf(UTIL_LINUX_VERSION);
-	    return EXIT_SUCCESS;
-	}
-	if (! strcmp (arg, "-h") || ! strcmp (arg, "--help"))
-	    return usage(EXIT_FAILURE);
-
-	if (! strcmp (arg, "-a") || ! strcmp (arg, "--all")) {
-	    check_all++;
-	    continue;
-	}
-	if (! strcmp (arg, "-l") || ! strcmp (arg, "--list")) {
-	    if (argc < 2) {
-		printsignals (stdout, 0);
-		return EXIT_SUCCESS;
-	    }
-	    if (argc > 2)
-		return usage (EXIT_FAILURE);
-	    /* argc == 2, accept "kill -l $?" */
-	    arg = argv[1];
-	    if ((numsig = arg_to_signum (arg, 1)) < 0)
-		errx(EXIT_FAILURE, _("unknown signal: %s"), arg);
-	    printsig (numsig);
-	    return EXIT_SUCCESS;
-	}
-	/* for compatibility with procps kill(1) */
-	if (! strncmp (arg, "--list=", 7) || ! strncmp (arg, "-l=", 3)) {
-		char *p = strchr(arg, '=') + 1;
-		if ((numsig = arg_to_signum(p, 1)) < 0)
-			errx(EXIT_FAILURE, _("unknown signal: %s"), p);
-		printsig (numsig);
-		return EXIT_SUCCESS;
-	}
-	if (! strcmp (arg, "-L") || ! strcmp (arg, "--table")) {
-	    printsignals (stdout, 1);
-	    return EXIT_SUCCESS;
-	}
-	if (! strcmp (arg, "-p") || ! strcmp (arg, "--pid")) {
-	    do_pid++;
-	    if (do_kill)
-		return usage (EXIT_FAILURE);
-	    continue;
-	}
-	if (! strcmp (arg, "-s") || ! strcmp (arg, "--signal")) {
-	    if (argc < 2) {
-		return usage (EXIT_FAILURE);
-	    }
-	    do_kill++;
-	    if (do_pid)
-		return usage (EXIT_FAILURE);
-	    argc--, argv++;
-	    arg = *argv;
-	    if ((numsig = arg_to_signum (arg, 0)) < 0) {
-		nosig (arg);
-		return EXIT_FAILURE;
-	    }
-	    continue;
-	}
-	if (! strcmp (arg, "-q") || ! strcmp (arg, "--queue")) {
-	    if (argc < 2)
-		return usage (EXIT_FAILURE);
-	    argc--, argv++;
-	    arg = *argv;
+	int errors, numsig, pid;
+	char *ep, *arg;
+	int do_pid, do_kill, check_all;
+
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	numsig = SIGTERM;
+	do_pid = (!strcmp(program_invocation_short_name, "pid"));	/* Yecch */
+	do_kill = 0;
+	check_all = 0;
+	/* Loop through the arguments.  Actually, -a is the only option
+	 * can be used with other options.  The 'kill' is basically a
+	 * one-option-at-most program. */
+	for (argc--, argv++; argc > 0; argc--, argv++) {
+		arg = *argv;
+		if (*arg != '-')
+			break;
+		if (!strcmp(arg, "--")) {
+			argc--, argv++;
+			break;
+		}
+		if (!strcmp(arg, "-v") || !strcmp(arg, "-V") ||
+		    !strcmp(arg, "--version")) {
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		}
+		if (!strcmp(arg, "-h") || !strcmp(arg, "--help"))
+			return usage(EXIT_FAILURE);
+
+		if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
+			check_all++;
+			continue;
+		}
+		if (!strcmp(arg, "-l") || !strcmp(arg, "--list")) {
+			if (argc < 2) {
+				printsignals(stdout, 0);
+				return EXIT_SUCCESS;
+			}
+			if (argc > 2)
+				return usage(EXIT_FAILURE);
+			/* argc == 2, accept "kill -l $?" */
+			arg = argv[1];
+			if ((numsig = arg_to_signum(arg, 1)) < 0)
+				errx(EXIT_FAILURE, _("unknown signal: %s"),
+				     arg);
+			printsig(numsig);
+			return EXIT_SUCCESS;
+		}
+		/* for compatibility with procps kill(1) */
+		if (!strncmp(arg, "--list=", 7) || !strncmp(arg, "-l=", 3)) {
+			char *p = strchr(arg, '=') + 1;
+			if ((numsig = arg_to_signum(p, 1)) < 0)
+				errx(EXIT_FAILURE, _("unknown signal: %s"), p);
+			printsig(numsig);
+			return EXIT_SUCCESS;
+		}
+		if (!strcmp(arg, "-L") || !strcmp(arg, "--table")) {
+			printsignals(stdout, 1);
+			return EXIT_SUCCESS;
+		}
+		if (!strcmp(arg, "-p") || !strcmp(arg, "--pid")) {
+			do_pid++;
+			if (do_kill)
+				return usage(EXIT_FAILURE);
+			continue;
+		}
+		if (!strcmp(arg, "-s") || !strcmp(arg, "--signal")) {
+			if (argc < 2)
+				return usage(EXIT_FAILURE);
+			do_kill++;
+			if (do_pid)
+				return usage(EXIT_FAILURE);
+			argc--, argv++;
+			arg = *argv;
+			if ((numsig = arg_to_signum(arg, 0)) < 0) {
+				nosig(arg);
+				return EXIT_FAILURE;
+			}
+			continue;
+		}
+		if (!strcmp(arg, "-q") || !strcmp(arg, "--queue")) {
+			if (argc < 2)
+				return usage(EXIT_FAILURE);
+			argc--, argv++;
+			arg = *argv;
 #ifdef HAVE_SIGQUEUE
-	    sigdata.sival_int = strtos32_or_err(arg, _("invalid sigval argument"));
-	    use_sigval = 1;
+			sigdata.sival_int =
+			    strtos32_or_err(arg, _("invalid sigval argument"));
+			use_sigval = 1;
 #endif
-	    continue;
-	}
-	/*  `arg' begins with a dash but is not a known option.
-	    so it's probably something like -HUP, or -1/-n
-	    try to deal with it.
-	    -n could be signal n, or pid -n (i.e. process group n).
-	    In case of doubt POSIX tells us to assume a signal.
-	    If a signal has been parsed, assume it's a pid, break */
-	if (do_kill)
-	  break;
-	arg++;
-	if ((numsig = arg_to_signum (arg, 0)) < 0) {
-	    return usage (EXIT_FAILURE);
+			continue;
+		}
+		/* 'arg' begins with a dash but is not a known option.
+		 * So it's probably something like -HUP, or -1/-n try to
+		 * deal with it.
+		 *
+		 * -n could be signal n, or pid -n (i.e., process group
+		 * number).  In case of doubt POSIX tells us to assume a
+		 * signal.  If a signal has been parsed, assume it is a
+		 * pid, break.  */
+		if (do_kill)
+			break;
+		arg++;
+		if ((numsig = arg_to_signum(arg, 0)) < 0)
+			return usage(EXIT_FAILURE);
+		do_kill++;
+		if (do_pid)
+			return usage(EXIT_FAILURE);
+		continue;
 	}
-	do_kill++;
+	if (!*argv)
+		return usage(EXIT_FAILURE);
 	if (do_pid)
-	    return usage (EXIT_FAILURE);
-	continue;
-    }
-
-    if (! *argv) {
-	return usage (EXIT_FAILURE);
-    }
-    if (do_pid) {
-	numsig = -1;
-    }
-
-    /*  we're done with the options.
-	the rest of the arguments should be process ids and names.
-	kill them.  */
-    for (errors = 0; (arg = *argv) != NULL; argv++) {
-	pid = strtol (arg, &ep, 10);
-	if (! *ep)
-	    errors += kill_verbose (arg, pid, numsig);
-	else  {
-	    struct proc_processes *ps = proc_open_processes();
-	    int ct = 0;
-
-	    if (!ps)
-	        continue;
-
-	    if (!check_all)
-		proc_processes_filter_by_uid(ps, getuid());
-
-	    proc_processes_filter_by_name(ps, arg);
-
-	    while (proc_next_pid(ps, &pid) == 0) {
-		errors += kill_verbose(arg, pid, numsig);
-		ct++;
-	    }
-
-	    if (!ct) {
-		errors++;
-		warnx (_("cannot find process \"%s\""), arg);
-	    }
-	    proc_close_processes(ps);
+		numsig = -1;
+
+	/* We are done with the options.  The rest of the arguments
+	 * should be process ids and names, kill them.  */
+	for (errors = 0; (arg = *argv) != NULL; argv++) {
+		pid = strtol(arg, &ep, 10);
+		if (!*ep)
+			errors += kill_verbose(arg, pid, numsig);
+		else {
+			struct proc_processes *ps = proc_open_processes();
+			int ct = 0;
+
+			if (!ps)
+				continue;
+			if (!check_all)
+				proc_processes_filter_by_uid(ps, getuid());
+			proc_processes_filter_by_name(ps, arg);
+			while (proc_next_pid(ps, &pid) == 0) {
+				errors += kill_verbose(arg, pid, numsig);
+				ct++;
+			}
+			if (!ct) {
+				errors++;
+				warnx(_("cannot find process \"%s\""), arg);
+			}
+			proc_close_processes(ps);
+		}
 	}
-    }
-    if (errors != 0)
-	errors = EXIT_FAILURE;
-    return errors;
+	if (errors != 0)
+		errors = EXIT_FAILURE;
+	return errors;
 }
 
 #ifdef SIGRTMIN
@@ -323,83 +315,77 @@ static int rtsig_to_signum(char *sig)
 		sig += 4;
 		maxi = 1;
 	}
-
 	if (!isdigit(*sig))
 		return -1;
-
 	errno = 0;
 	num = strtol(sig, &ep, 10);
 	if (!ep || sig == ep || errno || num < 0)
 		return -1;
-
 	num = maxi ? SIGRTMAX - num : SIGRTMIN + num;
-
 	if (num < SIGRTMIN || num > SIGRTMAX)
 		return -1;
-
 	return num;
 }
 #endif
 
-static int signame_to_signum (char *sig)
+static int signame_to_signum(char *sig)
 {
-    size_t n;
-
-    if (! strncasecmp (sig, "sig", 3))
-	sig += 3;
+	size_t n;
 
+	if (!strncasecmp(sig, "sig", 3))
+		sig += 3;
 #ifdef SIGRTMIN
-    /* RT signals */
-    if (!strncasecmp(sig, "rt", 2))
-	return rtsig_to_signum(sig + 2);
+	/* RT signals */
+	if (!strncasecmp(sig, "rt", 2))
+		return rtsig_to_signum(sig + 2);
 #endif
-    /* Normal sugnals */
-    for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
-	if (! strcasecmp (sys_signame[n].name, sig))
-	    return sys_signame[n].val;
-    }
-    return (-1);
+	/* Normal sugnals */
+	for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
+		if (!strcasecmp(sys_signame[n].name, sig))
+			return sys_signame[n].val;
+	}
+	return (-1);
 }
 
-static int arg_to_signum (char *arg, int maskbit)
+static int arg_to_signum(char *arg, int maskbit)
 {
-    int numsig;
-    char *ep;
-
-    if (isdigit (*arg)) {
-	numsig = strtol (arg, &ep, 10);
-	if (numsig >= NSIG && maskbit && (numsig & 128) != 0)
-	    numsig -= 128;
-	if (*ep != 0 || numsig < 0 || numsig >= NSIG)
-	    return (-1);
-	return (numsig);
-    }
-    return signame_to_signum (arg);
+	int numsig;
+	char *ep;
+
+	if (isdigit(*arg)) {
+		numsig = strtol(arg, &ep, 10);
+		if (numsig >= NSIG && maskbit && (numsig & 128) != 0)
+			numsig -= 128;
+		if (*ep != 0 || numsig < 0 || numsig >= NSIG)
+			return (-1);
+		return (numsig);
+	}
+	return signame_to_signum(arg);
 }
 
-static void nosig (char *name)
+static void nosig(char *name)
 {
-    warnx (_("unknown signal %s; valid signals:"), name);
-    printsignals (stderr, 1);
+	warnx(_("unknown signal %s; valid signals:"), name);
+	printsignals(stderr, 1);
 }
 
-static void printsig (int sig)
+static void printsig(int sig)
 {
-    size_t n;
+	size_t n;
 
-    for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
-	if (sys_signame[n].val == sig) {
-	    printf ("%s\n", sys_signame[n].name);
-	    return;
+	for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
+		if (sys_signame[n].val == sig) {
+			printf("%s\n", sys_signame[n].name);
+			return;
+		}
 	}
-    }
 #ifdef SIGRTMIN
-    if (sig >= SIGRTMIN && sig <= SIGRTMAX) {
-	printf ("RT%d\n", sig - SIGRTMIN);
-	return;
-    }
+	if (sig >= SIGRTMIN && sig <= SIGRTMAX) {
+		printf("RT%d\n", sig - SIGRTMIN);
+		return;
+	}
 #endif
-    printf("%d\n", sig);
+	printf("%d\n", sig);
 }
 
 #define FIELD_WIDTH 11
@@ -407,50 +393,48 @@ static void pretty_print_signal(FILE *fp, size_t term_width, size_t *lpos,
 				int signum, const char *name)
 {
 	if (term_width < (*lpos + FIELD_WIDTH)) {
-	    fputc ('\n', fp);
-	    *lpos = 0;
+		fputc('\n', fp);
+		*lpos = 0;
 	}
 	*lpos += FIELD_WIDTH;
-	fprintf (fp, "%2d %-8s", signum, name);
+	fprintf(fp, "%2d %-8s", signum, name);
 }
 
-static void printsignals (FILE *fp, int pretty)
+static void printsignals(FILE *fp, int pretty)
 {
-    size_t n, lth, lpos = 0, width;
-
-    if (!pretty) {
-	for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
-	    lth = 1+strlen(sys_signame[n].name);
-	    if (lpos+lth > 72) {
-		fputc ('\n', fp);
-		lpos = 0;
-	    } else if (lpos)
-		fputc (' ', fp);
-	    lpos += lth;
-	    fputs (sys_signame[n].name, fp);
-	}
+	size_t n, lth, lpos = 0, width;
+
+	if (!pretty) {
+		for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
+			lth = 1 + strlen(sys_signame[n].name);
+			if (lpos + lth > 72) {
+				fputc('\n', fp);
+				lpos = 0;
+			} else if (lpos)
+				fputc(' ', fp);
+			lpos += lth;
+			fputs(sys_signame[n].name, fp);
+		}
 #ifdef SIGRTMIN
-	fputs (" RT<N> RTMIN+<N> RTMAX-<N>", fp);
+		fputs(" RT<N> RTMIN+<N> RTMAX-<N>", fp);
 #endif
-	fputc ('\n', fp);
-	return;
-    }
-    /* pretty print */
-    width = get_terminal_width();
-    if (width == 0)
-	width = 72;
-    else
-	width -= 1;
-
-    for (n = 0; n < ARRAY_SIZE(sys_signame); n++)
-	    pretty_print_signal(fp, width, &lpos,
-			    sys_signame[n].val, sys_signame[n].name);
-
+		fputc('\n', fp);
+		return;
+	}
+	/* pretty print */
+	width = get_terminal_width();
+	if (width == 0)
+		width = 72;
+	else
+		width -= 1;
+	for (n = 0; n < ARRAY_SIZE(sys_signame); n++)
+		pretty_print_signal(fp, width, &lpos,
+				    sys_signame[n].val, sys_signame[n].name);
 #ifdef SIGRTMIN
-    pretty_print_signal(fp, width, &lpos, SIGRTMIN, "RTMIN");
-    pretty_print_signal(fp, width, &lpos, SIGRTMAX, "RTMAX");
+	pretty_print_signal(fp, width, &lpos, SIGRTMIN, "RTMIN");
+	pretty_print_signal(fp, width, &lpos, SIGRTMAX, "RTMAX");
 #endif
-    fputc ('\n', fp);
+	fputc('\n', fp);
 }
 
 static int usage(int status)
@@ -471,28 +455,26 @@ static int usage(int status)
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("kill(1)"));
-
 	return status;
 }
 
-static int kill_verbose (char *procname, pid_t pid, int sig)
+static int kill_verbose(char *procname, pid_t pid, int sig)
 {
-    int rc = 0;
+	int rc = 0;
 
-    if (sig < 0) {
-	printf ("%ld\n", (long)pid);
-	return 0;
-    }
+	if (sig < 0) {
+		printf("%ld\n", (long)pid);
+		return 0;
+	}
 #ifdef HAVE_SIGQUEUE
-    if (use_sigval)
-	rc = sigqueue(pid, sig, sigdata);
-    else
+	if (use_sigval)
+		rc = sigqueue(pid, sig, sigdata);
+	else
 #endif
-	rc = kill (pid, sig);
-
-    if (rc < 0) {
-	warn(_("sending signal to %s failed"), procname);
-	return 1;
-    }
-    return 0;
+		rc = kill(pid, sig);
+	if (rc < 0) {
+		warn(_("sending signal to %s failed"), procname);
+		return 1;
+	}
+	return 0;
 }
-- 
1.9.0

