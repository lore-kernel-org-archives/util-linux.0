Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:58842 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab3CGX1k (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Mar 2013 18:27:40 -0500
Received: by mail-we0-f170.google.com with SMTP id z53so320469wey.29
        for <util-linux@vger.kernel.org>; Thu, 07 Mar 2013 15:27:38 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/7] kill, procs: fix coding style
Date: Thu,  7 Mar 2013 23:27:21 +0000
Message-Id: <1362698844-21292-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
References: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c  | 405 ++++++++++++++++++++++++++---------------------------
 misc-utils/procs.c | 172 ++++++++++++-----------
 2 files changed, 290 insertions(+), 287 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index c9fb76b..5e349c8 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -141,150 +141,147 @@ struct signv {
 
 extern char *mybasename(char *);
 
-static int arg_to_signum (char *arg, int mask);
-static void nosig (char *name);
-static void printsig (int sig);
-static void printsignals (FILE *fp);
-static int usage (int status);
-static int kill_verbose (char *procname, int pid, int sig);
+static int arg_to_signum(char *arg, int mask);
+static void nosig(char *name);
+static void printsig(int sig);
+static void printsignals(FILE *fp);
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
-    int *pids, *ip;
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
-	if (! strcmp (arg, "-a") || ! strcmp (arg, "--all")) {
-	    check_all++;
-	    continue;
-	}
-	if (! strcmp (arg, "-l") || ! strcmp (arg, "--list")) {
-	    if (argc < 2) {
-		printsignals (stdout);
-		return EXIT_SUCCESS;
-	    }
-	    if (argc > 2) {
-		return usage (EXIT_FAILURE);
-	    }
-	    /* argc == 2, accept "kill -l $?" */
-	    arg = argv[1];
-	    if ((numsig = arg_to_signum (arg, 1)) < 0)
-		errx(EXIT_FAILURE, _("unknown signal: %s"), arg);
-	    printsig (numsig);
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
+	int *pids, *ip;
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
+
+	/* Loop through the arguments.  Actually, -a is the only option
+	 * can be used with other options.  'kill' is basically a
+	 * one-option-at-most program.  */
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
+		if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
+			check_all++;
+			continue;
+		}
+		if (!strcmp(arg, "-l") || !strcmp(arg, "--list")) {
+			if (argc < 2) {
+				printsignals(stdout);
+				return EXIT_SUCCESS;
+			}
+			if (argc > 2) {
+				return usage(EXIT_FAILURE);
+			}
+			/* argc == 2, accept "kill -l $?" */
+			arg = argv[1];
+			if ((numsig = arg_to_signum(arg, 1)) < 0)
+				errx(EXIT_FAILURE, _("unknown signal: %s"),
+				     arg);
+			printsig(numsig);
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
+		 * So it is probably something like -HUP, or -1/-n try to
+		 * deal with it.  -n could be signal n, or pid -n (i.e.,
+		 * process group n).  In case of doubt POSIX tells us to
+		 * assume a signal.  If a signal has been parsed, assume
+		 * it i+
+		 s a pid, break.  */
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
+
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
-    for (errors = EXIT_SUCCESS; (arg = *argv) != NULL; argv++) {
-	pid = strtol (arg, &ep, 10);
-	if (! *ep)
-	    errors += kill_verbose (arg, pid, numsig);
-	else {
-	    pids = get_pids (arg, check_all);
-	    if (! pids) {
-		errors++;
-		warnx (_("cannot find process \"%s\""), arg);
-		continue;
-	    }
-	    for (ip = pids; *ip >= 0; ip++)
-		errors += kill_verbose (arg, *ip, numsig);
-	    free (pids);
+		numsig = -1;
+
+	/* We are done with the options.  The rest of the arguments
+	 * should be process ids and names, and kill them.  */
+	for (errors = EXIT_SUCCESS; (arg = *argv) != NULL; argv++) {
+		pid = strtol(arg, &ep, 10);
+		if (!*ep)
+			errors += kill_verbose(arg, pid, numsig);
+		else {
+			pids = get_pids(arg, check_all);
+			if (!pids) {
+				errors++;
+				warnx(_("cannot find process \"%s\""), arg);
+				continue;
+			}
+			for (ip = pids; *ip >= 0; ip++)
+				errors += kill_verbose(arg, *ip, numsig);
+			free(pids);
+		}
 	}
-    }
-    if (errors != EXIT_SUCCESS)
-	errors = EXIT_FAILURE;
-    return errors;
+	if (errors != EXIT_SUCCESS)
+		errors = EXIT_FAILURE;
+	return errors;
 }
 
 #ifdef SIGRTMIN
@@ -310,92 +307,92 @@ static int rtsig_to_signum(char *sig)
 
 	num = maxi ? SIGRTMAX - num : SIGRTMIN + num;
 
-	if (num < SIGRTMIN || num > SIGRTMAX)
+	if (num < SIGRTMIN || SIGRTMAX < num)
 		return -1;
 
 	return num;
 }
 #endif
 
-static int signame_to_signum (char *sig)
+static int signame_to_signum(char *sig)
 {
-    size_t n;
+	size_t n;
 
-    if (! strncasecmp (sig, "sig", 3))
-	sig += 3;
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
+	return -1;
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
+		if (NSIG <= numsig && maskbit && (numsig & 128) != 0)
+			numsig -= 128;
+		if (*ep != 0 || numsig < 0 || NSIG <= numsig)
+			return -1;
+		return numsig;
+	}
+	return signame_to_signum(arg);
 }
 
