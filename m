Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:51049 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752039Ab3ATXX2 (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Sun, 20 Jan 2013 18:23:28 -0500
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 2A66433DAB7
	for <util-linux-ng@vger.kernel.org>; Sun, 20 Jan 2013 23:23:28 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: fsck files w/relative paths
Date: Sun, 20 Jan 2013 18:27:22 -0500
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart5039930.N7qHBfr1Q2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201301201827.23141.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart5039930.N7qHBfr1Q2
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

if i create a dummy local fs in a file:
$ dd if=3D/dev/zero of=3Dfoo count=3D1 seek=3D1000
$ mke2fs -F foo

now trying to run fsck on it:
$ fsck ./foo
fsck from util-linux 2.22.2
Usage: fsck.ext4 [-panyrcdfvtDFV] [-b superblock] [-B blocksize]
                [-I inode_buffer_blocks] [-P process_inode_size]
                [-l|-L bad_blocks_file] [-C fd] [-j external_journal]
                [-E extended-options] device

that's weird ...

running it through strace shows it behaves as if no args were provided=20
(num_devices=3D0), so it looks up my rootfs details, and then runs fsck:
[pid 28095] execve("/sbin/fsck.ext4", ["fsck.ext4", "./foo", "/dev/sdd2"], =
[/*=20
69 vars */]) =3D 0

reading the code, it expects files to have absolute paths.  so running:
$ fsck $PWD/foo
works just fine

we could tweak parse_argv() so that it checks for argv[0] =3D=3D '.' in add=
ition=20
to argv[0] =3D=3D '/'.  but that wouldn't fix other relative paths like:
$ fsck images/foo
$ fsck foo

should we treat all non-options as devices ?  would that break anything ?
=2Dmike

--nextPart5039930.N7qHBfr1Q2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJQ/H1bAAoJEEFjO5/oN/WB44YP/2lBaaoKscb2QZ6GABWy+5bs
JbhCq8PogRTosBWBv54Bp7mY9XogNsN0r4E8O1nqdQ7tLHPdBrGR3GN4Wy4V2tls
NwScGul19mEwmgCn7UpT3tLprifAi7g+tSYHtPY0sd0JPIDn6IhO14TNz6XyPEgK
H5/eNzDdMuJtispFn6ddFujFkYrz+ZF2Ojb/S0VjS7EwgjDXTA9CuUk0H5DEvbvO
pEvtyA4J8Hjekml8UwRN/zm7+xYpxexy6VXZTJWcAG4a37e11KKRj76l0Q59T61n
7LA68okS9vIA4GyH8sEKS0KVKryTf/RcNrKgq3Aows3Nqwa6suB+eUOrGhBWvre2
HrpcRmRqi+/qipJgNeM6dLvjpX5XdS9cakZDkZ6sNWJq6d/8Wvzd5TBGM5ClgYRn
q6w+r1KtUXFq4x+IwgRffmw+x46ISf9Ym+GFi2vxGM6Bdl8KeI6e+hwDhr1dkAlR
En/u5640l+6lJodV5tbF9W9L3xnkSP6nEBEKVZawXuoPqe/OuFsoctm0RwJ0LFBb
XwfoMTNOwUhC57ixG37pzYjtS2V8RyKoEYtdM2HQGtyHBOv3IjsHC8ASvpfs/gDN
eE86KvgEYvCYtdXF2gIED6sHConNfXzTl1/lnbBT22vuizReV7Fr/KC0ncLA8R2Q
6ZVplIDoVodWvlq9nPBy
=PLaM
-----END PGP SIGNATURE-----

--nextPart5039930.N7qHBfr1Q2--
