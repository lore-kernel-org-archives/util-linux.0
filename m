Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:46460 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753057AbbCLIql (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Mar 2015 04:46:41 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 0E50AAC77
	for <util-linux@vger.kernel.org>; Thu, 12 Mar 2015 08:46:40 +0000 (UTC)
Date: Thu, 12 Mar 2015 09:46:39 +0100
From: Petr Gajdos <pgajdos@suse.cz>
To: util-linux@vger.kernel.org
Subject: prevent cal segfault
Message-ID: <20150312084639.GC9756@laura.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--5gxpn/Q6ypwruk0T
Content-Type: multipart/mixed; boundary="69pVuxX8awAiJ7fD"
Content-Disposition: inline


--69pVuxX8awAiJ7fD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

cal utility segfaults in putp() when setupterm() fails as cal
insufficiently checks for setupterm() failure.

$ TERM=3D cal
Segmentation fault

Please find details in=20

https://bugzilla.suse.com/show_bug.cgi?id=3D903440

especially in comment 4.

Petr


--69pVuxX8awAiJ7fD
Content-Type: text/x-patch; charset=us-ascii
Content-Disposition: attachment; filename="util-linux-cal-no-terminal.patch"
Content-Transfer-Encoding: quoted-printable

Index: misc-utils/cal.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- misc-utils/cal.c.orig	2014-08-26 16:48:45.132654654 +0200
+++ misc-utils/cal.c	2015-03-11 14:16:06.075064939 +0100
@@ -81,14 +81,22 @@
 # endif
 # include <term.h>
=20
-static void my_setupterm(const char *term, int fildes, int *errret)
+#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(HAVE_=
LIBTERMCAP)
+static const char	*term=3D"";
+#endif
+
+static int my_setupterm(const char *term, int fildes)
 {
-	setupterm((char *)term, fildes, errret);
+        int errret; /* unused */
+	return setupterm((char *)term, fildes, &errret) =3D=3D OK;
 }
=20
 static void my_putstring(char *s)
 {
-	putp(s);
+	if (term)
+		putp(s);
+	else
+		fputs(s, stdout);
 }
=20
 static const char *my_tgetstr(char *s __attribute__((__unused__)), char *s=
s)
@@ -107,9 +115,9 @@
 static char tcbuffer[4096];
 static char *strbuf =3D termbuffer;
=20
-static void my_setupterm(const char *term, int fildes __attribute__((__unu=
sed__)), int *errret)
+static int my_setupterm(const char *term, int fildes __attribute__((__unus=
ed__)))
 {
-	*errret =3D tgetent(tcbuffer, term);
+	return tgetent(tcbuffer, term) =3D=3D 1;
 }
=20
 static void my_putstring(char *s)
@@ -135,10 +143,6 @@
=20
 #endif	/* end of LIBTERMCAP / NCURSES */
=20
-#if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(HAVE_=
LIBTERMCAP)
-static const char	*term=3D"";
-#endif
-
 static const char	*Senter=3D"", *Sexit=3D"";/* enter and exit standout mod=
e */
=20
 #include "widechar.h"
@@ -293,12 +297,14 @@
=20
 #if defined(HAVE_LIBNCURSES) || defined(HAVE_LIBNCURSESW) || defined(HAVE_=
LIBTERMCAP)
 	if ((term =3D getenv("TERM"))) {
-		int ret;
-		my_setupterm(term, STDOUT_FILENO, &ret);
-		if (ret > 0) {
+		if (my_setupterm(term, STDOUT_FILENO)) {
 			Senter =3D my_tgetstr("so","smso");
 			Sexit =3D my_tgetstr("se","rmso");
 		}
+		else
+		{
+			term =3D NULL;
+		}
 	}
 #endif
=20

--69pVuxX8awAiJ7fD--

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlUBUmwACgkQGevYtT2kPwOyEACfZR1+XYOF6OfIJPAJH4NOrjMI
dAIAoKB4mw465Zf/Q1iJySTwA/yldOw4
=3Gj0
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--
