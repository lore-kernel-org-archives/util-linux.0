Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36995 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752800Ab3LBRCN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 2 Dec 2013 12:02:13 -0500
Date: Mon, 2 Dec 2013 18:02:08 +0100
From: Karel Zak <kzak@redhat.com>
To: Phillip Susi <psusi@ubuntu.com>
Cc: util-linux@vger.kernel.org
Subject: Re: script input redirection / eof handling
Message-ID: <20131202170208.GI5572@x2.net.home>
References: <52726756.8060205@ubuntu.com>
 <20131202123659.GE5572@x2.net.home>
 <20131202125421.GF5572@x2.net.home>
 <529C9CFF.5030709@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <529C9CFF.5030709@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Dec 02, 2013 at 09:45:19AM -0500, Phillip Susi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 12/2/2013 7:54 AM, Karel Zak wrote:
> > Note, that if you want to support this scenario (stdin is not a 
> > terminal) then send a patch ;-)
> 
> It seems to work fine up until it hits eof, which can also happen on a

 well, it's nasty that the code ignores return codes and it call's tty
 ioctls/functions for non-tty file descriptors.

> tty and you'll get the same bad behavior, so I think refusing to run
> on a non tty isn't a proper fix.
> 
> >> Yep, I think it would be enough to add
> >> 
> >> kill(0, SIGTERM);
> >> 
> >> before done() in doinput() to avoid orphans.
> 
> You don't want to just make sure the children die, you want to make
> sure that the child sees the eof and capture any final output it may have.

 never ending orphans suck...

 The possible solution (hack) to emulate end-of-file is by write "exit\n" to 
 the master tty. For example patch below works for me (it also make it
 more robust for non-ttys).

    Karel

diff --git a/term-utils/script.c b/term-utils/script.c
index c18274c..8437ec8 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -107,6 +107,7 @@ int	fflg = 0;
 int	qflg = 0;
 int	tflg = 0;
 int	forceflg = 0;
+int	isterm;
 
 int die;
 int resized;
@@ -230,9 +231,6 @@ main(int argc, char **argv) {
 		die_if_link(fname);
 	}
 
-	if (!isatty(STDIN_FILENO))
-		errx(EXIT_FAILURE, _("The stdin is not a terminal."));
-
 	if ((fscript = fopen(fname, aflg ? "a" : "w")) == NULL) {
 		warn(_("cannot open %s"), fname);
 		fail();
@@ -314,11 +312,21 @@ doinput(void) {
 		else if (cc < 0 && errno == EINTR && resized)
 		{
 			/* transmit window change information to the child */
-			ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&win);
-			ioctl(slave, TIOCSWINSZ, (char *)&win);
+			if (isterm) {
+				ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&win);
+				ioctl(slave, TIOCSWINSZ, (char *)&win);
+			}
 			resized = 0;
-		}
-		else
+		} else if (cc == 0 && errno == 0) {
+			/* end-of-file, probably "foo | script" */
+			strcpy(ibuf, "exit\n");
+			if (write(master, ibuf, 5) < 0) {
+				warn (_("write failed"));
+				fail();
+			}
+			pause();		/* wait for SIGCHLD */
+			break;
+		} else
 			break;
 	}
 
@@ -473,6 +481,9 @@ void
 fixtty(void) {
 	struct termios rtt;
 
+	if (!isterm)
+		return;
+
 	rtt = tt;
 	cfmakeraw(&rtt);
 	rtt.c_lflag &= ~ECHO;
@@ -503,7 +514,8 @@ done(void) {
 
 		master = -1;
 	} else {
-		tcsetattr(STDIN_FILENO, TCSADRAIN, &tt);
+		if (isterm)
+			tcsetattr(STDIN_FILENO, TCSADRAIN, &tt);
 		if (!qflg)
 			printf(_("Script done, file is %s\n"), fname);
 #ifdef HAVE_LIBUTEMPTER
@@ -524,9 +536,19 @@ done(void) {
 void
 getmaster(void) {
 #if defined(HAVE_LIBUTIL) && defined(HAVE_PTY_H)
-	tcgetattr(STDIN_FILENO, &tt);
-	ioctl(STDIN_FILENO, TIOCGWINSZ, (char *)&win);
-	if (openpty(&master, &slave, NULL, &tt, &win) < 0) {
+	int rc;
+
+	isterm = isatty(STDIN_FILENO);
+
+	if (isterm) {
+		if (tcgetattr(STDIN_FILENO, &tt) != 0)
+			err(EXIT_FAILURE, _("failed to get terminal attributes"));
+		ioctl(STDIN_FILENO, TIOCGWINSZ, (char *) &win);
+		rc = openpty(&master, &slave, NULL, &tt, &win);
+	} else
+		rc = openpty(&master, &slave, NULL, NULL, NULL);
+
+	if (rc < 0) {
 		warn(_("openpty failed"));
 		fail();
 	}
@@ -534,6 +556,8 @@ getmaster(void) {
 	char *pty, *bank, *cp;
 	struct stat stb;
 
+	isterm = isatty(STDIN_FILENO);
+
 	pty = &line[strlen("/dev/ptyp")];
 	for (bank = "pqrs"; *bank; bank++) {
 		line[strlen("/dev/pty")] = *bank;
@@ -552,9 +576,11 @@ getmaster(void) {
 				ok = access(line, R_OK|W_OK) == 0;
 				*tp = 'p';
 				if (ok) {
-					tcgetattr(STDIN_FILENO, &tt);
-					ioctl(STDIN_FILENO, TIOCGWINSZ,
-						(char *)&win);
+					if (isterm) {
+						tcgetattr(STDIN_FILENO, &tt);
+						ioctl(STDIN_FILENO, TIOCGWINSZ,
+								(char *)&win);
+					}
 					return;
 				}
 				close(master);
@@ -577,8 +603,10 @@ getslave(void) {
 		warn(_("cannot open %s"), line);
 		fail();
 	}
-	tcsetattr(slave, TCSANOW, &tt);
-	ioctl(slave, TIOCSWINSZ, (char *)&win);
+	if (isterm) {
+		tcsetattr(slave, TCSANOW, &tt);
+		ioctl(slave, TIOCSWINSZ, (char *)&win);
+	}
 #endif
 	setsid();
 	ioctl(slave, TIOCSCTTY, 0);
