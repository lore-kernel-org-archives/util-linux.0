Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:46368 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab1IMJIs (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 13 Sep 2011 05:08:48 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 5CDF189994
	for <util-linux@vger.kernel.org>; Tue, 13 Sep 2011 11:08:47 +0200 (CEST)
Date: Tue, 13 Sep 2011 11:08:46 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Neil F Brown <nfbrown@suse.com>
Subject: [PATCH] lib: do not attempt to close(0) in sysfs_deinit()
Message-ID: <20110913090845.GA8203@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="PNTmBPCT7hxwcZjr"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

If the 'open' fails we 'goto err' which runs 'sysfs_deinit()' on a 'cxt'
which hasn't been fully initialised. The 'dir_fd' is still 0, so
sysfs_deinit calls "close(0)".

Addresses: https://bugzilla.novell.com/show_bug.cgi?id=3D714151
Reported-by: Diego Ercolani <diego.ercolani@gmail.com>
Analysed-by: Neil Brown <nfbrown@suse.com>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 lib/sysfs.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index eec1f24..ebb3bb5 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -140,6 +140,7 @@ int sysfs_init(struct sysfs_cxt *cxt, dev_t devno, stru=
ct sysfs_cxt *parent)
 	int fd, rc =3D 0;
=20
 	memset(cxt, 0, sizeof(*cxt));
+	cxt->dir_fd =3D -1;
=20
 	if (!sysfs_devno_path(devno, path, sizeof(path)))
 		goto err;
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--PNTmBPCT7hxwcZjr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk5vHZ0ACgkQnZxG0T6qDD13TQCfXT1gJbFKZXvVmDz3Yk69GCMC
mV4An0K+2DMJBNVxKwtUtqettJ1oUHgU
=jZPq
-----END PGP SIGNATURE-----

--PNTmBPCT7hxwcZjr--
