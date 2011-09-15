Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:46289 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751162Ab1IOITT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 15 Sep 2011 04:19:19 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 613788C061
	for <util-linux@vger.kernel.org>; Thu, 15 Sep 2011 10:19:18 +0200 (CEST)
Date: Thu, 15 Sep 2011 10:19:17 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH] flock: make flock(3) work on NFSv4
Message-ID: <20110915081916.GA11152@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

To pleace an exclusive lock on a file, NFSv4 requires
the file to be opened RW because of the emulation of flock()
by fcntl():

http://www.spinics.net/lists/linux-nfs/msg18502.html

So instead of O_RDONLY, open the file in O_RDWR if access()
indicates it is possible (unless shared lock is requested).

=46rom: Michal Kubecek <mkubecek@suse.cz>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 sys-utils/flock.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index 7d321de..a500319 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -129,6 +129,7 @@ int main(int argc, char *argv[])
   int have_timeout =3D 0;
   int type =3D LOCK_EX;
   int block =3D 0;
+  int open_accmode;
   int fd =3D -1;
   int opt, ix;
   int do_close =3D 0;
@@ -211,9 +212,11 @@ int main(int argc, char *argv[])
     }
=20
     filename =3D argv[optind];
-    fd =3D open(filename, O_RDONLY|O_NOCTTY|O_CREAT, 0666);
+    open_accmode =3D ((type =3D=3D LOCK_SH || access(filename, R_OK|W_OK) =
< 0) ?
+                    O_RDONLY : O_RDWR);
+    fd =3D open(filename, open_accmode|O_NOCTTY|O_CREAT, 0666);
     /* Linux doesn't like O_CREAT on a directory, even though it should be=
 a
-       no-op */
+       no-op; POSIX doesn't allow O_RDWR or O_WRONLY */
     if (fd < 0 && errno =3D=3D EISDIR)
         fd =3D open(filename, O_RDONLY|O_NOCTTY);
=20
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk5xtQQACgkQnZxG0T6qDD1fwgCggOErqTnc6CCez+bsLifPXIdQ
m2kAoIW+C3Xx1mHAXoZWKyiluElKa6nM
=8Ic0
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
