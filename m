Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 32/49] login: move signal stuff to the one place
Date: Mon, 17 Oct 2011 13:15:11 +0200
Message-Id: <1318850128-23458-33-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |  166 +++++++++++++++++++++++++--------------------------
 1 files changed, 82 insertions(+), 84 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 52598f4..ffde1af 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -122,10 +122,88 @@ static int timeout = LOGIN_TIMEOUT;
 static int child_pid = 0;
 static volatile int got_sig = 0;
 
-static void timedout(int);
-static void sigint(int);
-static void motd(void);
-static void sleepexit(int eval);
+jmp_buf motdinterrupt;
+
+/*
+ * Robert Ambrose writes:
+ * A couple of my users have a problem with login processes hanging around
+ * soaking up pts's.  What they seem to hung up on is trying to write out the
+ * message 'Login timed out after %d seconds' when the connection has already
+ * been dropped.
+ * What I did was add a second timeout while trying to write the message so
+ * the process just exits if the second timeout expires.
+ */
+static void timedout2(int sig __attribute__ ((__unused__)))
+{
+	struct termios ti;
+
+	/* reset echo */
+	tcgetattr(0, &ti);
+	ti.c_lflag |= ECHO;
+	tcsetattr(0, TCSANOW, &ti);
+	exit(EXIT_SUCCESS);	/* %% */
+}
+
+static void timedout(int sig __attribute__ ((__unused__)))
+{
+	signal(SIGALRM, timedout2);
+	alarm(10);
+	/* TRANSLATORS: The standard value for %d is 60. */
+	warnx(_("timed out after %d seconds"), timeout);
+	signal(SIGALRM, SIG_IGN);
+	alarm(0);
+	timedout2(0);
+}
+
+/*
+ * This handler allows to inform a shell about signals to login. If you have
+ * (root) permissions you can kill all login childrent by one signal to login
+ * process.
+ *
+ * Also, parent who is session leader is able (before setsid() in child) to
+ * inform child when controlling tty goes away (e.g. modem hangup, SIGHUP).
+ */
+static void sig_handler(int signal)
+{
+	if (child_pid)
+		kill(-child_pid, signal);
+	else
+		got_sig = 1;
+	if (signal == SIGTERM)
+		kill(-child_pid, SIGHUP);	/* because the shell often ignores SIGTERM */
+}
+
+static void sigint(int sig __attribute__ ((__unused__)))
+{
+	longjmp(motdinterrupt, 1);
+}
+
+
+/* Should not be called from PAM code... */
+static void sleepexit(int eval)
+{
+	sleep(LOGIN_EXIT_TIMEOUT);
+	exit(eval);
+}
+
+static void motd(void)
+{
+	int fd, nchars;
+	void (*oldint) (int);
+	char tbuf[8192];
+
+	if ((fd = open(_PATH_MOTDFILE, O_RDONLY, 0)) < 0)
+		return;
+	oldint = signal(SIGINT, sigint);
+	if (setjmp(motdinterrupt) == 0)
+		while ((nchars = read(fd, tbuf, sizeof(tbuf))) > 0) {
+			if (write(fileno(stdout), tbuf, nchars)) {
+				;	/* glibc warn_unused_result */
+			}
+		}
+	signal(SIGINT, oldint);
+	close(fd);
+}
 
 /*
  * Nice and simple code provided by Linus Torvalds 16-Feb-93
@@ -337,23 +415,6 @@ static void log_btmp(struct login_context *cxt)
 	updwtmp(_PATH_BTMP, &ut);
 }
 
-/*
- * This handler allows to inform a shell about signals to login. If you have
- * (root) permissions you can kill all login childrent by one signal to login
- * process.
- *
- * Also, parent who is session leader is able (before setsid() in child) to
- * inform child when controlling tty goes away (e.g. modem hangup, SIGHUP).
- */
-static void sig_handler(int signal)
-{
-	if (child_pid)
-		kill(-child_pid, signal);
-	else
-		got_sig = 1;
-	if (signal == SIGTERM)
-		kill(-child_pid, SIGHUP);	/* because the shell often ignores SIGTERM */
-}
 
 #ifdef HAVE_LIBAUDIT
 static void log_audit(struct login_context *cxt, int status)
@@ -1255,67 +1316,4 @@ int main(int argc, char **argv)
 	exit(EXIT_SUCCESS);
 }
 
-/*
- * Robert Ambrose writes:
- * A couple of my users have a problem with login processes hanging around
- * soaking up pts's.  What they seem to hung up on is trying to write out the
- * message 'Login timed out after %d seconds' when the connection has already
- * been dropped.
- * What I did was add a second timeout while trying to write the message so
- * the process just exits if the second timeout expires.
- */
-static void timedout2(int sig __attribute__ ((__unused__)))
-{
-	struct termios ti;
-
-	/* reset echo */
-	tcgetattr(0, &ti);
-	ti.c_lflag |= ECHO;
-	tcsetattr(0, TCSANOW, &ti);
-	exit(EXIT_SUCCESS);	/* %% */
-}
 
-static void timedout(int sig __attribute__ ((__unused__)))
-{
-	signal(SIGALRM, timedout2);
-	alarm(10);
-	/* TRANSLATORS: The standard value for %d is 60. */
-	warnx(_("timed out after %d seconds"), timeout);
-	signal(SIGALRM, SIG_IGN);
-	alarm(0);
-	timedout2(0);
-}
-
-jmp_buf motdinterrupt;
-
-static void motd(void)
-{
-	int fd, nchars;
-	void (*oldint) (int);
-	char tbuf[8192];
-
-	if ((fd = open(_PATH_MOTDFILE, O_RDONLY, 0)) < 0)
-		return;
-	oldint = signal(SIGINT, sigint);
-	if (setjmp(motdinterrupt) == 0)
-		while ((nchars = read(fd, tbuf, sizeof(tbuf))) > 0) {
-			if (write(fileno(stdout), tbuf, nchars)) {
-				;	/* glibc warn_unused_result */
-			}
-		}
-	signal(SIGINT, oldint);
-	close(fd);
-}
-
-static void sigint(int sig __attribute__ ((__unused__)))
-{
-	longjmp(motdinterrupt, 1);
-}
-
-
-/* Should not be called from PAM code... */
-static void sleepexit(int eval)
-{
-	sleep(LOGIN_EXIT_TIMEOUT);
-	exit(eval);
-}
-- 
1.7.6.4
