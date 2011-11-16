Return-Path: vapier@gentoo.org
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Subject: Re: flock in 2.20.1 can no longer lock the file it will execute
Date: Wed, 16 Nov 2011 10:25:46 -0500
Cc: util-linux@vger.kernel.org, Michal Kubecek <mkubecek@suse.cz>,
        Petr Uzel <petr.uzel@suse.cz>
References: <201111140123.39789.vapier@gentoo.org> <20111116131321.GN7916@nb.net.home>
In-Reply-To: <20111116131321.GN7916@nb.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3538490.9dlZimUAUM";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201111161025.47605.vapier@gentoo.org>
List-ID: <util-linux.vger.kernel.org>

--nextPart3538490.9dlZimUAUM
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 16 November 2011 08:13:21 Karel Zak wrote:
> On Mon, Nov 14, 2011 at 01:23:38AM -0500, Mike Frysinger wrote:
> > i've been using a trick with flock to add locking to all of my shell
> > scripts.
> >=20
> > basically, i take a lock on the shell script itself:
> > 	flock -eon ./test.sh ./test.sh
> >=20
> > with <=3Dutil-linux-2.20, this has worked fine.  but starting with 2.20=
=2E1,
> > i now
> >=20
> > get -ETXTBSY (on ext4, but i doubt that matters):
> > 	$ echo '#!/bin/sh' > test.sh
> > 	$ chmod a+rx test.sh
> > 	$ ./flock -eon ./test.sh ./test.sh
> > 	./flock: ./test.sh: Text file busy
> >=20
> > the only commit made to flock.c between 2.20 and 2.20.1 is this:
> > 	commit 75aaee08f06b92d119ed827c53d1af5474eb16ff
> > 	flock: make flock(1) work on NFSv4
> >=20
> > and indeed, reverting that made my life happy again.  reading the small
> > patch shows the obvious flaw: you can't open a file for O_RDWR and
> > attempt to execute it at the same time.
>=20
>  Hmm... maybe we can add a new --read-write command line option for
>  NFS guys rather than be smart with access(). The regression is
>  unacceptable.

i wonder what happens if you attempt to take a read-only lock on nfs.  do y=
ou=20
get back an error ?  or does it fail silently at runtime in the nfs layers ?

if the former, one solution might be to open the file, attempt to grab the=
=20
lock, and if the flock() fails, retry the whole thing but with O_RDWR inste=
ad.

int rw_flags =3D O_RDONLY;
=2E..
retry:
	... current open logic which uses new rw_flags var ...

	... if flock fails, and rw_flags =3D=3D O_RDONLY, then set rw_flags to O_R=
DWR=20
and jump back to retry ...
=2Dmike

--nextPart3538490.9dlZimUAUM
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOw9X7AAoJEEFjO5/oN/WBXGcQAJVnz0/B31J+GdqBhxfPYA5x
4FdHs45IhYMywTptU+oMpUGk1c1otRIBoakWOu/Cr52LwOaZNhyASUd2SJP+WbHY
K6Rlfkgy6cIJ7mZYkGFEHRoixYTaWdo7uJltvUMyrpHJDs8oxNEq8bpGLhSTzM7F
QuI5FUsEsVHKwChPwZnLjt5KY+ejc5NwWlfV4DSoXHzgATp5s6lWkz0UO8TIhuHJ
2daPHyFdmMz/TWKyv4LjUFVTKXTd88nkR0yoETir51LcZAhVboxj057T8t0puipk
utcoQ41m1F+Td2qVvyenUDtWj5+E/+8UcRjVdVVlG4P7B495TUsBe6NyqX8qN0D0
M4N8u0dSlrr9rgoniYXeIsu0AgVnDClMynw0d+fY/2ZYz1xNjp36kN7c5wZQ+Mo6
v6RBn72joQ2Zqb7hMorraymOD/OXqvIRnYWzQi4P7z6S9EHHNMe2dSL9bKEe2Kle
5oPks/TWoO1CA8kVQAS/vuQGNd75q05M+TEfsPDkdqSrIA3q/KwVmGJNVEMg5ghZ
pJVvUgTQgfroY59c4AghIHJSxxV2w1ZCwvpgOsZrddJU58YrxanAanxQ2A7L+Oka
8ZALW8vCCa7gA0XthHI08u01nexhw/aToyhamYoXFjE71gF0pkgfjjsHCoQ6S1hD
ySWhEaDlHtoMZzXJUvtv
=NYDf
-----END PGP SIGNATURE-----

--nextPart3538490.9dlZimUAUM--
