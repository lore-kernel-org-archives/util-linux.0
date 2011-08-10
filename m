Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:54108 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753255Ab1HJJqV (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Aug 2011 05:46:21 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id E5B8A8A95F
	for <util-linux@vger.kernel.org>; Wed, 10 Aug 2011 11:46:19 +0200 (CEST)
Date: Wed, 10 Aug 2011 13:46:06 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] logger.1: use simple apostrophe instead of multibyte char
Message-ID: <20110810114604.GA31717@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/logger.1 |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index 4312551..c5f8424 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -110,7 +110,7 @@ The
 utility exits 0 on success, and >0 if an error occurs.
 .Pp
 Valid facility names are: auth, authpriv (for security information of a
-sensitive nature), cron, daemon, ftp, kern (can=E2=80=99t be generated fro=
m user
+sensitive nature), cron, daemon, ftp, kern (can't be generated from user
 process), lpr, mail, news, security (deprecated synonym for auth), syslog,
 user, uucp, and local0 to local7, inclusive.
 .Pp
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk5Cb3wACgkQnZxG0T6qDD1qugCfX6onA/JxjsJ4LJCUiZlWZJYa
gcgAn3zkqy5EQxViyegFAkvdEx/IwL5p
=YPAx
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
