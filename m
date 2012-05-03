Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44601 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753942Ab2ECMks (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 May 2012 08:40:48 -0400
Received: by wgbdr13 with SMTP id dr13so1715211wgb.1
        for <util-linux@vger.kernel.org>; Thu, 03 May 2012 05:40:47 -0700 (PDT)
Message-ID: <4FA27CCA.1060500@gmail.com>
Date: Thu, 03 May 2012 14:40:42 +0200
From: =?UTF-8?B?VmxhZGltaXIgJ8+GLWNvZGVyL3BoY29kZXInIFNlcmJpbmVua28=?=
	<phcoder@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] Support UFS UUID
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enigA44054F83D357C45D2CF9052"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA44054F83D357C45D2CF9052
Content-Type: multipart/mixed;
 boundary="------------010403090905000609050907"

This is a multi-part message in MIME format.
--------------010403090905000609050907
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


--=20
Regards
Vladimir '=CF=86-coder/phcoder' Serbinenko


--------------010403090905000609050907
Content-Type: text/x-diff;
 name="ufs_blkid.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="ufs_blkid.diff"

diff --git a/libblkid/src/superblocks/ufs.c b/libblkid/src/superblocks/uf=
s.c
index 3ace715..673a528 100644
--- a/libblkid/src/superblocks/ufs.c
+++ b/libblkid/src/superblocks/ufs.c
@@ -174,6 +174,7 @@ static int probe_ufs(blkid_probe pr,
 	size_t i;
 	uint32_t magic;
 	struct ufs_super_block *ufs;
+	int is_be;
=20
 	for (i =3D 0; i < ARRAY_SIZE(offsets); i++) {
 		uint32_t magLE, magBE;
@@ -192,6 +193,7 @@ static int probe_ufs(blkid_probe pr,
 		for (y =3D 0; y < ARRAY_SIZE(mags); y++) {
 			if (magLE =3D=3D mags[y] || magBE =3D=3D mags[y]) {
 				magic =3D mags[y];
+				is_be =3D (magBE =3D=3D mags[y]);
 				goto found;
 			}
 		}
@@ -206,6 +208,23 @@ found:
 				sizeof(ufs->fs_u11.fs_u2.fs_volname));
 	} else
 		blkid_probe_set_version(pr, "1");
+	if (ufs->fs_id[0] || ufs->fs_id[1])
+	{
+		if (is_be)
+			blkid_probe_sprintf_uuid(pr,
+					 (unsigned char *) &ufs->fs_id,
+						 sizeof(ufs->fs_id),
+						 "%08x%08x",
+						 be32_to_cpu(ufs->fs_id[0]),
+						 be32_to_cpu(ufs->fs_id[1]));
+		else
+			blkid_probe_sprintf_uuid(pr,
+					 (unsigned char *) &ufs->fs_id,
+						 sizeof(ufs->fs_id),
+						 "%08x%08x",
+						 le32_to_cpu(ufs->fs_id[0]),
+						 le32_to_cpu(ufs->fs_id[1]));
+	}
=20
 	if (blkid_probe_set_magic(pr,
 			(offsets[i] * 1024) +

--------------010403090905000609050907--

--------------enigA44054F83D357C45D2CF9052
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREKAAYFAk+ifMoACgkQNak7dOguQgl9HgEAuaTkFL1tMCEJNOhRz3Us9Kda
rIaweM+suZKsNpWM3dQBAML+vBLUFMr/xczBbPFrURQg0/IWuPTPY03+L4pEX4AW
=xI0L
-----END PGP SIGNATURE-----

--------------enigA44054F83D357C45D2CF9052--
