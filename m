Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:39473 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754585AbaLVLrn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:43 -0500
Received: by mail-wg0-f41.google.com with SMTP id y19so6472575wgg.28
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:42 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 14/14] script: add struct script_control and remove global variables
Date: Mon, 22 Dec 2014 11:47:17 +0000
Message-Id: <1419248837-4619-15-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix also couple indentation issues.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/script.c | 489 ++++++++++++++++++++++++++--------------------------
 1 file changed, 247 insertions(+), 242 deletions(-)

diff --git a/term-utils/script.c b/term-utils/script.c
index 0eaa73f..99c7fc8 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -12,8 +12,8 @@
  *    documentation and/or other materials provided with the distribution.
  * 3. All advertising materials mentioning features or use of this software
  *    must display the following acknowledgement:
- *	This product includes software developed by the University of
- *	California, Berkeley and its contributors.
+ *      This product includes software developed by the University of
+ *      California, Berkeley and its contributors.
  * 4. Neither the name of the University nor the names of its contributors
  *    may be used to endorse or promote products derived from this software
  *    without specific prior written permission.
@@ -80,42 +80,41 @@
 
 #define DEFAULT_OUTPUT "typescript"
 
-char	*shell;
-FILE	*fscript;
-FILE	*timingfd;
-int	master = -1;
-int	slave;
-pid_t	child;
-pid_t	subchild;
-int	childstatus;
-char	*fname;
-
-struct	termios tt;
-struct	winsize win;
-int	lb;
-int	l;
+struct script_control {
+	char *shell;		/* shell to be executed */
+	char *cflg;		/* command to be executed */
+	char *fname;		/* output file path */
+	FILE *typescriptfp;	/* output file pointer */
+	FILE *timingfp;		/* timing file pointer */
+	int master;		/* pseudoterminal master file descriptor */
+	int slave;		/* pseudoterminal slave file descriptor */
+	pid_t child;		/* child pid */
+	pid_t subchild;		/* subchild pid */
+	int childstatus;	/* child process exit value */
+	struct termios tt;	/* slave terminal runtime attributes */
+	struct winsize win;	/* terminal window size */
 #if !HAVE_LIBUTIL || !HAVE_PTY_H
-char	line[] = "/dev/ptyXX";
+	char line *;		/* terminal line */
 #endif
-int	aflg = 0;
-char	*cflg = NULL;
-int	eflg = 0;
-int	fflg = 0;
-int	qflg = 0;
-int	tflg = 0;
-int	forceflg = 0;
-int	isterm;
-
-sigset_t block_mask, unblock_mask;
-
-int die;
-int resized;
+	unsigned int
+	 aflg:1,		/* append output */
+	 eflg:1,		/* return child exit value */
+	 fflg:1,		/* flush after each write */
+	 qflg:1,		/* suppress most output */
+	 tflg:1,		/* include timing file */
+	 forceflg:1,		/* write output to links */
+	 isterm:1,		/* is child process running as terminal */
+	 resized:1,		/* has terminal been resized */
+	 die:1;			/* terminate program */
+	sigset_t block_mask;	/* signals that are blocked */
+	sigset_t unblock_mask;	/* original signal mask */
+};
+struct script_control *gctl;	/* global control structure, used in signal handlers */
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
-	fprintf(out,
-	      _(" %s [options] [file]\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] [file]\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --append            append the output\n"
@@ -132,17 +131,17 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static void die_if_link(char *fn)
+static void die_if_link(const struct script_control *ctl)
 {
 	struct stat s;
 
-	if (forceflg)
+	if (ctl->forceflg)
 		return;
-	if (lstat(fn, &s) == 0 && (S_ISLNK(s.st_mode) || s.st_nlink > 1))
+	if (lstat(ctl->fname, &s) == 0 && (S_ISLNK(s.st_mode) || s.st_nlink > 1))
 		errx(EXIT_FAILURE,
 		     _("output file `%s' is a link\n"
 		       "Use --force if you really want to use it.\n"
-		       "Program not started."), fn);
+		       "Program not started."), ctl->fname);
 }
 
 /*
@@ -154,69 +153,67 @@ static void my_strftime(char *buf, size_t len, const char *fmt, const struct tm
 	strftime(buf, len, fmt, tm);
 }
 
-static void __attribute__((__noreturn__)) done(void)
+static void __attribute__((__noreturn__)) done(struct script_control *ctl)
 {
 	time_t tvec;
 
-	if (subchild) {
+	if (ctl->subchild) {
 		/* output process */
