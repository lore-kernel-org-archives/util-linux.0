Return-Path: util-linux-owner@vger.kernel.org
Received: from jespernyerup.dk ([109.74.204.79]:50208 "EHLO jespernyerup.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751326AbaBWTUB (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 23 Feb 2014 14:20:01 -0500
Date: Sun, 23 Feb 2014 20:20:00 +0100
From: Jesper Dahl Nyerup <nyerup@one.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] script: Also flush writes to timing file.
Message-ID: <20140223191959.GA3103@one.com>
Reply-To: nyerup@one.com
References: <1392673386-42128-1-git-send-email-nyerup@one.com>
 <1392752925-48502-1-git-send-email-nyerup@one.com>
 <20140221124420.GE30903@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
In-Reply-To: <20140221124420.GE30903@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Feb 21  13:44, Karel Zak wrote:
> On Tue, Feb 18, 2014 at 08:48:45PM +0100, Jesper Dahl Nyerup wrote:
> >  term-utils/script.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
>=20
>  Applied, thanks.
>=20
>  I have also made the files usage more robust and close all in done()
>  (based on Sami's suggestion).

Thanks!

J.
--=20
Jesper Dahl Nyerup
Systems Engineer
One.com, nyerup@one.com

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iEYEARECAAYFAlMKSd8ACgkQtzA4yjN/Kb37qgCfdGwKaAz55ZdNIj6v4rB/bb2z
UnkAoIXyXkPzLHUcmi4NsEHzW9oI68TZ
=qaZQ
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
