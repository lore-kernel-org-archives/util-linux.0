Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:44338 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbBVOnJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:43:09 -0500
Received: by wesk11 with SMTP id k11so13553960wes.11
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:43:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>, Wolfgang Richter <wolf@cs.cmu.edu>,
        Ruediger Meier <ruediger.meier@ga-group.nl>
Subject: [PATCH 05/12] script: merge doinput() and output() functions to do_io()
Date: Sun, 22 Feb 2015 14:42:42 +0000
Message-Id: <1424616169-693-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
References: <1424616169-693-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

One item to poll() more is a lot less work for system than separete input
and output processes.

Addresses: https://github.com/karelzak/util-linux/pull/62
CC: Wolfgang Richter <wolf@cs.cmu.edu>
CC: Ruediger Meier <ruediger.meier@ga-group.nl>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 220 ++++++++++++----------------------------------------
 1 file changed, 51 insertions(+), 169 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 672c610..395b96a 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -82,7 +82,7 @@
 
 #define DEFAULT_OUTPUT "typescript"
 
-enum { POLLFDS = 2 };
+enum { POLLFDS = 3 };
 
 struct script_control {
 	char *shell;		/* shell to be executed */
@@ -93,7 +93,6 @@ struct script_control {
 	int master;		/* pseudoterminal master file descriptor */
 	int slave;		/* pseudoterminal slave file descriptor */
 	pid_t child;		/* child pid */
-	pid_t subchild;		/* subchild pid */
 	int childstatus;	/* child process exit value */
 	struct termios tt;	/* slave terminal runtime attributes */
 	struct winsize win;	/* terminal window size */
@@ -160,39 +159,15 @@ static void my_strftime(char *buf, size_t len, const char *fmt, const struct tm
 
 static void __attribute__((__noreturn__)) done(struct script_control *ctl)
 {
-	time_t tvec;
-
-	if (ctl->subchild) {
-		/* output process */
-		if (ctl->typescriptfp) {
-			if (!ctl->qflg) {
-				char buf[BUFSIZ];
-				tvec = time((time_t *)NULL);
-				my_strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
-				fprintf(ctl->typescriptfp, _("\nScript done on %s"), buf);
-			}
-			if (close_stream(ctl->typescriptfp) != 0)
-				errx(EXIT_FAILURE, _("write error"));
-			ctl->typescriptfp = NULL;
-		}
-		if (ctl->timingfp && close_stream(ctl->timingfp) != 0)
-			errx(EXIT_FAILURE, _("write error"));
-		ctl->timingfp = NULL;
-
-		close(ctl->master);
-		ctl->master = -1;
-	} else {
-		/* input process */
-		if (ctl->isterm)
-			tcsetattr(STDIN_FILENO, TCSADRAIN, &ctl->tt);
-		if (!ctl->qflg)
-			printf(_("Script done, file is %s\n"), ctl->fname);
+	if (ctl->isterm)
+		tcsetattr(STDIN_FILENO, TCSADRAIN, &ctl->tt);
+	if (!ctl->qflg)
+		printf(_("Script done, file is %s\n"), ctl->fname);
 #ifdef HAVE_LIBUTEMPTER
-		if (ctl->master >= 0)
-			utempter_remove_record(ctl->master);
+	if (ctl->master >= 0)
+		utempter_remove_record(ctl->master);
 #endif
-		kill(ctl->child, SIGTERM);	/* make sure we don't create orphans */
-	}
+	kill(ctl->child, SIGTERM);	/* make sure we don't create orphans */
 
 	if (ctl->eflg) {
 		if (WIFSIGNALED(ctl->childstatus))
@@ -209,15 +184,6 @@ static void fail(struct script_control *ctl)
 	done(ctl);
 }
 
-static void wait_for_empty_fd(struct script_control *ctl, int fd)
-{
-	struct pollfd fds[] = {
-		{.fd = fd, .events = POLLIN}
-	};
-
-	while (ctl->die == 0 && poll(fds, 1, 100) == 1) ;
-}
-
 static void finish(struct script_control *ctl, int wait)
 {
 	int status;
@@ -234,97 +200,6 @@ static void finish(struct script_control *ctl, int wait)
 	errno = errsv;
 }
 
-static void doinput(struct script_control *ctl)
-{
-	char ibuf[BUFSIZ];
-	struct pollfd pfd[POLLFDS];
-	int ret, i;
-	ssize_t bytes;
-
-	/* close things irrelevant for this process */
-	if (ctl->typescriptfp)
-		fclose(ctl->typescriptfp);
-	if (ctl->timingfp)
-		fclose(ctl->timingfp);
-	ctl->typescriptfp = ctl->timingfp = NULL;
-
-	pfd[0].fd = STDIN_FILENO;
-	pfd[0].events = POLLIN;
-	pfd[1].fd = ctl->sigfd;
-	pfd[1].events = POLLIN | POLLERR | POLLHUP;
-
-	while (!ctl->die) {
-		/* wait for input or signal */
-		ret = poll(pfd, POLLFDS, -1);
-		if (ret < 0) {
-			if (errno == EAGAIN)
-				continue;
-			warn(_("poll failed"));
-			fail(ctl);
-		}
-		for (i = 0; i < POLLFDS; i++) {
-			if (pfd[i].revents == 0)
-				continue;
-			if (i == 0 && (bytes = read(pfd[i].fd, ibuf, BUFSIZ)) > 0) {
-				if (write_all(ctl->master, ibuf, bytes)) {
-					warn(_("write failed"));
-					fail(ctl);
-				}
-			}
-			if (i == 1) {
-				struct signalfd_siginfo info;
-				ssize_t bytes;
-
-				bytes = read(pfd[i].fd, &info, sizeof(info));
-				assert(bytes == sizeof(info));
-				switch (info.ssi_signo) {
-				case SIGCHLD:
-					finish(ctl, 0);
-					break;
-				case SIGWINCH:
-					if (ctl->isterm) {
-						ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&ctl->win);
-						ioctl(ctl->slave, TIOCSWINSZ, (char *)&ctl->win);
-					}
-					break;
-				default:
-					abort();
-				}
-			}
-		}
-	}
-
-	/* To be sure that we don't miss any data */
-	wait_for_empty_fd(ctl, ctl->slave);
-	wait_for_empty_fd(ctl, ctl->master);
-
-	if (ctl->die == 0) {
-		/*
-		 * Forward EOF from stdin (detected by read() above) to slave
-		 * (shell) to correctly terminate the session. It seems we have
-		 * to wait for empty terminal FDs otherwise EOF maybe ignored
-		 * (why?) and typescript is incomplete.      -- kzak Dec-2013
-		 *
-		 * We usually use this when stdin is not a tty, for example:
-		 * echo "ps" | script
-		 */
-		int c = DEF_EOF;
-
-		if (write_all(ctl->master, &c, 1)) {
-			warn(_("write failed"));
-			fail(ctl);
-		}
-
-		/* wait for "exit" message from shell before we print "Script
-		 * done" in done() */
-		wait_for_empty_fd(ctl, ctl->master);
-	}
-
-	if (!ctl->die)
-		finish(ctl, 1);	/* wait for children */
-	done(ctl);
-}
-
 static void write_output(struct script_control *ctl, char *obuf,
 			    ssize_t bytes, double *oldtime)
 {
@@ -352,34 +227,31 @@ static void write_output(struct script_control *ctl, char *obuf,
 	}
 }
 
-
-static void dooutput(struct script_control *ctl)
+static void do_io(struct script_control *ctl)
 {
-	char obuf[BUFSIZ];
+	char buf[BUFSIZ];
 	struct pollfd pfd[POLLFDS];
 	int ret, i;
 	ssize_t bytes;
 	double oldtime = time(NULL);
 
-	close(STDIN_FILENO);
-#ifdef HAVE_LIBUTIL
-	close(ctl->slave);
-#endif
 	if (ctl->tflg && !ctl->timingfp)
 		ctl->timingfp = fdopen(STDERR_FILENO, "w");
 
+	pfd[0].fd = STDIN_FILENO;
+	pfd[0].events = POLLIN;
+	pfd[1].fd = ctl->master;
+	pfd[1].events = POLLIN;
+	pfd[2].fd = ctl->sigfd;
+	pfd[2].events = POLLIN | POLLERR | POLLHUP;
+
 	if (!ctl->qflg) {
 		time_t tvec = time((time_t *)NULL);
-		my_strftime(obuf, sizeof obuf, "%c\n", localtime(&tvec));
-		fprintf(ctl->typescriptfp, _("Script started on %s"), obuf);
+		my_strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
+		fprintf(ctl->typescriptfp, _("Script started on %s"), buf);
 	}
 
-	pfd[0].fd = ctl->master;
-	pfd[0].events = POLLIN;
-	pfd[1].fd = ctl->sigfd;
-	pfd[1].events = POLLIN | POLLERR | POLLHUP;
-
-	while (1) {
+	while (!ctl->die) {
 		/* wait for input or signal */
 		ret = poll(pfd, POLLFDS, -1);
 		if (ret < 0) {
@@ -391,17 +263,33 @@ static void dooutput(struct script_control *ctl)
 		for (i = 0; i < POLLFDS; i++) {
 			if (pfd[i].revents == 0)
 				continue;
-			if (i == 0) {
-				bytes = read(pfd[i].fd, obuf, BUFSIZ);
+			if (i < 2) {
+				bytes = read(pfd[i].fd, buf, BUFSIZ);
 				if (bytes < 0) {
 					if (errno == EAGAIN)
 						continue;
 					fail(ctl);
 				}
-				write_output(ctl, obuf, bytes, &oldtime);
+				if (i == 0) {
+					if (write_all(ctl->master, buf, bytes)) {
+						warn(_("write failed"));
+						fail(ctl);
+					} else
+
+						/* without sync write_output()
+						 * will write both input &
+						 * shell output that looks like
+						 * double echoing */
+						fdatasync(ctl->master);
+					if (!ctl->isterm && !feof(stdin)) {
+						int c = DEF_EOF;
+						write_all(ctl->master, &c, 1);
+					}
+				} else
+					write_output(ctl, buf, bytes, &oldtime);
 				continue;
 			}
-			if (i == 1) {
+			if (i == 2) {
 				struct signalfd_siginfo info;
 				ssize_t bytes;
 
@@ -409,10 +297,13 @@ static void dooutput(struct script_control *ctl)
 				assert(bytes == sizeof(info));
 				switch (info.ssi_signo) {
 				case SIGCHLD:
-					done(ctl);
+					finish(ctl, 0);
 					break;
 				case SIGWINCH:
-					/* nothing */
+					if (ctl->isterm) {
+						ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&ctl->win);
+						ioctl(ctl->slave, TIOCSWINSZ, (char *)&ctl->win);
+					}
 					break;
 				default:
 					abort();
@@ -420,7 +311,9 @@ static void dooutput(struct script_control *ctl)
 			}
 		}
 	}
-	abort();
+	if (!ctl->die)
+		finish(ctl, 1); /* wait for children */
+	done(ctl);
 }
 
 static void getslave(struct script_control *ctl)
@@ -684,20 +577,9 @@ int main(int argc, char **argv)
 		warn(_("fork failed"));
 		fail(&ctl);
 	}
-	if (ctl.child == 0) {
-
-		ctl.subchild = ctl.child = fork();
-
-		if (ctl.child < 0) {
-			warn(_("fork failed"));
-			fail(&ctl);
-		}
-		if (ctl.child)
-			dooutput(&ctl);
-		else
-			doshell(&ctl);
-	}
-	doinput(&ctl);
+	if (ctl.child == 0)
+		doshell(&ctl);
+	do_io(&ctl);
 
 	return EXIT_SUCCESS;
 }
-- 
2.3.0

