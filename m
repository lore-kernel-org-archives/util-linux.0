Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:38756 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750817AbaAGJsB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 7 Jan 2014 04:48:01 -0500
Message-ID: <52CBCB08.1000702@archlinux.org>
Date: Tue, 07 Jan 2014 10:38:16 +0100
From: =?ISO-8859-15?Q?Thomas_B=E4chler?= <thomas@archlinux.org>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux@vger.kernel.org, Sami Kerola <kerolasa@iki.fi>
Subject: Re: [PATCH] uuidd: use pkg-config to find systemd-deamon support
References: <1389051548-1268-1-git-send-email-kerolasa@iki.fi> <20140107085831.GK31045@x2.net.home>
In-Reply-To: <20140107085831.GK31045@x2.net.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="qKqNug7SQSLJ2SRDaAJHalVb8pCRwoTvP"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qKqNug7SQSLJ2SRDaAJHalVb8pCRwoTvP
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 07.01.2014 09:58, schrieb Karel Zak:
> On Mon, Jan 06, 2014 at 11:39:08PM +0000, Sami Kerola wrote:
>>  configure.ac             |   3 +
>>  misc-utils/Makemodule.am |   3 +-
>>  misc-utils/sd-daemon.c   | 520 --------------------------------------=
---------
>>  misc-utils/sd-daemon.h   | 282 -------------------------
>>  misc-utils/uuidd.c       |   2 +-
>=20
>  Seems like a good idea, unfortunately I'm not sure about it.=20
> =20
>  The systemd (udevd) depends on libblkid+libuuid, it would be=20
>  probably better to keep util-linux without dependencies on systemd
>  libs otherwise we will introduce a cyclic dependence -- it could be
>  too tricky for some build systems and users :-) I'll think about it...=

>=20
>     Karel

We already have such a cyclic dependency, since udevd depends on
libblkid+libuuid, and findmnt (from util-linux) depends on libudev.



--qKqNug7SQSLJ2SRDaAJHalVb8pCRwoTvP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQIcBAEBCAAGBQJSy8sKAAoJEChPw0yOSxolOMMP/2rpAy61yEODqy8QocXCLGrP
6AHYbVXZqi/qT8kPf/jpdOAOP0A+qiIEF1dWbq7sFY+UTwCBhmhYEV6NVCK9BAAT
0SiG2R0XE3Ef8Wub9RNQAelJ7vyPyGkzH5/0hzoNqPAWHMWA4T6K10a6oyyQMdRu
eJgftQnMnjrKZ+ifu0ua8ubxcK0+r3UKEK/g8LPCwmntIhWGK1PLuwvVoDpz15kp
zYQ0m66Y1X0/MAwMh6uASTw9UtfNr7PP0Dg/Gy4j2DXIBcDfNT0oJXvXiL8oyC6Q
dYiUnUd1ILoZLabKAUF5TzBeIFZqdZ5O9ugeErm9S/0Km9dGErMtyyNoV2TEiemN
nclLIP+/I8vF3IXqCEVTHKRmy4281tDbj2dMu1Z4SHmLcRJojMjL+BWMliwKidsm
dKKO2cmENy/XATMNdj018kWwjcBq+T3KJFchZoLwmMRR+kZxaWQsUOFzo27F0rkJ
n1KKUnCZK5HPA2AoS/D6hdj4WnHGr5lEh+RhRD6zjbimrsAJIQ6ovDxnZIFhkT8o
jb7OjqnqbmtKQv8CAlAKCrEwJiCdeFEF3VGwbEfLg/y+6eJNdzDuyLCLwZEpw4XE
0xIsO5jt0llbA7aXXYdxOJbnfQUrLb1K93H8SVgG/TyM2RfTVHRXlErt29LXR8G7
69mZmYGfm8Bhso1Mx1bd
=ETuy
-----END PGP SIGNATURE-----

--qKqNug7SQSLJ2SRDaAJHalVb8pCRwoTvP--
