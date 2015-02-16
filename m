Return-Path: vapier@gentoo.org
Date: Mon, 16 Feb 2015 07:32:52 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: J William Piggott <elseifthen@gmx.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux <util-linux@vger.kernel.org>
Subject: Re: RFC hwclock: refactoring
Message-ID: <20150216123252.GE4359@vapier>
References: <5470FE32.9030805@gmx.com>
 <CAG27Bk3zu-8Qar_k44uM3_8_kOddJkqvb1be1_KmjkBGfBGcYA@mail.gmail.com>
 <20150216090226.GG4075@vapier>
 <54E1D668.3070001@gmx.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Rgf3q3z9SdmXC6oT"
In-Reply-To: <54E1D668.3070001@gmx.com>
List-ID: <util-linux.vger.kernel.org>


--Rgf3q3z9SdmXC6oT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 16 Feb 2015 06:37, J William Piggott wrote:
> On 02/16/2015 04:02 AM, Mike Frysinger wrote:
> > On 23 Nov 2014 13:31, Sami Kerola wrote:
> >> On 22 November 2014 at 21:20, JWP wrote:
> >>> Do we need Alpha code?  Is there a Linux distro that
> >>> still officially supports Alpha machines?
> >>
> >> I'm not sure if there is any up to date distribution for Alpha.
> >=20
> > Gentoo still produces up-to-date releases
>=20
> Yes, I contacted the two most authoritative Alpha people I could find,
> Tobias Klausmann and Matt Turner. Matt requested that we continue to
> maintain hwclock's Alpha code. I forgot to post a follow up here about
> it, sorry.

no worries.  if people are interested in refactoring code and want to verif=
y=20
alpha works (and qemu-system isn't doing it for them), we can get you acces=
s=20
to real alpha hardware :).
-mike

--Rgf3q3z9SdmXC6oT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJU4eN0AAoJEEFjO5/oN/WBbOkP/2sPNfMDYMuPMSXp+y3Hd5mU
GhZDbcN3SAYNBwBZH4xnrIqKzHO4juiuEcaRK6IoaOJ2cdYBqBMHgWlWlPsrQEGp
5i22h+xHEIICzG+k7qQ3Yguqu3K4kNFG31GiEa0gVh3vM0+rbTIRhrQSAYQsrrug
V/1VCtoB2K1IRBDZhIA90fL1h4PV4jVRIqXaZ6H9u6VCkVBxTuU8kqVuSTz0MBG9
kPJ3/yJkxKCKe90VG0eW8B99PDEephdL0LQKx7Ahvd1iFXoXHAmbZt7l2ngMS3J3
RdWRPzkCKpCp7pTZpucoUe1jtu85WjlOMGg4sYMLjNMPYumm5D7SmZ3D8RicHwdC
oaYUP0xJJSL9YrRh5tzskWWzcOElprPsXG1yC3vX5OuLNgjupOH3ej0wG3xr2Qy1
hGwge8UI3CdUvZNDEWlG5H3zkbITN7ppPKLq0GbtGkNOnoAWprVgX7dDhNf6OOs0
s1MPWcNCnFsm++UwLH81+J/PMOZOXU0ycXNp1IaLC/l+DzjNX75d+puIwzyXt1Zp
F+XK4QcJ/bEZGUb7LDqLYclTzJ5fAC3aXEYagZqEFwK04sxZoJsHrdNJLi/6Co8d
Z68SMS07dFGYkqVAh9bdcBA0WWTLNqybXCyqrHudTRgHx4+Iri7ra0JSQrgmyw9D
5z/Vu336R+tJGrJICRSa
=bmYk
-----END PGP SIGNATURE-----

--Rgf3q3z9SdmXC6oT--
