Return-Path: nyerup@one.com
Date: Mon, 10 Feb 2014 20:10:01 +0100
From: Jesper Dahl Nyerup <nyerup@one.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] scriptreplay: Add --maxdelay option.
Message-ID: <20140210191000.GA19280@one.com>
Reply-To: nyerup@one.com
References: <1392029598-8089-1-git-send-email-nyerup@one.com>
 <20140210182536.GS8506@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
In-Reply-To: <20140210182536.GS8506@x2.net.home>
List-ID: <util-linux.vger.kernel.org>


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 10  19:25, Karel Zak wrote:
> On Mon, Feb 10, 2014 at 11:53:18AM +0100, Jesper Dahl Nyerup wrote:
> >  term-utils/scriptreplay.1 |  6 ++++++
> >  term-utils/scriptreplay.c | 15 ++++++++++++---
> >  2 files changed, 18 insertions(+), 3 deletions(-)
>=20
>  Applied, thanks.

Back atcha.

> > +	double divi =3D 1, maxdelay =3D 10;
>=20
>  I have used maxdelay =3D 0; it seems more readable :-)

Fine by me.

I had 0 in my patch initially, but changed it to 10. The only reason was
if someone someday decided to make the option argument optional, a
default value of 0 would effectively render scriptreplay(1) to be a
poorly implemented cat(1).

But let's cross that bridge when we reach it.

J.
--=20
Jesper Dahl Nyerup
Systems Engineer
One.com, nyerup@one.com

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlL5JAgACgkQtzA4yjN/Kb09WgCgnCAOjSxBvIns6fZEpPK4eFkf
oDAAn2WJoJKupqIaxd8fdypyGS5r16Up
=WNi0
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
