Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:56879 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab2JHHI6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:08:58 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr7so3225349wib.1
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:08:58 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/14] pg: use unistd.h STDOUT_FILENO
Date: Mon,  8 Oct 2012 08:08:14 +0100
Message-Id: <1349680100-18120-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/pg.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/text-utils/pg.c b/text-utils/pg.c
index 4b3b668..dedcfb9 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -288,7 +288,7 @@ static int
 outcap(int i)
 {
 	char c = i;
-	return write_all(1, &c, 1) == 0 ? 1 : -1;
+	return write_all(STDOUT_FILENO, &c, 1) == 0 ? 1 : -1;
 }
 
 /*
@@ -301,7 +301,7 @@ mesg(const char *message)
 		return;
 	if (*message != '\n' && sflag)
 		vidputs(A_STANDOUT, outcap);
-	write_all(1, message, strlen(message));
+	write_all(STDOUT_FILENO, message, strlen(message));
 	if (*message != '\n' && sflag)
 		vidputs(A_NORMAL, outcap);
 }
@@ -338,7 +338,7 @@ getwinsize(void)
 		initialized = 1;
 	}
 #ifdef	TIOCGWINSZ
-	badioctl = ioctl(1, TIOCGWINSZ, &winsz);
+	badioctl = ioctl(STDOUT_FILENO, TIOCGWINSZ, &winsz);
 #endif
 	if (envcols)
 		ttycols = envcols - 1;
@@ -380,7 +380,7 @@ sighandler(int signum)
 {
 	if (canjump && (signum == SIGINT || signum == SIGQUIT))
 		longjmp(jmpenv, signum);
-	tcsetattr(1, TCSADRAIN, &otio);
+	tcsetattr(STDOUT_FILENO, TCSADRAIN, &otio);
 	quit(exitstatus);
 }
 
@@ -553,7 +553,7 @@ cline(void)
 	memset(buf, ' ', ttycols + 2);
 	buf[0] = '\r';
 	buf[ttycols + 1] = '\r';
-	write_all(1, buf, ttycols + 2);
+	write_all(STDOUT_FILENO, buf, ttycols + 2);
 	free(buf);
 }
 
@@ -583,7 +583,7 @@ getstate(int c)
 	default:
 #ifdef PG_BELL
 		if (bell)
-			tputs(bell, 1, outcap);
+			tputs(bell, STDOUT_FILENO, outcap);
 #endif  /*  PG_BELL  */
 		return INVALID;
 	}
@@ -649,21 +649,21 @@ prompt(long long pageno)
 	}
 	cmd.key = cmd.addon = cmd.cmdline[0] = '\0';
 	cmd.cmdlen = 0;
-	tcgetattr(1, &tio);
+	tcgetattr(STDOUT_FILENO, &tio);
 	tio.c_lflag &= ~(ICANON | ECHO);
 	tio.c_cc[VMIN] = 1;
 	tio.c_cc[VTIME] = 0;
