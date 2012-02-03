Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.gw90.de ([188.40.100.199]:54078 "EHLO mail.gw90.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757482Ab2BCSkf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 3 Feb 2012 13:40:35 -0500
Received: from g225173220.adsl.alicedsl.de ([92.225.173.220] helo=[192.168.178.43])
	by mail.gw90.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <paulepanter@users.sourceforge.net>)
	id 1RtNn9-0001A0-9W
	for util-linux@vger.kernel.org; Fri, 03 Feb 2012 18:23:23 +0000
Message-ID: <1328293391.4220.21.camel@mattotaupa>
Subject: [PATCH] flock.1: Fix grammar by removing =?ISO-8859-1?Q?=BBs=AB?=
From: Paul Menzel <paulepanter@users.sourceforge.net>
To: util-linux@vger.kernel.org
Date: Fri, 03 Feb 2012 19:23:11 +0100
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-Stcc/xNZBk+eRgL6r+Ty"
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--=-Stcc/xNZBk+eRgL6r+Ty
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

From: Paul Menzel <paulepanter@users.sourceforge.net>
Date: Fri, 3 Feb 2012 19:18:17 +0100

---
I am not sure about the first plural of form*s* either.

 sys-utils/flock.1 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/flock.1 b/sys-utils/flock.1
index 84bc96f..32f457f 100644
--- a/sys-utils/flock.1
+++ b/sys-utils/flock.1
@@ -42,7 +42,7 @@ This utility manages
 .BR flock (2)
 locks from within shell scripts or the command line.
 .PP
-The first and second forms wraps the lock around the executing a command, =
in
+The first and second forms wrap the lock around the executing a command, i=
n
 a manner similar to
 .BR su (1)
 or
--=20
1.7.9


--=-Stcc/xNZBk+eRgL6r+Ty
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAk8sJg8ACgkQPX1aK2wOHVgtFQCfdP+tBfS3HlupwvFn+x/clTmA
iXEAn3AWt8v18qRFO2K6aCFWyzQircRD
=6rLq
-----END PGP SIGNATURE-----

--=-Stcc/xNZBk+eRgL6r+Ty--

