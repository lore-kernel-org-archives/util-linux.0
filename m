Return-Path: vapier@gentoo.org
Date: Wed, 20 Jan 2016 15:00:28 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: Re: mount nofail: what failures should we allow ?
Message-ID: <20160120200028.GE14840@vapier.lan>
References: <20160119232458.GO14840@vapier.lan>
 <20160120102845.olo242uqrfzld6rh@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="O2gaCPMlz9o7j9TI"
In-Reply-To: <20160120102845.olo242uqrfzld6rh@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--O2gaCPMlz9o7j9TI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20 Jan 2016 11:28, Karel Zak wrote:
> On Tue, Jan 19, 2016 at 06:24:58PM -0500, Mike Frysinger wrote:
> > i've received two requests for the "nofail" option.  the doc for the
> > option is a bit ... terse ... so it's hard to guess at the overall
> > intention.
>=20
> man mount:
>    nofail Do not report errors for this device if it does not exist.
>=20
> from my point of view this description is pretty explicit :-)

does it mean the device node doesn't exist (ENOENT) ?  or does it also
accept the node being there, but returning other errors like ENXIO (the
driver isn't loaded) or ENOTDIR (bad path) or ENOTBLK (used a bad path
like /dev/zero) or ENOMEDIUM (the node & hardware exists, but is not
loaded) ?  there's probably other errno values you could catch here.

surely you agree that "does not exist" does not cover all these cases.
or at the very least, it's pretty ambiguous/fuzzy.

> > (2) ignore unknown fs types.  e.g. when a kernel config/module is missi=
ng
> > support for the requested filesystem type.  so a fstab entry like:
> > 	..src..  /mnt/foo  somefs defaults,nofail
> > rather than error out with:
> > 	mount: unknown filesystem type 'somefs'
> > it would just issue a warning like it does for other nofail options.
>=20
> I'm not sure with this. It's unusual situation when any filesystem is unk=
nown
> for libblkid, but it's pretty common that kernel returns EINVAL. This
> happen when a kernel config/module is missing, but also if you specify
> wrong mount options and in some another situations. I don't think we
> want to hide such problems. It's too generic...

i think there's a lot going on in this response.  let me distill it a
bit.  if i have a reiserfs that is usable, but i forgot to enable or
load the reiserfs kernel driver, should nofail be allowed to skip ?
or is this a hard failure ?
-mike

--O2gaCPMlz9o7j9TI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWn+dcAAoJEEFjO5/oN/WBfhQQAMukzSR4yEHFouHOTn5sNtFd
1prM+UF5PhiE2x+OB9hMQqMFtenIikCDdfo++i/46sJtnafeD7TXPmT68VF8diNg
THxJ0hCn0BGlvOYCRviZLcG9QY9HUEP2/SqEqFBjAhZqSlDsenHUGQQQoVj5zThg
0MrWmSg01gsdfK1pOTJohqIBmkn/3I7hINDaC6Oue6G36KrujJ3hIZ997jTai1AV
3EAVwRx78h4x5XB0YlJPJNcPi4buJB6NqhcXKUoD4SzQUlKBTCTsi3/cetG5vp1l
Gx5JLF0mHAh2bVlX0w86p1mGtZH1OPJRZUOgrLZjLsR2fysg6312Ov1TPRIjGQW5
NmzshS7IEuZ3DJpXhLkFlLJKGwl8SD8DlnNY1NW4vsHsJJQ35P0QEZRdcWodLXxv
9e0p+TnuRIgevQ9ZT20RJlE9MrQCavk0qYAUksKSyc9oGBMluduCmah+1slbVo5N
QNQ2Grtif4onKvhEph7CVa/ogB/rcfVSoGgDb45SxxZRKR6HAwZnS7aAPxRdmTcy
QXjxohaBk14gGr55cDYYw4hhHWyRaVRHLBqypTSpmt5OzksoO0wq18bMZvKevz5N
9aZexcBFXX2Vyz3P7aHpNEY2Fj2lb+U88LB95c+GlWhygYyYF8AGsNjbCkTZzB5v
IoSFHI1ORrDEbWV8eqBW
=Yx9h
-----END PGP SIGNATURE-----

--O2gaCPMlz9o7j9TI--
