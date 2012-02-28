Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33189 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qpj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:39 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so1997660vbb.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:38 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 07/13] sulogin: remove USE_ONELINE and SANE_TIO defines
Date: Tue, 28 Feb 2012 11:45:15 -0500
Message-Id: <1330447521-886-8-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This was only ever compiled in for a single distro, with no clear
indication of why.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.c |   85 +------------------------------------------------
 1 file changed, 1 insertion(+), 84 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 218b17e..b6cbd05 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -63,79 +63,6 @@ struct sigaction saved_sigint;
 struct sigaction saved_sigtstp;
 struct sigaction saved_sigquit;
 
-#ifndef IUCLC
-#  define IUCLC	0
-#endif
-
-#if defined(SANE_TIO) && (SANE_TIO == 1)
-/*
- *	Fix the tty modes and set reasonable defaults.
- *	(I'm not sure if this is needed under Linux, but..)
- */
-static void fixtty(void)
-{
-	struct termios tty;
-	int serial;
-
-	/* Skip serial console */
-	if (ioctl (0, TIOCMGET, (char*)&serial) == 0)
-		goto out;
-	/* Expected error */
-	serial = errno = 0;
-
-	tcgetattr(0, &tty);
-
-	/* Use defaults of <sys/ttydefaults.h> for base settings */
-	tty.c_iflag |= TTYDEF_IFLAG;
-	tty.c_oflag |= TTYDEF_OFLAG;
-	tty.c_lflag |= TTYDEF_LFLAG;
-	tty.c_cflag |= (TTYDEF_SPEED | TTYDEF_CFLAG);
-
-	/* Sane setting, allow eight bit characters, no carriage return delay
-	 * the same result as `stty sane cr0 pass8'
-	 */
-	tty.c_iflag |=  (BRKINT | ICRNL | IMAXBEL);
-#ifdef IUTF8 /* Not defined on FreeBSD */
-	tty.c_iflag |= IUTF8;
-#endif /* IUTF8 */
-	tty.c_iflag &= ~(IGNBRK | INLCR | IGNCR | IXOFF | IUCLC | IXANY | ISTRIP);
-	tty.c_oflag |=  (OPOST | ONLCR | NL0 | CR0 | TAB0 | BS0 | VT0 | FF0);
-	tty.c_oflag &= ~(OLCUC | OCRNL | ONOCR | ONLRET | OFILL | OFDEL |\
-			 NLDLY|CRDLY|TABDLY|BSDLY|VTDLY|FFDLY);
-	tty.c_lflag |=  (ISIG | ICANON | IEXTEN | ECHO|ECHOE|ECHOK|ECHOCTL|ECHOKE);
-	tty.c_lflag &= ~(ECHONL | NOFLSH | XCASE | TOSTOP | ECHOPRT);
-	tty.c_cflag |=  (CREAD | CS8 | B9600);
-	tty.c_cflag &= ~(PARENB);
-
-	/* VTIME and VMIN can overlap with VEOF and VEOL since they are
-	 * only used for non-canonical mode. We just set the at the
-	 * beginning, so nothing bad should happen.
-	 */
-	tty.c_cc[VTIME]    = 0;
-	tty.c_cc[VMIN]     = 1;
-	tty.c_cc[VINTR]    = CINTR;
-	tty.c_cc[VQUIT]    = CQUIT;
-	tty.c_cc[VERASE]   = CERASE; /* ASCII DEL (0177) */
-	tty.c_cc[VKILL]    = CKILL;
-	tty.c_cc[VEOF]     = CEOF;
-	tty.c_cc[VSWTC]    = _POSIX_VDISABLE;
-	tty.c_cc[VSTART]   = CSTART;
-	tty.c_cc[VSTOP]    = CSTOP;
-	tty.c_cc[VSUSP]    = CSUSP;
-	tty.c_cc[VEOL]     = _POSIX_VDISABLE;
-	tty.c_cc[VREPRINT] = CREPRINT;
-	tty.c_cc[VDISCARD] = CDISCARD;
-	tty.c_cc[VWERASE]  = CWERASE;
-	tty.c_cc[VLNEXT]   = CLNEXT;
-	tty.c_cc[VEOL2]    = _POSIX_VDISABLE;
-
-	tcsetattr(0, TCSANOW, &tty);
-out:
-	return;
-}
-#endif
-
-
 /*
  *	Called at timeout.
  */
@@ -366,18 +293,12 @@ static char *getpasswd(char *crypted)
 	static char pass[128];
 	char *ret = pass;
 	int i;
-#if defined(USE_ONELINE)
-	if (crypted[0])
-		printf("Give root password for login: ");
-	else
-		printf("Press enter for login: ");
-#else
+
 	if (crypted[0])
 		printf("Give root password for maintenance\n");
 	else
 		printf("Press enter for maintenance");
 	printf("(or type Control-D to continue): ");
-#endif
 	fflush(stdout);
 
 	tcgetattr(0, &old);
@@ -597,10 +518,6 @@ int main(int argc, char **argv)
 			perror("ioctl(TIOCSCTTY)");
 	}
 
-#if defined(SANE_TIO) && (SANE_TIO == 1)
-	fixtty();
-#endif
-
 	/*
 	 *	Get the root password.
 	 */
-- 
1.7.9.2

