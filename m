Return-Path: util-linux-owner@vger.kernel.org
Received: from nm30-vm0.bullet.mail.bf1.yahoo.com ([98.139.213.126]:48422 "EHLO
	nm30-vm0.bullet.mail.bf1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751724Ab3EUWKt (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 21 May 2013 18:10:49 -0400
Message-ID: <519BEF55.1090309@yahoo.com.ar>
Date: Tue, 21 May 2013 19:04:05 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>, Davidlohr Bueso <dave@gnu.org>
Subject: fdisk: reorder (cmd) bug with logical partitions.
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2NIMHFMRGXEIFQTGITRXV"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2NIMHFMRGXEIFQTGITRXV
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello


The reorder cmd (x->f) does not work propertly. A fdisk session example
for better description is attached.

See how the last partion "coco9" that should be "coco6" after re-order,
keeps with the same name, but with start-sector and end-sector with
incorrect values and outside the upper limit of the extended "coco4" and
the disk "coco" itself.


Good luck!


$ uname -a
Linux exequiel 3.8.13-64 #1 SMP PREEMPT Fri May 17 18:52:27 ART 2013
x86_64 GNU/Linux
$ cat pepe
# partition table of /dev/sda
unit: sectors

/dev/sda1 : start=3D     2048, size=3D   131072, Id=3D83, bootable
/dev/sda2 : start=3D   133120, size=3D 41943040, Id=3D83
/dev/sda3 : start=3D 42076160, size=3D 41943040, Id=3D83
/dev/sda4 : start=3D 84019200, size=3D3823009968, Id=3D 5
/dev/sda5 : start=3D 84021248, size=3D  8388608, Id=3D82
/dev/sda6 : start=3D 92411904, size=3D  8388608, Id=3D83
/dev/sda7 : start=3D100802560, size=3D  8388608, Id=3D83
/dev/sda8 : start=3D109193216, size=3D  8388608, Id=3D83
/dev/sda9 : start=3D117583872, size=3D  8388608, Id=3D83
/dev/sda10: start=3D125974528, size=3D1258291200, Id=3D83
/dev/sda11: start=3D1384267776, size=3D2097152000, Id=3D83
/dev/sda12: start=3D3481421824, size=3D425607344, Id=3D83
$ truncate --size 2000398934016 coco
$ sfdisk coco < pepe
<...>
$ fdisk coco
Welcome to fdisk (util-linux 2.23).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p

Disk coco: 2000.4 GB, 2000398934016 bytes, 3907029168 sectors
Units =3D sectors of 1 * 512 =3D 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk label type: dos
Disk identifier: 0x00000000

Device Boot      Start         End      Blocks   Id  System
 coco1   *        2048      133119       65536   83  Linux
 coco2          133120    42076159    20971520   83  Linux
 coco3        42076160    84019199    20971520   83  Linux
 coco4        84019200  3907029167  1911504984    5  Extended
 coco5        84021248    92409855     4194304   82  Linux swap / Solaris=

 coco6        92411904   100800511     4194304   83  Linux
 coco7       100802560   109191167     4194304   83  Linux
 coco8       109193216   117581823     4194304   83  Linux
 coco9       117583872   125972479     4194304   83  Linux
 coco10      125974528  1384265727   629145600   83  Linux
 coco11     1384267776  3481419775  1048576000   83  Linux
 coco12     3481421824  3907029167   212803672   83  Linux

Command (m for help): d
Partition number (1-12, default 12): 9
Partition 9 is deleted

Command (m for help): d
Partition number (1-11, default 11): 8
Partition 8 is deleted

Command (m for help): d
Partition number (1-10, default 10): 7
Partition 7 is deleted

Command (m for help): d
Partition number (1-9, default 9): 6
Partition 6 is deleted

Command (m for help): p

<...>

Device Boot      Start         End      Blocks   Id  System
 coco1   *        2048      133119       65536   83  Linux
 coco2          133120    42076159    20971520   83  Linux
 coco3        42076160    84019199    20971520   83  Linux
 coco4        84019200  3907029167  1911504984    5  Extended
 coco5        84021248    92409855     4194304   82  Linux swap / Solaris=

 coco6       125974528  1384265727   629145600   83  Linux
 coco7      1384267776  3481419775  1048576000   83  Linux
 coco8      3481421824  3907029167   212803672   83  Linux

Command (m for help): n
All primary partitions are in use
Adding logical partition 9
First sector (92411904-3907029167, default 92411904):
Using default value 92411904
Last sector, +sectors or +size{K,M,G} (92411904-125972479, default
125972479):
Using default value 125972479
Partition 9 of type Linux and of size 16 GiB is set

Command (m for help): p

<...>

Device Boot      Start         End      Blocks   Id  System
 coco1   *        2048      133119       65536   83  Linux
 coco2          133120    42076159    20971520   83  Linux
 coco3        42076160    84019199    20971520   83  Linux
 coco4        84019200  3907029167  1911504984    5  Extended
 coco5        84021248    92409855     4194304   82  Linux swap / Solaris=

 coco6       125974528  1384265727   629145600   83  Linux
 coco7      1384267776  3481419775  1048576000   83  Linux
 coco8      3481421824  3907029167   212803672   83  Linux
 coco9        92411904   125972479    16780288   83  Linux

Partition table entries are not in disk order

Command (m for help): x

Expert command (m for help): f
Done.

Expert command (m for help): r

Command (m for help): p

<...>

Device Boot      Start         End      Blocks   Id  System
 coco1   *        2048      133119       65536   83  Linux
 coco2          133120    42076159    20971520   83  Linux
 coco3        42076160    84019199    20971520   83  Linux
 coco4        84019200  3907029167  1911504984    5  Extended
 coco5        84021248    92409855     4194304   82  Linux swap / Solaris=

 coco6       125974528  1384265727   629145600   83  Linux
 coco7      1384267776  3481419775  1048576000   83  Linux
 coco8      3481421824  3907029167   212803672   83  Linux
 coco9      4387379200  4420939775    16780288   83  Linux

Command (m for help): v
Logical partition 9 not entirely in partition 4
Remaining 12282 unallocated 512-byte sectors




--=20
Gerardo Exequiel Pozzi
\cos^2\alpha + \sin^2\alpha =3D 1


------enig2NIMHFMRGXEIFQTGITRXV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJRm+9VAAoJEF7VFKRb1ck46f8H/1RtYwqAFyKU8YYqa//OK1OT
XoNu6yhe5Mob5xY/SPjfTZU5Fw4dU7Vuk1vjTeH18rtRXhLhsnIY2TC9GZi7tFy0
dUDqpLcdl2uuhwM7xfutGHUZ+yN1Pv3AsxgK4g+1W0tdQlTd6Rp5m4A3ksuuJ3D7
r+pvHCdgsWp8QJwGQb/0asw23CusU6En8GfxxgMTgiHSvljtKAxqddctMp7daon7
ZQTmF4EpIRZgNgLTqLfSoyOea5H86C7tY6UpgS53tCmEIpjpKgNuGy6VBUEhaHSw
ZiOWmybnyt6fgAIReUf4lIHsYyt24f1TxlKrsSZ7efLlfiQ7qBtkA2JBQi8Q+/E=
=Hau3
-----END PGP SIGNATURE-----

------enig2NIMHFMRGXEIFQTGITRXV--
