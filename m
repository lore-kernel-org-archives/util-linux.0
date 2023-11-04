Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE2AC4332F
	for <util-linux@archiver.kernel.org>; Sat,  4 Nov 2023 04:52:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbjKDEwE (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sat, 4 Nov 2023 00:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjKDEwD (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sat, 4 Nov 2023 00:52:03 -0400
Received: from tarta.nabijaczleweli.xyz (tarta.nabijaczleweli.xyz [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1684C123
        for <util-linux@vger.kernel.org>; Fri,  3 Nov 2023 21:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1699073515;
        bh=40Lzc1MBqcFjmtyd4N1wtrTovDKOZgJE400r4XMDYK4=;
        h=Date:From:To:Subject:From;
        b=o8TtORhXg7a6KaOpQ83dYx6Glb/6ayW32Kcs7BTeUuSr7V/TG35UDB0b3JFsF5hK3
         2KovA9kwk4CunLEScUAvcH0i5U4QtbpVNw1g2jkbopGlBM59Oo8rshm8UNLJze2Hkf
         aZYPxj8hpELBeEf7GDnT0pHXXh7kN87QmkvXZWKF0WwjUA7NzAfYTR1uyRTn5B/GA9
         yNkVOt8Xlok7mhRx56tpDoVcvN05gbPImkpsEC1FIoJ851p/DeJjL5i9QQ5diRToK6
         WRpznSmyd+ugaD9e78MswjzV6OKQzNiMlYOZZb+r0jB13mXDSN+9YQTQWCiIfagO3c
         zkQIcr8MxkRGA==
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 37D3611214
        for <util-linux@vger.kernel.org>; Sat,  4 Nov 2023 05:51:55 +0100 (CET)
Date:   Sat, 4 Nov 2023 05:51:55 +0100
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     util-linux@vger.kernel.org
Subject: [PATCH] fstrim.8: -v doesn't take an argument
Message-ID: <kvjsrwxmn5rtxniy5jdceoo4s2l4fqfyarz5jdifsip75ydhlf@tarta.nabijaczleweli.xyz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="or4h4etbeqwsw5n2"
Content-Disposition: inline
User-Agent: NeoMutt/20231103
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--or4h4etbeqwsw5n2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

---
Based on 2.38.1.

diff '--color=3Dauto' -u -r util-linux-2.38.1.old/sys-utils/fstrim.8.adoc u=
til-linux-2.38.1/sys-utils/fstrim.8.adoc
--- util-linux-2.38.1.old/sys-utils/fstrim.8.adoc	2022-05-11 10:13:11.12353=
0407 +0200
+++ util-linux-2.38.1/sys-utils/fstrim.8.adoc	2023-11-04 05:49:02.371888189=
 +0100
@@ -12,7 +12,7 @@
=20
 =3D=3D SYNOPSIS
=20
-*fstrim* [*-Aa*] [*-o* _offset_] [*-l* _length_] [*-m* _minimum-size_] [*-=
v* _mountpoint_]
+*fstrim* [*-Aa*] [*-o* _offset_] [*-l* _length_] [*-m* _minimum-size_] [*-=
v*] _mountpoint_
=20
 =3D=3D DESCRIPTION

--or4h4etbeqwsw5n2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmVFzecACgkQvP0LAY0m
WPHiGg/+JP6mUtLRq41Qwk9WEtnVSi+SWEzXLUEix6KhX37ZhQrQeYxX//1mFo6E
4HqYjKY5rTy+rD++FU3WUjwgjWRA5S1qSusrRG1ljRGO5GkpshG1ENGL98QQ+n0w
iO2pEkpSR7S1RIaVl2CQjfmCjMop93zeYov7hJ67SlzCzumOfNihs89f6lyfkrDM
yYaSUGpkjONQOkDgUB1nxRrO5SMqag8aFb41v2r5py0zulwAXSQ3EECwZzKeTVc/
tK4WMJ1SqlR1+SIkN/2XiIRZ22x3Nk6r+6lnSa+SOGQ+oONC/qzMsKow+hV/IZ8r
/s9IHz6/+FZSup3eUqa+E85c/cJntynOkN2ZOVLi9rKuDH5Tzhc/GGqIpX/bRwfD
s+7BYY7kbWulPZDud9JMqxft8SkUrVY1vcqMaOXF64Nk82g62ACC5S2Fc6aFi4B/
okKvblrdBFUuou4aR84XLTAqjiaIInt7r3QuNUsc0sH4bzcHtNGBMoBLcwtEwNJ/
pNTHd++OsBEtm6SrmGzLd+nTc1LWSWGvKtqNxUgyJWJ93mgYM6LBIWqww1lTRmrP
S9nRqHUnEvQri1eQWE3iO6+skUcu1ivWtiIqD0d8U6dHch+xjkxEU+lAseJOy5nM
7uKm9rG2lwygDi3APtET/PnoBukRo5A7slKtiLhy8wudvw2Rv9k=
=PJD2
-----END PGP SIGNATURE-----

--or4h4etbeqwsw5n2--
