Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:43740 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933218AbeAYEY1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 24 Jan 2018 23:24:27 -0500
Date: Wed, 24 Jan 2018 23:24:26 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] mount(8): drop redundant filesystem-specific sections
Message-ID: <20180125042426.GE1718@vapier>
References: <20180119184520.13067-1-vapier@gentoo.org>
 <20180122090923.io62zeuwnv25iw7p@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="HeFlAV5LIbMFYYuh"
In-Reply-To: <20180122090923.io62zeuwnv25iw7p@ws.net.home>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--HeFlAV5LIbMFYYuh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22 Jan 2018 10:09, Karel Zak wrote:
> On Fri, Jan 19, 2018 at 01:45:20PM -0500, Mike Frysinger wrote:
> > Add a new section to the top of the filesystem-specific chapter to point
> > people generally to the filesystem-specific man pages.  This way we can
> > delete all the redundant subsections that say the same thing.
>=20
> Well, the subsections also provides the name of the package where is FS
> specific man page :-)
>=20
> > -.SS "Mount options for xfs"
> > -See the options section of the
> > -.BR xfs (5)
> > -man page (the xfsprogs package must be installed).
>=20
> It's probably not so important (and I have no strong opinion about
> it), but I can imagine that for end-users it's useful. Maybe we can
> add to the man page a small table with FS name, man page and package
> name:
>=20
>       xfs   xfs(5)          xfsprogs
>       ext4  ext4(5)         e2fsprogs
>       cifs  mount.cifs(8)   cifs-utils
>       ...
>=20
> or is it overkill?

the only reason i hesitated to try and do that was due to cross-distro
package naming idiosyncrasies.  but i guess if we refer to the upstream
project using the name they choose, the rest can be an exercise for the
user ?
-mike

--HeFlAV5LIbMFYYuh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlppW/oACgkQQWM7n+g3
9YGeYRAAnS0rdlhoqwP+xjcWmds+pL6g7Dl42+RK23jDYDJ/OSdCugqQkipMDmMM
OpSkIp2HUCOAnYSSkWv/y00CK5YclLS2QCb57sFG7at/6cHqa0bT0NZIiN7IML3f
gw+Nkg8EqYosdH+VfoMvikOuYHlUhfDC5qdpO+G5EepX2xJo/C87BsGIA2pPmiS7
sSbB2NaTT+EPYqxq4GLV4wihhPCCT9MHXGkSW12T0Gi0gMM6XPE6FdLMxiLwAzZQ
GF3zPy7iM3nkVdUsuQ5BYsXEgu96KoK4RGiLaXVwr+16ls9e7UnRNsfSVlWiG7Ll
Bv2aOM9rM9qQzECZyB4OTE53TrEm8Zz54NHu2B7nP43fvUVkUEgTi7hSK+a7EiHs
4Jk+6sTlrtQwwZmCJvcqntTx4obctmJoZD21UUYJ2TPFbBVqR1C5NJCGf71KYPqD
MEsAh00hS4xqRunCJQIEDPGJ25lcrmAVPP5WUm9bNtQ9OgMLqthO61WS2Xm0z6wm
ha1JMf8aZp+w7mSLt/4tSFZ659KtjfgN2joQsnSyqCS2rUDUc7Ela7DbmWG/wYku
5bioMKv9eok1WUpD9obhZLEHrwqdh4E05UX9cQ3t7kgR9AXgz/pl0ifJgJkthVIk
1gLGf7W7MAHaNM6r9nRReMUY/t/zRkYbXtsXRLBwHqkA7k8Udyk=
=SWcA
-----END PGP SIGNATURE-----

--HeFlAV5LIbMFYYuh--
