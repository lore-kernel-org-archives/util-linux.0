Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E8EC4707A
	for <util-linux@archiver.kernel.org>; Fri, 21 May 2021 20:09:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 063BA6101B
	for <util-linux@archiver.kernel.org>; Fri, 21 May 2021 20:09:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbhEUUK1 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 21 May 2021 16:10:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbhEUUK0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 21 May 2021 16:10:26 -0400
X-Greylist: delayed 535 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 May 2021 13:09:03 PDT
Received: from smtp.dkm.cz (smtp.dkm.cz [IPv6:2a02:8301:0:11::39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51F32C061574
        for <util-linux@vger.kernel.org>; Fri, 21 May 2021 13:09:03 -0700 (PDT)
Received: from smtp.dkm.cz (localhost [127.0.0.1])
        by smtp.dkm.cz (Postfix) with ESMTP id BDC8F234CD
        for <util-linux@vger.kernel.org>; Fri, 21 May 2021 22:00:01 +0200 (CEST)
Received: from router.bayer.uni.cx (ip-89-103-167-90.net.upcbroadband.cz [89.103.167.90])
        by smtp.dkm.cz (Postfix) with ESMTP
        for <util-linux@vger.kernel.org>; Fri, 21 May 2021 22:00:01 +0200 (CEST)
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2001:470:993c:1:5246:5dff:fe8e:a186])
        by router.bayer.uni.cx (Postfix) with SMTP id 98397A0F87
        for <util-linux@vger.kernel.org>; Fri, 21 May 2021 22:00:00 +0200 (CEST)
Received: by album.bayer.uni.cx (sSMTP sendmail emulation); Fri, 21 May 2021 22:00:00 +0200
Date:   Fri, 21 May 2021 22:00:00 +0200
From:   Petr Pisar <petr.pisar@atlas.cz>
To:     util-linux@vger.kernel.org
Subject: util-linux-2.37-rc2: "%delta:" is not C-format string
Message-ID: <YKgRQPRRbMUYR2d9@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="orvA/aEI+U364uDd"
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--orvA/aEI+U364uDd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

when translating util-linux-2.37-rc2, I found that:

#: sys-utils/irq-common.c:482
#, fuzzy, c-format
msgid "%delta:"

is mishandled by gettext. Because it is marked as c-format, I cannot transl=
ated
it as:

msgstr "%rozd=C3=ADl:"

I think you need to put some hint into the source code so thet xgettext does
not store c-format flag into a POT file for this message.

-- Petr

--orvA/aEI+U364uDd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE4/QvzhVoMKgDWObpT9GuwzZa978FAmCoEUAACgkQT9GuwzZa
979D/xAAqRhGPPdoKumJ8Un+GeV1TMX6kciMWrQA3W8blt/HDC50hVBOhTyrQSi+
avDr/uH/e8NgBeMif8W5asPlS+89osL3ngPkrVjG3RkwtAqNe6cYSw53azDq3iQ8
wZ87R2qeB8Frnmpl6ir0xM6ct93Yy0RYeaElFjL3YxR+3uJsu5cTwygOotcEX9HC
TQWS/b2ylM/iHCnGN0YOb4pfnxd7WS+hG1p1iisZXDx7b79gl6OU/Y+rG/zGN6v3
ku3CVwKjoTTHTi9lCgBRJw7J59JLhDvBdbvQQe774XxtFC4F9csdCFaMkXc+X/oF
GPLbwAENkAXSbjeFRuK2wJ8ZkPzoJ2rcN5L/1IrBhFU2PhIi6QK7D7HjgrvcxpSJ
Gl1LNV/SztQX0qsO5wBerWUb5PET3leoVslPiuOMy0RmSU7kus+5iOvImg2BQ+ln
rXYUW/Mn1djQj3U9KUWuMwPFlagUyCeZjEEgKLrCDX14SRzBVp24MwFwyI5ZEfs4
qTE4RA8TJX4MCgecoUQFQIbhTdD2yRa0xZpsxkAFqXbsWW2X05s+RGV3VwYXadiZ
Jpi5OJH9yyGrD7GUGjG7Nl/c574BtxE8urcnOJNwtfRJg4cYyBU5Sy2+W+OSNCQn
PPBMZAyhtWE49Jmi65udnMLJEZALCfPm7/jfQlyrS4verrqJYC0=
=T3j4
-----END PGP SIGNATURE-----

--orvA/aEI+U364uDd--
