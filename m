Return-Path: util-linux-owner@vger.kernel.org
Received: from minas.ics.muni.cz ([147.251.4.40]:34917 "EHLO minas.ics.muni.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756147Ab2EGNwG (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 7 May 2012 09:52:06 -0400
Received: from album.ics.muni.cz (album.ics.muni.cz [147.251.23.20])
	by minas.ics.muni.cz (8.13.8/8.13.8/SuSE Linux 0.8) with SMTP id q47DYGxF005677
	for <util-linux@vger.kernel.org>; Mon, 7 May 2012 15:34:17 +0200
Date: Mon, 7 May 2012 15:34:15 +0200
From: Petr Pisar <petr.pisar@atlas.cz>
To: util-linux@vger.kernel.org
Subject: addpart and delpart tools are not internationalized
Message-ID: <20120507133415.GA7097@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

I've just found addpart and delpart does not put any message into most recent
(2.21-rc2) gettext translation catalog template. Thus the output of these two
tools cannot be translated.

-- Petr

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iF4EABEIAAYFAk+nz1cACgkQEsnFx2fG+qJ0GgD+Kdo/2MmS+epCU2eJR02CmSQE
xjwT+DjaIt1uZHDgdE8A+wWFaAc40lvg+i5aQ7HUqnhe2oXPv/CmegR7QFCWoW+z
=rsAp
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
