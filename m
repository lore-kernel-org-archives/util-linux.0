Return-Path: util-linux-owner@vger.kernel.org
Received: from karif.server-speed.net ([188.40.51.140]:53755 "EHLO
	karif.server-speed.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab1HKPkV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 11 Aug 2011 11:40:21 -0400
Received: from karif.server-speed.net (karif.server-speed.net [127.0.0.1])
	by karif.server-speed.net (Postfix) with ESMTP id EF7AA90008
	for <util-linux@vger.kernel.org>; Thu, 11 Aug 2011 17:32:58 +0200 (CEST)
Received: from [192.168.4.247] (h081217049118.dyn.cm.kabsi.at [81.217.49.118])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: flo)
	by karif.server-speed.net (Postfix) with ESMTPSA
	for <util-linux@vger.kernel.org>; Thu, 11 Aug 2011 17:32:58 +0200 (CEST)
Message-ID: <4E43F629.6040408@xinu.at>
Date: Thu, 11 Aug 2011 17:32:57 +0200
From: Florian Pritz <bluewind@xinu.at>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: mkswap fails to use more than 2GiB and doesn't recognize LVM
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7FC94C0F0826E576BC36ABD0"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7FC94C0F0826E576BC36ABD0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

I'm running util-linux 2.19.1 with a x86_64 linux 3.0.1 on Arch Linux.

mkswap displays the following output when trying to create swap on a
8GiB logical volume.
> # mkswap /dev/mapper/vg_brynhild-swap
> mkswap: warning: truncating swap area to 2097144 KiB
> mkswap: /dev/mapper/vg_brynhild-swap: warning: don't erase bootbits sec=
tors
>         on whole disk. Use -f to force.
> Setting up swapspace version 1, size =3D 2097140 KiB
> no label, UUID=3D5eae2d8b-f664-46f5-983c-bdcd4301fa66

I tried adding -p 8589934592 to force 8GiB, but that doesn't change
anything.

It also fails to see that we are using LVM so this is not a real device
and we won't overwrite any boot sectors.

busybox mkswap crates the expected 8GiB swap, so I think this is a bug.

--=20
Florian Pritz


--------------enig7FC94C0F0826E576BC36ABD0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQIcBAEBAgAGBQJOQ/YpAAoJEG0WVcFM4cE+bBYP/jVU5Ai6wyPMu63WsSKa+8OI
cQ95cboGYNxGLg9WOVyOujhDcMbMnhvqphN8KAzEPdcL+sRO9LeuAVnBwdtJV0b3
wHssEsySQr3mrPZN2B5KVPf+jYav+VVmRlaww5jABOV01aFp0H7yfbTgDv9g5Vt1
sSS9HQb8oCPSYhwswgE6vavivi0AuOrxdEHgeb3yzWNAGTzYp8YatpLYs7fXJGGa
io3WF7vc+IKQP1P7t2B11B1w2gHZ22uSOQk4JhmwiY+mYiGUMVDFRU8xh5wcnnIA
f2T+lkrBG2p57LrqqYh+WGyG+ZaDrHXEdD0ocvFog8D19PMlTI95RMb6063DTqQ4
6xRhawnFvw/d4C4dwkSCW0PfG/qUaulRdpr2j0Ey+X6qhChd6Y2Uoe1GoROEtcyX
x9NJy+20pMDIJ/2N3jWYX5vKOOrponSBa9qRw5/rcztnkTeh5Cn3tpt57WT3Se+O
QAzSIEpvB4VC9NVFUhP1pbhjgalK0NNOQSpJhAuoL6IllVAm4tr34C0kRK8QQbPg
MiN5ZGAyDuIAnf/+Ss228hD3hIa49xw2u5WtyIhMkz3epZYXKb8bvphiaNMhne5w
z3/0pz6oelwSVj+W/ScdhQvBGMzXtLYNerTnTWfkyZzRJcXj9t9hTHwgXBc8zcK+
VaATbZ7r9nRFvos1D8ua
=TulI
-----END PGP SIGNATURE-----

--------------enig7FC94C0F0826E576BC36ABD0--
