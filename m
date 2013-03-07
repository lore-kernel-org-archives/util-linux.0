Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:51606 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab3CGX1i (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Mar 2013 18:27:38 -0500
Received: by mail-wi0-f181.google.com with SMTP id hm6so646056wib.8
        for <util-linux@vger.kernel.org>; Thu, 07 Mar 2013 15:27:36 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/7] kill: use libc error printing facilities and exit values
Date: Thu,  7 Mar 2013 23:27:20 +0000
Message-Id: <1362698844-21292-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
References: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c  | 54 +++++++++++++++++++++++-------------------------------
 misc-utils/procs.c |  2 +-
 2 files changed, 24 insertions(+), 32 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 2b6256c..c9fb76b 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -148,8 +148,6 @@ static void printsignals (FILE *fp);
 static int usage (int status);
 static int kill_verbose (char *procname, int pid, int sig);
 
-static char *progname;
-
 #ifdef HAVE_SIGQUEUE
 static int use_sigval;
 static union sigval sigdata;
@@ -158,21 +156,17 @@ static union sigval sigdata;
 int main (int argc, char *argv[])
 {
     int errors, numsig, pid;
-    char *ep, *arg, *p;
+    char *ep, *arg;
     int do_pid, do_kill, check_all;
     int *pids, *ip;
 
-    progname = argv[0];
-    if ((p = strrchr(progname, '/')) != NULL)
-	    progname = p+1;
-
     setlocale(LC_ALL, "");
     bindtextdomain(PACKAGE, LOCALEDIR);
     textdomain(PACKAGE);
     atexit(close_stdout);
 
     numsig = SIGTERM;
-    do_pid = (! strcmp (progname, "pid")); 	/* Yecch */
+    do_pid = (! strcmp (program_invocation_short_name, "pid")); 	/* Yecch */
     do_kill = 0;
     check_all = 0;
 
@@ -191,7 +185,7 @@ int main (int argc, char *argv[])
 	if (! strcmp (arg, "-v") || ! strcmp (arg, "-V") ||
 	    ! strcmp (arg, "--version")) {
 	    printf(UTIL_LINUX_VERSION);
-	    return 0;
+	    return EXIT_SUCCESS;
 	}
 	if (! strcmp (arg, "-a") || ! strcmp (arg, "--all")) {
 	    check_all++;
@@ -200,44 +194,42 @@ int main (int argc, char *argv[])
 	if (! strcmp (arg, "-l") || ! strcmp (arg, "--list")) {
 	    if (argc < 2) {
 		printsignals (stdout);
-		return 0;
+		return EXIT_SUCCESS;
 	    }
 	    if (argc > 2) {
-		return usage (1);
+		return usage (EXIT_FAILURE);
 	    }
 	    /* argc == 2, accept "kill -l $?" */
 	    arg = argv[1];
-	    if ((numsig = arg_to_signum (arg, 1)) < 0) {
-		fprintf (stderr, _("%s: unknown signal %s\n"), progname, arg);
-		return 1;
-	    }
+	    if ((numsig = arg_to_signum (arg, 1)) < 0)
+		errx(EXIT_FAILURE, _("unknown signal: %s"), arg);
 	    printsig (numsig);
-	    return 0;
+	    return EXIT_SUCCESS;
 	}
 	if (! strcmp (arg, "-p") || ! strcmp (arg, "--pid")) {
 	    do_pid++;
 	    if (do_kill)
-		return usage (1);
+		return usage (EXIT_FAILURE);
 	    continue;
 	}
 	if (! strcmp (arg, "-s") || ! strcmp (arg, "--signal")) {
 	    if (argc < 2) {
-		return usage (1);
+		return usage (EXIT_FAILURE);
 	    }
 	    do_kill++;
 	    if (do_pid)
-		return usage (1);
+		return usage (EXIT_FAILURE);
 	    argc--, argv++;
 	    arg = *argv;
 	    if ((numsig = arg_to_signum (arg, 0)) < 0) {
 		nosig (arg);
-		return 1;
+		return EXIT_FAILURE;
 	    }
 	    continue;
 	}
 	if (! strcmp (arg, "-q") || ! strcmp (arg, "--queue")) {
 	    if (argc < 2)
-		return usage (1);
+		return usage (EXIT_FAILURE);
 	    argc--, argv++;
 	    arg = *argv;
 #ifdef HAVE_SIGQUEUE
@@ -256,16 +248,16 @@ int main (int argc, char *argv[])
 	  break;
 	arg++;
 	if ((numsig = arg_to_signum (arg, 0)) < 0) {
-	    return usage (1);
+	    return usage (EXIT_FAILURE);
 	}
 	do_kill++;
 	if (do_pid)
-	    return usage (1);
+	    return usage (EXIT_FAILURE);
 	continue;
     }
 
     if (! *argv) {
-	return usage (1);
+	return usage (EXIT_FAILURE);
     }
     if (do_pid) {
 	numsig = -1;
@@ -274,7 +266,7 @@ int main (int argc, char *argv[])
     /*  we're done with the options.
 	the rest of the arguments should be process ids and names.
 	kill them.  */
-    for (errors = 0; (arg = *argv) != NULL; argv++) {
+    for (errors = EXIT_SUCCESS; (arg = *argv) != NULL; argv++) {
 	pid = strtol (arg, &ep, 10);
 	if (! *ep)
 	    errors += kill_verbose (arg, pid, numsig);
@@ -282,8 +274,7 @@ int main (int argc, char *argv[])
 	    pids = get_pids (arg, check_all);
 	    if (! pids) {
 		errors++;
-		fprintf (stderr, _("%s: can't find process \"%s\"\n"),
-			 progname, arg);
+		warnx (_("cannot find process \"%s\""), arg);
 		continue;
 	    }
 	    for (ip = pids; *ip >= 0; ip++)
@@ -291,7 +282,9 @@ int main (int argc, char *argv[])
 	    free (pids);
 	}
     }
-    return (errors);
+    if (errors != EXIT_SUCCESS)
+	errors = EXIT_FAILURE;
+    return errors;
 }
 
 #ifdef SIGRTMIN
@@ -362,7 +355,7 @@ static int arg_to_signum (char *arg, int maskbit)
 
 static void nosig (char *name)
 {
-    fprintf (stderr, _("%s: unknown signal %s; valid signals:\n"), progname, name);
+    warnx (_("unknown signal %s; valid signals:"), name);
     printsignals (stderr);
 }
 
@@ -442,8 +435,7 @@ static int kill_verbose (char *procname, int pid, int sig)
 	rc = kill (pid, sig);
 
     if (rc < 0) {
-	fprintf (stderr, "%s ", progname);
-	perror (procname);
+	warn(_("sending signal to %s failed"), procname);
 	return 1;
     }
     return 0;
diff --git a/misc-utils/procs.c b/misc-utils/procs.c
index e76c390..f3057fe 100644
--- a/misc-utils/procs.c
+++ b/misc-utils/procs.c
@@ -41,7 +41,7 @@ get_pids (char *process_name, int get_all) {
 
     dir = opendir ("/proc");
     if (! dir) {
-	perror ("opendir /proc");
+	warn ("opendir /proc");
 	return NULL;
     }
     uid = getuid ();
-- 
1.8.1.5

