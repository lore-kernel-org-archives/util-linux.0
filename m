Return-Path: util-linux-owner@vger.kernel.org
Received: from thewalter.net ([94.75.203.101]:54879 "EHLO thewalter.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751227AbaGGHhp (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 Jul 2014 03:37:45 -0400
From: Stef Walter <stefw@redhat.com>
To: util-linux@vger.kernel.org
Cc: Stef Walter <stefw@redhat.com>
Subject: [PATCH] agetty: Reprompt and reprint /etc/issue if we receive SIGUSR1
Date: Mon,  7 Jul 2014 09:31:24 +0200
Message-Id: <1404718284-4192-1-git-send-email-stefw@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Several of the /etc/issue escape codes such as \4 and \S depend on
variable data which can change after the agetty prompt is displayed.
This can cause stale data to be displayed when a user looks at a VT,
especially in cases of DHCP racing with system start up.

This commit allows agetty to react a SIGUSR1 signal by reprinting
its prompt including the reprocessing of /etc/issue.

We never want this to occur once the user has started typing a
user name. So we detect when the user starts typing, after which
no further reprompting occurs even if SIGUSR1 is received.

Signed-off-by: Stef Walter <stefw@redhat.com>
---
 term-utils/agetty.8 |  9 +++++-
 term-utils/agetty.c | 86 +++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 81 insertions(+), 14 deletions(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 27a0d1b..b11dd4b 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -385,7 +385,14 @@ displays as:
 This is thingol.orcan.dk (Linux i386 1.1.9) 18:29:30
 .fi
 .RE
-
+.SH SIGNALS
+Upon receiving
+.BR SIGUSR1
+.BR agetty
+will reprint the
+.B /etc/issue
+(if so configured) and login prompt. It will do this unless the
+user has started typing a login name.
 .SH FILES
 .na
 .TP
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 2b5932d..3e38107 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -270,6 +270,7 @@ static char *get_logname(struct options *op,
 			 struct termios *tp, struct chardata *cp);
 static void termio_final(struct options *op,
 			 struct termios *tp, struct chardata *cp);
+static void sig_usr1_handler(int sig);
 static int caps_lock(char *s);
 static speed_t bcode(char *s);
 static void usage(FILE * out) __attribute__((__noreturn__));
@@ -285,6 +286,9 @@ static int plymouth_command(const char* arg);
 /* Fake hostname for ut_host specified on command line. */
 static char *fakehost;
 
+/* Indicates whether we've been asked (via a signal) to reprompt */
+static int reprompt_flag;
+
 #ifdef DEBUGGING
 # include "closestream.h"
 # ifndef DEBUG_OUTPUT
@@ -309,7 +313,7 @@ int main(int argc, char **argv)
 	};
 	char *login_argv[LOGIN_ARGV_MAX + 1];
 	int login_argc = 0;
-	struct sigaction sa, sa_hup, sa_quit, sa_int;
+	struct sigaction sa, sa_hup, sa_quit, sa_int, sa_usr1;
 	sigset_t set;
 
 	setlocale(LC_ALL, "");
@@ -324,6 +328,12 @@ int main(int argc, char **argv)
 	sigaction(SIGQUIT, &sa, &sa_quit);
 	sigaction(SIGINT, &sa, &sa_int);
 
+	/* Signal to restart prompting */
+	memset(&sa_usr1, 0, sizeof (sa_usr1));
+	sa_usr1.sa_handler = sig_usr1_handler;
+	sigemptyset (&sa_usr1.sa_mask);
+	sigaction(SIGUSR1, &sa_usr1, NULL);
+
 #ifdef DEBUGGING
 	dbf = fopen(DEBUG_OUTPUT, "w");
 	for (int i = 1; i < argc; i++) {
@@ -824,6 +834,11 @@ static void parse_args(int argc, char **argv, struct options *op)
 	debug("exiting parseargs\n");
 }
 
+static void sig_usr1_handler(int sig)
+{
+	reprompt_flag = sig;
+}
+
 /* Parse alternate baud rates. */
 static void parse_speeds(struct options *op, char *arg)
 {
@@ -1114,6 +1129,21 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
 }
 
 /* Initialize termios settings. */
+static void termio_clear(int fd)
+{
+	/*
+	 * Do not write a full reset (ESC c) because this destroys
+	 * the unicode mode again if the terminal was in unicode
+	 * mode.  Also it clears the CONSOLE_MAGIC features which
+	 * are required for some languages/console-fonts.
+	 * Just put the cursor to the home position (ESC [ H),
+	 * erase everything below the cursor (ESC [ J), and set the
+	 * scrolling region to the full window (ESC [ r)
+	 */
+	write_all(fd, "\033[r\033[H\033[J", 9);
+}
+
+/* Initialize termios settings. */
 static void termio_init(struct options *op, struct termios *tp)
 {
 	speed_t ispeed, ospeed;
@@ -1166,18 +1196,8 @@ static void termio_init(struct options *op, struct termios *tp)
 		if ((tp->c_cflag & (CS8|PARODD|PARENB)) == CS8)
 			op->flags |= F_EIGHTBITS;
 
-		if ((op->flags & F_NOCLEAR) == 0) {
-			/*
-			 * Do not write a full reset (ESC c) because this destroys
-			 * the unicode mode again if the terminal was in unicode
-			 * mode.  Also it clears the CONSOLE_MAGIC features which
-			 * are required for some languages/console-fonts.
-			 * Just put the cursor to the home position (ESC [ H),
-			 * erase everything below the cursor (ESC [ J), and set the
-			 * scrolling region to the full window (ESC [ r)
-			 */
-			write_all(STDOUT_FILENO, "\033[r\033[H\033[J", 9);
-		}
+		if ((op->flags & F_NOCLEAR) == 0)
+			termio_clear(STDOUT_FILENO);
 		return;
 	}
 
@@ -1593,6 +1613,37 @@ static void next_speed(struct options *op, struct termios *tp)
 	tcsetattr(STDIN_FILENO, TCSANOW, tp);
 }
 
