Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:34093 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751613Ab1HHAfb (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 7 Aug 2011 20:35:31 -0400
From: Mike Frysinger <vapier@gentoo.org>
To: Bruce Dubbs <bruce.dubbs@gmail.com>
Subject: Re: umount -a
Date: Sun, 7 Aug 2011 20:35:16 -0400
Cc: util-linux@vger.kernel.org
References: <4E387230.5060002@gmail.com>
In-Reply-To: <4E387230.5060002@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2062139.ijTKKpavY2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201108072035.16673.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2062139.ijTKKpavY2
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Tuesday, August 02, 2011 17:54:56 Bruce Dubbs wrote:
> At linuxfromscratch, we've just made some changes to write bootscript
> messages to /run/var.  This seems to work fine for us until shutdown where
>=20
>    umaount -a
>=20
> unmounts /run which is mounted as a tmpfs.  We can certainly work around
> the problem, but was wondering if this issue may also affect others.

you could make the same argument for /dev, but i dont think that gets handl=
ed=20
specially either.  plus, there's the whole "will only work with recent util-
linux versions".  so it makes sense imo to have distro init code to deal wi=
th=20
this regardless of anything else.
=2Dmike

--nextPart2062139.ijTKKpavY2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOPy9EAAoJEEFjO5/oN/WBZ04P/30So4eN6t/PS7THmPBq0Wns
4pzXjhnpFHeW53E6IGRAI+C5YHUO1xiURNKWc03YLFHcp8/ZiIfAN6HAySOMXqcv
2d9SGH4k2UrVzx3BnfNN9T7GmC9dITebLp4Ze5K+N18V0+4FX/Ha1Reavot/CTLW
7m346927N/9yiUhKwGQUS/3THmiGmBqmWtuDERL5nuKfwuY42nvAnH/mL8VT7ReW
mZf9s4nljYrG5lOqTyGZ3jhzHSPMDOvzIrhOHGhPsUBHIuPeThEYa9CfeMBoFxQk
C3aCUjCv1TYKy1FrobGX9/UY16+M9e+xZ66AU1yRJComjKb3q/TUwpdW6XbGaOTk
WepqbKDqBwRk5UQ6PNU1O3H0Oj3Upnw4Dc4CO0Oeg2lPuCa1U4wq3c9z3BgoSaTO
viVypQLICex7L9r6Aixm5wpiM9et8jRwm0bKFol+EvCK+6EszSjFKavOCA2zBNeN
nbQnZaydRgl7DRjHoyGasZIjDbjopsOgXTEuV6qGUl7BlzD/rdoVhLg6B5i4XaQQ
KLhHtMZJ/RZFEDqExUfeU7vwqPCTqMmwQfoVEtBX5UGIVCwuSO63ow8fmDu2cm4j
V8XH/VEikLldHMd0j8IRMnkzx8wTlwPSr+gN4bupN/C9OQvFdasW4m5zyqA9MaXT
sH3ZeQQBbw02Apac7seL
=gpz8
-----END PGP SIGNATURE-----

--nextPart2062139.ijTKKpavY2--
