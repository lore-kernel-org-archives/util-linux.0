Return-Path: <SRS0=+H4D=BE=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 847C8C433E3
	for <util-linux@archiver.kernel.org>; Sat, 25 Jul 2020 17:02:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E317206D7
	for <util-linux@archiver.kernel.org>; Sat, 25 Jul 2020 17:02:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbgGYRCO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 25 Jul 2020 13:02:14 -0400
Received: from jabberwock.ucw.cz ([46.255.230.98]:54064 "EHLO
        jabberwock.ucw.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbgGYRCO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 25 Jul 2020 13:02:14 -0400
Received: by jabberwock.ucw.cz (Postfix, from userid 1017)
        id AF60D1C0BDD; Sat, 25 Jul 2020 19:02:11 +0200 (CEST)
Date:   Sat, 25 Jul 2020 19:02:11 +0200
From:   Pavel Machek <pavel@ucw.cz>
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.36
Message-ID: <20200725170211.GA2807@amd>
References: <20200723100828.262ftx3qhie2sc32@ws.net.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="Dxnq1zWXvFF0Q93v"
Content-Disposition: inline
In-Reply-To: <20200723100828.262ftx3qhie2sc32@ws.net.home>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--Dxnq1zWXvFF0Q93v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> The commands fdisk(8), sfdisk(8), cfdisk(8), mkswap(8) and wipefs(8) now
> support block devices locking by flock(2) to better behave with udevd or =
other
> tools. Ffor more details see https://systemd.io/BLOCK_DEVICE_LOCKING/.  T=
his

There's typo "ffor", but I guess it is too late to fix that?

Best regards,
									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--Dxnq1zWXvFF0Q93v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAl8cZZMACgkQMOfwapXb+vL9XwCbBSLZEvCjGt5yMfUaG1pII7Rn
AP0AnRQMyE9vGu1xvXbuGuUg3CODmyPW
=qUWC
-----END PGP SIGNATURE-----

--Dxnq1zWXvFF0Q93v--
