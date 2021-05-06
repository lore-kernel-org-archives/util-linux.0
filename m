Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD3EC433B4
	for <util-linux@archiver.kernel.org>; Thu,  6 May 2021 10:54:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EDB761040
	for <util-linux@archiver.kernel.org>; Thu,  6 May 2021 10:54:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234616AbhEFKzQ (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 6 May 2021 06:55:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:57006 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234614AbhEFKzN (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 May 2021 06:55:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BBD34AC1A
        for <util-linux@vger.kernel.org>; Thu,  6 May 2021 10:54:14 +0000 (UTC)
Date:   Thu, 6 May 2021 12:54:12 +0200
From:   Werner Fink <werner@suse.de>
To:     util-linux@vger.kernel.org
Cc:     werner@suse.de
Subject: [PATCH] sulogin: ignore not existing console devices
Message-ID: <YJPK1JUPtKTuMJ1J@boole.suse.de>
Mail-Followup-To: util-linux@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="dmITk4gbmOfpHNxn"
Content-Disposition: inline
X-GPG-Fingerprint: 1B06 BF5A 3829 90FB CBA2  75BE 50E9 0D55 1DC1 6B2E
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--dmITk4gbmOfpHNxn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

and also not functional console devices. Redirect the error
messages to the appropiate console device.

Signed-off-by: Werner Fink <werner@suse.de>

---
 login-utils/sulogin-consoles.h |  1 +
 login-utils/sulogin.c          | 97 +++++++++++++++++++++++++++++++++++---=
----
 2 files changed, 82 insertions(+), 16 deletions(-)

diff --git a/login-utils/sulogin-consoles.h b/login-utils/sulogin-consoles.h
index 0bfbc3871..12032c997 100644
--- a/login-utils/sulogin-consoles.h
+++ b/login-utils/sulogin-consoles.h
@@ -40,6 +40,7 @@ struct console {
 	int fd, id;
 #define	CON_SERIAL	0x0001
 #define	CON_NOTTY	0x0002
+#define	CON_EIO		0x0004
 	pid_t pid;
 	struct chardata cp;
 	struct termios tio;
diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 9091caf14..c833796e7 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -52,6 +52,7 @@
 #ifdef __linux__
 # include <sys/kd.h>
 # include <sys/param.h>
+# include <linux/serial.h>
 #endif
=20
 #include "c.h"
@@ -104,6 +105,9 @@ static void tcinit(struct console *con)
 	int flags =3D 0, mode =3D 0;
 	struct termios *tio =3D &con->tio;
 	const int fd =3D con->fd;
+#if defined(TIOCGSERIAL)
+	struct serial_struct serinfo;
+#endif
 #ifdef USE_PLYMOUTH_SUPPORT
 	struct termios lock;
 	int i =3D (plymouth_command(MAGIC_PING)) ? PLYMOUTH_TERMIOS_FLAGS_DELAY :=
 0;
@@ -123,27 +127,72 @@ static void tcinit(struct console *con)
 	}
 	memset(&lock, 0, sizeof(struct termios));
 	ioctl(fd, TIOCSLCKTRMIOS, &lock);
+	errno =3D 0;
 #endif
+
+#if defined(TIOCGSERIAL)
+	if (ioctl(fd, TIOCGSERIAL,  &serinfo) >=3D 0)
+	    	con->flags |=3D CON_SERIAL;
+	errno =3D 0;
+#else
+# if defined(KDGKBMODE)
+	if (ioctl(fd, KDGKBMODE, &mode) < 0)
+		con->flags |=3D CON_SERIAL;
 	errno =3D 0;
+# endif
+#endif
=20
 	if (tcgetattr(fd, tio) < 0) {
-		warn(_("tcgetattr failed"));
-		con->flags |=3D CON_NOTTY;
-		return;
+		int saveno =3D errno;
+#if defined(KDGKBMODE) || defined(TIOCGSERIAL)
+		if (con->flags & CON_SERIAL) {			/* Try to recover this */
+
+# if defined(TIOCGSERIAL)
+			serinfo.flags |=3D ASYNC_SKIP_TEST;	/* Skip test of UART */
+
+			if (ioctl(fd, TIOCSSERIAL, &serinfo) < 0)
+				goto tcgeterr;
+			if (ioctl(fd, TIOCSERCONFIG) < 0)	/* Try to autoconfigure */
+				goto tcgeterr;
+			if (ioctl(fd, TIOCGSERIAL,  &serinfo) < 0)
+				goto tcgeterr;			/* Ouch */
+# endif
+			if (tcgetattr(fd, tio) < 0)		/* Retry to get tty attributes */
+				saveno =3D errno;
+		}
+# if defined(TIOCGSERIAL)
+	tcgeterr:
+# endif
+		if (saveno)
+#endif
+		{
+			FILE *fcerr =3D fdopen(fd, "w");
+			if (fcerr) {
+				fprintf(fcerr, _("tcgetattr failed"));
+				fclose(fcerr);
+			}
+			warn(_("tcgetattr failed"));
+
+			con->flags &=3D ~CON_SERIAL;
+			if (saveno !=3D EIO)
+				con->flags |=3D CON_NOTTY;
+			else
+				con->flags |=3D CON_EIO;
+
+			errno =3D 0;
+			return;
+		}
 	}
=20
 	/* Handle lines other than virtual consoles here */
-#if defined(KDGKBMODE)
-	if (ioctl(fd, KDGKBMODE, &mode) < 0)
+#if defined(KDGKBMODE) || defined(TIOCGSERIAL)
+	if (con->flags & CON_SERIAL)
 #endif
 	{
 		speed_t ispeed, ospeed;
 		struct winsize ws;
 		errno =3D 0;
=20
-		/* this is a modem line */
-		con->flags |=3D CON_SERIAL;
-
 		/* Flush input and output queues on modem lines */
 		tcflush(fd, TCIOFLUSH);
=20
@@ -220,6 +269,8 @@ static void tcfinal(struct console *con)
 	struct termios *tio =3D &con->tio;
 	const int fd =3D con->fd;
=20
+	if (con->flags & CON_EIO)
+		return;
 	if ((con->flags & CON_SERIAL) =3D=3D 0) {
 		xsetenv("TERM", "linux", 1);
 		return;
@@ -557,12 +608,16 @@ err:
 static void setup(struct console *con)
 {
 	int fd =3D con->fd;
-	const pid_t pid =3D getpid(), pgrp =3D getpgid(0), ppgrp =3D
-	    getpgid(getppid()), ttypgrp =3D tcgetpgrp(fd);
+	const pid_t pid =3D getpid(), pgrp =3D getpgid(0), ppgrp =3D getpgid(getp=
pid());
+	pid_t ttypgrp;
=20
 	if (con->flags & CON_NOTTY)
+		goto notty;
+	if (con->flags & CON_EIO)
 		return;
=20
+	ttypgrp =3D tcgetpgrp(fd);
+
 	/*
 	 * Only go through this trouble if the new
 	 * tty doesn't fall in this process group.
@@ -585,6 +640,7 @@ static void setup(struct console *con)
 		ioctl(fd, TIOCSCTTY, (char *)1);
 		tcsetpgrp(fd, ppgrp);
 	}
+notty:
 	dup2(fd, STDIN_FILENO);
 	dup2(fd, STDOUT_FILENO);
 	dup2(fd, STDERR_FILENO);
@@ -608,20 +664,25 @@ static const char *getpasswd(struct console *con)
 	struct termios tty;
 	static char pass[128], *ptr;
 	struct chardata *cp;
-	const char *ret =3D pass;
+	const char *ret =3D NULL;
 	unsigned char tc;
 	char c, ascval;
 	int eightbit;
 	const int fd =3D con->fd;
=20
-	if (con->flags & CON_NOTTY)
+	if (con->flags & CON_EIO)
 		goto out;
+
 	cp =3D &con->cp;
 	tty =3D con->tio;
+	tc =3D 0;
+	ret =3D pass;
=20
 	tty.c_iflag &=3D ~(IUCLC|IXON|IXOFF|IXANY);
 	tty.c_lflag &=3D ~(ECHO|ECHOE|ECHOK|ECHONL|TOSTOP|ISIG);
-	tc =3D (tcsetattr(fd, TCSAFLUSH, &tty) =3D=3D 0);
+
+	if ((con->flags & CON_NOTTY) =3D=3D 0)
+		tc =3D (tcsetattr(fd, TCSAFLUSH, &tty) =3D=3D 0);
=20
 	sigemptyset(&sa.sa_mask);
 	sa.sa_handler =3D alrm_handler;
@@ -647,11 +708,12 @@ static const char *getpasswd(struct console *con)
 			}
 			ret =3D NULL;
 			switch (errno) {
-			case 0:
 			case EIO:
+				con->flags |=3D CON_EIO;
 			case ESRCH:
 			case EINVAL:
 			case ENOENT:
+			case 0:
 				break;
 			default:
 				warn(_("cannot read %s"), con->tty);
@@ -775,7 +837,7 @@ static void sushell(struct passwd *pwd)
=20
 #ifdef HAVE_LIBSELINUX
 	if (is_selinux_enabled() > 0) {
-		security_context_t scon=3DNULL;
+		char *scon=3DNULL;
 		char *seuser=3DNULL;
 		char *level=3DNULL;
 		if (getseuserbyname("root", &seuser, &level) =3D=3D 0) {
@@ -968,10 +1030,13 @@ int main(int argc, char **argv)
 		con =3D list_entry(ptr, struct console, entry);
 		if (con->id >=3D CONMAX)
 			break;
+		if (con->flags & CON_EIO)
+			goto next;
=20
 		switch ((con->pid =3D fork())) {
 		case 0:
 			mask_signal(SIGCHLD, SIG_DFL, NULL);
+			dup2(con->fd, STDERR_FILENO);
 		nofork:
 			setup(con);
 			while (1) {
@@ -1026,7 +1091,7 @@ int main(int argc, char **argv)
 		default:
 			break;
 		}
-
+	next:
 		ptr =3D ptr->next;
=20
 	} while (ptr !=3D &consoles);

--dmITk4gbmOfpHNxn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJgBAABCABKFiEEGwa/WjgpkPvLonW+UOkNVR3Bay4FAmCTytAsFIAAAAAAFQAO
cGthLWFkZHJlc3NAZ251cGcub3Jnd2VybmVyQHN1c2UuZGUACgkQUOkNVR3Bay4+
wg/+L+Lv0SbsSaf50Ie3uzq6UNDVe3xCkRlXFuIchkEc1lx9mHhIP1prc94P1pow
Bp7+mIZQDmqXrEI9q0HMjjYllckkFJ/eftzi/MPIRCgleCMIDwkyh0TbIsytwKf/
hzqnAIv6ODfYyrtjrZqntENeknzASWcgUpdFv78qzgivc9zLPqqrBGUCRemV6M4n
xXpXL/ggts8eecTD7WodlNGY3PwFXlECFdnszhm+XgsGvwsQgo0iXqBiUjsr4Gwh
P5N81PJbAgmLuXzcvdHqFFeuaMug1ToDziMUS47Nhk4a2SsupezZHumBcXTzrVpZ
GcaC8x6WIshwtNvEmVv0VawY84sUL2j6zXwVnb5Yn8SkbxuygOk8YP0k9EdzG1kU
LHGyUYtZBFTMrN79q8MVFW+51jKQzl73O7/Rk/cQjHdjtqf6P2aJpOQN7z6YnIyC
NY3MY37qWDh4xisiDG0tkcNvUgHwftyA6SY1Up7HVkX4mlYQ+Q8LLx19We62L/00
8LZWXLg/CfGbyb5f1vQvZTMz15bW7eB8mqArZyir9iF5VZko3BGUx55gfEWbd6iJ
SbI1oXjYpBm/T9OTLprBhoSj9cXgMrHWaZayBCadqO2RheUiUtAz1XzcPKEop/5x
Na7ZUgOX8xjj67dyM8otkeaA7ILMjSLY3YOVMa0Az8Mr1u8=
=oV1/
-----END PGP SIGNATURE-----

--dmITk4gbmOfpHNxn--
