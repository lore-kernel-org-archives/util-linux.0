Return-Path: util-linux-owner@vger.kernel.org
Received: from nm2-vm6.bullet.mail.ne1.yahoo.com ([98.138.91.254]:30794 "EHLO
	nm2-vm6.bullet.mail.ne1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754389Ab3GAOyy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 1 Jul 2013 10:54:54 -0400
Message-ID: <51D196E2.8000605@yahoo.com.ar>
Date: Mon, 01 Jul 2013 11:49:06 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
MIME-Version: 1.0
To: util-linux <util-linux@vger.kernel.org>, Karel Zak <kzak@redhat.com>
Subject: Re: fdisk: reorder (cmd) bug with logical partitions.
References: <519BEF55.1090309@yahoo.com.ar>
In-Reply-To: <519BEF55.1090309@yahoo.com.ar>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="----enig2LLCVPJGEVTDJKDEFHROF"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
------enig2LLCVPJGEVTDJKDEFHROF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Looks like this message was ignored. Resending as remainder.


On 05/21/2013 07:04 PM, Gerardo Exequiel Pozzi wrote:
> Hello
>=20
>=20
> The reorder cmd (x->f) does not work propertly. A fdisk session example=

> for better description is attached.
>=20
> See how the last partion "coco9" that should be "coco6" after re-order,=

> keeps with the same name, but with start-sector and end-sector with
> incorrect values and outside the upper limit of the extended "coco4" an=
d
> the disk "coco" itself.
>=20
>=20
> Good luck!
>=20
>=20
> $ uname -a
> Linux exequiel 3.8.13-64 #1 SMP PREEMPT Fri May 17 18:52:27 ART 2013
> x86_64 GNU/Linux
> $ cat pepe
> # partition table of /dev/sda
> unit: sectors
>=20
> /dev/sda1 : start=3D     2048, size=3D   131072, Id=3D83, bootable
> /dev/sda2 : start=3D   133120, size=3D 41943040, Id=3D83
> /dev/sda3 : start=3D 42076160, size=3D 41943040, Id=3D83
> /dev/sda4 : start=3D 84019200, size=3D3823009968, Id=3D 5
> /dev/sda5 : start=3D 84021248, size=3D  8388608, Id=3D82
> /dev/sda6 : start=3D 92411904, size=3D  8388608, Id=3D83
> /dev/sda7 : start=3D100802560, size=3D  8388608, Id=3D83
> /dev/sda8 : start=3D109193216, size=3D  8388608, Id=3D83
> /dev/sda9 : start=3D117583872, size=3D  8388608, Id=3D83
> /dev/sda10: start=3D125974528, size=3D1258291200, Id=3D83
> /dev/sda11: start=3D1384267776, size=3D2097152000, Id=3D83
> /dev/sda12: start=3D3481421824, size=3D425607344, Id=3D83
> $ truncate --size 2000398934016 coco
> $ sfdisk coco < pepe
> <...>
> $ fdisk coco
> Welcome to fdisk (util-linux 2.23).
>=20
> Changes will remain in memory only, until you decide to write them.
> Be careful before using the write command.
>=20
>=20
> Command (m for help): p
>=20
> Disk coco: 2000.4 GB, 2000398934016 bytes, 3907029168 sectors
> Units =3D sectors of 1 * 512 =3D 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disk label type: dos
> Disk identifier: 0x00000000
>=20
> Device Boot      Start         End      Blocks   Id  System
>  coco1   *        2048      133119       65536   83  Linux
>  coco2          133120    42076159    20971520   83  Linux
>  coco3        42076160    84019199    20971520   83  Linux
>  coco4        84019200  3907029167  1911504984    5  Extended
>  coco5        84021248    92409855     4194304   82  Linux swap / Solar=
is
>  coco6        92411904   100800511     4194304   83  Linux
>  coco7       100802560   109191167     4194304   83  Linux
>  coco8       109193216   117581823     4194304   83  Linux
>  coco9       117583872   125972479     4194304   83  Linux
>  coco10      125974528  1384265727   629145600   83  Linux
>  coco11     1384267776  3481419775  1048576000   83  Linux
>  coco12     3481421824  3907029167   212803672   83  Linux
>=20
> Command (m for help): d
> Partition number (1-12, default 12): 9
> Partition 9 is deleted
>=20
> Command (m for help): d
> Partition number (1-11, default 11): 8
> Partition 8 is deleted
>=20
> Command (m for help): d
> Partition number (1-10, default 10): 7
> Partition 7 is deleted
>=20
> Command (m for help): d
> Partition number (1-9, default 9): 6
> Partition 6 is deleted
>=20
> Command (m for help): p
>=20
> <...>
>=20
> Device Boot      Start         End      Blocks   Id  System
>  coco1   *        2048      133119       65536   83  Linux
>  coco2          133120    42076159    20971520   83  Linux
>  coco3        42076160    84019199    20971520   83  Linux
>  coco4        84019200  3907029167  1911504984    5  Extended
>  coco5        84021248    92409855     4194304   82  Linux swap / Solar=
is
>  coco6       125974528  1384265727   629145600   83  Linux
>  coco7      1384267776  3481419775  1048576000   83  Linux
>  coco8      3481421824  3907029167   212803672   83  Linux
>=20
> Command (m for help): n
> All primary partitions are in use
> Adding logical partition 9
> First sector (92411904-3907029167, default 92411904):
> Using default value 92411904
> Last sector, +sectors or +size{K,M,G} (92411904-125972479, default
> 125972479):
> Using default value 125972479
> Partition 9 of type Linux and of size 16 GiB is set
>=20
> Command (m for help): p
>=20
> <...>
>=20
> Device Boot      Start         End      Blocks   Id  System
>  coco1   *        2048      133119       65536   83  Linux
>  coco2          133120    42076159    20971520   83  Linux
>  coco3        42076160    84019199    20971520   83  Linux
>  coco4        84019200  3907029167  1911504984    5  Extended
>  coco5        84021248    92409855     4194304   82  Linux swap / Solar=
is
>  coco6       125974528  1384265727   629145600   83  Linux
>  coco7      1384267776  3481419775  1048576000   83  Linux
>  coco8      3481421824  3907029167   212803672   83  Linux
>  coco9        92411904   125972479    16780288   83  Linux
>=20
> Partition table entries are not in disk order
>=20
> Command (m for help): x
>=20
> Expert command (m for help): f
> Done.
>=20
> Expert command (m for help): r
>=20
> Command (m for help): p
>=20
> <...>
>=20
> Device Boot      Start         End      Blocks   Id  System
>  coco1   *        2048      133119       65536   83  Linux
>  coco2          133120    42076159    20971520   83  Linux
>  coco3        42076160    84019199    20971520   83  Linux
>  coco4        84019200  3907029167  1911504984    5  Extended
>  coco5        84021248    92409855     4194304   82  Linux swap / Solar=
is
>  coco6       125974528  1384265727   629145600   83  Linux
>  coco7      1384267776  3481419775  1048576000   83  Linux
>  coco8      3481421824  3907029167   212803672   83  Linux
>  coco9      4387379200  4420939775    16780288   83  Linux
>=20
> Command (m for help): v
> Logical partition 9 not entirely in partition 4
> Remaining 12282 unallocated 512-byte sectors
>=20
>=20
>=20
>=20


--=20
Gerardo Exequiel Pozzi
\cos^2\alpha + \sin^2\alpha =3D 1


------enig2LLCVPJGEVTDJKDEFHROF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBAgAGBQJR0ZbsAAoJEF7VFKRb1ck43oUH+wZhzKOjETB/N/OwEp1bediC
HrIFAp61hkvxb4eJtajzsL/+5O37gEMw0uoYEelNUHa6MThBAqSp++WoJHIsiytO
REcDVlAh7ryNR1wHpCw34jG83ybHLkbcv6kVT1d7V5KhzBcJD03q+ZtBl35f0EK4
Se66xh783S6c/4y3C105QtHSEFldX2IVDsoOsSmlbJb1YLkc1cA8hSh7suaTmLi+
TFwNXIvZSdf/dtM2SLIGSbZxilfLJoH+x5QWDcGYSyx/X2TqnhoeZ7qagHo19n0Q
U2/CY73ldXK/eo3JjJPkviIq0ZjdGI8o3dFGrXNMmRE2VZnOYuqHzoCkAoYD4Yg=
=MECB
-----END PGP SIGNATURE-----

------enig2LLCVPJGEVTDJKDEFHROF--
