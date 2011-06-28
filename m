Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:61159 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756251Ab1F1Kne (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Jun 2011 06:43:34 -0400
Received: by eyx24 with SMTP id 24so13123eyx.19
        for <util-linux@vger.kernel.org>; Tue, 28 Jun 2011 03:43:33 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/4] script: remove unnecessary void casting
Date: Tue, 28 Jun 2011 12:43:24 +0200
Message-Id: <1309257806-1418-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1309257806-1418-1-git-send-email-kerolasa@iki.fi>
References: <1309257806-1418-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c |   56 +++++++++++++++++++++++++-------------------------
 1 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 1753849..601a91d 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -289,7 +289,7 @@ doinput() {
 	register int cc;
 	char ibuf[BUFSIZ];
 
-	(void) fclose(fscript);
+	fclose(fscript);
 
 	while (die == 0) {
 		if ((cc = read(0, ibuf, BUFSIZ)) > 0) {
@@ -326,8 +326,8 @@ void
 resize(int dummy __attribute__ ((__unused__))) {
 	resized = 1;
 	/* transmit window change information to the child */
-	(void) ioctl(0, TIOCGWINSZ, (char *)&win);
-	(void) ioctl(slave, TIOCSWINSZ, (char *)&win);
+	ioctl(0, TIOCGWINSZ, (char *)&win);
+	ioctl(slave, TIOCSWINSZ, (char *)&win);
 }
 
 /*
@@ -350,9 +350,9 @@ dooutput(FILE *timingfd) {
 	ssize_t wrt;
 	ssize_t fwrt;
 
-	(void) close(0);
+	close(0);
 #ifdef HAVE_LIBUTIL
-	(void) close(slave);
+	close(slave);
 #endif
 	tvec = time((time_t *)NULL);
 	my_strftime(obuf, sizeof obuf, "%c\n", localtime(&tvec));
@@ -396,7 +396,7 @@ dooutput(FILE *timingfd) {
 			fail();
 		}
 		if (fflg)
-			(void) fflush(fscript);
+			fflush(fscript);
 	} while(1);
 
 	if (flgs)
@@ -413,18 +413,18 @@ doshell() {
 
 	t = open(_PATH_DEV_TTY, O_RDWR);
 	if (t >= 0) {
-		(void) ioctl(t, TIOCNOTTY, (char *)0);
-		(void) close(t);
+		ioctl(t, TIOCNOTTY, (char *)0);
+		close(t);
 	}
 #endif
 
 	getslave();
-	(void) close(master);
-	(void) fclose(fscript);
-	(void) dup2(slave, 0);
-	(void) dup2(slave, 1);
-	(void) dup2(slave, 2);
-	(void) close(slave);
+	close(master);
+	fclose(fscript);
+	dup2(slave, 0);
+	dup2(slave, 1);
+	dup2(slave, 2);
+	close(slave);
 
 	master = -1;
 
@@ -450,13 +450,13 @@ fixtty() {
 	rtt = tt;
 	cfmakeraw(&rtt);
 	rtt.c_lflag &= ~ECHO;
-	(void) tcsetattr(0, TCSANOW, &rtt);
+	tcsetattr(0, TCSANOW, &rtt);
 }
 
 void
 fail() {
 
-	(void) kill(0, SIGTERM);
+	kill(0, SIGTERM);
 	done();
 }
 
@@ -471,12 +471,12 @@ done() {
 			my_strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
 			fprintf(fscript, _("\nScript done on %s"), buf);
 		}
-		(void) fclose(fscript);
-		(void) close(master);
+		fclose(fscript);
+		close(master);
 
 		master = -1;
 	} else {
-		(void) tcsetattr(0, TCSADRAIN, &tt);
+		tcsetattr(0, TCSADRAIN, &tt);
 		if (!qflg)
 			printf(_("Script done, file is %s\n"), fname);
 #ifdef HAVE_LIBUTEMPTER
@@ -497,8 +497,8 @@ done() {
 void
 getmaster() {
 #if HAVE_LIBUTIL && HAVE_PTY_H
-	(void) tcgetattr(0, &tt);
-	(void) ioctl(0, TIOCGWINSZ, (char *)&win);
+	tcgetattr(0, &tt);
+	ioctl(0, TIOCGWINSZ, (char *)&win);
 	if (openpty(&master, &slave, NULL, &tt, &win) < 0) {
 		warn(_("openpty failed"));
 		fail();
@@ -525,12 +525,12 @@ getmaster() {
 				ok = access(line, R_OK|W_OK) == 0;
 				*tp = 'p';
 				if (ok) {
-					(void) tcgetattr(0, &tt);
-				    	(void) ioctl(0, TIOCGWINSZ, 
+					tcgetattr(0, &tt);
+					ioctl(0, TIOCGWINSZ,
 						(char *)&win);
 					return;
 				}
-				(void) close(master);
+				close(master);
 				master = -1;
 			}
 		}
@@ -550,9 +550,9 @@ getslave() {
 		warn(_("open failed: %s"), line);
 		fail();
 	}
-	(void) tcsetattr(slave, TCSANOW, &tt);
-	(void) ioctl(slave, TIOCSWINSZ, (char *)&win);
+	tcsetattr(slave, TCSANOW, &tt);
+	ioctl(slave, TIOCSWINSZ, (char *)&win);
 #endif
-	(void) setsid();
-	(void) ioctl(slave, TIOCSCTTY, 0);
+	setsid();
+	ioctl(slave, TIOCSCTTY, 0);
 }
-- 
1.7.5.2

