Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:53130 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755430Ab2ECTEm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 3 May 2012 15:04:42 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id D82D69664A
	for <util-linux@vger.kernel.org>; Thu,  3 May 2012 21:04:41 +0200 (CEST)
Date: Thu, 3 May 2012 21:04:34 +0200
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: Re: [PATCH 3/3] libuuid: use randutils
Message-ID: <20120503190434.GA32558@skipper.site>
References: <1333662730.2696.6.camel@offbook>
 <20120410113150.GN19784@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
In-Reply-To: <20120410113150.GN19784@x2.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2012 at 01:31:50PM +0200, Karel Zak wrote:
> On Thu, Apr 05, 2012 at 11:52:10PM +0200, Davidlohr Bueso wrote:
> >  libuuid/src/Makefile.am |    3 +-
> >  libuuid/src/gen_uuid.c  |   99 ++-------------------------------------=
-------
> >  2 files changed, 7 insertions(+), 95 deletions(-)
>=20
>  Applied, thanks.
>=20
> > @@ -703,7 +614,7 @@ void uuid_generate_random(uuid_t out)
> >   */
> >  void uuid_generate(uuid_t out)
> >  {
> > -	if (get_random_fd() >=3D 0)
> > +	if (random_get_fd() >=3D 0)
> >  		uuid_generate_random(out);
>=20
> This sucks:
>=20
>  - because we call random_get_fd() in __uuid_generate_random again:
>=20
>    $ strace -e open ./misc-utils/uuidgen
>    open("/dev/urandom", O_RDONLY)          =3D 3
>    open("/dev/urandom", O_RDONLY)          =3D 4
>=20
>    it would be better to add 'fd' argument to __uuid_generate_random(),
>    use it in uuid_generate() and reuse the file descriptor if >=3D 0.=20
>=20
>    We use __uuid_generate_random in the library and in uuidd, so we
>    don't have to care about API there.
>=20
>  - it's file descriptor leak in shared library...
>=20
>  Volunteers? ;-)

Patch addressing this is included in the uuidd series I sent shortly
before. But please check the note about it in the series cover letter.

Thanks,

Petr

--=20
Petr Uzel
IRC: ptr_uzl @ freenode

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk+i1sIACgkQnZxG0T6qDD0krgCfenUWrU3TJGC/nWqEIWIIxtan
Qu8An36sP4rqPK08D3PczLrfEn356RPE
=+FrM
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
