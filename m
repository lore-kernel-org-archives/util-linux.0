Return-Path: vapier@gentoo.org
Date: Fri, 19 Jan 2018 13:24:42 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, linux-man@vger.kernel.org
Subject: Re: moving filesystem mount options from util-linux to man-pages
Message-ID: <20180119182442.GL28967@vapier>
References: <20180119023637.GI7217@vapier>
 <20180119101245.5umnbe6koa22hneh@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="aNvCJ41Feu8IgPyB"
In-Reply-To: <20180119101245.5umnbe6koa22hneh@ws.net.home>
List-ID: <util-linux.vger.kernel.org>


--aNvCJ41Feu8IgPyB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19 Jan 2018 11:12, Karel Zak wrote:
> On Thu, Jan 18, 2018 at 09:36:37PM -0500, Mike Frysinger wrote:
> > the mount(8) man page covers not only the mount command, but also the
> > various file system options that come from the kernel.  it seems like
> > the communities have settled on the man-pages project for holding all
> > the userland-facing documentation, it has good practices for tracking
> > features across versions, and updating it is a lot easier/safer (than
> > util-linux) and up-to-date on the web (via man7.org).  while looking
> > up some proc/ramfs options, i noticed util-linux was out of date by
> > over 6 years :/.
>=20
> Please, send patch if you see any obsolete stuff in mount.8.
> Unfortunately kernel guys (usually) don't care...
>=20
> > imo, it seems like we should move all kernel-specific documentation
> > out of the util-linux project and into man-pages.  obviously all the
> > mount command line options and such should remain.
>=20
> I've talked about it (including LKML) many times in last ten years.
>=20
> > specifically i'm looking at "FILESYSTEM-SPECIFIC MOUNT OPTIONS":
> > http://man7.org/linux/man-pages/man8/mount.8.html#FILESYSTEM-SPECIFIC_M=
OUNT_OPTIONS
> >=20
> > we probably want to leave "FILESYSTEM-INDEPENDENT MOUNT OPTIONS"
> > in util-linux since those are all parsed by util-linux's mount
> > and turned into the MS_xxx bits.
> >=20
> > thoughts ?  mount(2) doesn't seem like the best place, but these
> > are the fields that go in the "data" string to that syscall.
>=20
> Fortunately, this "move project" is already on the way. The target is=20
> man section 5 and FS specific packages. We already successfully moved=20
>=20
>  man nfs=20
>  man xfs
>  man ext4 (ext2, ...)

if you're OK with that direction, then that makes sense to me

> All depends on FS maintainers. I'm going to support arbitrary activity=20
> in this area, but this does not depend on util-linux project.

man-pages is a community project, so i don't think that's entirely
accurate.  but i'll just send more deletion updates for util-linux.
-mike

--aNvCJ41Feu8IgPyB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEuQK1JxMl+JKsJRrUQWM7n+g39YEFAlpiN+oACgkQQWM7n+g3
9YGhTBAAjGMLfWwsiv3JLeZdQ5ZsAGM45L1KSrOmxs1ML/fsNytlVATT9HBgccIG
HiAUlfn/hrEYtHHplK031S1M1MoullmzMpFcUndVw0OGbjAncUoMpWaV3tXOTdGv
PlQgBpeIUfN5h0tOBU1IemUV1y/Nd00sPZz729pYC6u+UQyiRegPMGbfBI68xkZ6
EkYlXHdgCnPUfIJkzigE7sZ/FLbyU5NEMOyKfF8BYsn0/QmvdduaPbW8NhqLrUbm
ub6XGmFFXwFAkbSdKd7rLW6ap+otFyO9K9oKmzfsPlF9jHiHprwLumK+p9Qyj7s6
Fu1BOky5mQGh1oWr8BZ0nPVk7uQ78wcCyuNXpLaxICrjUz9WI7Me8AYS+XzRHoI3
VzVvsUHL6Kbk0KAZzx4Jgr2a5wAXUormEIawf/WmfIPit2JJ/tgkKYeT4yqh+svz
TX8b+VYePKsmzCOB8UVhQ0ud9B4UpHtnWjSCJCnDICt+S2u0Rj2LUxzZhuQfkoOe
fFbfxtGI66PuD6Q+rdIJOwJJQq8LvvKnAnNeAQV/gPITQcu6O5jRSr+gyUapUlZF
unrVcQiOxJrzzA4DQ2lwc/B7CuFZAfaQY97Yhq9TiBBlvPsjNd9uyP54SHxU4Z4a
llia7kBDwx5QDVeU3ysEI0Q/c1CSgIZsMZMlIOJD9pZVFtG/bB4=
=4x6B
-----END PGP SIGNATURE-----

--aNvCJ41Feu8IgPyB--