-static void nosig (char *name)
+static void nosig(char *name)
 {
-    warnx (_("unknown signal %s; valid signals:"), name);
-    printsignals (stderr);
+	warnx(_("unknown signal %s; valid signals:"), name);
+	printsignals(stderr);
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
+	if (SIGRTMIN <= sig && sig <= SIGRTMAX) {
+		printf("RT%d\n", sig - SIGRTMIN);
+		return;
+	}
 #endif
-    printf("%d\n", sig);
+	printf("%d\n", sig);
 }
 
-static void printsignals (FILE *fp)
+static void printsignals(FILE *fp)
 {
-    size_t n, lth, lpos = 0;
-
-    for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
-	lth = 1+strlen(sys_signame[n].name);
-	if (lpos+lth > 72) {
-	    fputc ('\n', fp);
-	    lpos = 0;
-	} else if (lpos)
-	    fputc (' ', fp);
-	lpos += lth;
-	fputs (sys_signame[n].name, fp);
-    }
+	size_t n, lth, lpos = 0;
+
+	for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
+		lth = 1 + strlen(sys_signame[n].name);
+		if (lpos + lth > 72) {
+			fputc('\n', fp);
+			lpos = 0;
+		} else if (lpos)
+			fputc(' ', fp);
+		lpos += lth;
+		fputs(sys_signame[n].name, fp);
+	}
 #ifdef SIGRTMIN
-    fputs (" RT<N> RTMIN+<N> RTMAX-<N>", fp);
+	fputs(" RT<N> RTMIN+<N> RTMAX-<N>", fp);
 #endif
-    fputc ('\n', fp);
+	fputc('\n', fp);
 }
 
 static int usage(int status)
@@ -419,24 +416,24 @@ static int usage(int status)
 	return status;
 }
 
