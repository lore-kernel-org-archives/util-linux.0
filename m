Return-Path: util-linux-owner@vger.kernel.org
Received: from charybdis-ext.suse.de ([195.135.221.2]:57588 "EHLO g231.suse.de"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753926Ab2LGIWM (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 7 Dec 2012 03:22:12 -0500
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Werner Fink <werner@suse.de>
Subject: [PATCH 5/5] sulogin: add multi console feature from SysVinit sulogin
Date: Fri,  7 Dec 2012 09:00:58 +0100
Message-Id: <1354867258-14206-5-git-send-email-werner@suse.de>
In-Reply-To: <1354867258-14206-1-git-send-email-werner@suse.de>
References: <1354867258-14206-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Now after adding Conflicts=rescue.service to getty@.service and
serial-getty@.service and Conflicts=getty.target to rescue.target
all works with `systemctl rescue'.  Even adding init=/sbin/sulogin
to the kernels command line by using the `e' key in grub2 boot
menu works flawless.

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin.c |  665 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 516 insertions(+), 149 deletions(-)

diff --git login-utils/sulogin.c login-utils/sulogin.c
index 0b0d21c..c4e44a9 100644
--- login-utils/sulogin.c
+++ login-utils/sulogin.c
@@ -24,8 +24,10 @@
  * along with this program; if not, write to the Free Software
  * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
  */
+#include <sys/mman.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
@@ -67,15 +69,188 @@
 #include "pathnames.h"
 #include "strutils.h"
 #include "ttyutils.h"
+#include "consoles.h"
+#define CONMAX		16
+
+#define BS		CTRL('h')
+#define NL		CTRL('j')
+#define CR		CTRL('m')
 
 static unsigned int timeout;
 static int profile;
+static volatile uint32_t openfd;		/* Remember higher file descriptors */
+static volatile uint32_t *usemask;
 
 struct sigaction saved_sigint;
 struct sigaction saved_sigtstp;
 struct sigaction saved_sigquit;
+struct sigaction saved_sighup;
+struct sigaction saved_sigchld;
 
 static volatile sig_atomic_t alarm_rised;
+static volatile sig_atomic_t sigchild;
+
+#ifndef IUCLC
+# define IUCLC		0
+#endif
+
+/*
+ * Fix the tty modes and set reasonable defaults.
+ */
+static void tcinit(struct console *con)
+{
+	int mode = 0, flags = 0;
+	struct termios *tio = &con->tio;
+	int fd = con->fd;
+
+	errno = 0;
+
+	if (tcgetattr(fd, tio) < 0) {
+		warn(_("tcgetattr failed"));
+		con->flags |= CON_NOTTY;
+		return;
+	}
+
+	/* Handle serial lines here */
+	if (ioctl(fd, TIOCMGET, (char *) &mode) == 0) {
+		speed_t ispeed, ospeed;
+		struct winsize ws;
+
+		/* this is a modem line */
+		con->flags |= CON_SERIAL;
+
+		/* Flush input and output queues on modem lines */
+		(void) tcflush(fd, TCIOFLUSH);
+
+		ispeed = cfgetispeed(tio);
+		ospeed = cfgetospeed(tio);
+
+		if (!ispeed) ispeed = TTYDEF_SPEED;
+		if (!ospeed) ospeed = TTYDEF_SPEED;
+
+		tio->c_iflag = tio->c_lflag = tio->c_oflag = 0;
+		tio->c_cflag = CREAD | CS8 | HUPCL | (tio->c_cflag & CLOCAL);
+
+		cfsetispeed(tio, ispeed);
+		cfsetospeed(tio, ospeed);
+
+		tio->c_line         = 0;
+		tio->c_cc[VTIME]    = 0;
+		tio->c_cc[VMIN]     = 1;
+
+		if (ioctl(fd, TIOCGWINSZ, &ws) == 0) {
+			int set = 0;
+			if (ws.ws_row == 0) {
+				ws.ws_row = 24;
+				set++;
+			}
+			if (ws.ws_col == 0) {
+				ws.ws_col = 80;
+				set++;
+			}
+			if (set)
+				(void)ioctl(fd, TIOCSWINSZ, &ws);
+		}
+
+		setlocale(LC_CTYPE, "POSIX");
+		goto setattr;
+	}
+#if defined(IUTF8) && defined(KDGKBMODE)
+	/* Detect mode of current keyboard setup, e.g. for UTF-8 */
+	if (ioctl(fd, KDGKBMODE, &mode) < 0)
+		mode = K_RAW;
+	switch(mode) {
+	case K_UNICODE:
+		setlocale(LC_CTYPE, "C.UTF-8");
+		flags |= UL_TTY_UTF8;
+		break;
+	case K_RAW:
+	case K_MEDIUMRAW:
+	case K_XLATE:
+	default:
+		setlocale(LC_CTYPE, "POSIX");
+		break;
+	}
+#else
+	setlocale(LC_CTYPE, "POSIX");
+#endif
+	reset_virtual_console(tio, flags);
+setattr:
+	if (tcsetattr(fd, TCSANOW, tio))
+		warn(_("tcsetattr failed"));
+
+	/* Enable blocking mode for read and write */
+	if ((flags = fcntl(fd, F_GETFL, 0)) != -1)
+		(void)fcntl(fd, F_SETFL, flags & ~O_NONBLOCK);
+}
+
+/*
+ * Finalize the tty modes on modem lines.
+ */
+static void tcfinal(struct console *con)
+{
+	struct termios *tio;
+	int fd;
+
+	if ((con->flags & CON_SERIAL) == 0) {
+		setenv("TERM", "linux", 1);
+		return;
+	}
+	if (con->flags & CON_NOTTY)
+		return;
+
+	setenv("TERM", "vt102", 1);
+	tio = &con->tio;
+	fd = con->fd;
+
+	tio->c_iflag |= (IXON | IXOFF);
+	tio->c_lflag |= (ICANON | ISIG | ECHO|ECHOE|ECHOK|ECHOKE);
+	tio->c_oflag |= OPOST;
+
+	tio->c_cc[VINTR]    = CINTR;
+	tio->c_cc[VQUIT]    = CQUIT;
+	tio->c_cc[VERASE]   = con->cp.erase;
+	tio->c_cc[VKILL]    = con->cp.kill;
+	tio->c_cc[VEOF]     = CEOF;
+#ifdef VSWTC
+	tio->c_cc[VSWTC]    = _POSIX_VDISABLE;
+#else
+	tio->c_cc[VSWTCH]   = _POSIX_VDISABLE;
+#endif
+	tio->c_cc[VSTART]   = CSTART;
+	tio->c_cc[VSTOP]    = CSTOP;
+	tio->c_cc[VSUSP]    = CSUSP;
+	tio->c_cc[VEOL]     = _POSIX_VDISABLE;
+
+	if (con->cp.eol == CR) {
+		tio->c_iflag |= ICRNL;
+		tio->c_iflag &= ~(INLCR|IGNCR);
+		tio->c_oflag |= ONLCR;
+		tio->c_oflag &= ~(OCRNL|ONLRET);
+	}
+
+	switch (con->cp.parity) {
+	default:
+	case 0:
+		tio->c_cflag &= ~(PARODD | PARENB);
+		tio->c_iflag &= ~(INPCK | ISTRIP);
+		break;
+	case 1:				/* odd parity */
+		tio->c_cflag |= PARODD;
+		/* fall through */
+	case 2:				/* even parity */
+		tio->c_cflag |= PARENB;
+		tio->c_iflag |= (INPCK | ISTRIP);
+		/* fall through */
+	case (1 | 2):			/* no parity bit */
+		tio->c_cflag &= ~CSIZE;
+		tio->c_cflag |= CS7;
+		break;
+	}
+
+	/* Set line attributes */
+	(void)tcsetattr(fd, TCSANOW, tio);
+}
 
 /*
  * Called at timeout.
@@ -86,6 +261,11 @@ static void alrm_handler(int sig __attribute__((unused)))
 	alarm_rised++;
 }
 
+static void chld_handler(int sig __attribute__((unused)))
+{
+	sigchild++;
+}
+
 static void mask_signal(int signal, void (*handler)(int),
 		struct sigaction *origaction)
 {
@@ -95,8 +275,7 @@ static void mask_signal(int signal, void (*handler)(int),
 	sigemptyset(&newaction.sa_mask);
 	newaction.sa_flags = 0;
 
-	sigaction(signal, NULL, origaction);
-	sigaction(signal, &newaction, NULL);
+	sigaction(signal, &newaction, origaction);
 }
 
 static void unmask_signal(int signal, struct sigaction *sa)
@@ -296,51 +475,202 @@ static struct passwd *getrootpwent(int try_manually)
 }
 
 /*
+ * Ask by prompt for the password.
+ */
+static void doprompt(const char *crypted, struct console *con)
+{
+	struct termios tty;
+
+	if (con->flags & CON_SERIAL) {
+		tty = con->tio;
+		/*
+		 * For prompting: map NL in output to CR-NL
+		 * otherwise we may see stairs in the output.
+		 */
+		tty.c_oflag |= (ONLCR | OPOST);
+		(void) tcsetattr(con->fd, TCSADRAIN, &tty);
+	}
+	if (con->file == (FILE*)0) {
+		if  ((con->file = fdopen(con->fd, "r+")) == (FILE*)0)
+			goto err;
+	}
+#if defined(USE_ONELINE)
+	if (crypted[0])
+		fprintf(con->file, _("Give root password for login: "));
+	else
+		fprintf(con->file, _("Press enter for login: "));
+#else
+	if (crypted[0])
+		fprintf(con->file, _("Give root password for maintenance\n"));
+	else
+		fprintf(con->file, _("Press enter for maintenance"));
+	fprintf(con->file, _("(or type Control-D to continue): "));
+#endif
+	fflush(con->file);
+err:
+	if (con->flags & CON_SERIAL)
+		(void) tcsetattr(con->fd, TCSADRAIN, &con->tio);
+}
+
+/*
+ * Make sure to have an own session and controlling terminal
+ */
+static void setup(struct console *con)
+{
+	pid_t pid, pgrp, ppgrp, ttypgrp;
+	int fd;
+
+	if (con->flags & CON_NOTTY)
+		return;
+	fd = con->fd;
+
+	/*
+	 * Only go through this trouble if the new
+	 * tty doesn't fall in this process group.
+	 */
+	pid = getpid();
+	pgrp = getpgid(0);
+	ppgrp = getpgid(getppid());
+	ttypgrp = tcgetpgrp(fd);
+
+	if (pgrp != ttypgrp && ppgrp != ttypgrp) {
+		if (pid != getsid(0)) {
+			if (pid == getpgid(0))
+				setpgid(0, getpgid(getppid()));
+			setsid();
+		}
+
+		mask_signal(SIGHUP, SIG_IGN, &saved_sighup);
+		if (ttypgrp > 0)
+			ioctl(STDIN_FILENO, TIOCNOTTY, (char *)1);
+		unmask_signal(SIGHUP, &saved_sighup);
+		if (fd > STDIN_FILENO)  close(STDIN_FILENO);
+		if (fd > STDOUT_FILENO) close(STDOUT_FILENO);
+		if (fd > STDERR_FILENO) close(STDERR_FILENO);
+
+		ioctl(fd, TIOCSCTTY, (char *)1);
+		tcsetpgrp(fd, ppgrp);
+	}
+	dup2(fd, STDIN_FILENO);
+	dup2(fd, STDOUT_FILENO);
+	dup2(fd, STDERR_FILENO);
+	con->fd = STDIN_FILENO;
+
+	for (fd = STDERR_FILENO+1; fd < 32; fd++) {
+		if (openfd & (1<<fd)) {
+			close(fd);
+			openfd &= ~(1<<fd);
+		}
+	}
+}
+
+/*
  * Ask for the password. Note that there is no default timeout as we normally
  * skip this during boot.
  */
-static char *getpasswd(char *crypted)
+static char *getpasswd(struct console *con)
 {
 	struct sigaction sa;
-	struct termios old, tty;
-	static char pass[128];
+	struct termios tty;
+	static char pass[128], *ptr;
+	struct chardata *cp;
 	char *ret = pass;
-	size_t i;
+	unsigned char tc;
+	char c, ascval;
+	int eightbit;
+	int fd;
 
-	if (crypted[0])
-		printf(_("Give root password for maintenance\n"));
-	else
-		printf(_("Press enter for maintenance"));
-	printf(_("(or type Control-D to continue): "));
-	fflush(stdout);
+	if (con->flags & CON_NOTTY)
+		goto out;
+	fd = con->fd;
+	cp = &con->cp;
+	tty = con->tio;
 
-	tcgetattr(0, &old);
-	tcgetattr(0, &tty);
 	tty.c_iflag &= ~(IUCLC|IXON|IXOFF|IXANY);
-	tty.c_lflag &= ~(ECHO|ECHOE|ECHOK|ECHONL|TOSTOP);
-	tcsetattr(0, TCSANOW, &tty);
-
-	pass[sizeof(pass) - 1] = 0;
+	tty.c_lflag &= ~(ECHO|ECHOE|ECHOK|ECHONL|TOSTOP|ISIG);
+	tc = (tcsetattr(fd, TCSAFLUSH, &tty) == 0);
 
 	sa.sa_handler = alrm_handler;
 	sa.sa_flags = 0;
 	sigaction(SIGALRM, &sa, NULL);
-	if (timeout)
-		alarm(timeout);
+	if (timeout) alarm(timeout);
 
-	if (read(0, pass, sizeof(pass) - 1) <= 0)
-		ret = NULL;
-	else {
-		for (i = 0; i < sizeof(pass) && pass[i]; i++)
-			if (pass[i] == '\r' || pass[i] == '\n') {
-				pass[i] = 0;
+	ptr = &pass[0];
+	cp->eol = *ptr = '\0';
+
+	eightbit = ((con->flags & CON_SERIAL) == 0 || (tty.c_cflag & (PARODD|PARENB)) == 0);
+	while (cp->eol == '\0') {
+		if (read(fd, &c, 1) < 1) {
+			if (errno == EINTR || errno == EAGAIN) {
+				usleep(1000);
+				continue;
+			}
+			ret = (char*)0;
+			switch (errno) {
+			case 0:
+			case EIO:
+			case ESRCH:
+			case EINVAL:
+			case ENOENT:
 				break;
+			default:
+				fprintf(stderr, "sulogin: read(%s): %m\n\r", con->tty);
+				break;
+			}
+			goto quit;
+		}
+
+		if (eightbit)
+			ascval = c;
+		else if (c != (ascval = (c & 0177))) {
+			uint32_t bits, mask;
+			for (bits = 1, mask = 1; mask & 0177; mask <<= 1) {
+				if (mask & ascval)
+					bits++;
+			}
+			cp->parity |= ((bits & 1) ? 1 : 2);
+		}
+
+		switch (ascval) {
+		case 0:
+			*ptr = '\0';
+			goto quit; 
+		case CR:
+		case NL:
+			*ptr = '\0';
+			cp->eol = ascval;
+			break;
+		case BS:
+		case CERASE:
+			cp->erase = ascval;
+			if (ptr > &pass[0])
+				ptr--;
+			break;
+		case CKILL:
+			cp->kill = ascval;
+			while (ptr > &pass[0])
+				ptr--;
+			break;
+		case CEOF:
+			goto quit;		
+		default:
+			if ((size_t)(ptr - &pass[0]) >= (sizeof(pass) -1 )) {
+				 fprintf(stderr, "sulogin: input overrun at %s\n\r", con->tty);
+				 ret = (char*)0;
+				 goto quit;
 			}
+			*ptr++ = ascval;
+			break;
+		}
 	}
+quit:
 	alarm(0);
-	tcsetattr(0, TCSANOW, &old);
-	printf("\n");
-
+	if (tc)
+		(void)tcsetattr(fd, TCSAFLUSH, &con->tio);
+	if (ret && *ret != '\0')
+		tcfinal(con);
+	printf("\r\n");
+out:
 	return ret;
 }
 
@@ -385,9 +715,10 @@ static void sushell(struct passwd *pwd)
 	/*
 	 * Set some important environment variables.
 	 */
-	if (getcwd(home, sizeof(home)) != NULL)
-		setenv("HOME", home, 1);
+	if (getcwd(home, sizeof(home)) == NULL)
+		strcpy(home, "/");
 
+	setenv("HOME", home, 1);
 	setenv("LOGNAME", "root", 1);
 	setenv("USER", "root", 1);
 	if (!profile)
@@ -400,6 +731,7 @@ static void sushell(struct passwd *pwd)
 	unmask_signal(SIGINT, &saved_sigint);
 	unmask_signal(SIGTSTP, &saved_sigtstp);
 	unmask_signal(SIGQUIT, &saved_sigquit);
+	mask_signal(SIGHUP, SIG_DFL, NULL);
 
 #ifdef HAVE_LIBSELINUX
 	if (is_selinux_enabled() > 0) {
@@ -425,36 +757,6 @@ static void sushell(struct passwd *pwd)
 	warn(_("%s: exec failed"), "/bin/sh");
 }
 
-static void fixtty(void)
-{
-	struct termios tp;
-	int x = 0, fl = 0;
-
-	/* Skip serial console */
-	if (ioctl(STDIN_FILENO, TIOCMGET, (char *) &x) == 0)
-		return;
-
-#if defined(IUTF8) && defined(KDGKBMODE)
-	/* Detect mode of current keyboard setup, e.g. for UTF-8 */
-	if (ioctl(STDIN_FILENO, KDGKBMODE, &x) == 0 && x == K_UNICODE) {
-		setlocale(LC_CTYPE, "C.UTF-8");
-		fl |= UL_TTY_UTF8;
-	}
-#else
-	setlocale(LC_CTYPE, "POSIX");
-#endif
-	memset(&tp, 0, sizeof(struct termios));
-	if (tcgetattr(STDIN_FILENO, &tp) < 0) {
-		warn(_("tcgetattr failed"));
-		return;
-	}
-
-	reset_virtual_console(&tp, fl);
-
-	if (tcsetattr(STDIN_FILENO, TCSADRAIN, &tp))
-		warn(_("tcsetattr failed"));
-}
-
 #ifdef USE_EMERGENCY_DEV
 /*
  * Make C library standard calls such like ttyname(3) work
@@ -518,13 +820,14 @@ static void usage(FILE *out)
 
 int main(int argc, char **argv)
 {
+	struct list_head consoles = {&consoles, &consoles}, *ptr;
+	struct console *con;
 	char *tty = NULL;
-	char *p;
 	struct passwd *pwd;
-	int c, fd = -1;
+	int c, status = 0;
+	int reconnect = 0;
 	int opt_e = 0;
-	pid_t pid, pgrp, ppgrp, ttypgrp;
-	struct sigaction saved_sighup;
+	pid_t pid;
 
 	static const struct option longopts[] = {
 		{ "login-shell",  0, 0, 'p' },
@@ -535,10 +838,18 @@ int main(int argc, char **argv)
 		{ NULL,           0, 0, 0 }
 	};
 
+	/*
+	 * If we are init we need to set up a own session.
+	 */
+	if ((pid = getpid()) == 1) {
+		setsid();
+		(void)ioctl(STDIN_FILENO, TIOCSCTTY, (char *)1);
+	}
+
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
-	atexit(close_stdout);
+	atexit(close_stdout); /* XXX */
 
 	/*
 	 * See if we have a timeout flag.
@@ -570,78 +881,45 @@ int main(int argc, char **argv)
 	if (geteuid() != 0)
 		errx(EXIT_FAILURE, _("only root can run this program."));
 
-	/*
-	 * See if we need to open an other tty device.
-	 */
 	mask_signal(SIGQUIT, SIG_IGN, &saved_sigquit);
 	mask_signal(SIGTSTP, SIG_IGN, &saved_sigtstp);
 	mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
+	mask_signal(SIGHUP,  SIG_IGN, &saved_sighup);
+
+	/*
+	 * See if we need to open an other tty device.
+	 */
 	if (optind < argc)
 		tty = argv[optind];
 
-	if (tty || (tty = getenv("CONSOLE"))) {
-
-		if ((fd = open(tty, O_RDWR)) < 0) {
-			warn(_("cannot open %s"), tty);
-			fd = dup(STDIN_FILENO);
-		}
-
-		if (fd < 0) {
-			warn(_("cannot duplicate stdin file descriptor"));
-		} else if (!isatty(fd)) {
-			warn(_("%s: not a tty"), tty);
-			close(fd);
-		} else {
+	if (!tty || *tty == '\0')
+		tty = getenv("CONSOLE");
 
-			/*
-			 * Only go through this trouble if the new tty doesn't
-			 * fall in this process group.
-			 */
-			pid = getpid();
-			pgrp = getpgid(0);
-			ppgrp = getpgid(getppid());
-			ttypgrp = tcgetpgrp(fd);
-
-			if (pgrp != ttypgrp && ppgrp != ttypgrp) {
-				if (pid != getsid(0)) {
-					if (pid == getpgid(0))
-						setpgid(0, getpgid(getppid()));
-					setsid();
-				}
+	/*
+	 * Detect possible consoles, use stdin as fallback.
+	 * If an optional tty is given, reconnect it to stdin.
+	 */
+	reconnect = detect_consoles(tty, STDIN_FILENO, &consoles);
 
-				sigaction(SIGHUP, NULL, &saved_sighup);
-				if (ttypgrp > 0)
-					ioctl(0, TIOCNOTTY, (char *)1);
-				sigaction(SIGHUP, &saved_sighup, NULL);
-				close(STDIN_FILENO);
-				close(STDOUT_FILENO);
-				close(STDERR_FILENO);
-				if (fd > 2)
-					close(fd);
-				if ((fd = open(tty, O_RDWR|O_NOCTTY)) < 0)
-					warn(_("cannot open %s"), tty);
-				else {
-					ioctl(STDIN_FILENO, TIOCSCTTY, (char *)1);
-					tcsetpgrp(fd, ppgrp);
-					dup2(fd, STDIN_FILENO);
-					dup2(fd, STDOUT_FILENO);
-					dup2(fd, STDERR_FILENO);
-
-					if (fd > STDERR_FILENO)
-						close(fd);
-				}
-			} else
-				if (fd > STDERR_FILENO)
-					close(fd);
-		}
-	} else if (getpid() == 1) {
-		/* We are init. We hence need to set a session anyway */
-		setsid();
-		if (ioctl(STDIN_FILENO, TIOCSCTTY, (char *)1))
-			warn(_("TIOCSCTTY: ioctl failed"));
+	/*
+	 * If previous stdin was not the speified tty and therefore reconnected
+	 * to the specified tty also reconnect stdout and stderr.
+	 */
+	if (reconnect) {
+		if (isatty(STDOUT_FILENO) == 0)
+			dup2(STDOUT_FILENO, STDIN_FILENO);
+		if (isatty(STDERR_FILENO) == 0)
+			dup2(STDOUT_FILENO, STDERR_FILENO);
 	}
 
-	fixtty();
+	/*
+	 * Should not happen
+	 */
+	if (list_empty(&consoles)) {
+		if (!errno)
+			errno = ENOENT;
+		errx(EXIT_FAILURE, _("cannot open console: %m\n"));
+	}
 
 	/*
 	 * Get the root password.
@@ -652,32 +930,121 @@ int main(int argc, char **argv)
 	}
 
 	/*
-	 * Ask for the password.
+	 * Ask for the password on the consoles.
 	 */
-	while (pwd) {
-		int failed = 0;
-		if ((p = getpasswd(pwd->pw_passwd)) == NULL)
+	list_for_each(ptr, &consoles) {
+		con = list_entry(ptr, struct console, entry);
+		if (con->id >= CONMAX)
 			break;
-		if (pwd->pw_passwd[0] == 0 ||
-		    strcmp(crypt(p, pwd->pw_passwd), pwd->pw_passwd) == 0) {
-			sushell(pwd);
-			failed++;
+		if (con->fd >= 0) {
+			openfd |= (1<<con->fd);
+			tcinit(con);
+			continue;
 		}
-		mask_signal(SIGQUIT, SIG_IGN, &saved_sigquit);
-		mask_signal(SIGTSTP, SIG_IGN, &saved_sigtstp);
-		mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
-		if (failed) {
-		    fprintf(stderr, _("Can not execute su shell\n\n"));
-		    break;
-		} else
-		    fprintf(stderr, _("Login incorrect\n\n"));
+		if ((con->fd = open(con->tty, O_RDWR | O_NOCTTY | O_NONBLOCK)) < 0)
+			continue;
+		openfd |= (1<<con->fd);
+		tcinit(con);
 	}
+	ptr = (&consoles)->next;
+	usemask = (uint32_t*)mmap(NULL, sizeof(uint32_t), PROT_READ|PROT_WRITE, MAP_ANONYMOUS|MAP_SHARED, -1, 0);
 
-	if (alarm_rised)
-		fprintf(stderr, _("Timed out\n\n"));
+	if (ptr->next == &consoles) {
+		con = list_entry(ptr, struct console, entry);
+		goto nofork;
+	}
 
-	/*
-	 * User pressed Control-D.
-	 */
+	mask_signal(SIGCHLD, chld_handler, &saved_sigchld);
+	do {
+		con = list_entry(ptr, struct console, entry);
+		if (con->id >= CONMAX)
+			break;
+
+		switch ((con->pid = fork())) {
+		case 0:
+			mask_signal(SIGCHLD, SIG_DFL, NULL);
+			/* fall through */
+		nofork:
+			setup(con);
+			while (1) {
+				const char *passwd = pwd->pw_passwd;
+				const char *answer;
+				int failed = 0, doshell = 0;
+
+				doprompt(passwd, con);
+				if ((answer = getpasswd(con)) == NULL)
+					break;
+
+				if (passwd[0] == '\0')
+					doshell++;
+				else {
+					const char *cryptbuf;
+					cryptbuf = crypt(answer, passwd);
+					if (cryptbuf == NULL)
+						warnx(_("crypt failed: %m\n"));
+					else if (strcmp(cryptbuf, pwd->pw_passwd) == 0)
+						doshell++;
+				}
+
+				if (doshell) {
+					*usemask |= (1<<con->id);
+					sushell(pwd);
+					*usemask &= ~(1<<con->id);
+					failed++;
+				}
+
+				mask_signal(SIGQUIT, SIG_IGN, &saved_sigquit);
+				mask_signal(SIGTSTP, SIG_IGN, &saved_sigtstp);
+				mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
+
+				if (failed) {
+					fprintf(stderr, _("Can not execute su shell\n\n"));
+					break;
+				}
+				fprintf(stderr, _("Login incorrect\n\n"));
+			}
+			if (alarm_rised) {
+				tcfinal(con);
+				warnx(_("Timed out\n\n"));
+			}
+			/*
+			 * User pressed Control-D.
+			 */
+			exit(0);
+		case -1:
+			warnx(_("Can not fork: %m\n"));
+			/* fall through */
+		default:
+			break;
+		}
+
+		ptr = ptr->next;
+
+	} while (ptr != &consoles);
+
+	while ((pid = wait(&status))) {
+		if (errno == ECHILD)
+			break;
+		if (pid < 0)
+			continue;
+		list_for_each(ptr, &consoles) {
+			con = list_entry(ptr, struct console, entry);
+			if (con->pid == pid) {
+				*usemask &= ~(1<<con->id);
+				continue;
+			}
+			if (kill(con->pid, 0) < 0) {
+				*usemask &= ~(1<<con->id);
+				continue;
+			}
+			if (*usemask & (1<<con->id))
+				continue;
+			kill(con->pid, SIGHUP);
+			usleep(5000);
+			kill(con->pid, SIGKILL);
+		}
+	}
+
+	mask_signal(SIGCHLD, SIG_DFL, NULL);
 	return EXIT_SUCCESS;
 }
-- 
1.7.10.4

