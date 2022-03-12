Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30D07C433EF
	for <util-linux@archiver.kernel.org>; Sat, 12 Mar 2022 11:53:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbiCLLy3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 12 Mar 2022 06:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiCLLy3 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 12 Mar 2022 06:54:29 -0500
X-Greylist: delayed 459 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 12 Mar 2022 03:53:21 PST
Received: from smtp.dkm.cz (smtp.dkm.cz [62.24.64.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADA862FD
        for <util-linux@vger.kernel.org>; Sat, 12 Mar 2022 03:53:21 -0800 (PST)
Received: from smtp.dkm.cz (localhost [127.0.0.1])
        by smtp.dkm.cz (Postfix) with ESMTP id B8F5521EF5
        for <util-linux@vger.kernel.org>; Sat, 12 Mar 2022 12:45:35 +0100 (CET)
Received: from router.bayer.uni.cx (ip-78-45-76-93.net.upcbroadband.cz [78.45.76.93])
        by smtp.dkm.cz (Postfix) with ESMTP
        for <util-linux@vger.kernel.org>; Sat, 12 Mar 2022 12:45:35 +0100 (CET)
Received: from album.bayer.uni.cx (album.bayer.uni.cx [IPv6:2001:470:993c:1:5246:5dff:fe8e:a186])
        by router.bayer.uni.cx (Postfix) with SMTP id 8CA5DAA15C
        for <util-linux@vger.kernel.org>; Sat, 12 Mar 2022 12:45:34 +0100 (CET)
Received: by album.bayer.uni.cx (sSMTP sendmail emulation); Sat, 12 Mar 2022 12:45:35 +0100
Date:   Sat, 12 Mar 2022 12:45:35 +0100
From:   Petr Pisar <petr.pisar@atlas.cz>
To:     util-linux@vger.kernel.org
Subject: A mistake in "failed to cache size" message
Message-ID: <YiyH3zt/z206Hs3K@album.bayer.uni.cx>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7Tjcyej3yG4WmjoW"
Content-Disposition: inline
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--7Tjcyej3yG4WmjoW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,

while translating util-linux-2.38-rc2, I noticed that this message:

#: misc-utils/hardlink.c:1262
msgid "failed to cache size"

should read:

msgid "failed to parse a cache size"

-- Petr

--7Tjcyej3yG4WmjoW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEE4/QvzhVoMKgDWObpT9GuwzZa978FAmIsh94ACgkQT9GuwzZa
97+B/w//YCBbs8xvB/F84OBGSfRr6NHgkRYiLII4he9TQIj6uBgwFGctxRenRHAY
DFMrO4MaXWVp1RdCHXALwlGbM0pxmJxvUAPNEXClPPF8vBr02vhK31tejYiRoGUT
bz44C785PI/U62tLxoBoN5rVaiUCk+bZT7OGP06NyCK93G0q6HHnXaHv+4sqHoov
7nIQRabNYZPq6tjeTHVagxUgJnW4MHYKQwr6tVz8NQYV8twKjDSkXNRXn/Eb8llJ
BeeAndJoIRtqZQwhad+Wa07TI8MBd2WY5jNbXid5mhRV0D551aO2OW8pGxP7oUP7
5WHlyBPltpNhZY/kIHWF89fhhmd2k7oJoUz8T88Ycpd4iJhLtn3NuZGKc9xDs13I
tjlhsiDFuBgfhIKD7FzhisIyOBKw1gcBpta5rYEX2wOXY05/NxKlFZ5cfN7EhY8M
95h1qBb2aavRhLZ4WeZYK7g3NOO4ykZc31lylFXswhRRsV6bzo9fX+aT17gLNUN1
9jx9MIKuvOXZ0bPh28XTjph4+cIH9HmOMuAjBj2lrP28wl+rFxGBdfYeSVGA3CyM
Tvi0w4yt90aZC1IHpB7g0zMTrvdFgP+UQnt/Wc9Z77qfHWCTgr+TFZwf95svJXJK
11rdNBrZvqdXF4no9vWBNpd9KzQBmYs/fBUtjSeAI2IsQAzE0tc=
=P2S2
-----END PGP SIGNATURE-----

--7Tjcyej3yG4WmjoW--
