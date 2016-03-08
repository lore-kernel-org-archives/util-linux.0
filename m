Return-Path: vapier@gentoo.org
Date: Tue, 8 Mar 2016 09:28:31 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Ruediger Meier <ruediger.meier@ga-group.nl>
Subject: Re: [PATCH] include sysmacros.h where used
Message-ID: <20160308142831.GM6588@vapier.lan>
References: <1457389593-15124-1-git-send-email-vapier@gentoo.org>
 <20160308133449.valpkagmel6jaegy@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lf0NQ8GVTdtriwpn"
In-Reply-To: <20160308133449.valpkagmel6jaegy@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--lf0NQ8GVTdtriwpn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 08 Mar 2016 14:34, Karel Zak wrote:
> On Mon, Mar 07, 2016 at 05:26:33PM -0500, Mike Frysinger wrote:
> > BSD/Linux systems stick major/minor/makedev in sysmacros.h.  Newer Linux
> > libraries have been moving away from including sysmacros.h implicitly v=
ia
> > sys/types.h, so include it directly.
>=20
> Applied and then reverted ;-) It seems in conflict with Rudi's
> changes. We need #ifdef HAVE_SYS_SYSMACROS_H for the file.
>=20
> I have moved it to c.h, it seems better to keep it on one place. (I
> hope it does not have any side effects to have it everywhere.)

hopefully not, but i'd watch out for shadowing.  like lib/linux_version.c
which has variables named "major" and "minor".
-mike

--lf0NQ8GVTdtriwpn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW3uGOAAoJEEFjO5/oN/WBzZsP/Ry8I3a5j2AbjKHeOHcn95vp
5VHRXyqU71b4AgK892oDJpDfw5050mF6CkfIkw+JzTKwEHYrhZIdnCkjc8sB5g5B
QDT9vz1tpHCb1x0D8Fp37AEntqir2XryqAEFPbuOg/xf3uFzmpji+8VmVB160MKL
iG4zzCsUNaPH3G3Z5rZwyZhcU5YFcanlztHBU4UdmldLzwf8tc2TCWuJU/pzoILz
znveV5lHjR6RgwLwDQPeLAf6W4lkEEBBnGH8J8pD23eImQRhSgvYTeevyZmFBrdc
o1NHaBhyoWE8sB57MJO9O4uvEErUXAbCrqAYduEH3aRxz3INzu89ZoIdgdWT/VKN
sJxsV+1uDiOdKWuh7YyzQVPxxf9/M9RwYq0UTcgcLWBcpZHxeiWS0ct57mMZwZ3I
XDGvfBz65cEVdnV8SBvXyyFDMiCj1XJPlI3JJ8Zsyq1hbJsR3JmP8/qRyT/OoiS6
QNBJKKs4/zHS85sbIwaAUzLqkIjk/LB9WzkOdPHYCMdIXUdekQMb4hlIj6h+FHhL
v4ReGy5y/ZTJSnhhLTtV9usUsbMamMqiWuFMNyyhKXWBtnuhkkOj71ckV7lKWiDZ
ak4gQ0umoegy22CxgZ89QE4AaLe+jpiT9PeGinkCKigtu4n6ZWkLcgA/qkEW61qz
3lAakffAhdDbqU9+K5jR
=zXJL
-----END PGP SIGNATURE-----

--lf0NQ8GVTdtriwpn--
