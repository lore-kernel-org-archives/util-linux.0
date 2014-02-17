Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:51676 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750929AbaBQIbD (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 17 Feb 2014 03:31:03 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH 3/3] tests: automatic whitespace trimming broke earlier commit
Date: Mon, 17 Feb 2014 03:31:01 -0500
Message-ID: <7637074.9zSARVxuln@vapier>
In-Reply-To: <1389816953-11531-3-git-send-email-kerolasa@iki.fi>
References: <1389816953-11531-1-git-send-email-kerolasa@iki.fi> <1389816953-11531-3-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1803405.aa0p9XhJz0"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart1803405.aa0p9XhJz0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Wednesday, January 15, 2014 20:15:53 Sami Kerola wrote:
> Setting in .gitconfig to do 'git apply --whitespace=3Dfix' automatica=
lly
> turned automation against user.

seems like git settings are still breaking these tests ?  commit=20
c367cda936f301b3d116a587356594b038de6d04 in the tree doesn't modify any=
thing=20
and three of the cal tests are failing because of trailing whitespace=20=

differences.
=2Dmike
--nextPart1803405.aa0p9XhJz0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABAgAGBQJTAcjFAAoJEEFjO5/oN/WBALAP/Rxu3NA/DXvbWY0lzGp7MWvS
VZroeGxDa9jAExbCT//LlPFas5X1kWrpNQhBf1QqLreX8dlPiAH+jkhR1vlbYjrs
JidbZJ2S79lKyx8fOYW9fEHWIugFa9+/Jl6ZHOlLpNAFp575rUiHO/EWcvGF/6VT
wvzZ7owMeXtNIsLt0GP0lWiIUfu9qIOnpVxq4vfTz5Yi0IrOkpUaAxKlWM+fX2Py
0WZfDzU/7SS07CzybK1sH4Ycp5pU1GOHmunb15T1TRUVaipyA3JlhmSybHTd2Wwg
lI2N9KbhtVN0PJTwVRPaJL+fB/G0H0BQFjuiszWHz5QwoSazZGCXbzL/8uvmG7aX
m6k7ibXaQWwUQZZvZZyyndhJIM4ZlIAyoDk63C2sGfMYdEab38cKSLoO7DCTocem
ZCufnXVi+J+UZx2jALtdqgb6Jfqwd6Pn7uv2AQpxo9JMzZkSvyL2pG67Z/54dqA/
HsnRyLXrKNy6k7xZgQDyvMruTNKYWc2ZG0goNjTOvTiUfVD9mssTQHBDgkg85F+d
v7hxAw8W3ToNb7g5PVUCpacZwSPFWiKe9zFsmDn+XttdwmTReowD9nfLRV4/L6ow
7iSgxkrFYgwlbsck3u9u+Jl8wgK5UTmQQodhAavBaRN6nymOLNKrsARklP7dXnEY
kYkIVJ+2pwobk45UQu16
=R5rD
-----END PGP SIGNATURE-----

--nextPart1803405.aa0p9XhJz0--

