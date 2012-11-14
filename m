Return-Path: util-linux-owner@vger.kernel.org
Received: from vint.altlinux.org ([194.107.17.35]:53523 "EHLO
	vint.altlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945923Ab2KNXKd (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 14 Nov 2012 18:10:33 -0500
Received: from wo.int.altlinux.org (wo.int.altlinux.org [192.168.1.4])
	by vint.altlinux.org (Postfix) with ESMTP id AE4B7226C099
	for <util-linux@vger.kernel.org>; Wed, 14 Nov 2012 23:10:31 +0000 (UTC)
Date: Thu, 15 Nov 2012 03:10:31 +0400
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: util-linux@vger.kernel.org
Subject: Re: new mount regression
Message-ID: <20121114231031.GB20303@altlinux.org>
References: <50A3F95E.6030407@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="xXmbgvnjoT4axfJE"
In-Reply-To: <50A3F95E.6030407@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--xXmbgvnjoT4axfJE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Nov 15, 2012 at 12:04:46AM +0400, Alexey Gladkov wrote:
> Greetings!
>=20
> I found that mount no longer understands fstype list in the /etc/fstab
> after the migration to libmount:
>=20
> $ dd if=3D/dev/zero of=3D/tmp/disk bs=3D1M count=3D10
> $ losetup /dev/loop0 /tmp/disk
> $ mkfs.ext3 /dev/loop0
> $ grep loop0 /etc/fstab
> /dev/loop0 /media vfat,hfsplus,ext4,ext3,ext2 defaults 0 0
>=20
> $ mount /media
> mount: unknown filesystem type 'vfat,hfsplus,ext4,ext3,ext2'
>=20
> But if we use deprecated mount:
>=20
> $ ./mount.deprecated -v /media
> /dev/loop0 on /media type ext4 (rw)
>=20
> Also new mount understands fstype list in options:
>=20
> $ mount -t vfat,hfsplus,ext4,ext3,ext2 /dev/loop0 /media

Already reported with a patch in
http://marc.info/?l=3Dutil-linux-ng&m=3D134876452206541
The patch was labelled a hack and rejected in
http://marc.info/?l=3Dutil-linux-ng&m=3D134910609108013
but no better alternative is available so far.

Please apply that patch in Sisyphus until upstream has a better fix
for this regression.


--=20
ldv

--xXmbgvnjoT4axfJE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlCkJOcACgkQfKvmrJ41Nh5UqgCgmL9Hg1IlK8K0+/C7qwq5anRX
hxYAn2yclXctqu+27Nj4j/I+SNlBwAbQ
=bMLO
-----END PGP SIGNATURE-----

--xXmbgvnjoT4axfJE--
