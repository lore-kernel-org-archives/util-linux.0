Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:12686 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752738AbaGOQM6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 Jul 2014 12:12:58 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s6FGCu46028414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <util-linux@vger.kernel.org>; Tue, 15 Jul 2014 12:12:57 -0400
Message-ID: <53C55305.2050501@redhat.com>
Date: Tue, 15 Jul 2014 18:12:53 +0200
From: Stef Walter <stefw@redhat.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt and reprint /etc/issue if we receive
 SIGUSR1
References: <1404718284-4192-1-git-send-email-stefw@redhat.com> <20140715074717.GN30288@x2.net.home> <53C4DED8.2070706@redhat.com> <20140715091907.GQ30288@x2.net.home> <53C52149.6010301@redhat.com>
In-Reply-To: <53C52149.6010301@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------040601050403050405030207"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040601050403050405030207
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 15.07.2014 14:40, Stef Walter wrote:
> On 15.07.2014 11:19, Karel Zak wrote:
>>  Maybe the best would be to implement all within agetty, I mean add
>>  a special command 
>>
>>    agetty --reload [<tty>]
>>
>>  to reload another already running agetty process(es). So rather than
>>  "killall agetty" you have to use "agetty --reload".
>>  
>>  Then all the implementation will be a private thing and only the "--reload"
>>  command line option will be a public API.
> 
> Okay. I'll work on this and keep you posted.

Attached is the updated patch.

The current patch implements --reload. We use inotify on a path in /run
to signal the process. We don't create the file initially until does a
--reload.

Note that I didn't implement the [<tty>] option. It seems like it would
need inotify track multiple files, and as such be prone to races, when
trying to signal all agetty processes.

What do you think?

Stef


--------------040601050403050405030207
Content-Type: text/x-patch;
 name="0001-agetty-Reprompt-and-reprint-etc-issue-when-asked.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-agetty-Reprompt-and-reprint-etc-issue-when-asked.patch"

>From 33583bff1b4dfb3dcff582d1dec9f4005e8bdafd Mon Sep 17 00:00:00 2001
From: Stef Walter <stefw@redhat.com>
Date: Thu, 3 Jul 2014 17:44:41 +0200
Subject: [PATCH] agetty: Reprompt and reprint /etc/issue when asked

Add an 'agetty --reload' command which asks all running agetty
commands to display their prompts again.

Several of the /etc/issue escape codes such as \4 and \S depend on
variable data which can change after the agetty prompt is displayed.
This can cause stale data to be displayed when a user looks at a VT,
especially in cases of DHCP racing with system start up.

We never want this to occur once the user has started typing a
user name. So we detect when the user starts typing, after which
no further reprompting occurs after that point.

Signed-off-by: Stef Walter <stefw@redhat.com>
---
 term-utils/agetty.8 |   5 +++
 term-utils/agetty.c | 126 +++++++++++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 119 insertions(+), 12 deletions(-)

diff --git a/term-utils/agetty.8 b/term-utils/agetty.8
index 27a0d1b..c997129 100644
--- a/term-utils/agetty.8
+++ b/term-utils/agetty.8
@@ -252,6 +252,11 @@ Sleep seconds before open tty.
 \-\-nice \fInumber\fP
 Run login with this priority.
 .TP
+\-\-reload
+Ask all running agetty instances to reload and update their displayed prompts,
+if the user has not yet commenced logging in. After doing so the command will
+exit.
+.TP
 \-\-version
 Display version information and exit.
 .TP
diff --git a/term-utils/agetty.c b/term-utils/agetty.c
index 2b5932d..d92da80 100644
--- a/term-utils/agetty.c
+++ b/term-utils/agetty.c
@@ -18,6 +18,7 @@
 #include <signal.h>
 #include <errno.h>
 #include <sys/ioctl.h>
+#include <sys/inotify.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <sys/wait.h>
@@ -112,6 +113,9 @@
 #define LOGIN		"login: "
 #define LOGIN_ARGV_MAX	16		/* Numbers of args for login */
 
+/* Reload trigger file */
+#define GETTY_RELOAD_TRIGGER "/run/agetty.reload"
+
 /*
  * When multiple baud rates are specified on the command line, the first one
  * we will try is the first one specified.
@@ -281,10 +285,14 @@ static ssize_t append(char *dest, size_t len, const char  *sep, const char *src)
 static void check_username (const char* nm);
 static void login_options_to_argv(char *argv[], int *argc, char *str, char *username);
 static int plymouth_command(const char* arg);
+static void reload_agettys(void);
 
 /* Fake hostname for ut_host specified on command line. */
 static char *fakehost;
 
+/* Indicates whether we've been asked (via a signal) to reprompt */
+static int inotify_fd = -1;
+
 #ifdef DEBUGGING
 # include "closestream.h"
 # ifndef DEBUG_OUTPUT
@@ -334,6 +342,10 @@ int main(int argc, char **argv)
 	debug("\n");
 #endif				/* DEBUGGING */
 
