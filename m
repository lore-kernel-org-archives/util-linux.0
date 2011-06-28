Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:55070 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756864Ab1F1Knj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jun 2011 06:43:39 -0400
Received: by eyx24 with SMTP id 24so13130eyx.19
        for <util-linux@vger.kernel.org>; Tue, 28 Jun 2011 03:43:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/4] script: remove magic constants and a type mismatch fix
Date: Tue, 28 Jun 2011 12:43:26 +0200
Message-Id: <1309257806-1418-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1309257806-1418-1-git-send-email-kerolasa@iki.fi>
References: <1309257806-1418-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The type mismatch; doinput: int -> ssize_t

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c |   68 ++++++++++++++++++++++++++------------------------
 1 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 39bc5ef..fccc0c4 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -71,6 +71,8 @@
 #include <utempter.h>
 #endif
 
+#define DEFAULT_OUTPUT "typescript"
+
 void finish(int);
 void done(void);
 void fail(void);
@@ -164,16 +166,16 @@ main(int argc, char **argv) {
 	enum { FORCE_OPTION = CHAR_MAX + 1 };
 
 	static const struct option longopts[] = {
-		{ "append",	no_argument,	   0, 'a' },
-		{ "command",	required_argument, 0, 'c' },
-		{ "return",	no_argument,	   0, 'e' },
-		{ "flush",	no_argument,	   0, 'f' },
-		{ "force",	no_argument,	   0, FORCE_OPTION, },
-		{ "quiet",	no_argument,	   0, 'q' },
-		{ "timing",	optional_argument, 0, 't' },
-		{ "version",	no_argument,	   0, 'V' },
-		{ "help",	no_argument,	   0, 'h' },
-		{ NULL,		0, 0, 0 }
+		{ "append",	no_argument,	   NULL, 'a' },
+		{ "command",	required_argument, NULL, 'c' },
+		{ "return",	no_argument,	   NULL, 'e' },
+		{ "flush",	no_argument,	   NULL, 'f' },
+		{ "force",	no_argument,	   NULL, FORCE_OPTION, },
+		{ "quiet",	no_argument,	   NULL, 'q' },
+		{ "timing",	optional_argument, NULL, 't' },
+		{ "version",	no_argument,	   NULL, 'V' },
+		{ "help",	no_argument,	   NULL, 'h' },
+		{ NULL,		0, NULL, 0 }
 	};
 
 	setlocale(LC_ALL, "");
@@ -184,28 +186,28 @@ main(int argc, char **argv) {
 	while ((ch = getopt_long(argc, argv, "ac:efqt::Vh", longopts, NULL)) != -1)
 		switch(ch) {
 		case 'a':
-			aflg++;
+			aflg = 1;
 			break;
 		case 'c':
 			cflg = optarg;
 			break;
 		case 'e':
-			eflg++;
+			eflg = 1;
 			break;
 		case 'f':
-			fflg++;
+			fflg = 1;
 			break;
 		case FORCE_OPTION:
 			forceflg = 1;
 			break;
 		case 'q':
-			qflg++;
+			qflg = 1;
 			break;
 		case 't':
 			if (optarg)
 				if ((timingfd = fopen(optarg, "w")) == NULL)
 					err(EXIT_FAILURE, _("cannot open timing file %s"), optarg);
-			tflg++;
+			tflg = 1;
 			break;
 		case 'V':
 			printf(_("%s from %s\n"), program_invocation_short_name,
@@ -225,7 +227,7 @@ main(int argc, char **argv) {
 	if (argc > 0)
 		fname = argv[0];
 	else {
-		fname = "typescript";
+		fname = DEFAULT_OUTPUT;
 		die_if_link(fname);
 	}
 	if ((fscript = fopen(fname, aflg ? "a" : "w")) == NULL) {
@@ -289,20 +291,20 @@ main(int argc, char **argv) {
 
 void
 doinput() {
-	register int cc;
+	register ssize_t cc;
 	char ibuf[BUFSIZ];
 
 	fclose(fscript);
 
 	while (die == 0) {
-		if ((cc = read(0, ibuf, BUFSIZ)) > 0) {
+		if ((cc = read(STDIN_FILENO, ibuf, BUFSIZ)) > 0) {
 			ssize_t wrt = write(master, ibuf, cc);
-			if (wrt == -1) {
+			if (wrt < 0) {
 				warn (_("write failed"));
 				fail();
 			}
 		}
-		else if (cc == -1 && errno == EINTR && resized)
+		else if (cc < 0 && errno == EINTR && resized)
 			resized = 0;
 		else
 			break;
@@ -329,7 +331,7 @@ void
 resize(int dummy __attribute__ ((__unused__))) {
 	resized = 1;
 	/* transmit window change information to the child */
-	ioctl(0, TIOCGWINSZ, (char *)&win);
+	ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&win);
 	ioctl(slave, TIOCSWINSZ, (char *)&win);
 }
 
@@ -353,7 +355,7 @@ dooutput(FILE *timingfd) {
 	ssize_t wrt;
 	ssize_t fwrt;
 
-	close(0);
+	close(STDIN_FILENO);
 #ifdef HAVE_LIBUTIL
 	close(slave);
 #endif
@@ -388,7 +390,7 @@ dooutput(FILE *timingfd) {
 			fprintf(timingfd, "%f %zd\n", newtime - oldtime, cc);
 			oldtime = newtime;
 		}
-		wrt = write(1, obuf, cc);
+		wrt = write(STDOUT_FILENO, obuf, cc);
 		if (wrt < 0) {
 			warn (_("write failed"));
 			fail();
@@ -424,9 +426,9 @@ doshell() {
 	getslave();
 	close(master);
 	fclose(fscript);
-	dup2(slave, 0);
-	dup2(slave, 1);
-	dup2(slave, 2);
+	dup2(slave, STDIN_FILENO);
+	dup2(slave, STDOUT_FILENO);
+	dup2(slave, STDERR_FILENO);
 	close(slave);
 
 	master = -1;
@@ -453,13 +455,13 @@ fixtty() {
 	rtt = tt;
 	cfmakeraw(&rtt);
 	rtt.c_lflag &= ~ECHO;
-	tcsetattr(0, TCSANOW, &rtt);
+	tcsetattr(STDIN_FILENO, TCSANOW, &rtt);
 }
 
 void
 fail() {
 
-	kill(0, SIGTERM);
+	kill(getpid(), SIGTERM);
 	done();
 }
 
@@ -479,7 +481,7 @@ done() {
 
 		master = -1;
 	} else {
-		tcsetattr(0, TCSADRAIN, &tt);
+		tcsetattr(STDIN_FILENO, TCSADRAIN, &tt);
 		if (!qflg)
 			printf(_("Script done, file is %s\n"), fname);
 #ifdef HAVE_LIBUTEMPTER
@@ -500,8 +502,8 @@ done() {
 void
 getmaster() {
 #if HAVE_LIBUTIL && HAVE_PTY_H
-	tcgetattr(0, &tt);
-	ioctl(0, TIOCGWINSZ, (char *)&win);
+	tcgetattr(STDIN_FILENO, &tt);
+	ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&win);
 	if (openpty(&master, &slave, NULL, &tt, &win) < 0) {
 		warn(_("openpty failed"));
 		fail();
@@ -528,8 +530,8 @@ getmaster() {
 				ok = access(line, R_OK|W_OK) == 0;
 				*tp = 'p';
 				if (ok) {
-					tcgetattr(0, &tt);
-					ioctl(0, TIOCGWINSZ,
+					tcgetattr(STDIN_FILENO, &tt);
+					ioctl(STDIN_FILENO, TIOCGWINSZ,
 						(char *)&win);
 					return;
 				}
-- 
1.7.5.2

