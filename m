Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:45833 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755234Ab2EBOPb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 May 2012 10:15:31 -0400
Received: by were53 with SMTP id e53so407723wer.19
        for <util-linux@vger.kernel.org>; Wed, 02 May 2012 07:15:30 -0700 (PDT)
Message-ID: <4FA1417D.8010704@gmail.com>
Date: Wed, 02 May 2012 16:15:25 +0200
From: =?UTF-8?B?VmxhZGltaXIgJ8+GLWNvZGVyL3BoY29kZXInIFNlcmJpbmVua28=?=
	<phcoder@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: mkfs.minix -3 creates incorrect and limited filesystem
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enigEBD4532992703887C451AB26"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEBD4532992703887C451AB26
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

--- util-linux-2.20.1/disk-utils/mkfs.minix.c	2011-10-11 15:23:46.0000000=
00 +0200
+++ util-linux-2.20.1-mod/disk-utils/mkfs.minix.c	2012-05-02 13:56:09.993=
347189 +0200
@@ -487,7 +487,7 @@ static void setup_tables(void) {
=20
 	if (fs_version =3D=3D 3) {
 		Super3.s_log_zone_size =3D 0;
-		Super3.s_blocksize =3D BLOCKS;
+		Super3.s_blocksize =3D MINIX_BLOCK_SIZE;
 	}
 	else {
 		Super.s_log_zone_size =3D 0;
@@ -773,7 +773,7 @@ int main(int argc, char ** argv) {
 	if (fs_version =3D=3D 3)
 		magic =3D MINIX3_SUPER_MAGIC;
=20
-	if (fs_version =3D=3D 2) {
+	else if (fs_version =3D=3D 2) {
 		if (namelen =3D=3D 14)
 			magic =3D MINIX2_SUPER_MAGIC;
 		else

--=20
Regards
Vladimir '=CF=86-coder/phcoder' Serbinenko



--------------enigEBD4532992703887C451AB26
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREKAAYFAk+hQX0ACgkQNak7dOguQgm2QQD+NQS8iDRblJ/5ak05NO04hPHC
IF9LCeWs3jhX23FoNBwA/1DyV/Ll9+wkG8mQHTboZjybtl8IAKcX9SIr9rppAIo+
=4ErC
-----END PGP SIGNATURE-----

--------------enigEBD4532992703887C451AB26--
