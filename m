Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:52047 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132Ab1GALL5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 07:11:57 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BBBB78A95F
	for <util-linux@vger.kernel.org>; Fri,  1 Jul 2011 13:11:56 +0200 (CEST)
Date: Fri, 1 Jul 2011 13:11:56 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] sfdisk: warn if partition starts above 2 TiB limit
Message-ID: <20110701111154.GA24105@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZPt4rx8FFjLCG7dd"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ZPt4rx8FFjLCG7dd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 4ed5d37..d498371 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -1304,6 +1304,17 @@ partitions_ok(struct disk_desc *z) {
 	    }
     }
=20
+    /* Do the partitions start below the DOS 2TiB limit? */
+    {
+	for (p =3D partitions; p < partitions + partno; p++)
+	    if (p->size && p->start > (unsigned long) UINT32_MAX) {
+	        my_warn(_("Warning: partition %s has starting sector %lu, "
+		          "which is above the DOS 2 TiB limit\n"),
+			PNO(p), p->start);
+		return 0;
+	    }
+    }
+
     /* At most one chain of DOS extended partitions ? */
     /* It seems that the OS/2 fdisk has the additional requirement
        that the extended partition must be the fourth one */
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--ZPt4rx8FFjLCG7dd
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk4Nq3oACgkQnZxG0T6qDD0r9gCeI797BxsA9U7qAzu7DSeB3ba5
Xo8AnRC+YnKKhK6s4dyllmxAGCDU8L9j
=4wWj
-----END PGP SIGNATURE-----

--ZPt4rx8FFjLCG7dd--
