Return-Path: util-linux-owner@vger.kernel.org
Received: from mondschein.lichtvoll.de ([194.150.191.11]:59527 "EHLO
	mail.lichtvoll.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbaHDLxg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 Aug 2014 07:53:36 -0400
From: Martin Steigerwald <Martin@lichtvoll.de>
To: util-linux@vger.kernel.org
Subject: Re: [PATCH] Fix re-enabling of cursor with slang also after pressing Ctrl-C
Date: Mon, 04 Aug 2014 13:53:34 +0200
Message-ID: <2432624.0NNcbHJWc6@merkaba>
In-Reply-To: <1419379.tzkKhjxti9@merkaba>
References: <1419379.tzkKhjxti9@merkaba>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1472687.g4vGjlNesl"; micalg="pgp-sha1"; protocol="application/pgp-signature"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--nextPart1472687.g4vGjlNesl
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Am Montag, 4. August 2014, 13:28:11 schrieben Sie:
> According to curs_set(0) in ui_init() I think curs_set(1) belongs int=
o
> ui_end with in die_on_signal() also gets called on SIGINT or SIGTERM.=

>=20
> This should complete the fix made by Andreas in commit 4f4daf8f.
>=20
> I could not yet test the fix as building current git fails with:
>=20
> /usr/bin/ld: sys-utils/swapoff-swapon-common.o: undefined reference t=
o
> symbol 'blkid_probe_lookup_value@@BLKID_2.15'
> //home/martin/Linux/util-linux/util-linux/.libs/libblkid.so.1: error =
adding
> symbols: DSO missing from command line
>=20
> Will test as soon as I found out how to fix this build issue. Benno
> reported it already on mailing list.
>=20
> Addresses-Debian-Bug: #757000
> BCC=B4d there for reference.

Scratch that.

Fix doesn=B4t work.

Cursor is displayed on regular end, but not on Ctrl-C.

Don=B4t get why tough.

=2D-=20
Martin 'Helios' Steigerwald - http://www.Lichtvoll.de
GPG: 03B0 0D6C 0040 0710 4AFA  B82F 991B EAAC A599 84C7
--nextPart1472687.g4vGjlNesl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEABECAAYFAlPfdD4ACgkQmRvqrKWZhMeWygCghGqAWr/AX0y3vNKjaBvR3d2v
qRMAoIkyRZwp+EjBEwofPy1HgVXigaxF
=aNEf
-----END PGP SIGNATURE-----

--nextPart1472687.g4vGjlNesl--

