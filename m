Return-Path: pali.rohar@gmail.com
Date: Thu, 19 Apr 2018 17:25:42 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali.rohar@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Jan Kara <jack@suse.cz>, Steve Kenton <skenton@ou.edu>,
	util-linux@vger.kernel.org,
	Michael Kerrisk <mtk.manpages@gmail.com>
Subject: Re: [PATCH 1/1] Update mount options for UDF
Message-ID: <20180419152542.neoemd7i2wsjutdj@pali>
References: <20180227184407.5945-1-skenton@ou.edu>
 <20180228130828.j3wbez6pzzzeknuc@ws.net.home>
 <20180228133220.3rmkcqnk6giry4bk@quack2.suse.cz>
 <20180228220319.ccosidfzrdlowwqu@pali>
 <20180301110851.tc7erpwy3duhvzxw@ws.net.home>
 <20180301172408.wsggwvmb33oogmex@pali>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hwsgbjq2oksilfbo"
In-Reply-To: <20180301172408.wsggwvmb33oogmex@pali>
List-ID: <util-linux.vger.kernel.org>


--hwsgbjq2oksilfbo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thursday 01 March 2018 18:24:08 Pali Roh=C3=A1r wrote:
> On Thursday 01 March 2018 12:08:51 Karel Zak wrote:
> > On Wed, Feb 28, 2018 at 11:03:19PM +0100, Pali Roh=C3=A1r wrote:
> > > On Wednesday 28 February 2018 14:32:20 Jan Kara wrote:
> > > > On Wed 28-02-18 14:08:28, Karel Zak wrote:
> > > > > On Tue, Feb 27, 2018 at 12:44:07PM -0600, Steve Kenton wrote:
> > > > > > Signed-off-by: Steve Kenton <skenton@ou.edu>
> > > > > > Acked-by: Jan Kara <jack@suse.cz>
> > > > > > ---
> > > > > >  sys-utils/mount.8 | 89 +++++++++++++++++++++++++++++++++++++++=
++--------------
> > > > > >  1 file changed, 67 insertions(+), 22 deletions(-)
> > > > >=20
> > > > > Applied, thanks.
> > > > >=20
> > > > > Jan, what about to create udf(5) man page? We already have fs-spe=
cific
> > > > > man pages (e.g. ext4, tmpfs, nfs, btrfs, ...). It's usually maint=
ained
> > > > > within fs-specific tools (e.g. ext4 -> e2fsprogs) or together with
> > > > > standard man-pages (CC: to Michael).
> > > >=20
> > > > I'm fine with that. Pali is actually the maintainer of udf-tools so=
 if he
> > > > is willing to take the manpage there, it's probably the best place.
> > >=20
> > > Is udftools the best place for kernel udf mount options? Because
> > > userspace udftools are not needed for kernel udf driver, nor for
> > > mounting existing udf filesystem.
> >=20
> > This is reason why Michael is in CC: :-)
>=20
> Ok :-)
>=20
> > > For me it looks like that kernel drivers should have its documentation
> > > in kernel itself...
> > >=20
> > > Anyway, I have not know yet that there is e.g. ext4 manpage which
> > > describe mount options. I was always looking into mount.8 manpage for
> > > filesystem mount parameters.
> >=20
> > There is no extN stuff anymore in mount.8.
>=20
> Ah, ok. I have Debian stable on servers which has older mount.8 with
> ext* options.
>=20
> > > The only missing filesystem in mount.8 is nfs, but that is probably
> > > because mount uses mount.nfs helper.
> >=20
> > Unfortunately, it's nothing unusual that mount.8 is ignored by FS
> > devels and not up to date... so the idea is keep FS docs near to=20
> > the FS developers to improve things ;-)=20
> >=20
> > For example NFS developers have decided to maintain it in nfs-utils,
> > extN in e2fsprogs, tmpfs and procfs in Michaels' man-pages, etc.
> >=20
> > Anyway, I have no problem to maintain UDF (or another) mount options=20
> > in mount.8. It's your choice. Your patches for mount.8 are welcomed.
>=20
> So wait for Michael answer...

So do you have any answer?

In the meanwhile I created a small update, check if it is OK:
https://github.com/karelzak/util-linux/pull/622

--=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--hwsgbjq2oksilfbo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQS4VrIQdKium2krgIWL8Mk9A+RDUgUCWti09AAKCRCL8Mk9A+RD
UnMYAJ9Y973/Ko7IYS55zVdF744If+X9lgCfXxTa9cnFJtDYk8FygB2JHiU00JE=
=YJuQ
-----END PGP SIGNATURE-----

--hwsgbjq2oksilfbo--
