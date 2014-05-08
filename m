Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50671 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256AbaEHKJm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 8 May 2014 06:09:42 -0400
From: Werner Fink <werner@suse.de>
To: util-linux@vger.kernel.org
Cc: Werner Fink <werner@suse.de>, Ruediger Meier <sweet_f_a@gmx.de>
Subject: [PATCH 1/4] Avoid that agetty nor sulogin are fooled by a running plymouth
Date: Thu,  8 May 2014 12:09:22 +0200
Message-Id: <1399543765-31106-1-git-send-email-werner@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The nowadays used plymouth locks the devices used for the system
console which causes that agetty as well as sulogin can not modify
the termios settings of e.g. the serial devices of the systenm console.

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin.c |   51 ++++++++++++++++++++++++++++++++-
 term-utils/agetty.c   |   75 ++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 118 insertions(+), 8 deletions(-)

diff --git login-utils/sulogin.c login-utils/sulogin.c
index 37d006d..1e227a8 100644
--- login-utils/sulogin.c
+++ login-utils/sulogin.c
@@ -77,13 +77,62 @@ static volatile sig_atomic_t sigchild;
 #endif
 
 /*
+ * For the case plymouth is found on this system
+ */
+static int plymouth_command(const char* arg)
+{
+	const char *cmd = "/usr/bin/plymouth";
+	static int has_plymouth = 1;
+	pid_t pid;
+
+	if (!has_plymouth)
+		return 127;
+
+	pid = fork();
+	if (!pid) {
+		int fd = open("/dev/null", O_RDWR);
+		dup2(fd, 0);
+		dup2(fd, 1);
+		dup2(fd, 2);
+		close(fd);
+		execl(cmd, cmd, arg, (char *) NULL);
+		exit(127);
+	} else if (pid > 0) {
+		int status;
+		waitpid(pid, &status, 0);
+		if (status == 127)
+			has_plymouth = 0;
+		return status;
+	}
+	return 1;
+}
+
+/*
  * Fix the tty modes and set reasonable defaults.
  */
 static void tcinit(struct console *con)
 {
 	int mode = 0, flags = 0;
 	struct termios *tio = &con->tio;
-	int fd = con->fd;
+	struct termios lock;
+	int fd = con->fd, i = (plymouth_command("--ping")) ? 20 : 0;
+
+	while (i-- > 0) {
+		/*
+		 * With plymouth the termios flags become changed after this
+		 * function had changed the termios.
+		 */
+		memset(&lock, 0, sizeof(struct termios));
+		if (ioctl(fd, TIOCGLCKTRMIOS, &lock) < 0)
+			break;
+		if (!lock.c_iflag && !lock.c_oflag && !lock.c_cflag && !lock.c_lflag)
+			break;
+		if (i == 15 && plymouth_command("quit") != 0)
+			break;
+		sleep(1);
+	}
+	memset(&lock, 0, sizeof(struct termios));
+	ioctl(fd, TIOCSLCKTRMIOS, &lock);
 
 	errno = 0;
 
diff --git term-utils/agetty.c term-utils/agetty.c
index 7c0579c..fe671a9 100644
--- term-utils/agetty.c
+++ term-utils/agetty.c
@@ -20,6 +20,7 @@
 #include <sys/ioctl.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/wait.h>
 #include <fcntl.h>
 #include <stdarg.h>
 #include <ctype.h>
@@ -276,13 +277,15 @@ static void log_warn (const char *, ...)
 static ssize_t append(char *dest, size_t len, const char  *sep, const char *src);
 static void check_username (const char* nm);
 static void login_options_to_argv(char *argv[], int *argc, char *str, char *username);
+static int plymouth_command(const char* arg);
 
 /* Fake hostname for ut_host specified on command line. */
 static char *fakehost;
 
 #ifdef DEBUGGING
+# include "closestream.h"
 # ifndef DEBUG_OUTPUT
-#  define DEBUG_OUTPUT "/dev/ttyp0"
+#  define DEBUG_OUTPUT "/dev/tty10"
 # endif
 # define debug(s) do { fprintf(dbf,s); fflush(dbf); } while (0)
 FILE *dbf;
@@ -320,8 +323,12 @@ int main(int argc, char **argv)
 
 #ifdef DEBUGGING
 	dbf = fopen(DEBUG_OUTPUT, "w");
-	for (int i = 1; i < argc; i++)
+	for (int i = 1; i < argc; i++) {
+		if (i > 1)
+			debug(" ");
 		debug(argv[i]);
+	}
+	debug("\n");
 #endif				/* DEBUGGING */
 
 	/* Parse command-line arguments. */
@@ -472,7 +479,6 @@ int main(int argc, char **argv)
 	}
 	free(options.osrelease);
 #ifdef DEBUGGING
