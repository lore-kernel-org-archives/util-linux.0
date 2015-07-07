Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:38271 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752049AbbGGHHR (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Jul 2015 03:07:17 -0400
Date: Tue, 7 Jul 2015 03:07:16 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] agetty: Reprompt once the network addresses change if
 address displayed
Message-ID: <20150707070716.GJ17734@vapier>
References: <1435928288-25644-1-git-send-email-stefw@redhat.com>
 <20150706140711.GF17734@vapier>
 <559ACFC3.6050303@gmail.com>
 <20150707042512.GI17734@vapier>
 <559B5E22.2050902@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Wosya/OiUJZ+2ov"
In-Reply-To: <559B5E22.2050902@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--9Wosya/OiUJZ+2ov
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 07 Jul 2015 00:05, Bruce Dubbs wrote:
> Mike Frysinger wrote:
> > On 06 Jul 2015 13:58, Bruce Dubbs wrote:
> >> Mike Frysinger wrote:
> >>> On 03 Jul 2015 14:58, Stef Walter wrote:
> >>>     #ifdef AGETTY_RELOAD
> >>>>    # include <sys/inotify.h>
> >>>> +# include <linux/netlink.h>
> >>>> +# include <linux/rtnetlink.h>
> >>>
> >>> why not use libmnl instead ?
> >>> 	http://netfilter.org/projects/libmnl
> >>
> >> That would not work for the LinuxFromScratch project.  At the time
> >> util-linux is built, libmnl is not available.
> >
> > then update the LFS insns to include libmnl, or build util-linux with t=
he
> > reload option disabled.  i don't see how LFS's decisions are relevant h=
ere.
>=20
> Yes, we can do either, but it seems like a lot of overhead to add a new=
=20
> package for 95 lines of code that are already written.
>=20
> We already manage about 1000 packages and are volunteers. Many of my=20
> users would call adding a new library for one minor function bloat.
> None of the packages we support now use that library although that could=
=20
> change in the future if others start to use it.
>=20
> Yes, our decisions are only a minor input to upstream packages, but=20
> there may be others that have similar concerns that don't monitor this li=
st.

the whole point of libmnl is to provide a clean userspace library API that =
is=20
completely standalone & minimal (it's in the name) so people don't have to=
=20
learn the low level netlink APIs nor have to include linux/ headers directl=
y=20
(which often lead to clashes with the C libraries).  libmnl itself is <20Ki=
B,=20
so i don't buy the bloat argument.

even then, if we do use libmnl in util-linux, it'd have configure checks so=
 that=20
if the system doesn't have it, it'd be disabled automatically.  i'm surpris=
ed=20
you're complaining about libmnl but not the other large external libs that=
=20
util-linux utilizes.

another point of information: the latest iproute2 now requires libmnl, so t=
hat=20
ship has already sailed.
-mike

--9Wosya/OiUJZ+2ov
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJVm3qjAAoJEEFjO5/oN/WB2YwP/iGXYP50BeowMemjhP81GWla
Q708j83aLRUbjPp9cJofYKz6+G0W/Ybmvd5VuO7UUXN/FGhV2PmEysOa3ktA3Po+
HJmlXFGR/qKqW2amV1sFGYu96ApNyrk1gkaD6UDoTZ/29/EQcAW7Xkeo0XzHRQX2
1Nfd0I5NMM8IIWNfS9xtbi47WT4ZHHYcgTjd9R88HM+HAweTff+cet1cmTPccZhm
p/oDTwYGNlfU3UOQ5O7TOCqVIVdg72M4fJMeX5CjxQUHS4+WRiGW2B1rYDZCo9x3
t7/skBVvumLakVpG4jV9W1OhdwapgMdPPCnpKeLluCPVqixbzAEtsUGhNFLPqPOa
KmB2xdU+fF8wqFBI4wTWj3DzpomfQ61T5T7AAQ9aX2kVNh4x8AybhlHoGeFmO9o8
xFHFxVGs/Rler45G+kYhLWM7Rkck++9hVkFW5qaCSIKZnDeuNLXYCeBoBhbOgUf8
15f6sYP5Gqde3JC4qBwzFRgnpJr7EhcnmetZNBcZbU2aAzJsUsj53uSknKPeNKV5
C0cbcX8cGnVeMXCCWARjF2AFRa/AOWgwXKcTnOdTqMfwPDJHwAtIrV4e5Cu9xj0E
0e8L0j+qvNqCtlvil2Y4OKLMfhuY1X/MMKMoy1nVtWrQGHFhBF4zTaceAAz6ZIzO
pto8Stab8HYFazD3Dvau
=s6vJ
-----END PGP SIGNATURE-----

--9Wosya/OiUJZ+2ov--
