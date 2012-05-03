Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:38996 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752959Ab2ECMQN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 May 2012 08:16:13 -0400
Received: by wgbds11 with SMTP id ds11so281228wgb.1
        for <util-linux@vger.kernel.org>; Thu, 03 May 2012 05:16:12 -0700 (PDT)
Message-ID: <4FA27707.4090608@gmail.com>
Date: Thu, 03 May 2012 14:16:07 +0200
From: =?UTF-8?B?VmxhZGltaXIgJ8+GLWNvZGVyL3BoY29kZXInIFNlcmJpbmVua28=?=
	<phcoder@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] Accept small blocks for NTFS and Reiserfs in blkid
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enig5E789FD6A12B858EABEA58AC"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5E789FD6A12B858EABEA58AC
Content-Type: multipart/mixed;
 boundary="------------090605040804050405020701"

This is a multi-part message in MIME format.
--------------090605040804050405020701
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

libblkid is restrictive as to what it accepts as valid reiserfs or valid
NTFS.
One can mkfs an NTFS with 256B sectors and it's supported by ntfs-3g
Reiserfs can have 512B blocks and it works both with mkfs.ntfs and Linux.=

Patch attached.

--=20
Regards
Vladimir '=CF=86-coder/phcoder' Serbinenko


--------------090605040804050405020701
Content-Type: text/x-diff;
 name="block.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="block.diff"

diff -ur util-linux-2.20.1/libblkid/src/superblocks/ntfs.c util-linux-2.2=
0.1-mod/libblkid/src/superblocks/ntfs.c
--- util-linux-2.20.1/libblkid/src/superblocks/ntfs.c	2011-09-26 11:50:23=
=2E000000000 +0200
+++ util-linux-2.20.1-mod/libblkid/src/superblocks/ntfs.c	2012-05-03 14:0=
7:35.193438515 +0200
@@ -81,7 +81,7 @@
 		(ns->bios_parameter_block[1]  << 8);
 	sectors_per_cluster =3D ns->bios_parameter_block[2];
=20
-	if ((bytes_per_sector < 512) || (sectors_per_cluster =3D=3D 0))
+	if ((bytes_per_sector < 256) || (sectors_per_cluster =3D=3D 0))
 		return 1;
=20
 	if (ns->cluster_per_mft_record < 0)
diff -ur util-linux-2.20.1/libblkid/src/superblocks/reiserfs.c util-linux=
-2.20.1-mod/libblkid/src/superblocks/reiserfs.c
--- util-linux-2.20.1/libblkid/src/superblocks/reiserfs.c	2011-09-26 11:5=
0:23.000000000 +0200
+++ util-linux-2.20.1-mod/libblkid/src/superblocks/reiserfs.c	2012-05-03 =
14:08:29.636647756 +0200
@@ -49,12 +49,12 @@
=20
 	blocksize =3D le16_to_cpu(rs->rs_blocksize);
=20
-	/* The blocksize must be at least 1k */
-	if ((blocksize >> 10) =3D=3D 0)
+	/* The blocksize must be at least 512B */
+	if ((blocksize >> 9) =3D=3D 0)
 		return -BLKID_ERR_PARAM;
=20
 	/* If the superblock is inside the journal, we have the wrong one */
-	if (mag->kboff / (blocksize >> 10) > le32_to_cpu(rs->rs_journal_block))=

+	if (mag->kboff / (blocksize >> 9) > le32_to_cpu(rs->rs_journal_block) /=
 2)
 		return -BLKID_ERR_BIG;
=20
 	/* LABEL/UUID are only valid for later versions of Reiserfs v3.6. */

--------------090605040804050405020701--

--------------enig5E789FD6A12B858EABEA58AC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREKAAYFAk+idwgACgkQNak7dOguQgmKdgD/VTsnEKdlrKMJEKZ3ye25pyfM
i/2wSDOvchTsBM5rs6MA/iDYQ1Z5bItDd/aNPltDohbwiPy6O6fad5mTS1iZXK8Q
=reBf
-----END PGP SIGNATURE-----

--------------enig5E789FD6A12B858EABEA58AC--