+static int wait_for_term_input(int fd)
+{
+	struct termios orig, nonc;
+	char input[32];
+	int count;
+	int i;
+
+	/* Our aim here is to fall through if something fails
+         * and not be stuck waiting. On failure assume we have input */
+
+	if (tcgetattr(fd, &orig) != 0)
+		return 1;
+
+	memcpy(&nonc, &orig, sizeof (nonc));
+	nonc.c_lflag &= ~(ICANON | ECHO | ECHOE | ECHOK | ECHOKE);
+	nonc.c_cc[VMIN] = 1;
+	nonc.c_cc[VTIME] = 0;
+
+	if (tcsetattr(fd, TCSANOW, &nonc) != 0)
+		return 1;
+
+	count = read(fd, input, sizeof (input));
+	tcsetattr(fd, TCSANOW, &orig);
+
+	/* Reinject the bytes we read back into the buffer */
+	for (i = 0; i < count; i++)
+		ioctl(fd, TIOCSTI, input + i);
+
+	return count > 0;
+}
+
 /* Get user name, establish parity, speed, erase, kill & eol. */
 static char *get_logname(struct options *op, struct termios *tp, struct chardata *cp)
 {
@@ -1625,9 +1676,18 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
 
 	while (*logname == '\0') {
 
+		reprompt_flag = 0;
+
 		/* Write issue file and prompt */
 		do_prompt(op, tp);
 
+		/* If asked to reprompt *before* terminal input arrives, then do so */
+		if (!wait_for_term_input(STDIN_FILENO) && reprompt_flag != 0) {
+			if (op->flags & F_VCONSOLE)
+				termio_clear(STDOUT_FILENO);
+			continue;
+		}
+
 		cp->eol = '\0';
 
 		/* Read name, watch for break and end-of-line. */
-- 
1.9.3

