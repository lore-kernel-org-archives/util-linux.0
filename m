Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:58336 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbaHLXtr (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 12 Aug 2014 19:49:47 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Stanislav Brabec <sbrabec@suse.cz>
Cc: util-linux@vger.kernel.org
Subject: Re: util-linux and distro bootstrap, dependencies and build cycles
Date: Tue, 12 Aug 2014 19:49:51 -0400
Message-ID: <3379360.AxIdjXfpXR@vapier>
In-Reply-To: <1407874531.5984.79.camel@oct.suse.cz>
References: <1407768431.5984.23.camel@oct.suse.cz> <1549603.ZWLTNRFnAF@vapier> <1407874531.5984.79.camel@oct.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart5861103.KMAcMix7RU"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart5861103.KMAcMix7RU
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

On Tue 12 Aug 2014 22:15:31 Stanislav Brabec wrote:
> Mike Frysinger wrote:
> > On Mon 11 Aug 2014 16:47:11 Stanislav Brabec wrote:
> > > Solution 1:
> > >=20
> > > Modify make system by adding:
> > > --enable-build-stage-1: Distro bootstrap stage 1: Build only code=

> > >     without systemd and python dependencies.
> > > --enable-build-stage-2: Distro bootstrap stage 2: Build code with=

> > >     systemd dependencies (even if they are optional). Use install=
ed
> > >     instances of libmount, libblkid, libsmartcols and libuuidd, d=
o not
> > >     build them in-tree.
> > > --enable-build-stage-3: Distro bootstrap stage 3: Build python-li=
bmount
> > >     only. Use installed instance of libmount, do not build them i=
n-tree.
> >=20
> > how is this any different from just passing --without-{udev,python}=
 ?
>=20
> --without-systemd still builds the same set of binaries, just without=

> support of systemd. It does not allow to exclude lslogins, logger and=

> uuidd and build them later.
>=20
> --with-python builds complete util-linux and libraries plus python
> bindings, not bindings only.

i'm not seeing the problem.  disable both, and you've broken the circul=
ar=20
deps.  every day Gentoo is doing bootstraps of the distro and this isn'=
t an=20
issue for us.
=2Dmike
--nextPart5861103.KMAcMix7RU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABAgAGBQJT6qgfAAoJEEFjO5/oN/WBxHkQALUo20CPGx/rwNBwCzQauykG
UT2C+Y8Ajj8TNovln5DrG1hE7U0Ew+Bl/y9jxwRD+38BCmueyCgfVdTR7Q847fZG
ZTkd4KimvrCg51tP5B0+7fyUp/MgbnOSsSZfA1PwUKDUZSV49U1XM4+49guoXcJ3
Ne4DjY3Kva+iqtmj16n3VEd9O+EpkMeOUJEJGobGrwilZni3Pv+AM1IS/KyIXTl/
xveOeb4bO70b0Vxz5V+NVc0U26Ey/3HCiwFAFP24sIcg+w+2F/WqFrq4Eg+RpuU5
k99CgcUoJQGGvGhr3D2PjyWzIiuTTB3HOEPPS4GUIeNH/3UWh2hZ0ZGIcRVSse73
ZyKRF40QKdV+CN5JMU3KKd6jnoY8oTyXfkHC3+/vEz5lY8Fc7SYfVyjsfID45utu
dWhw3jkkfLdjqsn2y24x6I47ALojZaTrDSp45hzMDe02YPAeFVugv6omdokP4PjB
BnV5j0cA1KyN+zEevPqmZ3VJEXxS1u52MMF/FUc5Y0AUct9irVieRTwiN0Stabqb
2wiQOc9BdOlc5pKOoIwP6y/VGR0HcSAvF8jAr3BwX+/P5TwoLqScLpbfT7wim66a
rwZIiee4GnOWPe5sIrs201DQWi5ReVcFjp9T1G84GWkdzzi8ZxBDJtCWGJvbEz/R
EXJsgr+SJeJmGJeW/UHI
=W9Zy
-----END PGP SIGNATURE-----

--nextPart5861103.KMAcMix7RU--

