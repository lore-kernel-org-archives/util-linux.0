Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33357 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbcGCVYL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:11 -0400
Received: by mail-wm0-f65.google.com with SMTP id r201so17540006wme.0
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/15] write: run atexit() checks at the end of execution
Date: Sun,  3 Jul 2016 22:23:49 +0100
Message-Id: <20160703212358.1218-7-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier use of _exit() caused program to terminate abnormally from atexit()
perspective and standard file descriptor close checks did not run resulting
to blindness if writes were successful, or not.  Easy fix is to avoid
running _exit() altogether.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 29 +++++++++++++++++------------
 1 file changed, 17 insertions(+), 12 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 11a6580..568892d 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -66,6 +66,8 @@
 #include "strutils.h"
 #include "xalloc.h"
 
+static sig_atomic_t signal_received = 0;
+
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
@@ -205,13 +207,11 @@ static void search_utmp(char *user, char *tty, char *mytty, uid_t myuid)
 }
 
 /*
- * done - cleanup and exit
+ * signal_handler - cause write loop to exit
  */
-static void __attribute__ ((__noreturn__))
-    done(int dummy __attribute__ ((__unused__)))
+static void signal_handler(int signo)
 {
-	printf("EOF\r\n");
-	_exit(EXIT_SUCCESS);
+	signal_received = signo;
 }
 
 /*
@@ -243,6 +243,7 @@ static void do_write(char *tty, char *mytty, uid_t myuid)
 	struct passwd *pwd;
 	time_t now;
 	char path[PATH_MAX], *host, line[512];
+	struct sigaction sigact;
 
 	/* Determine our login name(s) before the we reopen() stdout */
 	if ((pwd = getpwuid(myuid)) != NULL)
@@ -258,8 +259,11 @@ static void do_write(char *tty, char *mytty, uid_t myuid)
 	if ((freopen(path, "w", stdout)) == NULL)
 		err(EXIT_FAILURE, "%s", path);
 
-	signal(SIGINT, done);
-	signal(SIGHUP, done);
+	sigact.sa_handler = signal_handler;
+	sigemptyset(&sigact.sa_mask);
+	sigact.sa_flags = 0;
+	sigaction(SIGINT, &sigact, NULL);
+	sigaction(SIGHUP, &sigact, NULL);
 
 	/* print greeting */
 	host = xgethostname();
@@ -279,8 +283,12 @@ static void do_write(char *tty, char *mytty, uid_t myuid)
 	free(host);
 	printf("\r\n");
 
-	while (fgets(line, sizeof(line), stdin) != NULL)
+	while (fgets(line, sizeof(line), stdin) != NULL) {
+		if (signal_received)
+			break;
 		wr_fputs(line);
+	}
+	printf("EOF\r\n");
 }
 
 int main(int argc, char **argv)
@@ -368,8 +376,5 @@ int main(int argc, char **argv)
 	default:
 		usage(stderr);
 	}
-
-	done(0);
-	/* NOTREACHED */
-	return EXIT_FAILURE;
+	return EXIT_SUCCESS;
 }
-- 
2.9.0

