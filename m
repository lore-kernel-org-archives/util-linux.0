Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37595C433B4
	for <util-linux@archiver.kernel.org>; Mon, 17 May 2021 15:29:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1713F61108
	for <util-linux@archiver.kernel.org>; Mon, 17 May 2021 15:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245323AbhEQP3C (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 17 May 2021 11:29:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:39368 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244100AbhEQP0z (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 17 May 2021 11:26:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17B48B235
        for <util-linux@vger.kernel.org>; Mon, 17 May 2021 15:25:31 +0000 (UTC)
Date:   Mon, 17 May 2021 17:25:28 +0200
From:   "Dr. Werner Fink" <werner@suse.de>
To:     util-linux@vger.kernel.org
Subject: Re: [PATCH] sulogin: ignore not existing console devices
Message-ID: <20210517152528.GA11780@noether>
Mail-Followup-To: util-linux@vger.kernel.org
References: <YJPK1JUPtKTuMJ1J@boole.suse.de>
 <20210510145111.x5ap5raymlfoewi5@ws.net.home>
 <YKKEkSc/ryc56IJu@boole.suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="/WwmFnJnmDyWGHa4"
Content-Disposition: inline
In-Reply-To: <YKKEkSc/ryc56IJu@boole.suse.de>
X-GPG-Fingerprint: 1B06 BF5A 3829 90FB CBA2  75BE 50E9 0D55 1DC1 6B2E
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--/WwmFnJnmDyWGHa4
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021/05/17 16:58:25 +0200, Dr. Werner Fink wrote:
> On 2021/05/10 16:51:11 +0200, Karel Zak wrote:
> > On Thu, May 06, 2021 at 12:54:12PM +0200, Werner Fink wrote:
> > >  login-utils/sulogin-consoles.h |  1 +
> > >  login-utils/sulogin.c          | 97 ++++++++++++++++++++++++++++++++=
+++-------
> > >  2 files changed, 82 insertions(+), 16 deletions(-)
> >=20
> > Seems good, but git does not like the patch from your e-mail:
> >=20
> >         Applying: sulogin: ignore not existing console devices
> >         .git/rebase-apply/patch:49: space before tab in indent.
> >                     con->flags |=3D CON_SERIAL;
> >         error: patch failed: login-utils/sulogin.c:775
> >         error: login-utils/sulogin.c: patch does not apply
> >         Patch failed at 0001 sulogin: ignore not existing console devic=
es
>=20
> Thanks for spotting! ... looks like I've missed the a/b prefixes
>=20
> Werner

The attached patch is for latest git repository

Werner

--=20
  "Having a smoking section in a restaurant is like having
          a peeing section in a swimming pool." -- Edward Burr

--J2SCkAp4GZ/dPZZf
Content-Type: text/x-patch; charset=utf-8
Content-Description: 38a9f563577e0ff73bfeed2d011d211d1486180f.patch
Content-Disposition: attachment;
	filename="38a9f563577e0ff73bfeed2d011d211d1486180f.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 38a9f563577e0ff73bfeed2d011d211d1486180f Mon Sep 17 00:00:00 2001
=46rom: Werner Fink <werner@suse.de>
Date: Mon, 17 May 2021 17:20:32 +0200
Subject: [PATCH] sulogin: ignore none-existing console devices

and also none-functional console devices. Redirect the error
messages to the appropiate console device.

Signed-off-by: Werner Fink <werner@suse.de>
---
 login-utils/sulogin-consoles.h |  1 +
 login-utils/sulogin.c          | 95 ++++++++++++++++++++++++++++------
 2 files changed, 81 insertions(+), 15 deletions(-)

diff --git login-utils/sulogin-consoles.h login-utils/sulogin-consoles.h
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
diff --git login-utils/sulogin.c login-utils/sulogin.c
index 6ed63f1a0..8b4e2d108 100644
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
@@ -969,10 +1031,13 @@ int main(int argc, char **argv)
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
@@ -1027,7 +1092,7 @@ int main(int argc, char **argv)
 		default:
 			break;
 		}
-
+	next:
 		ptr =3D ptr->next;
=20
 	} while (ptr !=3D &consoles);
--=20
2.28.0


--J2SCkAp4GZ/dPZZf--

--/WwmFnJnmDyWGHa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJgBAABCABKFiEEGwa/WjgpkPvLonW+UOkNVR3Bay4FAmCiiuQsFIAAAAAAFQAO
cGthLWFkZHJlc3NAZ251cGcub3Jnd2VybmVyQHN1c2UuZGUACgkQUOkNVR3Bay7P
7xAA4VCZmX3fzhl0d7FTn+qo1spXy0B+BlkjLGTqqztnsyouCU96n82ZwIUB1YE8
VYyr2vqH/F9Ijb9m95WZ3iiXxMHEFNwRlCpicC1TtQ+C0F21XpEEG2xYbfanBAtP
5OlgMRi07rcN7B4Y5hIbViv4sK+Q80nNf4mZ44xWnoR6v0YHn6qLc+xW2gBarL6q
UbtC6VPGyig3VsYuA+podOBnooUP6H5q57GkwrjhtlQ6d8affNHNOjRw8+83FOxi
HScYHqwUG9Ep58UCalbuDk+vQ0H2GklywQBSvv2vS3HJpf8Qy5UTUCBFtQp6y68K
NZJRAe4AaxvdXQ1YTwUV8xsDhMJK9ThwTsBBNZHFp2xwqfd5qKrppaag7uePBB0n
1xlTimsz7TB/rYTatqsiEiCs0jmNoFGjrOfdOL+kCacB+3/oulNvFcWjUCGzU2fI
oItHq0J2hSTh9CzoyYW3OxpJ0CzMjlrHUtCWnooldHVes+J3Lv13NAnOi01OW0mW
DgR4Bb2mQHEDxxUFOby5eYNDoDnij47shXsRscnGDwvTOVoUEuBT0Q4Z7z7rYUlZ
e6laOLMEFfFCvKYRD41kDy8B8igR95CHKQ8UJJMr8UCxohW9xHmnIjHslsR/L558
7n7OLrWRjVlUsmruKBZS7n/YSbWvLFJ2dju2Omo/M0LAvJo=
=VgLf
-----END PGP SIGNATURE-----

--/WwmFnJnmDyWGHa4--
