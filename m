Return-Path: util-linux-owner@vger.kernel.org
Received: from fr1.as29.net ([88.190.23.70]:49333 "EHLO toothrot.meleeweb.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754009Ab2BPUW6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 16 Feb 2012 15:22:58 -0500
Received: from scabb.meleeweb.net ([82.66.45.165] helo=otis.scabb)
	by toothrot.meleeweb.net with esmtps
	 (TLSv1:AES256-SHA:256 [])
	id 1Ry7kY-0006N1-U4
	for util-linux@vger.kernel.org; Thu, 16 Feb 2012 21:16:18 +0100
Received: from lemonhead.scabb ([192.168.34.11])
	by otis.scabb (envelope-from <beber@meleeweb.net>)
	with esmtp id 1Ry7kY-0007te-Bk
	for util-linux@vger.kernel.org; Thu, 16 Feb 2012 21:16:18 +0100
Date: Thu, 16 Feb 2012 21:16:18 +0100
From: Bertrand Jacquin <beber@meleeweb.net>
To: util-linux@vger.kernel.org
Subject: sfdisk 2.20.1 --no-reread do BLKRRPART
Message-ID: <20120216201617.GD7482@lemonhead.scabb>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="llIrKcgUOe3dCx0c"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--llIrKcgUOe3dCx0c
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

When creating partitions on a destination that is not a block device,
sfdisk do a BLKRRPART ioctl even when --no-reread option is used, but
looking at documentation --no-reread only apply to the beginning
process.

Would it be fine to extend that to the complete process ?

Bertrand

  dd if=3D/dev/zero of=3D/tmp/disk.img bs=3D1024 count=3D4032
  strace -fF -s 1024 -e trace=3Dioctl \
    sfdisk --no-reread -C2 -H32 -S63 -q -f \
      /tmp/disk.img << EOF
unit: sectors

part1 : start=3D 63, size=3D 3969, Id=3D83
part2 : start=3D 4032, size=3D 98784, Id=3D83
part3 : start=3D 102816, size=3D 22176, Id=3D83
part4 : start=3D 124992, size=3D 0, Id=3D83
EOF

ioctl(0, SNDCTL_TMR_TIMEBASE or SNDRV_TIMER_IOCTL_NEXT_DEVICE or TCGETS, 0x=
7fff7b917ce0) =3D -1 ENOTTY (Inappropriate ioctl for device)
Warning: /tmp/disk.img is not a block device
ioctl(3, HDIO_GETGEO, 0x7fff7b917c10)   =3D -1 ENOTTY (Inappropriate ioctl =
for device)
Disk /tmp/disk.img: cannot get geometry
ioctl(3, BLKGETSIZE64, 0x7fff7b917be0)  =3D -1 ENOTTY (Inappropriate ioctl =
for device)
ioctl(3, BLKGETSIZE, 0x7fff7b917b18)    =3D -1 ENOTTY (Inappropriate ioctl =
for device)
ioctl(3, FDGETPRM, 0x7fff7b917af0)      =3D -1 ENOTTY (Inappropriate ioctl =
for device)

Disk /tmp/disk.img: 2 cylinders, 32 heads, 63 sectors/track

sfdisk: ERROR: sector 0 does not have an msdos signature
 /tmp/disk.img: unrecognized partition table type
Old situation:
No partitions found
New situation:
Units =3D sectors of 512 bytes, counting from 0

   Device Boot    Start       End   #sectors  Id  System
/tmp/disk.img1            63      4031       3969  83  Linux
/tmp/disk.img2          4032    102815      98784  83  Linux
/tmp/disk.img3        102816    124991      22176  83  Linux
/tmp/disk.img4        124992    124991          0  83  Linux
Successfully wrote the new partition table

Re-reading the partition table ...
ioctl(3, BLKRRPART, 0)                  =3D -1 ENOTTY (Inappropriate ioctl =
for device)
BLKRRPART: Inappropriate ioctl for device

--=20
Beber

--llIrKcgUOe3dCx0c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iEYEARECAAYFAk89ZBEACgkQibjJUzm7jPRafQCePvkxfxg4fRFHUj2p4Qd8SIVw
a1oAn1wRpTioBQ/PlW76rCHr+cw+EWka
=eZwo
-----END PGP SIGNATURE-----

--llIrKcgUOe3dCx0c--
