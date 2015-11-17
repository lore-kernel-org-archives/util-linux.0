Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:60510 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752503AbbKQEc3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Nov 2015 23:32:29 -0500
Date: Mon, 16 Nov 2015 23:32:29 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: "U.Mutlu" <for-gmane@mutluit.com>
Cc: util-linux@vger.kernel.org
Subject: Re: user namespaces: user mapping
Message-ID: <20151117043229.GH31395@vapier.lan>
References: <n2besp$j56$1@ger.gmane.org>
 <20151116041931.GC5949@vapier.lan>
 <n2ctjg$1d0$1@ger.gmane.org>
 <n2dpk4$p47$1@ger.gmane.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xHbokkKX1kTiQeDC"
In-Reply-To: <n2dpk4$p47$1@ger.gmane.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--xHbokkKX1kTiQeDC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17 Nov 2015 00:41, U.Mutlu wrote:
> I did some research on the net, and the findings are:
>   - user namespaces have their own security holes

there are no known security issues.  like all new code, there were some edge
cases in the original implementation, but they've been fixed since.  the on=
ly
thing left is that people don't like the new attack surface and inherently
distrust it.  but that's not the same thing as there being known security h=
oles.

>   - a workaround exists, but then a new problem happens: loop devices can=
not=20
> be accessed

loop devices are merely files which are owned by the root user.  not being =
able
to open files owned by the "real" root is to be expected.

> Does the user need to create his own loop device(s)?

you need to have the system/root chown them as the user before doing anythi=
ng
else.  sucks, but that's currently how it works.  would be nice if someone=
=20
looked into making it more accessible to users.  maybe others on this list =
are
aware of ongoing work.

> Hmm. it looks like there is (currently?) a big mess with user namespaces:
> https://code.google.com/p/chromium/issues/detail?id=3D457362

no, no there is not
-mike

--xHbokkKX1kTiQeDC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWSq3cAAoJEEFjO5/oN/WB/TsQAJwM1yH9XbkLOiTYTEj5SBB+
UuY0U4ZZbnDOzmoI7hK4uWRI8WM6epapX3ObmB2zDKX3QBCK0ly4pE/bjJtMdxNw
yX1IHdMtSYgxEbGVhou8LStFGTB+3foukxjc1SNbRLSWuWno5xY7lEJwqUkhuUyP
uVfbNgPsH6msNRZqsQRxDE+yJKZW1010No1FxociQtamITa3t3SmtrY48hvAeJSo
tnKfztVYvlDJ2XxZ6v1/ZZbsBYEiWvsRtpVeH6cZkNy5mWgfsKiQt7JTyjZYn+BH
3AFbfCiES54vQGy2qQz9rSH2ywAULsiQszUnT02U5iwbtcc3cvcGpFaiYktBKynD
he+Vr9spASgB7eKRq36MMJCS1NLribZmK2F6QSljydcD8v5RrYlnv98KseJ569DS
gHkoxWHKnGCJ52TEyRQKD3hT+MYUZrDZpltlmpHZLK3u5TehFpwUhaVWRwTLYeIw
HCCn1F6pILBbsL4+bW7pDg7fzeV9pQmHOB6d0VRaeP8Ez5mOaK4Lu3HaOuizYo0g
/i2DsvNP5M/v265epSI9DVSjy13nrUPNA2dXao4CzfpEpbubq5fswM+uXUomjFBZ
P+v75RGBWk4Yz695sPqPCbf4n52ar36Iw/spM7UzKj1o8+v/sfMyLOp22PDyiOwd
qVcf+iY8SLxKk4+nRtMc
=3fpU
-----END PGP SIGNATURE-----

--xHbokkKX1kTiQeDC--
