Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f47.google.com ([209.85.219.47]:47201 "EHLO
	mail-oa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751741AbaCIUag (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Mar 2014 16:30:36 -0400
Received: by mail-oa0-f47.google.com with SMTP id i11so6212939oag.6
        for <util-linux@vger.kernel.org>; Sun, 09 Mar 2014 13:30:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/10] kill: make usage() not to return
Date: Sun,  9 Mar 2014 15:30:18 -0500
Message-Id: <1394397023-7050-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
References: <1394397023-7050-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And change the function argument to be output stream.  Earlier the --help
made kill to exit with none zero value, that now is corrected.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index b95e03d..2fecda3 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -149,7 +149,7 @@ static int arg_to_signum(char *arg, int mask);
 static void nosig(char *name);
 static void printsig(int sig);
 static void printsignals(FILE *fp, int pretty);
-static int usage(int status);
+static void __attribute__((__noreturn__)) usage(FILE *out);
 static int kill_verbose(char *procname, int pid, int sig);
 
 #ifdef HAVE_SIGQUEUE
@@ -189,7 +189,7 @@ int main(int argc, char **argv)
 			return EXIT_SUCCESS;
 		}
 		if (!strcmp(arg, "-h") || !strcmp(arg, "--help"))
-			return usage(EXIT_FAILURE);
+			usage(stdout);
 
 		if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
 			check_all++;
@@ -201,7 +201,7 @@ int main(int argc, char **argv)
 				return EXIT_SUCCESS;
 			}
 			if (2 < argc)
-				return usage(EXIT_FAILURE);
+				usage(stderr);
 			/* argc == 2, accept "kill -l $?" */
 			arg = argv[1];
 			if ((numsig = arg_to_signum(arg, 1)) < 0)
@@ -225,15 +225,15 @@ int main(int argc, char **argv)
 		if (!strcmp(arg, "-p") || !strcmp(arg, "--pid")) {
 			do_pid++;
 			if (do_kill)
-				return usage(EXIT_FAILURE);
+				usage(stderr);
 			continue;
 		}
 		if (!strcmp(arg, "-s") || !strcmp(arg, "--signal")) {
 			if (argc < 2)
-				return usage(EXIT_FAILURE);
+				usage(stderr);
 			do_kill++;
 			if (do_pid)
-				return usage(EXIT_FAILURE);
+				usage(stderr);
 			argc--, argv++;
 			arg = *argv;
 			if ((numsig = arg_to_signum(arg, 0)) < 0) {
@@ -244,7 +244,7 @@ int main(int argc, char **argv)
 		}
 		if (!strcmp(arg, "-q") || !strcmp(arg, "--queue")) {
 			if (argc < 2)
-				return usage(EXIT_FAILURE);
+				usage(stderr);
 			argc--, argv++;
 			arg = *argv;
 #ifdef HAVE_SIGQUEUE
@@ -266,14 +266,14 @@ int main(int argc, char **argv)
 			break;
 		arg++;
 		if ((numsig = arg_to_signum(arg, 0)) < 0)
-			return usage(EXIT_FAILURE);
+			usage(stderr);
 		do_kill++;
 		if (do_pid)
-			return usage(EXIT_FAILURE);
+			usage(stderr);
 		continue;
 	}
 	if (!*argv)
-		return usage(EXIT_FAILURE);
+		usage(stderr);
 	if (do_pid)
 		numsig = -1;
 
@@ -441,10 +441,8 @@ static void printsignals(FILE *fp, int pretty)
 	fputc('\n', fp);
 }
 
-static int usage(int status)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
-	FILE *out = (status == 0 ? stdout : stderr);
-
 	fputs(USAGE_HEADER, out);
 	fprintf(out, _(" %s [options] <pid|name> [...]\n"), program_invocation_short_name);
 	fputs(USAGE_OPTIONS, out);
@@ -459,7 +457,7 @@ static int usage(int status)
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("kill(1)"));
-	return status;
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
 static int kill_verbose(char *procname, pid_t pid, int sig)
-- 
1.9.0

