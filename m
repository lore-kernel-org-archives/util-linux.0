Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:58398 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750742Ab1H3IUE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 30 Aug 2011 04:20:04 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 7861D8EE5B
	for <util-linux@vger.kernel.org>; Tue, 30 Aug 2011 10:20:02 +0200 (CEST)
Date: Tue, 30 Aug 2011 10:17:24 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] sfdisk.8: fix formatting
Message-ID: <20110830081722.GA20499@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ReaqsoxgOBHFXBhH"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.8 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisk/sfdisk.8 b/fdisk/sfdisk.8
index 7e659da..b7d8db7 100644
--- a/fdisk/sfdisk.8
+++ b/fdisk/sfdisk.8
@@ -237,7 +237,7 @@ For example:
 .fi
 first reports that /dev/hdb5 has Id 6, and then changes that into 83.
 .TP
-.BR \-u ", " \-\-unit " \fI\letter\fR"
+.BR \-u ", " \-\-unit " \fIletter\fR"
 Interpret the input and show the output in the units specified by
 .IR letter .
 This \fIletter\fR can be one of S, C, B or M, meaning Sectors, Cylinders,
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--ReaqsoxgOBHFXBhH
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk5cnJIACgkQnZxG0T6qDD0qhQCgjC5EwM2GJZwJbP91MLUzdzHR
vUAAn0V88tHX7Cjof0aXI8LjEqVheV7D
=kSh6
-----END PGP SIGNATURE-----

--ReaqsoxgOBHFXBhH--
