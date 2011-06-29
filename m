Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:38197 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753920Ab1F2IYL (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 29 Jun 2011 04:24:11 -0400
Date: Wed, 29 Jun 2011 10:24:09 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Konstantin Khlebnikov <khlebnikov@openvz.org>
Subject: [PATCH] umount: do not hang with disconnected NFS mounts
Message-ID: <20110629082408.GA27888@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yrj/dFKFPuw6o+aM"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since util-linux commit f4612577c942a3683b97632ad0b49671897c2070,
umount stat(2)s its argument to check whether it can be associated
with some loop device. This could hang with broken NFS mounts.

Fix by first checking mtab if umount's argument is mounted and only if
we fail, check if there is a loop device associated.

http://marc.info/?l=3Dutil-linux-ng&m=3D130924963804836&w=3D2

Reported-by: Konstantin Khlebnikov <khlebnikov@openvz.org>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 mount/umount.c |   42 ++++++++++++++++++++++--------------------
 1 files changed, 22 insertions(+), 20 deletions(-)

diff --git a/mount/umount.c b/mount/umount.c
index 0349cb3..96c940e 100644
--- a/mount/umount.c
+++ b/mount/umount.c
@@ -600,6 +600,7 @@ umount_file (char *arg) {
 	int fstab_has_user, fstab_has_users, fstab_has_owner, fstab_has_group;
 	int ok, status =3D 0;
 	struct stat statbuf;
+	char *loopdev =3D NULL;
=20
 	if (!*arg) {		/* "" would be expanded to `pwd` */
 		die(2, _("Cannot unmount \"\"\n"));
@@ -608,26 +609,7 @@ umount_file (char *arg) {
=20
 	file =3D canonicalize(arg); /* mtab paths are canonicalized */
=20
-	/* if file is a regular file, check if it is associated
-	 * with some loop device
-	 */
-	if (!stat(file, &statbuf) && S_ISREG(statbuf.st_mode)) {
-		char *loopdev =3D NULL;
-		switch (find_loopdev_by_backing_file(file, &loopdev)) {
-		case 0:
-			if (verbose)
-				printf(_("%s is associated with %s, trying to unmount it\n"),
-				       arg, loopdev);
-			file =3D loopdev;
-			break;
-		case 2:
-			if (verbose)
-				printf(_("%s is associated with more than one loop device: not unmount=
ing\n"),
-				       arg);
-			break;
-		}
-	}
-
+try_loopdev:
 	if (verbose > 1)
 		printf(_("Trying to unmount %s\n"), file);
=20
@@ -659,6 +641,26 @@ umount_file (char *arg) {
 	if (!mc && verbose)
 		printf(_("Could not find %s in mtab\n"), file);
=20
+	/* not found in mtab - check if it is associated with some loop device
+	 * (only if it is a regular file)
+	 */
+	if (!mc && !loopdev && !stat(file, &statbuf) && S_ISREG(statbuf.st_mode))=
 {
+		switch (find_loopdev_by_backing_file(file, &loopdev)) {
+		case 0:
+			if (verbose)
+				printf(_("%s is associated with %s\n"),
+				       arg, loopdev);
+			file =3D loopdev;
+			goto try_loopdev;
+			break;
+		case 2:
+			if (verbose)
+				printf(_("%s is associated with more than one loop device: not unmount=
ing\n"),
+				       arg);
+			break;
+		}
+	}
+
 	if (mc) {
 		/*
 		 * helper - umount helper (e.g. pam_mount)
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--yrj/dFKFPuw6o+aM
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk4K4SgACgkQnZxG0T6qDD0rEgCeJyLmlk9ZyoQednjMDgh82DZy
Q58An2c49RXOFMBimfRXLMffXtt9LrPZ
=Q360
-----END PGP SIGNATURE-----

--yrj/dFKFPuw6o+aM--
