Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:44753 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935Ab1KWS6J (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 23 Nov 2011 13:58:09 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Paul Stone <Paul@stone.org>
Subject: Re: how can I compile mount and umount as shared object files?
Date: Wed, 23 Nov 2011 13:58:15 -0500
Cc: util-linux@vger.kernel.org
References: <CA+zVqtWW+CknuW7NKyd2AZVsrDwj=J7gg+U2UYEBgbp++vaZgA@mail.gmail.com>
In-Reply-To: <CA+zVqtWW+CknuW7NKyd2AZVsrDwj=J7gg+U2UYEBgbp++vaZgA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3315867.aGkcpKDoyB";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201111231358.16493.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart3315867.aGkcpKDoyB
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday 22 November 2011 19:02:26 Paul Stone wrote:
> [root@xxxx .libs]# file *
> mount:  setuid ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
> dynamically linked (uses shared libs), for GNU/Linux 2.6.18, stripped
> umount: setuid ELF 64-bit LSB executable, x86-64, version 1 (SYSV),
> dynamically linked (uses shared libs), for GNU/Linux 2.6.18, stripped
>=20
> [root@xxxx .libs]# file /bin/mount /bin/umount
> /bin/mount:  setuid ELF 64-bit LSB shared object, x86-64, version 1
> (GNU/Linux), dynamically linked (uses shared libs), for GNU/Linux
> 2.6.18, stripped
> /bin/umount: setuid ELF 64-bit LSB shared object, x86-64, version 1
> (GNU/Linux), dynamically linked (uses shared libs), for GNU/Linux
> 2.6.18, stripped

looks like your objects in /bin/ are PIEs.  it's not required for these to =
be=20
PIEs, so you can install the locally compiled ones if you want and they sho=
uld=20
work fine.
=2Dmike

--nextPart3315867.aGkcpKDoyB
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOzUJIAAoJEEFjO5/oN/WBnTsQAIVWsqTu5MvpGIWrkY9SGIYp
hA5KWEaTE3pfEeTOnbANm0VVoXzQIHJowzFMQeEiPQGAhWo5X9ARVNL3oDVAxSyS
KTiuLJNGehz9nBWnAZhiPK17RAAzqyQW4hwFcatyakQdqeQn/4XRZjsRo2vQMkVs
/BUqVGwRSGT1kH2DC2bEeVTiKL/SVgFTC7LVPH1w4E4wwVr0FhxzCGa/ayb0BVrV
gctnna4oMSqHGlU8V5nOs5R2fvHuUMpGt+OzPDz0opnj84gl3I2wBzwUvOsO3q2I
6fZjGwHgdMXSnzl91uzEVKaPhDAJGLbai5pLQxGwltrhdqV/TNQJx4YSnaIlpdzt
gDK92D5nuYRtH3/C9Gi8HY/D1Qx5NXttHWqvJb500YwXSf5LCA2Kfd5UPQfYViK+
3JyvnBwV3rAZsuMPgu6pmMWLI4v4v5f3QRybCvkNj5zZcPrmG9qKOLiWCtcizr8e
Q2CekPTdnPkOi4ORqDz6cTTVrplGxe1/unCGE+tVaWHvSE6htIu/EIl3wYP6QiAK
wH62v5gjDrPciaYF06A/z/qn4lsxDUkyVDmZCF5oaHpZUBCMhn74RhHSYMJXz78n
0IYXHnlEwrzI/snsPz6aTWoHzPtI/JaZBZI/N70w/m6MlbNaQ3+W5g6IBz0qBvNm
PoPVgrESI6fj1k4bUJNK
=AacP
-----END PGP SIGNATURE-----

--nextPart3315867.aGkcpKDoyB--
