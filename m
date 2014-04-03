Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:55556 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162553AbaDCIOa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 3 Apr 2014 04:14:30 -0400
Message-ID: <533D1725.2060204@archlinux.org>
Date: Thu, 03 Apr 2014 10:09:09 +0200
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Dave Reisner <dreisner@archlinux.org>, util-linux@vger.kernel.org,
        thomas@archlinux.org
Subject: Re: [PATCH] switch_root: verify initramfs by f_type, not devno
References: <1396449690-4215-1-git-send-email-dreisner@archlinux.org> <20140403013808.GD585@rampage>
In-Reply-To: <20140403013808.GD585@rampage>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SHsUNEcJD2kf2RTVOpFvtSgx7c7Jk8Cqk"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SHsUNEcJD2kf2RTVOpFvtSgx7c7Jk8Cqk
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 03.04.2014 03:38, schrieb Dave Reisner:
> On Wed, Apr 02, 2014 at 10:41:30AM -0400, Dave Reisner wrote:
>> As of linux 3.14, the initramfs device will have both major and
>> minor 0, causing our paranoia check to fail. Make this version agnosti=
c
>> by checking the filesystem type, rather than a device number.
>>
>> Signed-off-by: Dave Reisner <dreisner@archlinux.org>
>> ---
>> This is essentially what busybox's switch_root does. I don't think the=
re's much
>> value in checking the devno at all, as it seems to be a needless restr=
iction.
>> Let's just allow deleting anything that looks like non-persistent stor=
age.
>=20
> A bisect of the kernel reveals that 9e30cc9595303 is the responsible
> change. It seems the kernel maintains its own mounts which are never
> exposed to userspace (which also would explain the FSID gaps in
> /proc/self/mountinfo). An instance of sysfs used to be one of these
> kernel only mounts but, for some time now, has not needed to be. The
> mentioned commit removes this kern_mount() call for sysfs, making the
> initramfs the first entry in the mount table -- FSID 0 instead of 1.
>=20
> I guess FSIDs are about as reliable as the numbering on block devices,
> and this comparison in switch_root was never really the right
> approach...

Thanks for getting to the bottom of this Dave. I guess going the way of
busybox (checking for RAMFS or TMPFS) is the right thing to do, as your
patch suggests.



--SHsUNEcJD2kf2RTVOpFvtSgx7c7Jk8Cqk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJTPRcoAAoJEChPw0yOSxol9QYP/3cpT4SwiUse04ys+UPS92SW
DTo/OcxpSWI3dp8hVGx67YUqN9xnMDOVvcgebSlHbCrEllLxieBITFEbAR1Lwmqu
vHbGdZnfY2EUT8Kx0YA///gxVnDK15fsZ09teWEqHTG5OXQHt9MN5xY5SNOugPF4
wTpwk9s8S+aPWb5JNkgXVKDM9ekoLNW6q9OQz1yGwXUoO2Sd/WKRLnO9WFaVLbPj
29hR0m9e3eD9k0rZV4qKP3Jz1fkz7uICT6noQL7Hvpu3fDs7EXmP948yaVx7Ub5j
2zIsY/DJn+xfQimKdyzC653bPn5CfbCUy9s4vsJ1s0Khji0MrSJ9bq46Pujz3K5E
YwHt1TRl6EOXUC+uxxC5zaPPWpYcMVc2o21dBWSNeha7CBQDrog2HWsghzd0ZVhV
mPng6pFOWCxnIYa0s39Ml6VPUYF5WW1snwiDfy5a5qng8EiwlGZRhbWItHnAwbEx
EdRo9N66HdiWLWIADKTXUq9tizE38MOgjdln+jtlBZBXD9FlrQRYV/r+sypZEu2k
Qf6p9NRZIefuevgxAN5+e/8+I/6pR5K6L2kvPX15zOK521dBa7nuK4oRExcX0+Bw
cfMr7QV23llWdo32F5VJIzBL8KfK1Xi0E1WBF23ZMeTm9bLcKhsTY/OFQzQ81f9G
bsRISMAHPPZya6QBrdRe
=QTzo
-----END PGP SIGNATURE-----

--SHsUNEcJD2kf2RTVOpFvtSgx7c7Jk8Cqk--
