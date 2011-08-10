Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:40948 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751495Ab1HJNcb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 10 Aug 2011 09:32:31 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 940078980B
	for <util-linux@vger.kernel.org>; Wed, 10 Aug 2011 15:32:30 +0200 (CEST)
Date: Wed, 10 Aug 2011 15:32:28 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] hexdump: fix segfault due to uninitialized memory
Message-ID: <20110810133227.GA14002@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CE+1k2dSO48ffgeK"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

util-linux commit 85bf44b714ab184907eb448eba389218956d6a51
replaced all calls to emalloc() with xmalloc(), whose semantics
is however different - it does not zero allocated memory. This
made hexdump segfault if MALLOC_PERTURB_ was set.

Reported-by: Kyrill Detinov <lazy.kent@opensuse.org>
Addresses: https://bugzilla.novell.com/show_bug.cgi?id=3D710877

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 text-utils/display.c |    4 ++--
 text-utils/parse.c   |    6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/text-utils/display.c b/text-utils/display.c
index c700b02..ad638e7 100644
--- a/text-utils/display.c
+++ b/text-utils/display.c
@@ -233,8 +233,8 @@ get(void)
 	u_char *tmpp;
=20
 	if (!curp) {
-		curp =3D xmalloc(blocksize);
-		savp =3D xmalloc(blocksize);
+		curp =3D xcalloc(1, blocksize);
+		savp =3D xcalloc(1, blocksize);
 	} else {
 		tmpp =3D curp;
 		curp =3D savp;
diff --git a/text-utils/parse.c b/text-utils/parse.c
index 7168aad..e41b4a0 100644
--- a/text-utils/parse.c
+++ b/text-utils/parse.c
@@ -86,7 +86,7 @@ void add(const char *fmt)
 	const char *savep;
=20
 	/* Start new linked list of format units. */
-	tfs =3D xmalloc(sizeof(FS));
+	tfs =3D xcalloc(1, sizeof(FS));
 	if (!fshead)
 		fshead =3D tfs;
 	else
@@ -102,7 +102,7 @@ void add(const char *fmt)
 			break;
=20
 		/* Allocate a new format unit and link it in. */
-		tfu =3D xmalloc(sizeof(FU));
+		tfu =3D xcalloc(1, sizeof(FU));
 		*nextfu =3D tfu;
 		nextfu =3D &tfu->nextfu;
 		tfu->reps =3D 1;
@@ -219,7 +219,7 @@ void rewrite(FS *fs)
 		 * conversion character gets its own.
 		 */
 		for (nconv =3D 0, fmtp =3D fu->fmt; *fmtp; nextpr =3D &pr->nextpr) {
-			pr =3D xmalloc(sizeof(PR));
+			pr =3D xcalloc(1, sizeof(PR));
 			if (!fu->nextpr)
 				fu->nextpr =3D pr;
 			else
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk5CiGsACgkQnZxG0T6qDD17xwCePf8NYpqQ/GzFFeyiZ90u3eZr
vqIAoImmFZdFFaJBk+v2C+SPPl5Fj1Us
=A2a3
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
