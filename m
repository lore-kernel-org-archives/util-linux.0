Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48030 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab1HBM4I (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2011 08:56:08 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 3737D8B45E
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2011 14:56:07 +0200 (CEST)
Date: Tue, 2 Aug 2011 14:56:06 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] look: fix manpage formatting
Message-ID: <20110802125605.GA12297@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/look.1 |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc-utils/look.1 b/misc-utils/look.1
index ea3b59e..a6ab568 100644
--- a/misc-utils/look.1
+++ b/misc-utils/look.1
@@ -54,9 +54,9 @@ that
 is invoked with).
 .PP
 If
-.Ar file
+.I file
 is not specified, the file
-.Pa /usr/share/dict/words
+.I /usr/share/dict/words
 is used, only alphanumeric characters are compared and the case of
 alphabetic characters is ignored.
 .SH OPTIONS
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk438+UACgkQnZxG0T6qDD3M6gCdFeUCZuq2wpt2Vqr0JDNEGWVE
g2UAn1TQxQDzapllouWzGa5Y6KmEgPhM
=PPDF
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--
