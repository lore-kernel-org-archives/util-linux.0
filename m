Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.gw90.de ([188.40.100.199]:54079 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757482Ab2BCSkh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Feb 2012 13:40:37 -0500
Received: from g225173220.adsl.alicedsl.de ([92.225.173.220] helo=[192.168.178.43])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1RtNpC-0001AG-MZ
	for util-linux@vger.kernel.org; Fri, 03 Feb 2012 18:25:30 +0000
Message-ID: <1328293518.4220.23.camel@mattotaupa>
Subject: [PATCH] flock.1: Add missing word =?ISO-8859-1?Q?=BBbe=AB?=
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: util-linux@vger.kernel.org
Date: Fri, 03 Feb 2012 19:25:18 +0100
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-52jbdBpeWC2mi6CYXEId"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-52jbdBpeWC2mi6CYXEId
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Paul Menzel <paulepanter@users.sourceforge.net>
Date: Fri, 3 Feb 2012 19:19:39 +0100

---
 sys-utils/flock.1 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index 32f457f..5a6f27f 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -54,7 +54,7 @@ lock cannot be immediately acquired,
 waits until the lock is available.
 .PP
 The third form uses open file by file descriptor number.  See examples how
-that can used.
+that can be used.
 .SH OPTIONS
 .TP
 \fB\-s\fP, \fB\-\-shared\fP
--=20
1.7.9

--=-52jbdBpeWC2mi6CYXEId
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk8sJo4ACgkQPX1aK2wOHVg2IQCdGUr4DDfccSx6KeLgajmWrfQj
YiwAniZj5DFh1VSVMIeerpY5tvVZBbxm
=aVbi
-----END PGP SIGNATURE-----

--=-52jbdBpeWC2mi6CYXEId--

