Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:40110 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754968Ab1GLC7y (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 11 Jul 2011 22:59:54 -0400
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id A89392AC1CB
	for <util-linux@vger.kernel.org>; Tue, 12 Jul 2011 02:59:53 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: `fsck -A` and fs-specific options
Date: Mon, 11 Jul 2011 22:59:54 -0400
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4175573.CkS2O5A6dc";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201107112259.55340.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart4175573.CkS2O5A6dc
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

ive got some "interesting" bugs here when using the `fsck -A` helper. =20
consider file systems that have unique mount options that sometimes the fsc=
k=20
program also needs to know about.  for mounting, this isnt a problem as the=
=20
options are stored in /etc/fstab and `mount` will extract the options field=
=20
and pass it along.  but what about fsck ?

for example, some journaling file systems allow the journal to be stored=20
separately.  reiserfs has the "jdev=3D" mount option and the "--journal" fs=
ck=20
option.  ext[34] have the "journal_dev=3D" mount option and the "-j" fsck=20
option.

another example is with loop mounts that take an offset.  fsck cannot opera=
te=20
on the loop source as the start of the file is not the image.  it needs to=
=20
first setup the loop with the offset, and then do the fsck on the loop poin=
t.
	/tmp/foo.img /mnt/tmp ext3 loop,offset=3D10000

i could code up some crap in the Gentoo init scripts to take care of this, =
but=20
if we handled it in util-linux, everyone would get this for free.  seems li=
ke=20
we need to add a per-filesystem-type lists that track the mount option (so =
we=20
can extract it from /etc/fstab) and how to translate it into the related fs=
ck=20
option.
=2Dmike

--nextPart4175573.CkS2O5A6dc
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOG7irAAoJEEFjO5/oN/WB4ewP/2PrU2+bPx3tj/HQ9N9V64Rl
2+emeeMhqxyNFZ38nKshaNiAkCCB5cXrZI2550hJiXgS3m9+nNVPPyQCdQzkShAb
5rI/mOd3e3EBHEcDxdEQzdek6eY2eTebxv5fBvCaZLQeVaGJth7zxchqZViOIXQM
VVL5ZHHClcgUZ01Luw0baBBjO/l0h6fq1VCIQC0/Z4uACfp+VX4e7NxFgQJRP0yR
9AnTJ9WhWNYvVMEphZDmQTustCFBl+wyJTmmgLE+z7Vk6f+43MPsP/RY1Dw+MUv7
Sepis2dfgi7sELyUDF0ni4Y7vHmytnaRTX6XYWfR7nQdpyIH3cfGOgnl5asajjXW
kJIu8WTQKzQTWr1W/YavCnig1Qd4YFhPtaxRMPrUPPEbsvtNR4grwHM8kepcCWpr
f6YrXi8wJoEl3Mfi3rgmQZxoR9HsS/DPB/55qRtugSD/N1bhv0GLkJ9naNazSVkt
iO3bH97OVRI1ZcH5SW9a8vqYk5fPHiXlDYvR7A3RJFdICQcFAo2YPZPwbstC9N9i
314uuF3qt2fR98urrdd3DZP1bksEngMHZRZ16HTuVO5R/xvDBHPXtf8jA2X0OVAE
ONKfFx5lmSbKUnuVo13MiPtG/I279BPR9M8mYUzP/utMVH4bZfvPlcVnwE+m9NGn
Ow4fluEsbPMgfksZe/r9
=RWCo
-----END PGP SIGNATURE-----

--nextPart4175573.CkS2O5A6dc--
