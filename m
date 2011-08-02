Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50233 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096Ab1HBN1d (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2011 09:27:33 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id AA1668B013
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2011 15:27:32 +0200 (CEST)
Date: Tue, 2 Aug 2011 15:27:32 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] wall: build with SUID_{C,LD}FLAGS
Message-ID: <20110802132730.GA2195@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tThc/1wpZn/ma/RB"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 term-utils/Makefile.am |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/term-utils/Makefile.am b/term-utils/Makefile.am
index 7b545c3..b423bbd 100644
--- a/term-utils/Makefile.am
+++ b/term-utils/Makefile.am
@@ -55,6 +55,8 @@ if BUILD_WALL
 usrbin_exec_PROGRAMS +=3D wall
 wall_SOURCES =3D wall.c ttymsg.c ttymsg.h $(top_srcdir)/lib/strutils.c
 dist_man_MANS +=3D wall.1
+wall_CFLAGS =3D $(SUID_CFLAGS) $(AM_CFLAGS)
+wall_LDFLAGS =3D $(SUID_LDFLAGS) $(AM_LDFLAGS)
 endif
=20
 if BUILD_WRITE
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--tThc/1wpZn/ma/RB
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk43+0IACgkQnZxG0T6qDD2StgCeLkWjRQqP1zzsgGcAbACOoyru
exAAnjYEnQWLUCbb1XTYdOqOMIfXMXWz
=VthI
-----END PGP SIGNATURE-----

--tThc/1wpZn/ma/RB--
