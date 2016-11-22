Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:55866 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752188AbcKVUnD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 22 Nov 2016 15:43:03 -0500
Date: Tue, 22 Nov 2016 12:43:01 -0800
From: Mike Frysinger <vapier@gentoo.org>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc: util-linux@vger.kernel.org
Subject: Re: [PATCH] lsns: Fix parser for /proc/<pid>/stat which is including
 space in comm
Message-ID: <20161122204301.GB21655@vapier.lan>
References: <87a8cvk01b.fsf@mail.parknet.co.jp>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="SX5mJoYSCb9KGGIe"
In-Reply-To: <87a8cvk01b.fsf@mail.parknet.co.jp>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


--SX5mJoYSCb9KGGIe
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19 Nov 2016 23:38, OGAWA Hirofumi wrote:
>=20
> Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>

can you please include an example line in the commit message ?
-mike

--SX5mJoYSCb9KGGIe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYNK3VAAoJEEFjO5/oN/WBUOoP/AtWwFQgsBh2+tN4aLWipEOl
OTFI0V9xFqGbTwCH/Lv5lxcv2S+BULFN8/AsJDindv9rUqGy+giCcc6lpGSSL/4E
WtXuikkSI+baBH3Oja5tMvqJnXrs0YdiXaaKO+8Ts8XzhFEXaICpTk9Dghefi/VZ
4nb/uTU3Aec5E0VbgxMw0mPGEm9y0nfcITrNsNdgHQKri/an+gIojywPcOUyiHhx
nwET1JAhET74gmmHrS4VLlMK4PiumWTeP4PpZTXtGDVEH2p7lruxKl/Fr+/oMSuy
DV1W5MIRIdLqQ38P4eUKhMXAJZmkJu7YdGmmV0xR/bc6wQ8HUiasGN+vjougESMv
i0xYzeu2kN6UxEciGhZA3CuoRbRK4jQBBQbuZA+mdkV/HmeTxRrGjWGCUwzwiE28
fIMfOmuKW2h5DI5i8wSgictR+4BP87046Zmebwum0tQasYxtYjjr6lxXcopvi8Eo
Xvov5+AY0eOPLNHrkDGVSzEUGUjZ9JCc1e8WNSZKvFQGIbthfsrrV9t5X//t5QS7
dLSpP32j2s0EHjm/au0ipSM18SeBU6H+VJrfh964XJMlG3h8/oWxuIcD6XWjeUaF
1mIeNMIAVWngsQbUQFWDSsBbemUeOMN/X0MGR4RLWibtYZk+D0ZeAjGiMCTPGUv+
hZynnlfbsWsh8d1G54fG
=cmUh
-----END PGP SIGNATURE-----

--SX5mJoYSCb9KGGIe--
