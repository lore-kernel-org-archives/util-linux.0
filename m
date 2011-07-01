Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:52021 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753132Ab1GALLh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 1 Jul 2011 07:11:37 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id A2DD48B013
	for <util-linux@vger.kernel.org>; Fri,  1 Jul 2011 13:11:36 +0200 (CEST)
Date: Fri, 1 Jul 2011 13:11:36 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: rangelino@novell.com
Subject: [PATCH] sfdisk: warn if partition size exceeds 2 TiB limit
Message-ID: <20110701111134.GA24033@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="liOOAslEiF7prFVr"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Roberto Angelino <rangelino@novell.com>
Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.c |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 6cd85a2..4ed5d37 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -1293,6 +1293,17 @@ partitions_ok(struct disk_desc *z) {
 	    }
     }
=20
+    /* Are the partitions within the DOS 2TiB limit? */
+    {
+	for (p =3D partitions; p < partitions + partno; p++)
+	    if (p->size > (unsigned long) UINT32_MAX) {
+	        my_warn(_("Warning: partition %s of size %lu sectors exceeds "
+		          "msdos 2TiB limit\n"),
+		        PNO(p), p->size);
+	        return 0;
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

--liOOAslEiF7prFVr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk4Nq2YACgkQnZxG0T6qDD25hgCfSbtydlnUZRgJi2q2PsDtXAju
92oAmgMfCSjYgJOufL04aYI9Rwp+AMq2
=DbSB
-----END PGP SIGNATURE-----

--liOOAslEiF7prFVr--
