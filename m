Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F293C6FD1F
	for <util-linux@archiver.kernel.org>; Thu, 16 Mar 2023 16:09:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbjCPQJI (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 16 Mar 2023 12:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjCPQJH (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 16 Mar 2023 12:09:07 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id ECBC19AFC9
        for <util-linux@vger.kernel.org>; Thu, 16 Mar 2023 09:09:04 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 819292CE8
        for <util-linux@vger.kernel.org>; Thu, 16 Mar 2023 17:09:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1678982940;
        bh=X0XYwcHrzul+5ohtAo07+Hh4U8iO+d+KUCqnD5u99i0=;
        h=Date:From:Cc:Subject:From;
        b=WbGGNoau/s9/rnW5jEZAcO+BkL6RSy5wEmddEpuT/+YPONFJ3fe+xnFK1J+pfI5oH
         jNPe8hQ5420yQGYDh2lb33tZYaVJHnIO2r3/noBWik5uquufTDGjY5/WvoG3Xrfzur
         2KDDQeSKsgDgrUoT7pm9VwwpDQ95/2dj1AouXzkgNulo2Xr66Rhu/snB9IlWJ/G7IB
         HlcLdijaXKY3Mlbs+5kQqM9z1TjKfNZaMboqmthzoOC5oBopiP1PAMZ1NxR57ziJLN
         Hc1pTfi4Orpcj5y1zf6hmvCwalFChZUkKt4Elpj+5rWEnh4LTBgzmDw2QsvPXfu5Xo
         NXWvcU7PV8QSw==
Date:   Thu, 16 Mar 2023 17:08:59 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     util-linux@vger.kernel.org
Subject: [PATCH] lsfd: error if extraneous argument given
Message-ID: <20230316160859.zksrhccvnnslkgyd@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w4dn53und4poyvec"
Content-Disposition: inline
User-Agent: NeoMutt/20220429
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--w4dn53und4poyvec
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The manual and help string both spec lsfd [options];
actually stick to that instead of ignoring subsequent arguments.

This is particularly a weird thing to allow given that lsof path
is legal and does something (either same as
lsfd -Q "MAJ:MIN =3D=3D \"$(stat -c %Hd:%Ld path)\"" if it's a mountpoint or
lsfd -Q "NAME ~=3D '$path'" (sans the regex and escaping) otherwise).

This mirrors ec96a89ed9551ffacfc58b3056c8070444e3a2f3 for largely the
same reason.
---
 misc-utils/lsfd.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/misc-utils/lsfd.c b/misc-utils/lsfd.c
index 27a0ada01..4b21bf6d2 100644
--- a/misc-utils/lsfd.c
+++ b/misc-utils/lsfd.c
@@ -1943,6 +1943,8 @@ int main(int argc, char *argv[])
 			errtryhelp(EXIT_FAILURE);
 		}
 	}
+	if (argv[optind])
+		errtryhelp(EXIT_FAILURE);
=20
 #define INITIALIZE_COLUMNS(COLUMN_SPEC)				\
 	for (i =3D 0; i < ARRAY_SIZE(COLUMN_SPEC); i++)	\
--=20
2.30.2

--w4dn53und4poyvec
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQTPxsACgkQvP0LAY0m
WPFsEg//ZfbdiHJrzXKNJXKPp9E4juL9EaNr9hAp1I7CtnKjhwp/vA8MszyDXofy
LXXp8o/qVDOS+NVUTN1G3z1XR6oLfCFXQOigp1MDwkA+NwTiAeKA2ipknDCZwAIe
DHyUQD9K1fAq+U2Bi58pUVpirO7IkFUyFwldbxNf2WzQsWwiybynmFUoh0mH1PdF
9Knqof1+CWjRxEW30D2jowDZfM7BE010w19ocO8fxVEnWsXB48GO058RLeyRZBHu
X+u3UcEJuw3mSJskHbABEsNsqrGhCjRuxw43dOV0gJmaNVUcy5erbxo2p1VCabbP
X3fVjCv20dxXWqdizjaeHKLbDxHR8iVZdizbuqingTYyx5FNIb5ZKq8QBWJnmrf1
hcz0RdIaslN0b/SaD4wFAMDMOeo0kqtkZMHKLRmvbFQUcAqEeIOdsVTb0sVjCsAt
W3Hj0sLmn1qN/w4F4hQI5Vf3vw17NogEgQsSGTi7M2tXXn68jG6oKZXoKZjFEWOV
aT3hq7+jxtdZdZwQy4z1U3rUxWI7Hlj/gmaSur63G3TclEygw9teN0oKO+WSWYAn
dFuwoeGaIOyNRrc0in22soteiUvRSvP5xL2BoLwuyWl5FjG+5SeJmu2w3++jmiPm
+gI6VR28lMTejhcq+R/hlYq2xscEDWug9KCVz6L3t4OdMJKyago=
=DYGA
-----END PGP SIGNATURE-----

--w4dn53und4poyvec--
