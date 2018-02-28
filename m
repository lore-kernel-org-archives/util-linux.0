Return-Path: pali.rohar@gmail.com
Date: Wed, 28 Feb 2018 23:03:19 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Karel Zak <kzak@redhat.com>, Steve Kenton <skenton@ou.edu>,
	util-linux@vger.kernel.org,
	Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH 1/1] Update mount options for UDF
Message-ID: <20180228220319.ccosidfzrdlowwqu@pali>
References: <20180227184407.5945-1-skenton@ou.edu>
 <20180228130828.j3wbez6pzzzeknuc@ws.net.home>
 <20180228133220.3rmkcqnk6giry4bk@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cjbf437rn2tnu7xb"
In-Reply-To: <20180228133220.3rmkcqnk6giry4bk@quack2.suse.cz>
List-ID: <util-linux.vger.kernel.org>


--cjbf437rn2tnu7xb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wednesday 28 February 2018 14:32:20 Jan Kara wrote:
> On Wed 28-02-18 14:08:28, Karel Zak wrote:
> > On Tue, Feb 27, 2018 at 12:44:07PM -0600, Steve Kenton wrote:
> > > Signed-off-by: Steve Kenton <skenton@ou.edu>
> > > Acked-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  sys-utils/mount.8 | 89 +++++++++++++++++++++++++++++++++++++++++----=
----------
> > >  1 file changed, 67 insertions(+), 22 deletions(-)
> >=20
> > Applied, thanks.
> >=20
> > Jan, what about to create udf(5) man page? We already have fs-specific
> > man pages (e.g. ext4, tmpfs, nfs, btrfs, ...). It's usually maintained
> > within fs-specific tools (e.g. ext4 -> e2fsprogs) or together with
> > standard man-pages (CC: to Michael).
>=20
> I'm fine with that. Pali is actually the maintainer of udf-tools so if he
> is willing to take the manpage there, it's probably the best place.

Is udftools the best place for kernel udf mount options? Because
userspace udftools are not needed for kernel udf driver, nor for
mounting existing udf filesystem.

For me it looks like that kernel drivers should have its documentation
in kernel itself...

Anyway, I have not know yet that there is e.g. ext4 manpage which
describe mount options. I was always looking into mount.8 manpage for
filesystem mount parameters.

The only missing filesystem in mount.8 is nfs, but that is probably
because mount uses mount.nfs helper.

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--cjbf437rn2tnu7xb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWpcnJAAKCRCL8Mk9A+RD
UgqSAKDHVQtGA7lg0gQrNVpKJPZa7oA1swCgxgEg/7FRSYbS57cnXELk+JJwMH0=
=UlRG
-----END PGP SIGNATURE-----

--cjbf437rn2tnu7xb--
