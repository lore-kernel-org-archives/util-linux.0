Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:59387 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750941Ab3KUUBI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 21 Nov 2013 15:01:08 -0500
From: Mike Frysinger <vapier@gentoo.org>
To: Phillip Susi <psusi@ubuntu.com>
Subject: Re: Generating release from git
Date: Thu, 21 Nov 2013 15:01:10 -0500
Cc: util-linux@vger.kernel.org
References: <527C3112.40904@ubuntu.com>
In-Reply-To: <527C3112.40904@ubuntu.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2356515.7vxIe1tYdU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201311211501.11278.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart2356515.7vxIe1tYdU
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Thursday 07 November 2013 19:32:18 Phillip Susi wrote:
> How do you generate the release tarball from the git repo?  I thought
> it would be to run make dist, but it seems the real release tarball is
> bootstrapped with autogen.sh, but NOT configured, and make dist
> generates a tarball that is already configured.

pretty sure that is incorrect.  `make dist` produces a tarball that has=20
autotools generated so people can run `./configure`, but the tarball doesn'=
t=20
contain things produced by `./configure` itself.
=2Dmike

--nextPart2356515.7vxIe1tYdU
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJSjmaHAAoJEEFjO5/oN/WByxoP/1kunTul/QuC3I0xmoUEV++B
IQmPArxI33Ioo1H4fbLvbvgNOQK3A9gAKlEatQ+d1sGD8F6WQiqD0zPRveaSrXh9
nT5pG+2Q3upkOzpU/eH/JIMuXxxdQ5kp3hdIv0RLorg7BmmvkDEfmOaxTWNP5nrA
1+5q3+0slbyyA3StlcWLqwU74/LN5fstdrYwqAabr1Tygp2qifnYNiY8eYecZImU
3IEHQva3217fL48QuouRdzPkz6OAV7BXB06aIv8lt4/lGtB4BCxaL6L9F9ZJ1kMb
aHawNX1FiPF2y7mkCK9RWD9/89fjVn40D0eJLuJjwcPHm5Ls/f+joByegXn9nqrl
wD43l0yLvme/y6jakBQbwVa1LkuOZej6w7w8A2deLHalHj+tMsw4bdeV8mhoZ5y7
8/V2hX8vROOUgWuPChU9kJuZwUVw9V/wyeilCIv2qKIPxXae8uM6/MFPVouyz7rN
dlykQ6k09LF69GyBXN8HWFqp7kj5H8oNGPPkT0VNQx3Sz7qXUBPvfn5eDt6xYu4n
2wZRLT0bsL0r2B7FvZB6W4cHpg81D9K68eAKNOHJBQ2IEHEgwHWY0VTQi10SGKCS
tXG3WOydfuDAfVR5hvapmhygwJb7nLQd8hDj81WKAQQzYUcMzEBCHTpW1fHp2BgZ
jVxCO2rXZEWcWLOMswZH
=DNzy
-----END PGP SIGNATURE-----

--nextPart2356515.7vxIe1tYdU--
