Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor.suse.de ([195.135.220.2]:34233 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754414Ab1C1OE6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Mar 2011 10:04:58 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id DDFAB93717
	for <util-linux@vger.kernel.org>; Mon, 28 Mar 2011 16:04:56 +0200 (CEST)
Date: Mon, 28 Mar 2011 16:04:56 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Miklos Szeredi <mszeredi@suse.cz>
Subject: [PATCH] umount: allow non-root umount of FUSE even if not in fstab
Message-ID: <20110328140454.GA4790@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

I hacked the following patch with which it is possible to use=20
"umount $dir" instead of "fusermount -u $dir", which IMHO is an
improvement in usability. It seems to work (at least for me), however,
I have to admit that I don't like it very much, because:
- it complicates umount
- duplicates code from fusermount
- should (???) be implemented using umount helpers

With regard to uhelpers: I spent some time looking into the fuse code,
but I don't think it could be done easily - has anybody investigated
this?

Related discussion (from 2006):
http://sourceforge.net/mailarchive/forum.php?thread_name=3D1253960851.6399.=
43.camel%40localhost.localdomain&forum_name=3Dfuse-devel

This feature addresses:
https://fate.novell.com/310710

---------- 8< ---------- 8< -----------

This patch introduces an exception to the "no non-root unmounts
unless the mount is in fstab", which is necessary to allow
unmounting FUSE filesystems with umount (originally, one
had to use fusermount -u).

Umount makes the same checks as fusermount -u does, namely:
- if the fstype starts with fuse/fuseblk
- compares the user_id stored in /etc/mtab (or /proc/mounts) with
  real UID of the calling user

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/umount.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/mount/umount.c b/mount/umount.c
index 42671f4..f887c6f 100644
--- a/mount/umount.c
+++ b/mount/umount.c
@@ -592,6 +592,33 @@ umount_file (char *arg) {
 			    _("umount: it seems %s is mounted multiple times"),
 			    file);
=20
+		/* If this is fuse-based filesystem, allow user unmount even
+		 * if the FS is not in fstab.
+		 *
+		 * Based on fusermount code. */
+		if (strcmp(mc->m.mnt_type, "fuse") =3D=3D 0 ||
+		    strcmp(mc->m.mnt_type, "fuseblk") =3D=3D 0 ||
+		    strncmp(mc->m.mnt_type, "fuse.", 5) =3D=3D 0 ||
+		    strncmp(mc->m.mnt_type, "fuseblk.", 8) =3D=3D 0) {
+			char *fuse_uidstr;
+			fuse_uidstr =3D get_option_value(mc->m.mnt_opts, "user=3D");
+			if (!fuse_uidstr)
+				fuse_uidstr =3D get_option_value(mc->m.mnt_opts, "user_id=3D");
+			if (fuse_uidstr) {
+				char uidstr[32];
+				unsigned uidlen;
+				uidlen =3D sprintf(uidstr, "%u", getuid());
+				if (strncmp(uidstr, fuse_uidstr, uidlen) =3D=3D 0) {
+					if (verbose)
+						printf(_("Unmounting %s (FUSE filesystem, mounted by uid=3D%s)\n"),
+						       arg, uidstr);
+					int ret =3D umount_one(arg, arg, arg, arg, NULL);
+					free(fuse_uidstr);
+					return ret;
+				}
+			}
+		}
+
 		/* If fstab contains the two lines
 		   /dev/sda1 /mnt/zip auto user,noauto  0 0
 		   /dev/sda4 /mnt/zip auto user,noauto  0 0
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iEYEARECAAYFAk2QlYYACgkQnZxG0T6qDD2NCACfRX1N4j54BNL4T2rRPSa/At6P
nvIAoI1RNl1fy45w8AoieDBe0qHQw8x/
=Z/7U
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