-	tcsetattr(1, TCSADRAIN, &tio);
-	tcflush(1, TCIFLUSH);
+	tcsetattr(STDOUT_FILENO, TCSADRAIN, &tio);
+	tcflush(STDOUT_FILENO, TCIFLUSH);
 	for (;;) {
-		switch (read(1, &key, 1)) {
+		switch (read(STDOUT_FILENO, &key, 1)) {
 		case 0: quit(0);
 			/*NOTREACHED*/
 		case -1: quit(1);
 		}
 		if (key == tio.c_cc[VERASE]) {
 			if (cmd.cmdlen) {
-				write_all(1, "\b \b", 3);
+				write_all(STDOUT_FILENO, "\b \b", 3);
 				cmd.cmdline[--cmd.cmdlen] = '\0';
 				switch (state) {
 				case ADDON_FIN:
@@ -766,14 +766,14 @@ prompt(long long pageno)
 				cmd.key = key;
 			}
 		}
-		write_all(1, &key, 1);
+		write_all(STDOUT_FILENO, &key, 1);
 		cmd.cmdline[cmd.cmdlen++] = key;
 		cmd.cmdline[cmd.cmdlen] = '\0';
 		if (nflag && state == CMD_FIN)
 			goto endprompt;
 	}
 endprompt:
-	tcsetattr(1, TCSADRAIN, &otio);
+	tcsetattr(STDOUT_FILENO, TCSADRAIN, &otio);
 	cline();
 	cmd.count = getcount(cmd.cmdline);
 }
@@ -1007,7 +1007,7 @@ pgfile(FILE *f, const char *name)
 		 * Just copy stdin to stdout.
 		 */
 		while ((sz = fread(b, sizeof *b, READBUF, f)) != 0)
-			write_all(1, b, sz);
+			write_all(STDOUT_FILENO, b, sz);
 		if (ferror(f)) {
 			warn("%s", name);
 			exitstatus++;
@@ -1147,7 +1147,7 @@ pgfile(FILE *f, const char *name)
 			if (cflag && clear_screen) {
 				switch (dline) {
 				case 0:
-					tputs(clear_screen, 1, outcap);
+					tputs(clear_screen, STDOUT_FILENO, outcap);
 					dline = 0;
 				}
 			}
@@ -1167,7 +1167,7 @@ pgfile(FILE *f, const char *name)
 				sz = p - b;
 				makeprint(b, sz);
 				canjump = 1;
-				write_all(1, b, sz);
+				write_all(STDOUT_FILENO, b, sz);
 				canjump = 0;
 			}
 		}
@@ -1457,9 +1457,9 @@ found_bw:
 				} else {
 					pid_t cpid;
 
-					write_all(1, cmd.cmdline,
+					write_all(STDOUT_FILENO, cmd.cmdline,
 					      strlen(cmd.cmdline));
-					write_all(1, "\n", 1);
+					write_all(STDOUT_FILENO, "\n", 1);
 					my_sigset(SIGINT, SIG_IGN);
 					my_sigset(SIGQUIT, SIG_IGN);
 					switch (cpid = fork()) {
@@ -1501,8 +1501,8 @@ found_bw:
 				 * Help!
 				 */
 				const char *help = _(helpscreen);
-				write_all(1, copyright, strlen(copyright));
-				write_all(1, help, strlen(help));
+				write_all(STDOUT_FILENO, copyright, strlen(copyright));
+				write_all(STDOUT_FILENO, help, strlen(help));
 				goto newcmd;
 			}
 			case 'n':
@@ -1636,9 +1636,9 @@ parse_arguments(int arg, int argc, char **argv)
 			/*
 			 * Use the prefix as specified by SUSv2.
 			 */
-			write_all(1, "::::::::::::::\n", 15);
-			write_all(1, argv[arg], strlen(argv[arg]));
-			write_all(1, "\n::::::::::::::\n", 16);
+			write_all(STDOUT_FILENO, "::::::::::::::\n", 15);
+			write_all(STDOUT_FILENO, argv[arg], strlen(argv[arg]));
+			write_all(STDOUT_FILENO, "\n::::::::::::::\n", 16);
 		}
 		pgfile(input, argv[arg]);
 		if (input != stdin)
@@ -1662,15 +1662,15 @@ main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	if (tcgetattr(1, &otio) == 0) {
+	if (tcgetattr(STDOUT_FILENO, &otio) == 0) {
 		ontty = 1;
 		oldint = my_sigset(SIGINT, sighandler);
 		oldquit = my_sigset(SIGQUIT, sighandler);
 		oldterm = my_sigset(SIGTERM, sighandler);
 		setlocale(LC_CTYPE, "");
 		setlocale(LC_COLLATE, "");
-		tty = ttyname(1);
-		setupterm(NULL, 1, &tinfostat);
+		tty = ttyname(STDOUT_FILENO);
+		setupterm(NULL, STDOUT_FILENO, &tinfostat);
 		getwinsize();
 		helpscreen = _(helpscreen);
 	}
-- 
1.7.12.2

