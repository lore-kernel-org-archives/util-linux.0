Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:38346 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757094Ab3HZQnu (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 Aug 2013 12:43:50 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Dave Reisner <d@falconindy.com>
Subject: Re: building pylibmount when python -> python3
Date: Mon, 26 Aug 2013 12:43:51 -0400
Cc: util-linux@vger.kernel.org
References: <20130826124730.GN699@rampage>
In-Reply-To: <20130826124730.GN699@rampage>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4005987.pTbduNuAqu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201308261243.52183.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart4005987.pTbduNuAqu
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 26 August 2013 08:47:30 Dave Reisner wrote:
> This came up in IRC and I thought it might be a good idea to mention it
> to the list. With pylibmount recently being merged into git, some folks
> might have trouble building from HEAD if their /usr/bin/python points to
> a version python>=3D3.0. While the end goal (after discussion with Karel)
> seems to be that we should be able to build this for both python2 and
> python3, you can work around the build failure for now by simply passing
> --with-python=3D/usr/bin/python2 (or --without-python if you don't care
> for the new module).

that doesn't quite work due to logic in the configure script that rejects=20
anything other than "yes".  fixing that doesn't help as AM_PATH_PYTHON only=
=20
respects $PYTHON.  then you have to set it to the full path and not just=20
PYTHON=3Dpython2 because the configure script wants the full path (to run t=
he=20
config script).  it's all pretty fragile atm.

i think the workaround is:
	$ PYTHON=3D/usr/bin/python2 ./configure
(or point it at python2.7 if your distro installs a fuller version)
=2Dmike

--nextPart4005987.pTbduNuAqu
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSG4XIAAoJEEFjO5/oN/WBOf0P/1UJRt6jqOTGZ2EM48W8bdjR
awlGo+b1CeWYTlNWX1pUlYGuTrKvuJVOnqgRiV6hwydrLy29iXrpF5xC8HT7+HqZ
+erS7lVM6dWgo4tllxf9cLfRUDGC3oGNy9XMZTa/ikXzfG3j5hCiAeuzk+r/G3wP
Ypa7NZbVaxcAkSUZ8iutPcdlhwNFoPZhzmGd2hMhdvXyu9qayTaEXmaqJUi/Y4Bf
hs8vOecbMBmPWI+AD84syqFY+TS23S6xVoLy/vLsJZKoZNaZ2mGDyO9ATDGvnIsF
LGk+JFZPLDNMQDs61ncIL0QH4vlUi0CC/5F3JwL0bQTSYqHXIdPay7dp4N2cvwT2
UayVaARMRfwSh2sSoJEYKI8ukmu5fIzxdwHoVLcZJfyhf6DpxiMC4qaHzPszMeyt
GgRsqQLPaOJ2Td1kw9vEjDCgPjQKtug0+eamUrHg4hxkajwlRosDhM3kmk8gqjlZ
YSzi6X2WUgwP73tEoyYSWGZ3vV3+l5mz9+AV4cnzKMEIdkHwvgt+GvM9VbirOrrp
QRA3Lyi46CcsIHVuP7Rq8L9lK4lkuT9qGIPfvPX/aHA2zJ6mk+pJ9U6mWGpeos0Y
7stlNSC6XMYQK9yZMmk+NNmt9SJsigwdOJd5UM8psgTvcxXD+GHEInoF4yMmJilr
HbyojJWh4H7wC4vlH0Ng
=8l5R
-----END PGP SIGNATURE-----

--nextPart4005987.pTbduNuAqu--