-	fprintf(dbf, "read %c\n", ch);
 	if (close_stream(dbf) != 0)
 		log_err("write failed: %s", DEBUG_OUTPUT);
 #endif
@@ -1089,6 +1095,27 @@ static void termio_init(struct options *op, struct termios *tp)
 {
 	speed_t ispeed, ospeed;
 	struct winsize ws;
+	struct termios lock;
+	int i =  (plymouth_command("--ping") == 0) ? 30 : 0;
+
+	while (i-- > 0) {
+		/*
+		 * Even with TTYReset=no it seems with systemd or plymouth
+		 * the termios flags become changed from under the first
+		 * agetty on a serial system console as the flags are locked.
+		 */
+		memset(&lock, 0, sizeof(struct termios));
+		if (ioctl(STDIN_FILENO, TIOCGLCKTRMIOS, &lock) < 0)
+			break;
+		if (!lock.c_iflag && !lock.c_oflag && !lock.c_cflag && !lock.c_lflag)
+			break;
+		debug("termios locked\n");
+		if (i == 15 && plymouth_command("quit") != 0)
+			break;
+		sleep(1);
+	}
+	memset(&lock, 0, sizeof(struct termios));
+	ioctl(STDIN_FILENO, TIOCSLCKTRMIOS, &lock);
 
 	if (op->flags & F_VCONSOLE) {
 #if defined(IUTF8) && defined(KDGKBMODE)
@@ -1153,9 +1180,6 @@ static void termio_init(struct options *op, struct termios *tp)
 	 * later on.
 	 */
 
-	 /* Flush input and output queues, important for modems! */
-	tcflush(STDIN_FILENO, TCIOFLUSH);
-
 #ifdef IUTF8
 	tp->c_iflag = tp->c_iflag & IUTF8;
 	if (tp->c_iflag & IUTF8)
@@ -1215,8 +1239,11 @@ static void termio_init(struct options *op, struct termios *tp)
 	if (op->flags & F_RTSCTS)
 		tp->c_cflag |= CRTSCTS;
 #endif
+	 /* Flush input and output queues, important for modems! */
+	tcflush(STDIN_FILENO, TCIOFLUSH);
 
-	tcsetattr(STDIN_FILENO, TCSANOW, tp);
+	if (tcsetattr(STDIN_FILENO, TCSANOW, tp))
+		log_warn(_("setting terminal attributes failed: %m"));
 
 	/* Go to blocking input even in local mode. */
 	fcntl(STDIN_FILENO, F_SETFL,
@@ -1237,6 +1264,10 @@ static void reset_vc(const struct options *op, struct termios *tp)
 
 	if (tcsetattr(STDIN_FILENO, TCSADRAIN, tp))
 		log_warn(_("setting terminal attributes failed: %m"));
+
+	/* Go to blocking input even in local mode. */
+	fcntl(STDIN_FILENO, F_SETFL,
+	      fcntl(STDIN_FILENO, F_GETFL, 0) & ~O_NONBLOCK);
 }
 
 /* Extract baud rate from modem status message. */
@@ -2257,3 +2288,33 @@ err:
 	log_err(_("checkname failed: %m"));
 }
 
+/*
+ * For the case plymouth is found on this system
+ */
+static int plymouth_command(const char* arg)
+{
+	const char *cmd = "/usr/bin/plymouth";
+	static int has_plymouth = 1;
+	pid_t pid;
+
+	if (!has_plymouth)
+		return 127;
+
+	pid = fork();
+	if (!pid) {
+		int fd = open("/dev/null", O_RDWR);
+		dup2(fd, 0);
+		dup2(fd, 1);
+		dup2(fd, 2);
+		close(fd);
+		execl(cmd, cmd, arg, (char *) NULL);
+		exit(127);
+	} else if (pid > 0) {
+		int status;
+		waitpid(pid, &status, 0);
+		if (status == 127)
+			has_plymouth = 0;
+		return status;
+	}
+	return 1;
+}
-- 
1.7.9.2

