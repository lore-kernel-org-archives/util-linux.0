Return-Path: util-linux-owner@vger.kernel.org
Received: from nm36-vm5.bullet.mail.bf1.yahoo.com ([72.30.238.141]:32546 "EHLO
	nm36-vm5.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932567AbaDBRgu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Apr 2014 13:36:50 -0400
Message-ID: <533C4911.4020406@yahoo.com.ar>
Date: Wed, 02 Apr 2014 14:29:53 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: fdisk partition reorder fails
References: <20140402164925.GA13910@aepfle.de>
In-Reply-To: <20140402164925.GA13910@aepfle.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="53TB9iSqAqK45tkfcskXLFkSvc3F2fGIv"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--53TB9iSqAqK45tkfcskXLFkSvc3F2fGIv
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 04/02/2014 01:49 PM, Olaf Hering wrote:
>=20
> This is fdisk from openSUSE 13.1. I have added partitions 15+ with
> parted. Once I'm done with repartitioning, I wanted to sort the
> partitions with fdisk like I have done it in the past. Too bad, this
> fails with the version included. The start sector is all scrambled and
> outside the disk. Lukily, this time I did not write it to disk.
>=20
> Looks like 2.24.1, included in Factory, is still broken.
>=20
>=20
> Olaf
>=20
> root@optiplex:~ # fdisk /dev/sda
> Welcome to fdisk (util-linux 2.23.2).
>=20
> Changes will remain in memory only, until you decide to write them.
> Be careful before using the write command.
>=20
>=20
> Command (m for help): p
>=20
> Disk /dev/sda: 1500.3 GB, 1500301910016 bytes, 2930277168 sectors
> Units =3D sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disk label type: dos
> Disk identifier: 0x0003bcd6
>=20
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sda1   *        2048     2097151     1047552   83  Linux
> /dev/sda2         2097152     4194303     1048576    7  HPFS/NTFS/exFAT=

> /dev/sda3         4194304    20971519     8388608   82  Linux swap / So=
laris
> /dev/sda4        20971520  2930276351  1454652416    f  W95 Ext'd (LBA)=

> /dev/sda5        20973568    73402367    26214400    7  HPFS/NTFS/exFAT=

> /dev/sda6        73404416   136318975    31457280    7  HPFS/NTFS/exFAT=

> /dev/sda7       136321024   199235583    31457280    7  HPFS/NTFS/exFAT=

> /dev/sda8       199237632   262152191    31457280    7  HPFS/NTFS/exFAT=

> /dev/sda9       262154240   325068799    31457280    7  HPFS/NTFS/exFAT=

> /dev/sda10      325070848   702558207   188743680    7  HPFS/NTFS/exFAT=

> /dev/sda11      899624960  1048561663    74468352   83  Linux
> /dev/sda12     1048576000  1258289151   104856576   83  Linux
> /dev/sda13     1258291200  1853884415   297796608   83  Linux
> /dev/sda14     1853886464  2930276351   538194944   83  Linux
> /dev/sda15      702558209   723529472    10485632   83  Linux
> /dev/sda16      723529728   744501247    10485760   83  Linux
> /dev/sda17      744501249   765471888    10485320   83  Linux
> /dev/sda18      765472768   786442239    10484736   83  Linux
> /dev/sda19      786442241   807414304    10486032   83  Linux
> /dev/sda20      807414306   828385512    10485603+  83  Linux
> /dev/sda21      828385514   849356720    10485603+  83  Linux
> /dev/sda22      849356800   870328319    10485760   83  Linux
>=20
> Partition table entries are not in disk order
>=20
> Command (m for help): x
>=20
> Expert command (m for help): p
>=20
> Disk /dev/sda: 255 heads, 63 sectors, 182401 cylinders
>=20
> Nr AF  Hd Sec  Cyl  Hd Sec  Cyl     Start      Size ID
>  1 80 117   1    1 138   8 1023       2048    2095104 83
>  2 00 138   8 1023 138   8 1023    2097152    2097152 07
>  3 00  21  17  261 254  63 1023    4194304   16777216 82
>  4 00 254  63 1023 254  63 1023   20971520 2909304832 0f
>  5 00 138   8 1023 138   8 1023       2048   52428800 07
>  6 00 138   8 1023 138   8 1023        184   62914560 07
>  7 00 138   8 1023 138   8 1023        944   62914560 07
>  8 00 138   8 1023 138   8 1023        592   62914560 07
>  9 00 138   8 1023 138   8 1023        240   62914560 07
> 10 00 138   8 1023 138   8 1023       1000  377487360 07
> 11 00 138   8 1023 138   8 1023        280  148936704 83
> 12 00 138   8 1023 138   8 1023         32  209713152 83
> 13 00 138   8 1023 138   8 1023        928  595593216 83
> 14 00 138   8 1023 138   8 1023         96 1076389888 83
> 15 00 138   8 1023 138   8 1023          1   20971264 83
> 16 00 138   8 1023 138   8 1023        255   20971520 83
> 17 00 138   8 1023 138   8 1023          1   20970640 83
> 18 00 138   8 1023 138   8 1023        879   20969472 83
> 19 00 138   8 1023 138   8 1023          1   20972064 83
> 20 00 138   8 1023 138   8 1023          1   20971207 83
> 21 00 138   8 1023 138   8 1023          1   20971207 83
> 22 00 138   8 1023 138   8 1023         79   20971520 83
>=20
> Expert command (m for help): p
>=20
> Disk /dev/sda: 255 heads, 63 sectors, 182401 cylinders
>=20
> Nr AF  Hd Sec  Cyl  Hd Sec  Cyl     Start      Size ID
>  1 80 117   1    1 138   8 1023       2048    2095104 83
>  2 00 138   8 1023 138   8 1023    2097152    2097152 07
>  3 00  21  17  261 254  63 1023    4194304   16777216 82
>  4 00 254  63 1023 254  63 1023   20971520 2909304832 0f
>  5 00 138   8 1023 138   8 1023       2048   52428800 07
>  6 00 138   8 1023 138   8 1023        184   62914560 07
>  7 00 138   8 1023 138   8 1023        944   62914560 07
>  8 00 138   8 1023 138   8 1023        592   62914560 07
>  9 00 138   8 1023 138   8 1023        240   62914560 07
> 10 00 138   8 1023 138   8 1023       1000  377487360 07
> 11 00 138   8 1023 138   8 1023  197066752  148936704 83
> 12 00 138   8 1023 138   8 1023  325046527  209713152 83
> 13 00 138   8 1023 138   8 1023  513789952  595593216 83
> 14 00 138   8 1023 138   8 1023 1088414575 1076389888 83
> 15 00 138   8 1023 138   8 1023 4211083265   20971264 83
> 16 00 138   8 1023 138   8 1023 4211082719   20971520 83
> 17 00 138   8 1023 138   8 1023 4211083032   20970640 83
> 18 00 138   8 1023 138   8 1023 4211083343   20969472 83
> 19 00 138   8 1023 138   8 1023 4181784857   20972064 83
> 20 00 138   8 1023 138   8 1023 4053805634   20971207 83
> 21 00 138   8 1023 138   8 1023 3865062538   20971207 83
> 22 00 138   8 1023 138   8 1023 3290437728   20971520 83
>=20
> Expert command (m for help): r
>=20
> Command (m for help): p
>=20
> Disk /dev/sda: 1500.3 GB, 1500301910016 bytes, 2930277168 sectors
> Units =3D sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disk label type: dos
> Disk identifier: 0x0003bcd6
>=20
>    Device Boot      Start         End      Blocks   Id  System
> /dev/sda1   *        2048     2097151     1047552   83  Linux
> /dev/sda2         2097152     4194303     1048576    7  HPFS/NTFS/exFAT=

> /dev/sda3         4194304    20971519     8388608   82  Linux swap / So=
laris
> /dev/sda4        20971520  2930276351  1454652416    f  W95 Ext'd (LBA)=

> /dev/sda5        20973568    73402367    26214400    7  HPFS/NTFS/exFAT=

> /dev/sda6        73404416   136318975    31457280    7  HPFS/NTFS/exFAT=

> /dev/sda7       136321024   199235583    31457280    7  HPFS/NTFS/exFAT=

> /dev/sda8       199237632   262152191    31457280    7  HPFS/NTFS/exFAT=

> /dev/sda9       262154240   325068799    31457280    7  HPFS/NTFS/exFAT=

> /dev/sda10      325070848   702558207   188743680    7  HPFS/NTFS/exFAT=

> /dev/sda11      899624960  1048561663    74468352   83  Linux
> /dev/sda12     1048576000  1258289151   104856576   83  Linux
> /dev/sda13     1258291200  1853884415   297796608   83  Linux
> /dev/sda14     1853886464  2930276351   538194944   83  Linux
> /dev/sda15     4997525505  5018496768    10485632   83  Linux
> /dev/sda16     5018497024  5039468543    10485760   83  Linux
> /dev/sda17     5039468545  5060439184    10485320   83  Linux
> /dev/sda18     5060440064  5081409535    10484736   83  Linux
> /dev/sda19     5081409537  5102381600    10486032   83  Linux
> /dev/sda20     5102381602  5123352808    10485603+  83  Linux
> /dev/sda21     5123352810  5144324016    10485603+  83  Linux
> /dev/sda22     5144324096  5165295615    10485760   83  Linux
>=20
>=20
>=20
>=20
> Now with newer version:
>=20
> 0:192.168.2.102:~ # fdisk /dev/sda
>=20
> Welcome to fdisk (util-linux 2.24.1).
> Changes will remain in memory only, until you decide to write them.
> Be careful before using the write command.
>=20
>=20
> Command (m for help): p
> Disk /dev/sda: 1.4 TiB, 1500301910016 bytes, 2930277168 sectors
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x0003bcd6
>=20
> Device     Boot      Start        End     Blocks  Id System
> /dev/sda1  *          2048    2097151    1047552  83 Linux
> /dev/sda2          2097152    4194303    1048576   7 HPFS/NTFS/exFAT
> /dev/sda3          4194304   20971519    8388608  82 Linux swap / Solar=
is
> /dev/sda4         20971520 2930276351 1454652416   f W95 Ext'd (LBA)
> /dev/sda5         20973568   73402367   26214400   7 HPFS/NTFS/exFAT
> /dev/sda6         73404416  136318975   31457280   7 HPFS/NTFS/exFAT
> /dev/sda7        136321024  199235583   31457280   7 HPFS/NTFS/exFAT
> /dev/sda8        199237632  262152191   31457280   7 HPFS/NTFS/exFAT
> /dev/sda9        262154240  325068799   31457280   7 HPFS/NTFS/exFAT
> /dev/sda10       325070848  702558207  188743680   7 HPFS/NTFS/exFAT
> /dev/sda11       899624960 1048561663   74468352  83 Linux
> /dev/sda12      1048576000 1258289151  104856576  83 Linux
> /dev/sda13      1258291200 1853884415  297796608  83 Linux
> /dev/sda14      1853886464 2930276351  538194944  83 Linux
> /dev/sda15       702558209  723529472   10485632  83 Linux
> /dev/sda16       723529728  744501247   10485760  83 Linux
> /dev/sda17       744501249  765471888   10485320  83 Linux
> /dev/sda18       765472768  786442239   10484736  83 Linux
> /dev/sda19       786442241  807414304   10486032  83 Linux
> /dev/sda20       807414306  828385512   10485603+ 83 Linux
> /dev/sda21       828385514  849356720   10485603+ 83 Linux
> /dev/sda22       849356800  870328319   10485760  83 Linux
>=20
> Partition table entries are not in disk order.
>=20
> Command (m for help): x
>=20
> Expert command (m for help): p
> Disk /dev/sda: 1.4 TiB, 1500301910016 bytes, 2930277168 sectors
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x0003bcd6
>=20
> Nr AF   Hd Sec   Cyl   Hd Sec   Cyl     Start       Size Id
>  1 80  117   1     1  138   8  1023      2048    2095104 83
>  2 00  138   8  1023  138   8  1023   2097152    2097152 07
>  3 00   21  17   261  254  63  1023   4194304   16777216 82
>  4 00  254  63  1023  254  63  1023  20971520 2909304832 0f
>  5 00  138   8  1023  138   8  1023      2048   52428800 07
>  6 00  138   8  1023  138   8  1023       184   62914560 07
>  7 00  138   8  1023  138   8  1023       944   62914560 07
>  8 00  138   8  1023  138   8  1023       592   62914560 07
>  9 00  138   8  1023  138   8  1023       240   62914560 07
> 10 00  138   8  1023  138   8  1023      1000  377487360 07
> 11 00  138   8  1023  138   8  1023       280  148936704 83
> 12 00  138   8  1023  138   8  1023        32  209713152 83
> 13 00  138   8  1023  138   8  1023       928  595593216 83
> 14 00  138   8  1023  138   8  1023        96 1076389888 83
> 15 00  138   8  1023  138   8  1023         1   20971264 83
> 16 00  138   8  1023  138   8  1023       255   20971520 83
> 17 00  138   8  1023  138   8  1023         1   20970640 83
> 18 00  138   8  1023  138   8  1023       879   20969472 83
> 19 00  138   8  1023  138   8  1023         1   20972064 83
> 20 00  138   8  1023  138   8  1023         1   20971207 83
> 21 00  138   8  1023  138   8  1023         1   20971207 83
> 22 00  138   8  1023  138   8  1023        79   20971520 83
>=20
> Expert command (m for help): f
>=20
> Done.
>=20
> Expert command (m for help): p
> Disk /dev/sda: 1.4 TiB, 1500301910016 bytes, 2930277168 sectors
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x0003bcd6
>=20
> Nr AF   Hd Sec   Cyl   Hd Sec   Cyl      Start       Size Id
>  1 80  117   1     1  138   8  1023       2048    2095104 83
>  2 00  138   8  1023  138   8  1023    2097152    2097152 07
>  3 00   21  17   261  254  63  1023    4194304   16777216 82
>  4 00  254  63  1023  254  63  1023   20971520 2909304832 0f
>  5 00  138   8  1023  138   8  1023       2048   52428800 07
>  6 00  138   8  1023  138   8  1023        184   62914560 07
>  7 00  138   8  1023  138   8  1023        944   62914560 07
>  8 00  138   8  1023  138   8  1023        592   62914560 07
>  9 00  138   8  1023  138   8  1023        240   62914560 07
> 10 00  138   8  1023  138   8  1023       1000  377487360 07
> 11 00  138   8  1023  138   8  1023  197066752  148936704 83
> 12 00  138   8  1023  138   8  1023  325046527  209713152 83
> 13 00  138   8  1023  138   8  1023  513789952  595593216 83
> 14 00  138   8  1023  138   8  1023 1088414575 1076389888 83
> 15 00  138   8  1023  138   8  1023 4211083265   20971264 83
> 16 00  138   8  1023  138   8  1023 4211082719   20971520 83
> 17 00  138   8  1023  138   8  1023 4211083032   20970640 83
> 18 00  138   8  1023  138   8  1023 4211083343   20969472 83
> 19 00  138   8  1023  138   8  1023 4181784857   20972064 83
> 20 00  138   8  1023  138   8  1023 4053805634   20971207 83
> 21 00  138   8  1023  138   8  1023 3865062538   20971207 83
> 22 00  138   8  1023  138   8  1023 3290437728   20971520 83
>=20
> Expert command (m for help): r
>=20
> Command (m for help): p
>=20
> Disk /dev/sda: 1.4 TiB, 1500301910016 bytes, 2930277168 sectors
> Units: sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disklabel type: dos
> Disk identifier: 0x0003bcd6
>=20
> Device     Boot      Start        End     Blocks  Id System
> /dev/sda1  *          2048    2097151    1047552  83 Linux
> /dev/sda2          2097152    4194303    1048576   7 HPFS/NTFS/exFAT
> /dev/sda3          4194304   20971519    8388608  82 Linux swap / Solar=
is
> /dev/sda4         20971520 2930276351 1454652416   f W95 Ext'd (LBA)
> /dev/sda5         20973568   73402367   26214400   7 HPFS/NTFS/exFAT
> /dev/sda6         73404416  136318975   31457280   7 HPFS/NTFS/exFAT
> /dev/sda7        136321024  199235583   31457280   7 HPFS/NTFS/exFAT
> /dev/sda8        199237632  262152191   31457280   7 HPFS/NTFS/exFAT
> /dev/sda9        262154240  325068799   31457280   7 HPFS/NTFS/exFAT
> /dev/sda10       325070848  702558207  188743680   7 HPFS/NTFS/exFAT
> /dev/sda11       899624960 1048561663   74468352  83 Linux
> /dev/sda12      1048576000 1258289151  104856576  83 Linux
> /dev/sda13      1258291200 1853884415  297796608  83 Linux
> /dev/sda14      1853886464 2930276351  538194944  83 Linux
> /dev/sda15      4997525505 5018496768   10485632  83 Linux
> /dev/sda16      5018497024 5039468543   10485760  83 Linux
> /dev/sda17      5039468545 5060439184   10485320  83 Linux
> /dev/sda18      5060440064 5081409535   10484736  83 Linux
> /dev/sda19      5081409537 5102381600   10486032  83 Linux
> /dev/sda20      5102381602 5123352808   10485603+ 83 Linux
> /dev/sda21      5123352810 5144324016   10485603+ 83 Linux
> /dev/sda22      5144324096 5165295615   10485760  83 Linux
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Looks like similar to this[#1] that I reported some time ago.

[#1] http://www.spinics.net/lists/util-linux-ng/msg08005.html

--=20
Gerardo Exequiel Pozzi
\cos^2\alpha + \sin^2\alpha =3D 1


--53TB9iSqAqK45tkfcskXLFkSvc3F2fGIv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJTPEkZAAoJEF7VFKRb1ck4B/MH/ROYINLsk+VObiFqrRh/891R
SvoY88svlBsqGoreBE0J6Bei3V1iHpCvr4Pl9solEIo8SAxajeaoMkfXILYrzJ0g
no4qZKFwCtxzBipwg36sAvWDGI4pf0YMmwpVwtnP+XX0xZrelAfNFdM8MeN+YQOP
c6D5X8ILreNkM58wE3tElXlwprme9nqIkHopOyxA0NqD/ahk68DOcfHyau55vanH
EcU1SemtNTLK4oNnuLmkMkETjO7lqg0H6gLKOY3Xb10wa24WXHF/TMIifbV1cdta
7nYLNeKcOvTp2nRQmZKicmxKT7rjyT60y17KNHWsJ4fBZjkd9wwdCuLZO8CThqc=
=oFyV
-----END PGP SIGNATURE-----

--53TB9iSqAqK45tkfcskXLFkSvc3F2fGIv--
