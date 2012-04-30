Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:33573 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755439Ab2D3UGx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 30 Apr 2012 16:06:53 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Phillip Susi <psusi@ubuntu.com>
Subject: Re: losetup -d --force for zombie loop devices?
Date: Mon, 30 Apr 2012 16:07:21 -0400
Cc: Thomas Orgis <thomas-forum@orgis.org>, util-linux@vger.kernel.org
References: <20120417100346.2a0b8301@orgis.org> <4F9EF01B.9040003@ubuntu.com>
In-Reply-To: <4F9EF01B.9040003@ubuntu.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2662136.ux9Ql8Htd0";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201204301607.22712.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2662136.ux9Ql8Htd0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Monday 30 April 2012 16:03:39 Phillip Susi wrote:
> On 4/17/2012 4:03 AM, Thomas Orgis wrote:
> > I am having an issue with a loop device that used to be connected to a
> > file on NFS. Not sure if this is actually a kernel bug, but I assume
> > (perhaps ignorantly so) that losetup could resolve the situation
> > anyways.
> >=20
> > 0. have NFS share on /mnt/nfs  (rw,users,noexec,nosuid,nodev,hard,intr)
> > 1. losetup --show -f /mnt/nfs/file.img
> >=20
> >     /dev/loop0
> >=20
> > # actually, it was using cryptsetup luksOpen/Close
> > 2. mount /dev/loop0&&  do_work&&  umount /dev/loop0
> > 3. loose connection to NFS server (it went offline, client machine
> > (laptop) switched networks ...) 4. umount -l /mnt/nfs
>=20
> This is the problem with umount -l: all it does is remove the path from
> the namespace, leaving the device still mounted.  Unfortunately umount
> -f is not properly supported.  The proper fix for this is to have the
> kernel support umount -f, and do away with the brain damaged umount -l.

`umount -l` has its place -- there are cases where you want those semantics=
=2E =20
granted, most people actually want a `umount -f`, but the two aren't mutual=
ly=20
exclusive.
=2Dmike

--nextPart2662136.ux9Ql8Htd0
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJPnvD6AAoJEEFjO5/oN/WBUmcP/0CNB5kn89UWX9S1aS53BwxS
n6PuV8OkdWOiUx8kWI5sIDefGKsryYwTF8iYfNRigov0qqSVfe9SUvfACXdj8ZBW
5DdFrpiUiVnjjHkS+NOrkxCdD2VHYkMGUEw9fYlhTtzLimGpA1Idr9rwicwETBqT
jQDvF2acRtOp6ygm+eD3KJG9WqYcoY7exaBgkbJfn4M5Tc5dePLcIq8z+g8sPty5
JP+r5yxf7A47PmndlQB1157v6wIHvrIP++99P3FFi456PxH4GnSzCd0W9stfialF
zOny/nAp5helv9qt8AgRCQgZSwV3cyf2ZNvDgpI/j1rMKXANlJKEuxN32pGcFIsC
LMUiXmfTGxzv6U4eeFnzyyJgvyw4DsFnoj7tRjeSrA1UVfez55z+hMylvUT5xduB
XNCP846VNyX/37doZYe8x5TaZavsQ+B9U22QlX92NThmbP5HlYOxaB3VVVZ0DYgk
EMPWUkBWOOrm/4cy6ZufZHGxCCZKqQ09nWICBYLlAdWmdY5dhmxOAiQ1vmEy5ZQO
HssAcI/L9wzVr5QjZm6YHhHr0qadrz9rdPz6chpDJhxEot4hpsJ9ErZ+iCgKBY0T
0D8Y9MiF25larfy36C1YSyFvP0S+cceyXmkcjr7GXlZGqDVqIKMiqb7pJO3TrHxV
oyZ6GzC3IbPHVk5om3lt
=aeEv
-----END PGP SIGNATURE-----

--nextPart2662136.ux9Ql8Htd0--