+	inotify_fd = inotify_init1(IN_NONBLOCK | IN_CLOEXEC);
+	if (inotify_fd > 0)
+		inotify_add_watch (inotify_fd, GETTY_RELOAD_TRIGGER, IN_ATTRIB | IN_MODIFY);
+
 	/* Parse command-line arguments. */
 	parse_args(argc, argv, &options);
 
@@ -587,6 +599,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 		HELP_OPTION,
 		ERASE_CHARS_OPTION,
 		KILL_CHARS_OPTION,
+		RELOAD_OPTION,
 	};
 	const struct option longopts[] = {
 		{  "8bits",	     no_argument,	 0,  '8'  },
@@ -618,6 +631,7 @@ static void parse_args(int argc, char **argv, struct options *op)
 		{  "nohints",        no_argument,        0,  NOHINTS_OPTION },
 		{  "nohostname",     no_argument,	 0,  NOHOSTNAME_OPTION },
 		{  "long-hostname",  no_argument,	 0,  LONGHOSTNAME_OPTION },
+		{  "reload",         no_argument,        0,  RELOAD_OPTION },
 		{  "version",	     no_argument,	 0,  VERSION_OPTION  },
 		{  "help",	     no_argument,	 0,  HELP_OPTION     },
 		{  "erase-chars",    required_argument,  0,  ERASE_CHARS_OPTION },
@@ -736,6 +750,9 @@ static void parse_args(int argc, char **argv, struct options *op)
 		case KILL_CHARS_OPTION:
 			op->killchars = optarg;
 			break;
+		case RELOAD_OPTION:
+			reload_agettys();
+			exit(EXIT_SUCCESS);
 		case VERSION_OPTION:
 			printf(_("%s from %s\n"), program_invocation_short_name,
 			       PACKAGE_STRING);
@@ -1114,6 +1131,21 @@ static void open_tty(char *tty, struct termios *tp, struct options *op)
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
@@ -1166,18 +1198,8 @@ static void termio_init(struct options *op, struct termios *tp)
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
 
@@ -1593,6 +1615,60 @@ static void next_speed(struct options *op, struct termios *tp)
 	tcsetattr(STDIN_FILENO, TCSANOW, tp);
 }
 
+static int wait_for_term_input(int fd)
+{
+	char buffer[sizeof(struct inotify_event) + NAME_MAX + 1];
+	struct termios orig, nonc;
+	fd_set rfds;
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
+	FD_ZERO(&rfds);
+	FD_SET(fd, &rfds);
+	if (inotify_fd >= 0)
+		FD_SET(inotify_fd, &rfds);
+
+	/* If waiting fails, just fall through, presumably reading input will fail */
+	if (select (MAX(fd, inotify_fd) + 1, &rfds, NULL, NULL, NULL) < 0)
+		return 1;
+
+	if (FD_ISSET(fd, &rfds)) {
+		count = read(fd, buffer, sizeof (buffer));
+
+		tcsetattr(fd, TCSANOW, &orig);
+
+		/* Reinject the bytes we read back into the buffer, usually just one byte */
+		for (i = 0; i < count; i++)
+			ioctl(fd, TIOCSTI, buffer + i);
+
+		/* Have terminal input */
+		return 1;
+
+	} else {
+		tcsetattr(fd, TCSANOW, &orig);
+
+		/* Just drain the inotify buffer */
+		while (read(inotify_fd, buffer, sizeof (buffer)) > 0);
+
+		/* Need to reprompt */
+		return 0;
+	}
+}
+
 /* Get user name, establish parity, speed, erase, kill & eol. */
 static char *get_logname(struct options *op, struct termios *tp, struct chardata *cp)
 {
@@ -1628,6 +1704,13 @@ static char *get_logname(struct options *op, struct termios *tp, struct chardata
 		/* Write issue file and prompt */
 		do_prompt(op, tp);
 
+		/* If asked to reprompt *before* terminal input arrives, then do so */
+		if (!wait_for_term_input(STDIN_FILENO)) {
+			if (op->flags & F_VCONSOLE)
+				termio_clear(STDOUT_FILENO);
+			continue;
+		}
+
 		cp->eol = '\0';
 
 		/* Read name, watch for break and end-of-line. */
@@ -2364,3 +2447,22 @@ static int plymouth_command(const char* arg)
 	}
 	return 1;
 }
+
+static void reload_agettys(void)
+{
+	struct timeval tv[2];
+	int fd;
+
+	if (gettimeofday (tv, NULL) < 0)
+		err (1, "couldn't get current time");
+	memcpy (tv, tv + 1, sizeof (struct timeval));
+
+	fd = open(GETTY_RELOAD_TRIGGER, O_CREAT|O_CLOEXEC|O_WRONLY, 0700);
+	if (fd < 0)
+		err (1, "couldn't open: %s", GETTY_RELOAD_TRIGGER);
+
+	if (futimes (fd, tv) < 0 || close (fd) < 0)
+		err (1, "couldn't touch file: %s", GETTY_RELOAD_TRIGGER);
+
+	close (fd);
+}
-- 
1.9.3


--------------040601050403050405030207--
