Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:60794 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755208Ab1K0BJn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 26 Nov 2011 20:09:43 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Paul Stone <Paul@stone.org>
Subject: Re: how can I compile mount and umount as shared object files?
Date: Sat, 26 Nov 2011 20:10:02 -0500
Cc: util-linux@vger.kernel.org
References: <CA+zVqtWW+CknuW7NKyd2AZVsrDwj=J7gg+U2UYEBgbp++vaZgA@mail.gmail.com> <201111231358.16493.vapier@gentoo.org> <CA+zVqtWCj=zRaOeesLfaOABHiuBcQMqTZRfJwE84s_G=Z8qAAA@mail.gmail.com>
In-Reply-To: <CA+zVqtWCj=zRaOeesLfaOABHiuBcQMqTZRfJwE84s_G=Z8qAAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3462558.BzIE7p8OlG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201111262010.03052.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart3462558.BzIE7p8OlG
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Saturday 26 November 2011 19:34:38 Paul Stone wrote:
> Thanks Mike,

please don't top post

> Any idea why they are compiled as PIEs for CentOS (and presumably Red Hat=
)?

i vaguely recall that RedHat's policy is to build all set*id and network=20
daemons as PIEs as security precautions.  Karel would probably know more.
=2Dmike

--nextPart3462558.BzIE7p8OlG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJO0Y3qAAoJEEFjO5/oN/WBS5MP/1YmtTcdhBo8M8Xz9zpY9ev8
dn1Vr+9sAyXa3WwGla/t7fpJCAuXVDwyiUZBRW3qPBWfRZvSYmUg7nCHTCD81Jbw
63UZA/cjts6UU0hqqR/ld00AAh37l4neKDeCBhnwenR5rHa9xCGbg0u3w2ZAP0UY
WNuV0ZJ8NFvJQZl0+hQfrJ9CpunFLdwBKpvMmmG6HJuNqyq7M5CadzqqnFm/tZTm
qkLP6vTmLIlm0xr4csp35yTSo0v/TL5bWVr96vL5wW4/p7nUF7ATZixksJAPAES9
UXF4AP7LsotghZ1a5oepNj2nRtTn0Evo0HqDOIQ002f1D/f2U5DK2zZ0/lYtXmHQ
bzAYoOcLI7CDTYaaks47SSk0kZJeHZs8z1xV/92/6Uf8lVTDr9DNIJUZuaSCvcgx
JzXe59GFJXDAJALAs9lgT/MFIe5Q+Hs0BYY1uUgp8Ycx5NRQK4HJxffKXJBNGbK3
EcrTGRTZb9X5uR0o1xk+/nclRKarih/EaWQDNHeOZLtWTr7bUZB3QVuuAg89nvNt
cYstfwtB23rv5g8EBMEJZb3O1cDdfBHvsObybcTx5bldNl+jrVoJZqcVUYYBf+Kz
QgGHUKzlWxaKt3TFxH9/Jly7gU1c1kE7N7bbICGX7QewZEtMW06nA/Pfgkd08UMe
scT1jcqvqohvoUo+/gh4
=oap1
-----END PGP SIGNATURE-----

--nextPart3462558.BzIE7p8OlG--
