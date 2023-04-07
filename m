Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0598C6FD1D
	for <util-linux@archiver.kernel.org>; Fri,  7 Apr 2023 14:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjDGOsO (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 7 Apr 2023 10:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjDGOsO (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 7 Apr 2023 10:48:14 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6C114C2F
        for <util-linux@vger.kernel.org>; Fri,  7 Apr 2023 07:48:10 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id E2B4457CA
        for <util-linux@vger.kernel.org>; Fri,  7 Apr 2023 16:48:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202211; t=1680878887;
        bh=M9PvX6ZrNYCR8wZc7a+ZaVD8URlxV/KWhXY7e0u9wn8=;
        h=Date:From:To:Subject:From;
        b=O7GnuDA3s23poq/eYUKLKjCL43rN4QvYhdyHyFv5KPzNmXTwX/8zZllnHlwPKabKB
         MVXZfTavEdY2EK+jhqfXX1Tb+lj55IB2fT9XeYwerVdpGzohgzkQIHTwKl/XhcSLjd
         H6y8hudEXvXnkaU7EYf+DIp5QKSEHZp1VlTHlthe6HsNHc/XXd7mvqQxgc7bamPO8O
         gwh44JRICety0U7JfyVTTi7uwFv2+8mwC2DNuq0dmitOHlkNzh6E76G1PNE8LPGBDv
         0GQ26YFr4h114AdaS7hiun8MtwSjklnCfOx6Nm/qnmeKhq5TLeXtJN4W8ZfnTrknuO
         FBl7QxE6vX1Ww==
Date:   Fri, 7 Apr 2023 16:48:06 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     util-linux@vger.kernel.org
Subject: [PATCH] Fix mmap/ioctl(3p) references in manual
Message-ID: <xirr7enxyybsuyjjroo3v452yjio3b3bfw4hdmctzhundq4wgg@ymt5yxyrni3q>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xusjrgekoziuduaw"
Content-Disposition: inline
User-Agent: NeoMutt/20230322
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--xusjrgekoziuduaw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

mmap(3p) is passable, inasmuch as it does actually describe mmap(2).

ioctl(3p), on the other hand, describes XSI STREAMS, which bear no
relation to ioctl(2) under Linux, much less ioctl_console(2).

Both live in the non-free manpages-posix-dev.
---
Based on 2.39-rc2 tarball.

diff '--color=3Dauto' -ur util-linux-2.39-rc2.orig/sys-utils/setarch.8.adoc=
 util-linux-2.39-rc2/sys-utils/setarch.8.adoc
--- util-linux-2.39-rc2.orig/sys-utils/setarch.8.adoc	2023-03-23 16:21:32.7=
92172791 +0100
+++ util-linux-2.39-rc2/sys-utils/setarch.8.adoc	2023-04-07 16:40:55.820024=
243 +0200
@@ -70,10 +70,10 @@
 This makes *select*(2), *pselect*(2), and *ppoll*(2) system calls preserve=
 the timeout value instead of modifying it to reflect the amount of time no=
t slept when interrupted by a signal handler. Use when _program_ depends on=
 this behavior. For more details see the timeout description in *select*(2)=
 manual page. Turns on *STICKY_TIMEOUTS*.
=20
 *-X*, *--read-implies-exec*::
-If this is set then *mmap*(3p) *PROT_READ* will also add the *PROT_EXEC* b=
it - as expected by legacy x86 binaries. Notice that the ELF loader will au=
tomatically set this bit when it encounters a legacy binary. Turns on *READ=
_IMPLIES_EXEC*.
+If this is set then *mmap*(2) *PROT_READ* will also add the *PROT_EXEC* bi=
t - as expected by legacy x86 binaries. Notice that the ELF loader will aut=
omatically set this bit when it encounters a legacy binary. Turns on *READ_=
IMPLIES_EXEC*.
=20
 *-Z*, *--mmap-page-zero*::
-SVr4 bug emulation that will set *mmap*(3p) page zero as read-only. Use wh=
en _program_ depends on this behavior, and the source code is not available=
 to be fixed. Turns on *MMAP_PAGE_ZERO*.
+SVr4 bug emulation that will set *mmap*(2) page zero as read-only. Use whe=
n _program_ depends on this behavior, and the source code is not available =
to be fixed. Turns on *MMAP_PAGE_ZERO*.
=20
 include::man-common/help-version.adoc[]
=20
diff '--color=3Dauto' -ur util-linux-2.39-rc2.orig/term-utils/setterm.1.ado=
c util-linux-2.39-rc2/term-utils/setterm.1.adoc
--- util-linux-2.39-rc2.orig/term-utils/setterm.1.adoc	2023-03-23 16:21:32.=
794172780 +0100
+++ util-linux-2.39-rc2/term-utils/setterm.1.adoc	2023-04-07 16:42:33.38837=
5375 +0200
@@ -134,7 +134,7 @@
 Displays the terminal reset string, which typically resets the terminal to=
 its power-on state.
=20
 *--resize*::
-Reset terminal size by assessing maximum row and column. This is useful wh=
en actual geometry and kernel terminal driver are not in sync. Most notable=
 use case is with serial consoles, that do not use *ioctl*(3p) but just byt=
e streams and breaks.
+Reset terminal size by assessing maximum row and column. This is useful wh=
en actual geometry and kernel terminal driver are not in sync. Most notable=
 use case is with serial consoles, that do not use *ioctl*(2) but just byte=
 streams and breaks.
=20
 *--reverse* on|off::
 Turns reverse video mode on or off. Except on a virtual console, *--revers=
e off* turns off all attributes (bold, half-brightness, blink, reverse).

--xusjrgekoziuduaw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmQwLSIACgkQvP0LAY0m
WPHuCxAApyXNeURQPvdxIpGPDcuSWgEYVG0utvrVxMgwlpccvHjazuZ+dG3u3T+U
jyyBfunlAT2u4HzHBiaK89Gt+2AFH8u8veml9fL6ugOFTZqi+TO3+4Svof8NT9gn
xiQU/waJaEDPdDBF2/2TOqHPjAFeMg3mF1RwrV1jJQAmbiYJ5xIgqKvaGqSNCDTp
4T1vR8KZ/kTgWI8koL+xN+18ilKP8nZSzU+n3lS5d3D9cn4OrnQ7GhHFOGRR6Dfv
0yy7AJOY1ksxAnBVilJpPf4c+U9E2dkQOvUv9yuWFO4XyJv5fKVjUWq8tVRkUmEa
EUZiSFWgFJoUrHuBylVm9UQ+c8v5bRfHROFQ4a6+j0XXMls35g0nlHheNfI/7hxl
WbL1p8nGxDzd7chFXG6LwF+TRk+UwSmXr+KjrjFEk534WwY9iArKgvmq3V6irqXV
eSoNU+vomeqfZLBuWbOskFFFWAUqEbDp50KLlUEXsEIB2+F1cPlwxy4MCfeI0YZu
+NkAxGflGq7rG1Slj/B4UmG4rnpaR2lbIgVX9bRSfvbkTj+90HwN61dmuooy2rwU
S4p5b5nE8M3YtDtAqwUfDh74K3nkxtKAszMpwq9N2+1vZ3Vzk4Sr5DBoqg812vIS
LcKRm4puzIvlKktu8dYDTPYNiTHhlGuIqnAg+nCiMXPbgkfM+qA=
=j3sn
-----END PGP SIGNATURE-----

--xusjrgekoziuduaw--
