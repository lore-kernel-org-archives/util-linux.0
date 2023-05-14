Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679CFC77B7F
	for <util-linux@archiver.kernel.org>; Sun, 14 May 2023 23:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjENXUF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 14 May 2023 19:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjENXUF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 14 May 2023 19:20:05 -0400
Received: from tarta.nabijaczleweli.xyz (unknown [139.28.40.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7010810C1
        for <util-linux@vger.kernel.org>; Sun, 14 May 2023 16:20:02 -0700 (PDT)
Received: from tarta.nabijaczleweli.xyz (unknown [192.168.1.250])
        by tarta.nabijaczleweli.xyz (Postfix) with ESMTPSA id 802427FF4
        for <util-linux@vger.kernel.org>; Mon, 15 May 2023 01:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=nabijaczleweli.xyz;
        s=202305; t=1684106399;
        bh=VsvIMp1dUONEllj+yeaKWcqIbwDeroiIQfwku2dNQTY=;
        h=Date:From:To:Subject:From;
        b=kTCzRYKVGFOX5oYjSJI7mEwFgH1nXC/Qjb0F043JWCZUc1nLTJsvFy+xUxcGCOcta
         ZEo8p6G+TzL3sDdg7VdAL1gPOsssYGsW+NR0Jf1wdi0gZlUS/dAaZcfkKRPb3nm/A9
         h45h8V+6l0qOhspGR3QuvfyjbygM9UawarwCdFtH3RpQV9jzhO5V6QidTjfnZLFe13
         nSAGV8l/lvj4D+95yaN8BJ5iHN5ZSr0z5R4zZZgssLujolmc6UA8AOzW9Qwrul/0pV
         H9nXccjUl/+u9fpd7Mt9fdjjBoRI9m763k5rQtFYNaTtVw9rtzjQ/GqYxhDvw8ynFC
         IJh52Qz1V2ZJA==
Date:   Mon, 15 May 2023 01:19:58 +0200
From:   =?utf-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
To:     util-linux@vger.kernel.org
Subject: [PATCH] mesg.1 cleanups/updates
Message-ID: <iv3bmcufpzlrrasfctami46xmazuhlq3z4hvd7537bomu6fa5q@k7tx2qgxwrrg>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jnrqhdkbsm6o7h22"
Content-Disposition: inline
User-Agent: NeoMutt/20230407
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


--jnrqhdkbsm6o7h22
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

First hunk:  grammar.
Second hunk: (a) mentioning BSD ptys and not UNIX98 ones is odd,
             (b) mentioning /only/ ptys is odder still.
Third hunk:  mesg is found in the UNIX Programmer's Manual;
             it takes its modern form in V7
             (it's unclear to me why V6 specifically is mentioned,
              since it's still default-invert + always-report-"was X").
---
Based on 2.39-rc3 tarball.

diff -u -r util-linux-2.39-rc3.orig/term-utils/mesg.1.adoc util-linux-2.39-=
rc3/term-utils/mesg.1.adoc
--- util-linux-2.39-rc3.orig/term-utils/mesg.1.adoc	2023-05-15 00:57:54.747=
355121 +0200
+++ util-linux-2.39-rc3/term-utils/mesg.1.adoc	2023-05-15 01:15:55.97120553=
2 +0200
@@ -54,7 +54,7 @@
=20
 Traditionally, write access is allowed by default. However, as users becom=
e more conscious of various security risks, there is a trend to remove writ=
e access by default, at least for the primary login shell. To make sure you=
r ttys are set the way you want them to be set, *mesg* should be executed i=
n your login scripts.
=20
-The *mesg* utility silently exits with error status 2 if not executed on t=
erminal. In this case execute *mesg* is pointless. The command line option =
*--verbose* forces mesg to print a warning in this situation. This behaviou=
r has been introduced in version 2.33.
+The *mesg* utility silently exits with error status 2 if not executed on a=
 terminal. In this case executing *mesg* is pointless. The command line opt=
ion *--verbose* forces *mesg* to print a warning in this situation. This be=
haviour has been introduced in version 2.33.
=20
 =3D=3D ARGUMENTS
=20
@@ -86,11 +86,12 @@
=20
 =3D=3D FILES
=20
-_/dev/[pt]ty[pq]?_
+_/dev/[pt]ty*_, _/dev/pts/[0-9]*_
=20
 =3D=3D HISTORY
=20
-A *mesg* command appeared in Version 6 AT&T UNIX.
+*mesg* (I) appears in the UNIX Programmer's Manual.
+It used to invert the current state with no argument before Version 7 AT&T=
 UNIX.
=20
 =3D=3D SEE ALSO
=20

--jnrqhdkbsm6o7h22
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEfWlHToQCjFzAxEFjvP0LAY0mWPEFAmRhbJsACgkQvP0LAY0m
WPHkqRAAuofoF37fg2fqFAyrj8rEAmzR0Z7gtGn+zIdVDD8qZCTjBHN1HaigRtLr
8wJMy6PyW+TsmivvHNYSkf8TFGZQu7KlGw5IUdJReBJcMcdNkiypQqsFaKPb7Z7Y
kJ02ox5yD53wX7eKUIDRqhk1bensNe2kbHd31mRfOwxqZu3RSGQnvc3d+oIFxXWS
mURKZFem5KVD4j+eTPu1AL46f8W/wEZrP6OBkzAUHDEkmpHB1jeVI0WMBsnrCUEa
ERwgXLD8O+TKsWaLWIuYaUqlnBbV7T3klb60yz29DJzu7B9HI6GtXZSVwoLCgXcN
+74XuEYZiHQi5AW3A0PZMn18r5zlpdEreV5ZSzKrjYUL7dhv2q3vMrlRSUzaFlcV
3hyaBStvw5B+hA2b5L05QgGATYY7cMb7KiLeN3EDljy6LtJhSXiVSRNDw1v7cbQ4
9m52x3MwBOLnQaRflKwFJfQiqAHkKEOzrVVFLD6S+JxxRl5TRT6vw/HHJ8lChr4w
TT3toEw3AuCAvoVy3G0yKU8FVF2OMnZmDOHehZuWxWBDNSMMvD6hoRaT9+ErUnzh
yLBcAEIfO3Me92xB4zIZghe77UzvA/3td4Q8v0Z4d3XOdoJZKlZ7Li9P6zh0pmMr
uSQQRZXL4Wb7Zs1ra+ypr9rSmrFZn5yfZDfPpfsVz2dJA3AHOTg=
=N3hD
-----END PGP SIGNATURE-----

--jnrqhdkbsm6o7h22--