-		if (fscript) {
-			if (!qflg) {
+		if (ctl->typescriptfp) {
+			if (!ctl->qflg) {
 				char buf[BUFSIZ];
 				tvec = time((time_t *)NULL);
 				my_strftime(buf, sizeof buf, "%c\n", localtime(&tvec));
-				fprintf(fscript, _("\nScript done on %s"), buf);
+				fprintf(ctl->typescriptfp, _("\nScript done on %s"), buf);
 			}
-			if (close_stream(fscript) != 0)
+			if (close_stream(ctl->typescriptfp) != 0)
 				errx(EXIT_FAILURE, _("write error"));
-			fscript = NULL;
+			ctl->typescriptfp = NULL;
 		}
-		if (timingfd && close_stream(timingfd) != 0)
+		if (ctl->timingfp && close_stream(ctl->timingfp) != 0)
 			errx(EXIT_FAILURE, _("write error"));
-		timingfd = NULL;
+		ctl->timingfp = NULL;
 
-		close(master);
-		master = -1;
+		close(ctl->master);
+		ctl->master = -1;
 	} else {
 		/* input process */
-		if (isterm)
-			tcsetattr(STDIN_FILENO, TCSADRAIN, &tt);
-		if (!qflg)
-			printf(_("Script done, file is %s\n"), fname);
+		if (ctl->isterm)
+			tcsetattr(STDIN_FILENO, TCSADRAIN, &ctl->tt);
+		if (!ctl->qflg)
+			printf(_("Script done, file is %s\n"), ctl->fname);
 #ifdef HAVE_LIBUTEMPTER
-		if (master >= 0)
-			utempter_remove_record(master);
+		if (ctl->master >= 0)
+			utempter_remove_record(ctl->master);
 #endif
-		kill(child, SIGTERM);	/* make sure we don't create orphans */
+		kill(ctl->child, SIGTERM);	/* make sure we don't create orphans */
 	}
 
-	if(eflg) {
-		if (WIFSIGNALED(childstatus))
-			exit(WTERMSIG(childstatus) + 0x80);
+	if (ctl->eflg) {
+		if (WIFSIGNALED(ctl->childstatus))
+			exit(WTERMSIG(ctl->childstatus) + 0x80);
 		else
-			exit(WEXITSTATUS(childstatus));
+			exit(WEXITSTATUS(ctl->childstatus));
 	}
 	exit(EXIT_SUCCESS);
 }
 
-static void
-fail(void) {
-
+static void fail(struct script_control *ctl)
+{
 	kill(0, SIGTERM);
-	done();
+	done(ctl);
 }
 
-
-static void wait_for_empty_fd(int fd)
+static void wait_for_empty_fd(struct script_control *ctl, int fd)
 {
 	struct pollfd fds[] = {
-		{ .fd = fd, .events = POLLIN }
+		{.fd = fd, .events = POLLIN}
 	};
 
-	while (die == 0 && poll(fds, 1, 100) == 1);
+	while (ctl->die == 0 && poll(fds, 1, 100) == 1) ;
 }
 
-static void finish(int wait)
+static void finish(struct script_control *ctl, int wait)
 {
 	int status;
 	pid_t pid;
@@ -224,15 +221,15 @@ static void finish(int wait)
 	int options = wait ? 0 : WNOHANG;
 
 	while ((pid = wait3(&status, options, 0)) > 0)
-		if (pid == child) {
-			childstatus = status;
-			die = 1;
+		if (pid == ctl->child) {
+			ctl->childstatus = status;
+			ctl->die = 1;
 		}
 
 	errno = errsv;
 }
 
-static void doinput(void)
+static void doinput(struct script_control *ctl)
 {
 	int errsv = 0;
 	ssize_t cc = 0;
@@ -240,41 +237,40 @@ static void doinput(void)
 	fd_set readfds;
 
 	/* close things irrelevant for this process */
-	if (fscript)
-		fclose(fscript);
-	if (timingfd)
-		fclose(timingfd);
-	fscript = timingfd = NULL;
+	if (ctl->typescriptfp)
+		fclose(ctl->typescriptfp);
+	if (ctl->timingfp)
+		fclose(ctl->timingfp);
+	ctl->typescriptfp = ctl->timingfp = NULL;
 
 	FD_ZERO(&readfds);
 
 	/* block SIGCHLD */
-	sigprocmask(SIG_SETMASK, &block_mask, &unblock_mask);
+	sigprocmask(SIG_SETMASK, &ctl->block_mask, &ctl->unblock_mask);
 
-	while (die == 0) {
+	while (!ctl->die) {
 		FD_SET(STDIN_FILENO, &readfds);
 
 		errno = 0;
 		/* wait for input or signal (including SIGCHLD) */
 		if ((cc = pselect(STDIN_FILENO + 1, &readfds, NULL, NULL, NULL,
-			&unblock_mask)) > 0) {
+				  &ctl->unblock_mask)) > 0) {
 
 			if ((cc = read(STDIN_FILENO, ibuf, BUFSIZ)) > 0) {
-				if (write_all(master, ibuf, cc)) {
-					warn (_("write failed"));
-					fail();
+				if (write_all(ctl->master, ibuf, cc)) {
+					warn(_("write failed"));
+					fail(ctl);
 				}
 			}
 		}
 
-		if (cc < 0 && errno == EINTR && resized)
-		{
+		if (cc < 0 && errno == EINTR && ctl->resized) {
 			/* transmit window change information to the child */
-			if (isterm) {
-				ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&win);
-				ioctl(slave, TIOCSWINSZ, (char *)&win);
+			if (ctl->isterm) {
+				ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&ctl->win);
+				ioctl(ctl->slave, TIOCSWINSZ, (char *)&ctl->win);
 			}
-			resized = 0;
+			ctl->resized = 0;
 
 		} else if (cc <= 0 && errno != EINTR) {
 			errsv = errno;
@@ -283,13 +279,13 @@ static void doinput(void)
 	}
 
 	/* unblock SIGCHLD */
-	sigprocmask(SIG_SETMASK, &unblock_mask, NULL);
+	sigprocmask(SIG_SETMASK, &ctl->unblock_mask, NULL);
 
 	/* To be sure that we don't miss any data */
-	wait_for_empty_fd(slave);
-	wait_for_empty_fd(master);
+	wait_for_empty_fd(ctl, ctl->slave);
+	wait_for_empty_fd(ctl, ctl->master);
 
-	if (die == 0 && cc == 0 && errsv == 0) {
+	if (ctl->die == 0 && cc == 0 && errsv == 0) {
 		/*
 		 * Forward EOF from stdin (detected by read() above) to slave
 		 * (shell) to correctly terminate the session. It seems we have
@@ -301,153 +297,155 @@ static void doinput(void)
 		 */
 		int c = DEF_EOF;
 
-		if (write_all(master, &c, 1)) {
-			warn (_("write failed"));
-			fail();
+		if (write_all(ctl->master, &c, 1)) {
+			warn(_("write failed"));
+			fail(ctl);
 		}
 
 		/* wait for "exit" message from shell before we print "Script
 		 * done" in done() */
-		wait_for_empty_fd(master);
+		wait_for_empty_fd(ctl, ctl->master);
 	}
 
-	if (!die)
-		finish(1);	/* wait for children */
-	done();
+	if (!ctl->die)
+		finish(ctl, 1);	/* wait for children */
+	done(ctl);
 }
 
-static void sig_finish(int dummy __attribute__ ((__unused__)))
+static void sig_finish(int dummy __attribute__((__unused__)))
 {
-	finish(0);
+	finish(gctl, 0);
 }
 
-static void resize(int dummy __attribute__ ((__unused__)))
+static void resize(int dummy __attribute__((__unused__)))
 {
-	resized = 1;
+	gctl->resized = 1;
 }
 
-static void dooutput(void)
+static void dooutput(struct script_control *ctl)
 {
 	ssize_t cc;
 	char obuf[BUFSIZ];
 	struct timeval tv;
-	double oldtime=time(NULL), newtime;
+	double oldtime = time(NULL), newtime;
 	int errsv = 0;
 	fd_set readfds;
 
 	close(STDIN_FILENO);
 #ifdef HAVE_LIBUTIL
-	close(slave);
+	close(ctl->slave);
 #endif
-	if (tflg && !timingfd)
-		timingfd = fdopen(STDERR_FILENO, "w");
+	if (ctl->tflg && !ctl->timingfp)
+		ctl->timingfp = fdopen(STDERR_FILENO, "w");
 
-	if (!qflg) {
+	if (!ctl->qflg) {
 		time_t tvec = time((time_t *)NULL);
 		my_strftime(obuf, sizeof obuf, "%c\n", localtime(&tvec));
-		fprintf(fscript, _("Script started on %s"), obuf);
+		fprintf(ctl->typescriptfp, _("Script started on %s"), obuf);
 	}
 
 	FD_ZERO(&readfds);
 
 	do {
-		if (die || errsv == EINTR) {
-			struct pollfd fds[] = {{ .fd = master, .events = POLLIN }};
+		if (ctl->die || errsv == EINTR) {
+			struct pollfd fds[] = {
+				{.fd = ctl->master, .events = POLLIN}
+			};
 			if (poll(fds, 1, 50) <= 0)
 				break;
 		}
 
 		/* block SIGCHLD */
-		sigprocmask(SIG_SETMASK, &block_mask, &unblock_mask);
+		sigprocmask(SIG_SETMASK, &ctl->block_mask, &ctl->unblock_mask);
 
-		FD_SET(master, &readfds);
+		FD_SET(ctl->master, &readfds);
 		errno = 0;
 
 		/* wait for input or signal (including SIGCHLD) */
-		if ((cc = pselect(master+1, &readfds, NULL, NULL, NULL,
-			&unblock_mask)) > 0) {
+		if ((cc = pselect(ctl->master + 1, &readfds, NULL, NULL, NULL,
+				  &ctl->unblock_mask)) > 0) {
 
-			cc = read(master, obuf, sizeof (obuf));
+			cc = read(ctl->master, obuf, sizeof(obuf));
 		}
 		errsv = errno;
 
 		/* unblock SIGCHLD */
-		sigprocmask(SIG_SETMASK, &unblock_mask, NULL);
+		sigprocmask(SIG_SETMASK, &ctl->unblock_mask, NULL);
 
-		if (tflg)
+		if (ctl->tflg)
 			gettimeofday(&tv, NULL);
 
 		if (errsv == EINTR && cc <= 0)
 			continue;	/* try it again */
 		if (cc <= 0)
 			break;
-		if (tflg && timingfd) {
-			newtime = tv.tv_sec + (double) tv.tv_usec / 1000000;
-			fprintf(timingfd, "%f %zd\n", newtime - oldtime, cc);
+		if (ctl->tflg && ctl->timingfp) {
+			newtime = tv.tv_sec + (double)tv.tv_usec / 1000000;
+			fprintf(ctl->timingfp, "%f %zd\n", newtime - oldtime, cc);
 			oldtime = newtime;
 		}
-		if (fwrite_all(obuf, 1, cc, fscript)) {
-			warn (_("cannot write script file"));
-			fail();
+		if (fwrite_all(obuf, 1, cc, ctl->typescriptfp)) {
+			warn(_("cannot write script file"));
+			fail(ctl);
 		}
-		if (fflg) {
-			fflush(fscript);
-			if (tflg && timingfd)
-				fflush(timingfd);
+		if (ctl->fflg) {
+			fflush(ctl->typescriptfp);
+			if (ctl->tflg && ctl->timingfp)
+				fflush(ctl->timingfp);
 		}
 		if (write_all(STDOUT_FILENO, obuf, cc)) {
-			warn (_("write failed"));
-			fail();
+			warn(_("write failed"));
+			fail(ctl);
 		}
-	} while(1);
+	} while (1);
 
-	done();
+	done(ctl);
 }
 
-static void getslave(void)
+static void getslave(struct script_control *ctl)
 {
 #ifndef HAVE_LIBUTIL
 	line[strlen("/dev/")] = 't';
-	slave = open(line, O_RDWR);
-	if (slave < 0) {
-		warn(_("cannot open %s"), line);
-		fail();
+	ctl->slave = open(ctl->line, O_RDWR);
+	if (ctl->slave < 0) {
+		warn(_("cannot open %s"), ctl->line);
+		fail(ctl);
 	}
-	if (isterm) {
-		tcsetattr(slave, TCSANOW, &tt);
-		ioctl(slave, TIOCSWINSZ, (char *)&win);
+	if (ctl->isterm) {
+		tcsetattr(ctl->slave, TCSANOW, &ctl->tt);
+		ioctl(ctl->slave, TIOCSWINSZ, (char *)&ctl->win);
 	}
 #endif
 	setsid();
-	ioctl(slave, TIOCSCTTY, 0);
+	ioctl(ctl->slave, TIOCSCTTY, 0);
 }
 
-static void doshell(void)
+static void doshell(struct script_control *ctl)
 {
 	char *shname;
 
-	getslave();
+	getslave(ctl);
 
 	/* close things irrelevant for this process */
-	close(master);
-	if (fscript)
-		fclose(fscript);
-	if (timingfd)
-		fclose(timingfd);
-	fscript = timingfd = NULL;
+	close(ctl->master);
+	if (ctl->typescriptfp)
+		fclose(ctl->typescriptfp);
+	if (ctl->timingfp)
+		fclose(ctl->timingfp);
+	ctl->typescriptfp = ctl->timingfp = NULL;
 
-	dup2(slave, STDIN_FILENO);
-	dup2(slave, STDOUT_FILENO);
-	dup2(slave, STDERR_FILENO);
-	close(slave);
+	dup2(ctl->slave, STDIN_FILENO);
+	dup2(ctl->slave, STDOUT_FILENO);
+	dup2(ctl->slave, STDERR_FILENO);
+	close(ctl->slave);
 
-	master = -1;
+	ctl->master = -1;
 
-	shname = strrchr(shell, '/');
+	shname = strrchr(ctl->shell, '/');
 	if (shname)
 		shname++;
 	else
-		shname = shell;
+		shname = ctl->shell;
 
 	/*
 	 * When invoked from within /etc/csh.login, script spawns a csh shell
@@ -459,93 +457,92 @@ static void doshell(void)
 	 */
 	signal(SIGTERM, SIG_DFL);
 
-	if (access(shell, X_OK) == 0) {
-		if (cflg)
-			execl(shell, shname, "-c", cflg, NULL);
+	if (access(ctl->shell, X_OK) == 0) {
+		if (ctl->cflg)
+			execl(ctl->shell, shname, "-c", ctl->cflg, NULL);
 		else
-			execl(shell, shname, "-i", NULL);
+			execl(ctl->shell, shname, "-i", NULL);
 	} else {
-		if (cflg)
-			execlp(shname, "-c", cflg, NULL);
+		if (ctl->cflg)
+			execlp(shname, "-c", ctl->cflg, NULL);
 		else
 			execlp(shname, "-i", NULL);
 	}
-	warn(_("failed to execute %s"), shell);
-	fail();
+	warn(_("failed to execute %s"), ctl->shell);
+	fail(ctl);
 }
 
-static void fixtty(void)
+static void fixtty(struct script_control *ctl)
 {
 	struct termios rtt;
 
-	if (!isterm)
+	if (!ctl->isterm)
 		return;
 
-	rtt = tt;
+	rtt = ctl->tt;
 	cfmakeraw(&rtt);
 	rtt.c_lflag &= ~ECHO;
 	tcsetattr(STDIN_FILENO, TCSANOW, &rtt);
 }
 
-static void getmaster(void)
+static void getmaster(struct script_control *ctl)
 {
 #if defined(HAVE_LIBUTIL) && defined(HAVE_PTY_H)
 	int rc;
 
-	isterm = isatty(STDIN_FILENO);
+	ctl->isterm = isatty(STDIN_FILENO);
 
-	if (isterm) {
-		if (tcgetattr(STDIN_FILENO, &tt) != 0)
+	if (ctl->isterm) {
+		if (tcgetattr(STDIN_FILENO, &ctl->tt) != 0)
 			err(EXIT_FAILURE, _("failed to get terminal attributes"));
-		ioctl(STDIN_FILENO, TIOCGWINSZ, (char *) &win);
-		rc = openpty(&master, &slave, NULL, &tt, &win);
+		ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&ctl->win);
+		rc = openpty(&ctl->master, &ctl->slave, NULL, &ctl->tt, &ctl->win);
 	} else
-		rc = openpty(&master, &slave, NULL, NULL, NULL);
+		rc = openpty(&ctl->master, &ctl->slave, NULL, NULL, NULL);
 
 	if (rc < 0) {
 		warn(_("openpty failed"));
-		fail();
+		fail(ctl);
 	}
 #else
 	char *pty, *bank, *cp;
 	struct stat stb;
 
-	isterm = isatty(STDIN_FILENO);
+	ctl->isterm = isatty(STDIN_FILENO);
 
-	pty = &line[strlen("/dev/ptyp")];
+	pty = &ctl->line[strlen("/dev/ptyp")];
 	for (bank = "pqrs"; *bank; bank++) {
-		line[strlen("/dev/pty")] = *bank;
+		ctl->line[strlen("/dev/pty")] = *bank;
 		*pty = '0';
-		if (stat(line, &stb) < 0)
+		if (stat(ctl->line, &stb) < 0)
 			break;
 		for (cp = "0123456789abcdef"; *cp; cp++) {
 			*pty = *cp;
-			master = open(line, O_RDWR);
-			if (master >= 0) {
-				char *tp = &line[strlen("/dev/")];
+			ctl->master = open(ctl->line, O_RDWR);
+			if (ctl->master >= 0) {
+				char *tp = &ctl->line[strlen("/dev/")];
 				int ok;
 
 				/* verify slave side is usable */
 				*tp = 't';
-				ok = access(line, R_OK|W_OK) == 0;
+				ok = access(ctl->line, R_OK | W_OK) == 0;
 				*tp = 'p';
 				if (ok) {
-					if (isterm) {
-						tcgetattr(STDIN_FILENO, &tt);
-						ioctl(STDIN_FILENO, TIOCGWINSZ,
-								(char *)&win);
+					if (ctl->isterm) {
+						tcgetattr(STDIN_FILENO, &ctl->tt);
+						ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&ctl->win);
 					}
 					return;
 				}
-				close(master);
-				master = -1;
+				close(ctl->master);
+				ctl->master = -1;
 			}
 		}
 	}
-	master = -1;
+	ctl->master = -1;
 	warn(_("out of pty's"));
-	fail();
-#endif /* not HAVE_LIBUTIL */
+	fail(ctl);
+#endif				/* not HAVE_LIBUTIL */
 }
 
 /*
@@ -558,22 +555,29 @@ static void getmaster(void)
  */
 int main(int argc, char **argv)
 {
+	struct script_control ctl = {
+#if !HAVE_LIBUTIL || !HAVE_PTY_H
+		.line = "/dev/ptyXX",
+#endif
+		.master = -1,
+		0
+	};
 	struct sigaction sa;
 	int ch;
 
 	enum { FORCE_OPTION = CHAR_MAX + 1 };
 
 	static const struct option longopts[] = {
-		{ "append",	no_argument,	   NULL, 'a' },
-		{ "command",	required_argument, NULL, 'c' },
-		{ "return",	no_argument,	   NULL, 'e' },
-		{ "flush",	no_argument,	   NULL, 'f' },
-		{ "force",	no_argument,	   NULL, FORCE_OPTION, },
-		{ "quiet",	no_argument,	   NULL, 'q' },
-		{ "timing",	optional_argument, NULL, 't' },
-		{ "version",	no_argument,	   NULL, 'V' },
-		{ "help",	no_argument,	   NULL, 'h' },
-		{ NULL,		0, NULL, 0 }
+		{"append", no_argument, NULL, 'a'},
+		{"command", required_argument, NULL, 'c'},
+		{"return", no_argument, NULL, 'e'},
+		{"flush", no_argument, NULL, 'f'},
+		{"force", no_argument, NULL, FORCE_OPTION,},
+		{"quiet", no_argument, NULL, 'q'},
+		{"timing", optional_argument, NULL, 't'},
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
 	};
 
 	setlocale(LC_ALL, "");
@@ -581,31 +585,32 @@ int main(int argc, char **argv)
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
+	gctl = &ctl;
 
 	while ((ch = getopt_long(argc, argv, "ac:efqt::Vh", longopts, NULL)) != -1)
-		switch(ch) {
+		switch (ch) {
 		case 'a':
-			aflg = 1;
+			ctl.aflg = 1;
 			break;
 		case 'c':
-			cflg = optarg;
+			ctl.cflg = optarg;
 			break;
 		case 'e':
-			eflg = 1;
+			ctl.eflg = 1;
 			break;
 		case 'f':
-			fflg = 1;
+			ctl.fflg = 1;
 			break;
 		case FORCE_OPTION:
-			forceflg = 1;
+			ctl.forceflg = 1;
 			break;
 		case 'q':
-			qflg = 1;
+			ctl.qflg = 1;
 			break;
 		case 't':
-			if (optarg && !(timingfd = fopen(optarg, "w")))
+			if (optarg && !(ctl.timingfp = fopen(optarg, "w")))
 				err(EXIT_FAILURE, _("cannot open %s"), optarg);
-			tflg = 1;
+			ctl.tflg = 1;
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -622,25 +627,25 @@ int main(int argc, char **argv)
 	argv += optind;
 
 	if (argc > 0)
-		fname = argv[0];
+		ctl.fname = argv[0];
 	else {
-		fname = DEFAULT_OUTPUT;
-		die_if_link(fname);
+		ctl.fname = DEFAULT_OUTPUT;
+		die_if_link(&ctl);
 	}
 
-	if ((fscript = fopen(fname, aflg ? "a" : "w")) == NULL) {
-		warn(_("cannot open %s"), fname);
-		fail();
+	if ((ctl.typescriptfp = fopen(ctl.fname, ctl.aflg ? "a" : "w")) == NULL) {
+		warn(_("cannot open %s"), ctl.fname);
+		fail(&ctl);
 	}
 
-	shell = getenv("SHELL");
-	if (shell == NULL)
-		shell = _PATH_BSHELL;
+	ctl.shell = getenv("SHELL");
+	if (ctl.shell == NULL)
+		ctl.shell = _PATH_BSHELL;
 
-	getmaster();
-	if (!qflg)
-		printf(_("Script started, file is %s\n"), fname);
-	fixtty();
+	getmaster(&ctl);
+	if (!ctl.qflg)
+		printf(_("Script started, file is %s\n"), ctl.fname);
+	fixtty(&ctl);
 
 #ifdef HAVE_LIBUTEMPTER
 	utempter_add_record(master, NULL);
@@ -652,36 +657,36 @@ int main(int argc, char **argv)
 	sigaction(SIGCHLD, &sa, NULL);
 
 	/* init mask for SIGCHLD */
-	sigprocmask(SIG_SETMASK, NULL, &block_mask);
-	sigaddset(&block_mask, SIGCHLD);
+	sigprocmask(SIG_SETMASK, NULL, &ctl.block_mask);
+	sigaddset(&ctl.block_mask, SIGCHLD);
 
-	sigprocmask(SIG_SETMASK, &block_mask, &unblock_mask);
-	child = fork();
-	sigprocmask(SIG_SETMASK, &unblock_mask, NULL);
+	sigprocmask(SIG_SETMASK, &ctl.block_mask, &ctl.unblock_mask);
+	ctl.child = fork();
+	sigprocmask(SIG_SETMASK, &ctl.unblock_mask, NULL);
 
-	if (child < 0) {
+	if (ctl.child < 0) {
 		warn(_("fork failed"));
-		fail();
+		fail(&ctl);
 	}
-	if (child == 0) {
+	if (ctl.child == 0) {
 
-		sigprocmask(SIG_SETMASK, &block_mask, NULL);
-		subchild = child = fork();
-		sigprocmask(SIG_SETMASK, &unblock_mask, NULL);
+		sigprocmask(SIG_SETMASK, &ctl.block_mask, NULL);
+		ctl.subchild = ctl.child = fork();
+		sigprocmask(SIG_SETMASK, &ctl.unblock_mask, NULL);
 
-		if (child < 0) {
+		if (ctl.child < 0) {
 			warn(_("fork failed"));
-			fail();
+			fail(&ctl);
 		}
-		if (child)
-			dooutput();
+		if (ctl.child)
+			dooutput(&ctl);
 		else
-			doshell();
+			doshell(&ctl);
 	} else {
 		sa.sa_handler = resize;
 		sigaction(SIGWINCH, &sa, NULL);
 	}
-	doinput();
+	doinput(&ctl);
 
 	return EXIT_SUCCESS;
 }
-- 
2.2.1

