Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:35993 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750945Ab3AYTzP (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Fri, 25 Jan 2013 14:55:15 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Karel Zak <kzak@redhat.com>
Subject: Re: fsck files w/relative paths
Date: Fri, 25 Jan 2013 14:55:09 -0500
Cc: util-linux-ng@vger.kernel.org
References: <201301201827.23141.vapier@gentoo.org> <201301251202.02511.vapier@gentoo.org> <20130125173623.GD1954@x2.net.home>
In-Reply-To: <20130125173623.GD1954@x2.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart8409701.8qmdgA2Ia5";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201301251455.10008.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart8409701.8qmdgA2Ia5
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Friday 25 January 2013 12:36:23 Karel Zak wrote:
> On Fri, Jan 25, 2013 at 12:02:01PM -0500, Mike Frysinger wrote:
> > On Friday 25 January 2013 10:17:36 Karel Zak wrote:
> > > On Sun, Jan 20, 2013 at 06:27:22PM -0500, Mike Frysinger wrote:
> > > > we could tweak parse_argv() so that it checks for argv[0] =3D=3D '.=
' in
> > > > addition to argv[0] =3D=3D '/'.  but that wouldn't fix other relati=
ve
> > > > paths like: $ fsck images/foo
> > > > $ fsck foo
> > >=20
> > > Hmm... maybe add a hint to the fsck man page is the best solution :-)
> > >=20
> > > > should we treat all non-options as devices ?  would that break
> > > > anything ?
> > >=20
> > > I don't think it's a good idea.
> > >=20
> > > All unknown stuff is by default interpreted as filesystem specific
> > > options (options for fsck.<type>) and it's pretty common that people
> > > don't use "--" separator between fsck and fsck.<type> options.
> >=20
> > well, i didn't mean non-fsck options, but non-options.  i.e. things that
> > don't
>=20
> I understand..
>=20
> > start with dashes.  are there fscks which use non-options as something
> > other than "file/device to check" ?
>=20
>  fsck.ext4 -L bad_block_file  /dev/sda1
>=20
> or whatever... and note that we have no clue about all possible fsck
> implementations (not all is public and open source..)

i would highlight the man page says people are supposed to use -- to separa=
te=20
fsck-specific options from fsck-specific ones.

as to your example here though, that shows that things are also broken.  if=
=20
you give an absolute path to the bad_block_file, then the auto-silencing of=
 the=20
root partition is run.

compare:
	fsck -L bad_block_file
	fsck -L $PWD/bad_block_file

the first will auto-append the root device while the latter will not for no=
=20
apparent reason to the user
=2Dmike

--nextPart8409701.8qmdgA2Ia5
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJRAuMdAAoJEEFjO5/oN/WBD3QP/0gLTlIt6Y3ZUx1Fv5MFloi/
Uk+PRYXguSyTBKedct+q1JiD00rjR2mRjoJnYRCXn730RRFS8Zwuo3xFI3olag+q
Lixo62DKYYqVW97HA+Uxh2Dq5fwwDfvTImtfXunPUdbNApV9O5lytXzqUPRlDS6e
NHMq2p6FsaFh54KWbtcusbClfNYYn1wq7SEyDqiarlp5kkMDiYhRUoGO37f444e5
l2221P0rOJ7oJf59hF02DCu+3gompRTWrC7hCbR0etbwCckFzC66yJlFtnUae9mb
p0UTkLPznZdBdClR7jN0a7lGBf20h1kNdvmYDU2ypIX9EKEo9rdo3PBYkw33kc5a
I5JU8b1LeIWShohH05/Znmj9vmyIyZhZTY89kAIuBt7ERhZ1AAKLNEpJPmKNWB2H
facII84RXtjmJBv7JrXQ6rd/qQDUoKGeG6368x6Xw6S+K8uDZ/oFmXjK0M4HldPA
7fgeoDEUFrUW4VEYRmEZOloiFDro5jvtNbW7Ta071prVfsKXYKE8OTUZpvt+3gMF
K47hmnSXCYVgmTjLEEXzqdtLLleL3a4S2+6Opy2JttlNPlU1uss2omWqxOIT+BO9
hZ6jCAkiiw35Cw8AiS8rFO8qYmM7THUdxjhwXsViC5t5fDDxZqqnO+LSCxOxlLVb
LbhTT/XhedJLWoSyXOCd
=LW06
-----END PGP SIGNATURE-----

--nextPart8409701.8qmdgA2Ia5--
