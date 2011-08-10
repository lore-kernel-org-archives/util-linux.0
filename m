Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:37359 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753881Ab1HJMQm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Aug 2011 08:16:42 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D98228AD27
	for <util-linux@vger.kernel.org>; Wed, 10 Aug 2011 14:16:41 +0200 (CEST)
Date: Wed, 10 Aug 2011 14:16:40 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] dmesg: avoid mess at the end of dmesg output
Message-ID: <20110810121639.GA19672@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Since util-linux commit a7ee94f2204011f26232ed3133514bf6e0d4a62c,
dmesg incorrectly calculates number of bytes that are remaining in the
buffer in get_next_record(). This could, under specific circumstances,
cause printing mess at the end of dmesg output:

> dmesg | tail
[ 1191.478725] Adding 285488k swap on /root/swapfile.  Priority:-2 extents:=
15 across:1186612k
[ 1205.588331] Adding 285488k swap on /root/swapfile.  Priority:-2 extents:=
15 across:1186612k
\xffffffba\xffffffba

Reported-by: Glenn Doig <doiggl@velocitynet.com.au>
Addresses: https://bugzilla.novell.com/show_bug.cgi?id=3D710417

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 sys-utils/dmesg.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 94f8c11..705269d 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -494,6 +494,8 @@ static int get_next_record(struct dmesg_control *ctl, s=
truct dmesg_record *rec)
=20
 		rec->next_size -=3D end - rec->next;
 		rec->next =3D rec->next_size > 0 ? end + 1 : NULL;
+		if (rec->next_size > 0)
+			rec->next_size--;
=20
 		return 0;
 	}
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk5CdqcACgkQnZxG0T6qDD0spgCfVvDF0DOEJow+oFsgv0jE65WA
MmkAn1qJNmtgbuQ+V/bg/05JttkEmS/A
=IFjA
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
