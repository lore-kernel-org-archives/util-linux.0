Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:41271 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbbGGP4t (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Jul 2015 11:56:49 -0400
Date: Tue, 7 Jul 2015 11:56:47 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt once the network addresses change if
 address displayed
Message-ID: <20150707155647.GL17734@vapier>
References: <1435928288-25644-1-git-send-email-stefw@redhat.com>
 <20150706140711.GF17734@vapier>
 <559ACFC3.6050303@gmail.com>
 <20150707042512.GI17734@vapier>
 <559B5E22.2050902@gmail.com>
 <20150707070716.GJ17734@vapier>
 <559BE8B0.3020403@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="NxDiCysn+RCvdoZt"
In-Reply-To: <559BE8B0.3020403@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--NxDiCysn+RCvdoZt
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07 Jul 2015 09:56, Bruce Dubbs wrote:
> Mike Frysinger wrote:
> > the whole point of libmnl is to provide a clean userspace library API t=
hat is
> > completely standalone & minimal (it's in the name) so people don't have=
 to
> > learn the low level netlink APIs nor have to include linux/ headers dir=
ectly
> > (which often lead to clashes with the C libraries).  libmnl itself is <=
20KiB,
> > so i don't buy the bloat argument.
> >
> > even then, if we do use libmnl in util-linux, it'd have configure check=
s so that
> > if the system doesn't have it, it'd be disabled automatically.  i'm sur=
prised
> > you're complaining about libmnl but not the other large external libs t=
hat
> > util-linux utilizes.
> >
> > another point of information: the latest iproute2 now requires libmnl, =
so that
> > ship has already sailed.
>=20
> Yes, you're right.  We do disable tipc in iproute2 for the same reason=20
> as we are discussing here.  That's not a function that many of our users=
=20
> would need.  If libmnl is added to util-linux, then we'll deal with it.

at some point i think it's going to be inevitable.  my (bystander) view is =
that=20
they'll be moving to use it more.
-mike

--NxDiCysn+RCvdoZt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVm/a/AAoJEEFjO5/oN/WBTkgP/jS607MHqzhA+aF40E9cC4lG
XwRtXAKQUg8teFBGpt5J/F9q+kTbbRkZupCIqdPkxpIYwMaRR/sLVZCHcCYUTBki
juKShiDtVNeqeu8eQgd2aMLae4WG0AOhj7yLoGhvy8dNaZuQejflZTgHsg1iV9so
a9JaFRXWOt1+JeRdpHg0SufNqo8/kMp1oB7P9OmCo0XzaarnEn3QMgI7UT55c6D2
IwLkQLOxl3rOKpHUK+IPawy9rfZl5G/1dzY/IBqSvHkZheWoodNCsnwdQjON4g/t
PcNbGRqXfn9WSJgK1WelW5TmJak0GH8B8b3PHNx5nz+JJE+seSru6z3kk5HD4ozt
mWdTQ0wGiL6wytXM739oXNOSAW/Qc0CnRmOpDwvpeZHf50Mz6ZvpqG+sGmMmfY46
dM/AfIn95WbdOrvawJN5bDLpmnmK6lCfP84fldApPQa4p2xQYBDAbpSLUkHVeAZc
i5pcywghk/OXqHdil0IHf1fpfV8uLPpI0imRKN5xpqiK077d+GMIMsH1k0Wvfhsh
U+w4qfXR7Vw7NTvgE5IoaX8nn3CQXI2sKcDfN/ydzcc7WDTUx4LtbhbR9j4KE/Gj
+FYbtlTGoYTmXFJbjogSahBDGMyVBQ/eXOrpfKzgikW76XaiQEUKPSuThgLOMye7
7Jpmj8dI4tuR6mo1/ONp
=nhA8
-----END PGP SIGNATURE-----

--NxDiCysn+RCvdoZt--
