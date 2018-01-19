Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43826 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752855AbeASCrS (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 18 Jan 2018 21:47:18 -0500
Date: Thu, 18 Jan 2018 21:47:17 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: Carlos Santos <casantos@datacom.ind.br>, util-linux@vger.kernel.org
Subject: Re: Problem building util-linux without a separate ncursesw include
 dir
Message-ID: <20180119024717.GJ7217@vapier>
References: <1971282138.2691482.1501546323018.JavaMail.zimbra@datacom.ind.br>
 <1705151756.2691717.1501548399616.JavaMail.zimbra@datacom.ind.br>
 <20170801072017.yl7mgv64pq7ccj5e@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Re2uCLPLNzqOLVJA"
In-Reply-To: <20170801072017.yl7mgv64pq7ccj5e@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--Re2uCLPLNzqOLVJA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 01 Aug 2017 09:20, Karel Zak wrote:
> On Mon, Jul 31, 2017 at 09:46:39PM -0300, Carlos Santos wrote:
> > > From: "Carlos Santos" <casantos@datacom.ind.br>
> > > To: util-linux@vger.kernel.org
> > > Sent: Monday, July 31, 2017 9:12:03 PM
> > > Subject: Problem building util-linux without a separate ncursesw incl=
ude dir
> >=20
> > > of util-linux. Would it be possible to make the location of ncursesw
> > > headers configurable, instead?
>=20
> We test for alone ncurses.h and term.h in the for non-wide ncurses.
> Can you send output from your configure from the current master
> branch (or v2.30.1)?
>=20
> > I was thinking on something simple, like https://pastebin.com/VqM9G9yu
>=20
> Hmm, but you don't distinguish between wide and non-wide ncurses.

why don't we just support ncurses's pkg-config files as the default ?
$ pkg-config --cflags ncurses
-D_GNU_SOURCE
$ pkg-config --cflags ncursesw
-D_GNU_SOURCE -I/usr/include/ncursesw
-mike

--Re2uCLPLNzqOLVJA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlphXDQACgkQQWM7n+g3
9YEa+A//Qo1NOi1kRxiVjYlucxcGgMpFbA5xQ5uumfl1ghkEOTYo7wdHdGsqJfj+
9P6Zmo8qHW6zadPBMVek2VYycfPMgXY2pg/duLmPIvgsXjMyEr8aVpUmiBQ6osx0
32KMQAFfTwPKULze8GrCqrBmIx9Z1rqKjRbAmnEcCFJu6rxTGu/mufMnh3ZZI/qi
KCe6F4ge+yvHBG/WFxlaGCL59BRbpEuzy2LmJ5ptBNd2RM7+sZn9sxZ+kurwq0TN
ids8HAjJCCaqFGrKspyTD5K50rDz1l6dJEyknc5OG5VR5otf4hw7s9JcrmCNs3Gm
RYA4bPne/UwViDy4MNjO8kdRx5FA0C+GzhFxRwXdLVPWkBMPIANvKBkSnCiWoe4+
ercocVehQ1itm/iGxUGoa8oABaKsbsJpkPHQrsHdSshf75Ta6/PtU3T4jOKcaejh
0BN/oebpre8RFSGoC1/JZPMWwqOKg0IPVDCCKkhN3dPgWfhs1vlxiiK0qTswvJPV
0KAtmZ3W+ou0CQ/IBIKaPgwf+bcg7ZTVTlsn8Cky3fb+E1r0FBOY8C9h8h/n7yJ8
g6I9J/RJUG7WVN0dhYvj8n6dUKs5upPqY/pgrBDQD7upA6+SIFbQveJsneVWlQKb
IlRq9rvkRaKlfn3++qiBE9YYeMHRcQiw8//zOzQbPjQdRb+gBYU=
=PUrD
-----END PGP SIGNATURE-----

--Re2uCLPLNzqOLVJA--
