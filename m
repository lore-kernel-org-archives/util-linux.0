Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62901 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757909Ab2EIVtV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 9 May 2012 17:49:21 -0400
Received: by wgbdr13 with SMTP id dr13so742166wgb.1
        for <util-linux@vger.kernel.org>; Wed, 09 May 2012 14:49:20 -0700 (PDT)
Message-ID: <4FAAE650.3040403@gmail.com>
Date: Wed, 09 May 2012 23:49:04 +0200
From: =?UTF-8?B?VmxhZGltaXIgJ8+GLWNvZGVyL3BoY29kZXInIFNlcmJpbmVua28=?=
	<phcoder@gmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix incorrect zone count
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="------------enigA5A765B8198A16C7F1B30756"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA5A765B8198A16C7F1B30756
Content-Type: multipart/mixed;
 boundary="------------000703000602050203040707"

This is a multi-part message in MIME format.
--------------000703000602050203040707
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello all. It seems that the zone map, inodes, inode maps and superblock
aren't included in the zone map. At least it's the impression I've got fr=
om:
        Super3.s_zmap_blocks =3D UPPER(BLOCKS -
(1+get_nimaps()+inode_blocks()),
                         BITS_PER_BLOCK+1);
However, in another place the assumption is opposite and this leads to
an attempt to write outside the allocated buffer. Attached patch fixes it=
=2E

--=20
Regards
Vladimir '=CF=86-coder/phcoder' Serbinenko


--------------000703000602050203040707
Content-Type: text/x-diff;
 name="minix.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="minix.diff"

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 051cd5f..fd68fc9 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -421,13 +432,13 @@ static void super_set_nzones(void)
 {
 	switch (fs_version) {
 	case 3:
-		Super3.s_zones =3D BLOCKS;
+		Super3.s_zones =3D BLOCKS - Super3.s_zmap_blocks - (1+get_nimaps()+ino=
de_blocks());
 		break;
 	case 2:
-		Super.s_zones =3D BLOCKS;
+		Super.s_zones =3D BLOCKS - Super.s_zmap_blocks - (1+get_nimaps()+inode=
_blocks());
 		break;
 	default: /* v1 */
-		Super.s_nzones =3D BLOCKS;
+		Super.s_nzones =3D BLOCKS - Super.s_zmap_blocks - (1+get_nimaps()+inod=
e_blocks());
 		break;
 	}
 }
@@ -497,8 +508,6 @@ static void setup_tables(void) {
 	}
=20
 	super_init_maxsize();
-	super_set_nzones();
-	zones =3D get_nzones();
=20
 	/* some magic nrs: 1 inode / 3 blocks */
 	if ( req_nr_inodes =3D=3D 0 )=20
@@ -522,6 +531,9 @@ static void setup_tables(void) {
 	}
=20
 	super_set_map_blocks(inodes);
+	super_set_nzones();
+
+	zones =3D get_nzones();
 	imaps =3D get_nimaps();
 	zmaps =3D get_nzmaps();
=20

--------------000703000602050203040707--

--------------enigA5A765B8198A16C7F1B30756
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iF4EAREKAAYFAk+q5lgACgkQNak7dOguQgk4qQEAjrf4JHhmDm91YdRtOZ9JnztM
8hX9+aR7Il0xtwVdS1MA/RqHVxgm6szKBvQW0y7VhTg3+kBD2fX0wqzyXXrPI0cG
=coXh
-----END PGP SIGNATURE-----

--------------enigA5A765B8198A16C7F1B30756--
