Return-Path: util-linux-owner@vger.kernel.org
Received: from mx2.suse.de ([195.135.220.15]:54261 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752612AbeDRDbp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 17 Apr 2018 23:31:45 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 90DC4AE6A
        for <util-linux@vger.kernel.org>; Wed, 18 Apr 2018 03:31:43 +0000 (UTC)
From: NeilBrown <neilb@suse.com>
To: util-linux@vger.kernel.org
Date: Wed, 18 Apr 2018 13:31:38 +1000
Subject: [PATCH] libmount: fix mnt_table_is_fs_mounted() for NFS bind mounts.
Message-ID: <87po2xqjfp.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


When you bind-mount a subdirectory of a local filesystem, the
path to that subdirectory appears as the fourth field in mountinfo.

For nfs mounts, the fourth field is always "/", and the subdirectory
part is appended to the "special" (aka "device") field.  This is
consistent with historical NFS usage which always includes a path in
the fs_spec field.

libmount needs to know about this when "mount -a" checks to see if
a filesystem is already mounted.

Without this fix, fstab lines like:

 server::/path /dir nfs defaults 0 0
 /dir/subdir /mnt/test none bind 0 0

result in a new mount at /mnt/test every time "mount -a" is run.


Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 libmount/src/tab.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 968057e429f5..21e37aea7f5d 100644
=2D-- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1542,6 +1542,7 @@ int mnt_table_is_fs_mounted(struct libmnt_table *tb, =
struct libmnt_fs *fstab_fs)
 	struct libmnt_fs *fs;
=20
 	char *root =3D NULL;
+	char *src2 =3D NULL;
 	const char *src =3D NULL, *tgt =3D NULL;
 	char *xtgt =3D NULL;
 	int rc =3D 0;
@@ -1566,8 +1567,18 @@ int mnt_table_is_fs_mounted(struct libmnt_table *tb,=
 struct libmnt_fs *fstab_fs)
 			flags =3D MS_BIND;
=20
 		rootfs =3D mnt_table_get_fs_root(tb, fstab_fs, flags, &root);
=2D		if (rootfs)
+		if (rootfs) {
+			const char *fstype =3D mnt_fs_get_fstype(rootfs);
+
 			src =3D mnt_fs_get_srcpath(rootfs);
+			if (fstype && strncmp(fstype, "nfs", 3) =3D=3D 0 && root) {
+				/* NFS stores the root at the end of the source */
+				asprintf(&src2, "%s%s", src, root);
+				src =3D src2;
+				free(root);
+				root =3D NULL;
+			}
+		}
 	}
=20
 	if (!src)
@@ -1667,6 +1678,7 @@ done:
 	free(root);
=20
 	DBG(TAB, ul_debugobj(tb, "mnt_table_is_fs_mounted: %s [rc=3D%d]", src, rc=
));
+	free(src2);
 	return rc;
 }
=20
=2D-=20
2.14.0.rc0.dirty


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEG8Yp69OQ2HB7X0l6Oeye3VZigbkFAlrWvBoACgkQOeye3VZi
gbnpWg//TtQjCUZ4fS3Jby3OFMrZXM1liWLlRuPWmKlYpljzFK3fZgWhFRa5WULH
2E8tLtn4pHAo9I5lLrWop+ouwEmKl01nhHUxav9LZHS0yMn9CfdN8mo1BuZvJHPJ
Cyp0s2MKxXQ0q1rSmbH2q/9dwBKYKB8TyjVrSuHuQnztHiQoB8ANXKjtZHuWFzAx
/FhirMo9AQfhx0atfnkqNgXgRzsmHWRK3ABiJT/9v71QNe9iNSMQwhWDnnSNSGup
pRULHX5VNkBGUh9EReEw64yFHq5csQFlaCqEZJTU0agno+ONC10V8fM/vNK9GqOn
3jEvKcW4YZUqw6nQMv1QLOhDnzUTtJd2uBUj8Bwd5n6kzB2vdF14TPiIrvCZZ4mj
cnGVq+ng138OIB6EcmxVTXg4IO52jxpfeG/MD2nQckP8eHVxHRYBXRZbKd6NnQIM
5/SztJIr9XA/Hv52/ah3Y+Lx0rtZY1VLDsTf8pXq13nCIRxa9i5f5ZN+Fws9MgcB
980J5jlV27Fm3pzb4K/2WKWwlxueYzzRgvqtiCdugM5+x9wBeAMevtEZSt2W4C0c
JyMKxrolGaKU//W0ODNkq35r2QdQ5GSEUMeZCiXeXF0KR0A6qpbBx8N852nCZIT/
qXmdq9WvoQ1xulCvratSlmUCgKfuDjSZ+iDvuYOlUuVXJGj8Mjw=
=vyUr
-----END PGP SIGNATURE-----
--=-=-=--
