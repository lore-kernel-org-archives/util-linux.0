Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:48019 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754433Ab1HBMz4 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 2 Aug 2011 08:55:56 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id CAE668B45E
	for <util-linux@vger.kernel.org>; Tue,  2 Aug 2011 14:55:55 +0200 (CEST)
Date: Tue, 2 Aug 2011 14:55:55 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH] cal: fix manpage formatting
Message-ID: <20110802125553.GA12229@foxbat.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/cal.1 |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/misc-utils/cal.1 b/misc-utils/cal.1
index d13c900..953e82a 100644
--- a/misc-utils/cal.1
+++ b/misc-utils/cal.1
@@ -35,9 +35,8 @@
 .\"     @(#)cal.1	8.1 (Berkeley) 6/6/93
 .\"
 .TH CAL "1" "June 2011" "util-linux" "User Commands"
-.Sh NAME
-.Nm cal
-.Nd displays a calendar
+.SH NAME
+cal \- displays a calendar
 .SH SYNOPSIS
 .B cal
 [\fIoptions\fR] [[[\fIday\fR] \fImonth\fR] \fIyear\fR]
--=20
1.7.3.4


Petr

--
Petr Uzel
IRC: ptr_uzl @ freenode

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.16 (GNU/Linux)

iEYEARECAAYFAk4389kACgkQnZxG0T6qDD2jJwCffBJYtLd3mR6UUX64FgHI/rqZ
Vf4AnA1KJoYYA57B2vKCC4pQvxvPoHD4
=T7iC
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
