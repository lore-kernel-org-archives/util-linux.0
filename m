Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:38624 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752143AbbBVOnI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:08 -0500
Received: by wesw55 with SMTP id w55so13582447wes.5
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>, Wolfgang Richter <wolf@cs.cmu.edu>,
        Ruediger Meier <ruediger.meier@ga-group.nl>
Subject: [PATCH 04/12] script: use poll() rather than select()
Date: Sun, 22 Feb 2015 14:42:41 +0000
Message-Id: <1424616169-693-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Finalize the signalfd() change by adding file descriptors to poll() loop.

Addresses: https://github.com/karelzak/util-linux/pull/62
CC: Wolfgang Richter <wolf@cs.cmu.edu>
CC: Ruediger Meier <ruediger.meier@ga-group.nl>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 202 +++++++++++++++++++++++++++++-----------------------
 1 file changed, 114 insertions(+), 88 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 0f27163..672c610 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -82,6 +82,8 @@
 
 #define DEFAULT_OUTPUT "typescript"
 
+enum { POLLFDS = 2 };
+
 struct script_control {
 	char *shell;		/* shell to be executed */
 	char *cflg;		/* command to be executed */
@@ -106,12 +108,10 @@ struct script_control {
 	 tflg:1,		/* include timing file */
 	 forceflg:1,		/* write output to links */
 	 isterm:1,		/* is child process running as terminal */
-	 resized:1,		/* has terminal been resized */
 	 die:1;			/* terminate program */
 	sigset_t sigset;	/* catch SIGCHLD and SIGWINCH with signalfd() */
 	int sigfd;		/* file descriptor for signalfd() */
 };
-struct script_control *gctl;	/* global control structure, used in signal handlers */
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
@@ -236,10 +236,10 @@ static void finish(struct script_control *ctl, int wait)
 
 static void doinput(struct script_control *ctl)
 {
-	int errsv = 0;
-	ssize_t cc = 0;
 	char ibuf[BUFSIZ];
-	fd_set readfds;
+	struct pollfd pfd[POLLFDS];
+	int ret, i;
+	ssize_t bytes;
 
 	/* close things irrelevant for this process */
 	if (ctl->typescriptfp)
@@ -248,35 +248,49 @@ static void doinput(struct script_control *ctl)
 		fclose(ctl->timingfp);
 	ctl->typescriptfp = ctl->timingfp = NULL;
 
-	FD_ZERO(&readfds);
+	pfd[0].fd = STDIN_FILENO;
+	pfd[0].events = POLLIN;
+	pfd[1].fd = ctl->sigfd;
+	pfd[1].events = POLLIN | POLLERR | POLLHUP;
 
 	while (!ctl->die) {
-		FD_SET(STDIN_FILENO, &readfds);
-
-		errno = 0;
-		/* wait for input or signal (including SIGCHLD) */
-		if ((cc = pselect(STDIN_FILENO + 1, &readfds, NULL, NULL, NULL,
-				  NULL)) > 0) {
-
-			if ((cc = read(STDIN_FILENO, ibuf, BUFSIZ)) > 0) {
-				if (write_all(ctl->master, ibuf, cc)) {
+		/* wait for input or signal */
+		ret = poll(pfd, POLLFDS, -1);
+		if (ret < 0) {
+			if (errno == EAGAIN)
+				continue;
+			warn(_("poll failed"));
+			fail(ctl);
+		}
+		for (i = 0; i < POLLFDS; i++) {
+			if (pfd[i].revents == 0)
+				continue;
+			if (i == 0 && (bytes = read(pfd[i].fd, ibuf, BUFSIZ)) > 0) {
+				if (write_all(ctl->master, ibuf, bytes)) {
 					warn(_("write failed"));
 					fail(ctl);
 				}
 			}
-		}
-
-		if (cc < 0 && errno == EINTR && ctl->resized) {
-			/* transmit window change information to the child */
-			if (ctl->isterm) {
-				ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&ctl->win);
-				ioctl(ctl->slave, TIOCSWINSZ, (char *)&ctl->win);
+			if (i == 1) {
+				struct signalfd_siginfo info;
+				ssize_t bytes;
+
+				bytes = read(pfd[i].fd, &info, sizeof(info));
+				assert(bytes == sizeof(info));
+				switch (info.ssi_signo) {
+				case SIGCHLD:
+					finish(ctl, 0);
+					break;
+				case SIGWINCH:
+					if (ctl->isterm) {
+						ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&ctl->win);
+						ioctl(ctl->slave, TIOCSWINSZ, (char *)&ctl->win);
+					}
+					break;
+				default:
+					abort();
+				}
 			}
-			ctl->resized = 0;
-
-		} else if (cc <= 0 && errno != EINTR) {
-			errsv = errno;
-			break;
 		}
 	}
 
@@ -284,7 +298,7 @@ static void doinput(struct script_control *ctl)
 	wait_for_empty_fd(ctl, ctl->slave);
 	wait_for_empty_fd(ctl, ctl->master);
 
-	if (ctl->die == 0 && cc == 0 && errsv == 0) {
+	if (ctl->die == 0) {
 		/*
 		 * Forward EOF from stdin (detected by read() above) to slave
 		 * (shell) to correctly terminate the session. It seems we have
@@ -311,24 +325,41 @@ static void doinput(struct script_control *ctl)
 	done(ctl);
 }
 
-static void sig_finish(int dummy __attribute__((__unused__)))
+static void write_output(struct script_control *ctl, char *obuf,
+			    ssize_t bytes, double *oldtime)
 {
-	finish(gctl, 0);
-}
 
-static void resize(int dummy __attribute__((__unused__)))
-{
-	gctl->resized = 1;
+	if (ctl->tflg && ctl->timingfp) {
+		struct timeval tv;
+		double newtime;
+
+		gettimeofday(&tv, NULL);
+		newtime = tv.tv_sec + (double)tv.tv_usec / 1000000;
+		fprintf(ctl->timingfp, "%f %zd\n", newtime - *oldtime, bytes);
+		if (ctl->fflg)
+			fflush(ctl->timingfp);
+		*oldtime = newtime;
+	}
+	if (fwrite_all(obuf, 1, bytes, ctl->typescriptfp)) {
+		warn(_("cannot write script file"));
+		fail(ctl);
+	}
+	if (ctl->fflg)
+		fflush(ctl->typescriptfp);
+	if (write_all(STDOUT_FILENO, obuf, bytes)) {
+		warn(_("write failed"));
+		fail(ctl);
+	}
 }
 
+
 static void dooutput(struct script_control *ctl)
 {
-	ssize_t cc;
 	char obuf[BUFSIZ];
-	struct timeval tv;
-	double oldtime = time(NULL), newtime;
-	int errsv = 0;
-	fd_set readfds;
+	struct pollfd pfd[POLLFDS];
+	int ret, i;
+	ssize_t bytes;
+	double oldtime = time(NULL);
 
 	close(STDIN_FILENO);
 #ifdef HAVE_LIBUTIL
@@ -343,57 +374,53 @@ static void dooutput(struct script_control *ctl)
 		fprintf(ctl->typescriptfp, _("Script started on %s"), obuf);
 	}
 
-	FD_ZERO(&readfds);
-
-	do {
-		if (ctl->die || errsv == EINTR) {
-			struct pollfd fds[] = {
-				{.fd = ctl->sigfd, .events = POLLIN | POLLERR | POLLHUP},
-				{.fd = ctl->master, .events = POLLIN}
-			};
-			if (poll(fds, 1, 50) <= 0)
-				break;
-		}
-
-		FD_SET(ctl->master, &readfds);
-		errno = 0;
-
-		/* wait for input or signal (including SIGCHLD) */
-		if ((cc = pselect(ctl->master + 1, &readfds, NULL, NULL, NULL,
-				  NULL)) > 0) {
-
-			cc = read(ctl->master, obuf, sizeof(obuf));
-		}
-		errsv = errno;
-
-		if (ctl->tflg)
-			gettimeofday(&tv, NULL);
-
-		if (errsv == EINTR && cc <= 0)
-			continue;	/* try it again */
-		if (cc <= 0)
-			break;
-		if (ctl->tflg && ctl->timingfp) {
-			newtime = tv.tv_sec + (double)tv.tv_usec / 1000000;
-			fprintf(ctl->timingfp, "%f %zd\n", newtime - oldtime, cc);
-			oldtime = newtime;
-		}
-		if (fwrite_all(obuf, 1, cc, ctl->typescriptfp)) {
-			warn(_("cannot write script file"));
+	pfd[0].fd = ctl->master;
+	pfd[0].events = POLLIN;
+	pfd[1].fd = ctl->sigfd;
+	pfd[1].events = POLLIN | POLLERR | POLLHUP;
+
+	while (1) {
+		/* wait for input or signal */
+		ret = poll(pfd, POLLFDS, -1);
+		if (ret < 0) {
+			if (errno == EAGAIN)
+				continue;
+			warn(_("poll failed"));
 			fail(ctl);
 		}
-		if (ctl->fflg) {
-			fflush(ctl->typescriptfp);
-			if (ctl->tflg && ctl->timingfp)
-				fflush(ctl->timingfp);
-		}
-		if (write_all(STDOUT_FILENO, obuf, cc)) {
-			warn(_("write failed"));
-			fail(ctl);
+		for (i = 0; i < POLLFDS; i++) {
+			if (pfd[i].revents == 0)
+				continue;
+			if (i == 0) {
+				bytes = read(pfd[i].fd, obuf, BUFSIZ);
+				if (bytes < 0) {
+					if (errno == EAGAIN)
+						continue;
+					fail(ctl);
+				}
+				write_output(ctl, obuf, bytes, &oldtime);
+				continue;
+			}
+			if (i == 1) {
+				struct signalfd_siginfo info;
+				ssize_t bytes;
+
+				bytes = read(pfd[i].fd, &info, sizeof(info));
+				assert(bytes == sizeof(info));
+				switch (info.ssi_signo) {
+				case SIGCHLD:
+					done(ctl);
+					break;
+				case SIGWINCH:
+					/* nothing */
+					break;
+				default:
+					abort();
+				}
+			}
 		}
-	} while (1);
-
-	done(ctl);
+	}
+	abort();
 }
 
 static void getslave(struct script_control *ctl)
@@ -578,7 +605,6 @@ int main(int argc, char **argv)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
-	gctl = &ctl;
 
 	while ((ch = getopt_long(argc, argv, "ac:efqt::Vh", longopts, NULL)) != -1)
 		switch (ch) {
-- 
2.3.0

