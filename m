Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:34776 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750718Ab1IGEeh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 7 Sep 2011 00:34:37 -0400
Received: from vapier.localnet (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 6F00E1B4003
	for <util-linux@vger.kernel.org>; Wed,  7 Sep 2011 04:34:37 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: util-linux-2.20 agetty clearing by default
Date: Wed, 7 Sep 2011 00:34:41 -0400
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1538957.p8R21010qm";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <201109070034.42352.vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

--nextPart1538957.p8R21010qm
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

some people have complained about the changed agetty default behavior of=20
clearing the screen.  should we invert the --noclear flag default ?  or is=
=20
this an intentional change in the default behavior ?
=2Dmike

--nextPart1538957.p8R21010qm
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.17 (GNU/Linux)

iQIcBAABAgAGBQJOZvRiAAoJEEFjO5/oN/WBLA8QAM5cTzZpjnlkggkdFu/XIdsd
Dh8q8ZG0aJchRtVc54C8mHU1IjrBYBcZch9uxPl3cKQ3wymnocNN8XO5Afht3S1K
9RTCB1UKrPbanhQkfTdhYtAhMQtaixGWt6j3FQ0n0w3h7RlbxTfV/D6ZIAtLJ7g+
Px1ensxj5O9QtXt7DY+A7cfwH/yuamA9cErPSQncEyvKBE77Ih+87JFP2Eq73zLF
PTJDXDqNoTzWIIf7biSPJfAPGz5Kx886bR+uGdPyDxed87UAXOGEAcPs8dcnPCjy
7zBc4nG57WyWYiezbbk5JXLZySJGgYN8Hlq15pFWiMbuncDS4JhqJRYdZVtKdCBB
RXMTrsuyrmnG/b2tC3luqL+IvRdlINVFLOEL/Fcp6+YrZML448u8tYIaPNO293SE
P0R96lU/nGiFIJWoPFsmdYYF9GCTrrR0iVlm+X1CJ1ZY/s90xAnKlnMS1V/N+JFz
DxyFtLV4Z9gd9Xn3fxJaplorgN8U93K2gZukqfyC5uJEPRQlj7Zwa3QQoP8dwc4h
zVspebbHG9/zKzu/4SBMQT4s3IM36ITLzCwulTkpjacInM8PaQ4HWrbPKal11B+U
VGnlWXz432kxC+v1yvtIa05i0VDkNuFP8UKo34jgTiwxTGOZ3aUGORDyCuozTFXa
Dl4KlyVCZFVVldJ+benh
=dcvh
-----END PGP SIGNATURE-----

--nextPart1538957.p8R21010qm--