-static int kill_verbose (char *procname, int pid, int sig)
+static int kill_verbose(char *procname, int pid, int sig)
 {
-    int rc;
+	int rc;
 
-    if (sig < 0) {
-	printf ("%d\n", pid);
-	return 0;
-    }
+	if (sig < 0) {
+		printf("%d\n", pid);
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
+		rc = kill(pid, sig);
 
-    if (rc < 0) {
-	warn(_("sending signal to %s failed"), procname);
-	return 1;
-    }
-    return 0;
+	if (rc < 0) {
+		warn(_("sending signal to %s failed"), procname);
+		return 1;
+	}
+	return 0;
 }
diff --git a/misc-utils/procs.c b/misc-utils/procs.c
index f3057fe..071a63a 100644
--- a/misc-utils/procs.c
+++ b/misc-utils/procs.c
@@ -12,8 +12,6 @@
  *
  */
 
-#define _POSIX_SOURCE 1
-
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <stdio.h>
@@ -25,102 +23,110 @@
 #include "kill.h"
 #include "xalloc.h"
 
-extern char *mybasename (char *);
-static char *parse_parens (char *buf);
-
-int *
-get_pids (char *process_name, int get_all) {
-    DIR *dir;
-    struct dirent *ent;
-    int status;
-    char *dname, fname[100], *cp, buf[256];
-    struct stat st;
-    uid_t uid;
-    FILE *fp;
-    int pid, *pids, num_pids, pids_size;
+extern char *mybasename(char *);
+static char *parse_parens(char *buf);
 
-    dir = opendir ("/proc");
-    if (! dir) {
-	warn ("opendir /proc");
-	return NULL;
-    }
-    uid = getuid ();
-    pids = NULL;
-    num_pids = pids_size = 0;
+int *get_pids(char *process_name, int get_all)
+{
+	DIR *dir;
+	struct dirent *ent;
+	int status;
+	char *dname, fname[100], *cp, buf[256];
+	struct stat st;
+	uid_t uid;
+	FILE *fp;
+	int pid, *pids, num_pids, pids_size;
 
-    while ((ent = readdir (dir)) != NULL) {
-	dname = ent->d_name;
-	if (! isdigit (*dname)) continue;
-	pid = atoi (dname);
-	sprintf (fname, "/proc/%d/cmdline", pid);
-	/* get the process owner */
-	status = stat (fname, &st);
-	if (status != 0) continue;
-	if (! get_all && uid != st.st_uid) continue;
-	/* get the command line */
-	fp = fopen (fname, "r");
-	if (! fp) continue;
-	cp = fgets (buf, sizeof (buf), fp);
-	fclose (fp);
-	/* an empty command line means the process is swapped out */
-	if (! cp || ! *cp) {
-	    /* get the process name from the statfile */
-	    sprintf (fname, "/proc/%d/stat", pid);
-	    fp = fopen (fname, "r");
-	    if (! fp) continue;
-	    cp = fgets (buf, sizeof (buf), fp);
-	    fclose (fp);
-	    if (cp == NULL) continue;
-	    cp = parse_parens (buf);
-	    if (cp == NULL) continue;
+	dir = opendir("/proc");
+	if (!dir) {
+		warn("opendir /proc");
+		return NULL;
 	}
-	/* ok, we got the process name. */
-	if (strcmp (process_name, mybasename (cp))) continue;
-	while (pids_size < num_pids + 2) {
-	    pids_size += 5;
-	    pids = (int *) xrealloc (pids, sizeof (int) * pids_size);
-	}
-	if (pids) {
-		pids[num_pids++] = pid;
-		pids[num_pids] = -1;
+	uid = getuid();
+	pids = NULL;
+	num_pids = pids_size = 0;
+
+	while ((ent = readdir(dir)) != NULL) {
+		dname = ent->d_name;
+		if (!isdigit(*dname))
+			continue;
+		pid = atoi(dname);
+		sprintf(fname, "/proc/%d/cmdline", pid);
+		/* get the process owner */
+		status = stat(fname, &st);
+		if (status != 0)
+			continue;
+		if (!get_all && uid != st.st_uid)
+			continue;
+		/* get the command line */
+		fp = fopen(fname, "r");
+		if (!fp)
+			continue;
+		cp = fgets(buf, sizeof(buf), fp);
+		fclose(fp);
+		/* an empty command line means the process is swapped out */
+		if (!cp || !*cp) {
+			/* get the process name from the statfile */
+			sprintf(fname, "/proc/%d/stat", pid);
+			fp = fopen(fname, "r");
+			if (!fp)
+				continue;
+			cp = fgets(buf, sizeof(buf), fp);
+			fclose(fp);
+			if (cp == NULL)
+				continue;
+			cp = parse_parens(buf);
+			if (cp == NULL)
+				continue;
+		}
+		/* ok, we got the process name. */
+		if (strcmp(process_name, mybasename(cp)))
+			continue;
+		while (pids_size < num_pids + 2) {
+			pids_size += 5;
+			pids = (int *)xrealloc(pids, sizeof(int) * pids_size);
+		}
+		if (pids) {
+			pids[num_pids++] = pid;
+			pids[num_pids] = -1;
+		}
 	}
-    }
-    closedir (dir);
-    return pids;
+	closedir(dir);
+	return pids;
 }
 
 /*
  *  parse_parens () -- return an index just past the first open paren in
  *	buf, and terminate the string at the matching close paren.
  */
-static char *parse_parens (char *buf)
+static char *parse_parens(char *buf)
 {
-    char *cp, *ip;
-    int depth;
+	char *cp, *ip;
+	int depth;
 
-    cp = strchr (buf, '(');
-    if (cp == NULL) return NULL;
-    cp++;
-    depth = 1;
-    for (ip = cp; *ip; ip++) {
-	if (*ip == '(')
-	    depth++;
-	if (*ip == ')') {
-	    depth--;
-	    if (depth == 0) {
-		*ip = 0;
-		break;
-	    }
+	cp = strchr(buf, '(');
+	if (cp == NULL)
+		return NULL;
+	cp++;
+	depth = 1;
+	for (ip = cp; *ip; ip++) {
+		if (*ip == '(')
+			depth++;
+		if (*ip == ')') {
+			depth--;
+			if (depth == 0) {
+				*ip = 0;
+				break;
+			}
+		}
 	}
-    }
-    return cp;
+	return cp;
 }
 
-char *mybasename (char *path)
+char *mybasename(char *path)
 {
-    char *cp;
+	char *cp;
 
-    cp = strrchr (path, '/');
-    return (cp ? cp + 1 : path);
+	cp = strrchr(path, '/');
+	return (cp ? cp + 1 : path);
 }
-
-- 
1.8.1.5

