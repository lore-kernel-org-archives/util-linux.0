Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-gh0-f174.google.com ([209.85.160.174]:65101 "EHLO
	mail-gh0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753163Ab2JRP5R (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Oct 2012 11:57:17 -0400
Received: by mail-gh0-f174.google.com with SMTP id g15so2443414ghb.19
        for <util-linux@vger.kernel.org>; Thu, 18 Oct 2012 08:57:17 -0700 (PDT)
Date: Thu, 18 Oct 2012 16:00:35 +0000
From: Ayan George <ayan@ayan.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] Use C99 idioms in kill.c
Message-ID: <508027a3.F4yA3cJIewfcpygT%ayan@ayan.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* Moved some declarations closer to where the vairable is used.
* Declared variables used only in loops within the loop itself.
---
 misc-utils/kill.c |   45 +++++++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 6abfd24..c0c87f2 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -157,10 +157,7 @@ static union sigval sigdata;
 
 int main (int argc, char *argv[])
 {
-    int errors, numsig, pid;
-    char *ep, *arg, *p;
-    int do_pid, do_kill, check_all;
-    int *pids, *ip;
+    char *arg, *p;
 
     progname = argv[0];
     if ((p = strrchr(progname, '/')) != NULL)
@@ -171,10 +168,10 @@ int main (int argc, char *argv[])
     textdomain(PACKAGE);
     atexit(close_stdout);
 
-    numsig = SIGTERM;
-    do_pid = (! strcmp (progname, "pid")); 	/* Yecch */
-    do_kill = 0;
-    check_all = 0;
+    int numsig = SIGTERM,
+    	do_pid = (! strcmp (progname, "pid")), 	/* Yecch */
+    	do_kill = 0,
+    	check_all = 0;
 
     /*  loop through the arguments.
 	actually, -a is the only option can be used with other options.
@@ -274,19 +271,21 @@ int main (int argc, char *argv[])
     /*  we're done with the options.
 	the rest of the arguments should be process ids and names.
 	kill them.  */
+    int errors;
     for (errors = 0; (arg = *argv) != NULL; argv++) {
-	pid = strtol (arg, &ep, 10);
+      	char *ep = NULL;
+	int pid = strtol (arg, &ep, 10);
 	if (! *ep)
 	    errors += kill_verbose (arg, pid, numsig);
 	else {
-	    pids = get_pids (arg, check_all);
+	    int *pids = get_pids (arg, check_all);
 	    if (! pids) {
 		errors++;
 		fprintf (stderr, _("%s: can't find process \"%s\"\n"),
 			 progname, arg);
 		continue;
 	    }
-	    for (ip = pids; *ip >= 0; ip++)
+	    for (int *ip = pids; *ip >= 0; ip++)
 		errors += kill_verbose (arg, *ip, numsig);
 	    free (pids);
 	}
@@ -297,8 +296,7 @@ int main (int argc, char *argv[])
 #ifdef SIGRTMIN
 static int rtsig_to_signum(char *sig)
 {
-	int num, maxi = 0;
-	char *ep = NULL;
+	int maxi = 0;
 
 	if (strncasecmp(sig, "min+", 4) == 0)
 		sig += 4;
@@ -311,7 +309,8 @@ static int rtsig_to_signum(char *sig)
 		return -1;
 
 	errno = 0;
-	num = strtol(sig, &ep, 10);
+	char *ep = NULL;
+	int num = strtol(sig, &ep, 10);
 	if (!ep || sig == ep || errno || num < 0)
 		return -1;
 
@@ -326,8 +325,6 @@ static int rtsig_to_signum(char *sig)
 
 static int signame_to_signum (char *sig)
 {
-    size_t n;
-
     if (! strncasecmp (sig, "sig", 3))
 	sig += 3;
 
@@ -337,7 +334,7 @@ static int signame_to_signum (char *sig)
 	return rtsig_to_signum(sig + 2);
 #endif
     /* Normal sugnals */
-    for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
+    for (size_t n = 0; n < ARRAY_SIZE(sys_signame); n++) {
 	if (! strcasecmp (sys_signame[n].name, sig))
 	    return sys_signame[n].val;
     }
@@ -368,9 +365,7 @@ static void nosig (char *name)
 
 static void printsig (int sig)
 {
-    size_t n;
-
-    for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
+    for (size_t n = 0; n < ARRAY_SIZE(sys_signame); n++) {
 	if (sys_signame[n].val == sig) {
 	    printf ("%s\n", sys_signame[n].name);
 	    return;
@@ -387,10 +382,10 @@ static void printsig (int sig)
 
 static void printsignals (FILE *fp)
 {
-    size_t n, lth, lpos = 0;
+    size_t lpos = 0;
 
-    for (n = 0; n < ARRAY_SIZE(sys_signame); n++) {
-	lth = 1+strlen(sys_signame[n].name);
+    for (size_t n = 0; n < ARRAY_SIZE(sys_signame); n++) {
+	size_t lth = 1+strlen(sys_signame[n].name);
 	if (lpos+lth > 72) {
 	    fputc ('\n', fp);
 	    lpos = 0;
@@ -407,9 +402,7 @@ static void printsignals (FILE *fp)
 
 static int usage (int status)
 {
-    FILE *fp;
-
-    fp = (status == 0 ? stdout : stderr);
+    FILE *fp = (status == 0 ? stdout : stderr);
     fprintf (fp, _("usage: %s [ -s signal | -p ] [ -a ] pid ...\n"), progname);
     fprintf (fp, _("       %s -l [ signal ]\n"), progname);
     return status;
-- 
1.7.10.4



