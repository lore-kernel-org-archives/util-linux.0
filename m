Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC353C433EF
	for <util-linux@archiver.kernel.org>; Sun, 13 Mar 2022 11:24:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbiCML0D (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Sun, 13 Mar 2022 07:26:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbiCML0C (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 13 Mar 2022 07:26:02 -0400
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73524201B4
        for <util-linux@vger.kernel.org>; Sun, 13 Mar 2022 04:24:54 -0700 (PDT)
X-KPN-MessageId: 32fbf842-a2c0-11ec-944c-005056994fde
Received: from smtp.kpnmail.nl (unknown [10.31.155.6])
        by ewsoutbound.so.kpn.org (Halon) with ESMTPS
        id 32fbf842-a2c0-11ec-944c-005056994fde;
        Sun, 13 Mar 2022 12:24:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=telfort.nl; s=telfort01;
        h=content-type:subject:from:to:mime-version:date:message-id;
        bh=5KlJsCc3RWRPoHctdQhWYhHEvSOKsu7YCLP668Y9ua0=;
        b=fcI/4ZvdbxM7S7RofHVaLERqDfI9SNcliM3L3OLfg5BuoXTf9nb7MkF2qQed/w6zQdUPmyQ5csmMF
         n8PVsgzXnqFX3FAErgfwCumxZDbWOv1ts7tD2eC8czOTdOwTXfP4s5hsQjlF+IxfXtKm1H5MSHwNXd
         ovwfonF/ssq+79as=
X-KPN-MID: 33|5f4bOw6n7MyBC0KNpU5Y9VurdM+6GUhpP3of2Tu1ckDAaOQw+n/yXaS2PnKw4Vo
 1P6+BR6cz7ztzbXVBzjedXcMPsz5w7dz2YPlnWvGnuIk=
X-KPN-VerifiedSender: Yes
X-CMASSUN: 33|O7U0A2c5XAzeA2czviFNEvoi9doczZIiyugqb2b1060dhuUZKmZKmhjA38oNfhf
 qddzLwmlWFM34+7YJT4tyfA==
X-Originating-IP: 82.168.50.91
Received: from [192.168.2.25] (82-168-50-91.fixed.kpn.net [82.168.50.91])
        by smtp.kpnmail.nl (Halon) with ESMTPSA
        id 334a86db-a2c0-11ec-bc0d-00505699772e;
        Sun, 13 Mar 2022 12:24:52 +0100 (CET)
Message-ID: <ece4e3d9-7cf7-2319-ec69-de978ab7081e@telfort.nl>
Date:   Sun, 13 Mar 2022 12:24:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
To:     util-linux@vger.kernel.org
From:   Benno Schulenberg <bensberg@telfort.nl>
Subject: the localized output of 'hardlink' is misaligned for some languages
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------BdWh5Q4GWLU11PXamWvh0l80"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------BdWh5Q4GWLU11PXamWvh0l80
Content-Type: multipart/mixed; boundary="------------eOOpBzguHJu2puLZ306DoTIU";
 protected-headers="v1"
From: Benno Schulenberg <bensberg@telfort.nl>
To: util-linux@vger.kernel.org
Message-ID: <ece4e3d9-7cf7-2319-ec69-de978ab7081e@telfort.nl>
Subject: the localized output of 'hardlink' is misaligned for some languages

--------------eOOpBzguHJu2puLZ306DoTIU
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable


Hi,

After applying the posted localization patch for 'hardlink', the
localized output is misaligned for some languages.  For example:

$ LANGUAGE=3Dpl hardlink --dry  ~/Programoj
W=C5=82a=C5=9Bciwo=C5=9Bci:           pr=C3=B3ba
Method:                   sha256
Plik=C3=B3w:                  8141
Dowi=C4=85zano:               2238 files
Por=C3=B3wnano:               0 xattrs
Por=C3=B3wnano:               2255 files
Oszcz=C4=99dzono:             9,52 MiB
Trwa=C5=82o:                  0.154945 seconds

It seems that for calculating the placement of the second column, it
counts the number of bytes in the word+colon thing and then subtracts
that from 25 to determine the number of needed padding spaces.  But it
should count the number of character columns instead.

Probably this should use libsmartcols in some way?

(That "Method": and "files" and "seconds" are not localized is due to
the incompleteness of the Polish translation.)

Benno

--------------eOOpBzguHJu2puLZ306DoTIU--

--------------BdWh5Q4GWLU11PXamWvh0l80
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEEv9AJBh5TUFKtDfIVDSjU0qCs6IQFAmIt1IMFAwAAAAAACgkQDSjU0qCs6IR7
4Q/+Npb8Gd3ggqZNFeNoykUs8lmFD1J3pWPY2vlbHit+W0vdstG7f3Ds3kOHaghX+HII2xpfOSN3
GO5hhtWocxmawiyam4S9ofRgRMjJE9Dg7d9HgvXS7YT3iXNYBYH05HbhtraMGYbN/68GaG+wYMFC
X0SokUkDN3OhCfbZvRo4ijh1jJnOk19B7sn3MYd2JeQiuP5PsWF1Psdjn/43+fFU2XgZHpWGs3jb
EZezYH+I+iDfPQkHUqHXcMRI0hzlziXcZgQIUyU50G0Tcm1aMkIoFKi5nSFEJSHp+cdIXZP9brtf
+yrCNWmSWce1c1qCw5WVJ18g2ZokFq4Ik15tGKLMhGHYrzA0OLkniska0zTv5eg9aMAZ7x7uHr2h
pu/ACDuQrEOuTL9FWe50RYUE8kY1YUzbln64M9NaG5L6/ZdoknwsMAsvTb6/bFFOUupEywBs5+Et
ThM8qt6efwsX0J+t0SRkvo3m9nPPL8Z3xknaWpPRKhQ9v35nzferf02dTONyoZjDLwXRVJP5+Cw7
fqMxig2GGYzujIw5BTI9TXrpcWIh+zB+6XDBcjnhDRxBxzs1ga6Xd/RtOgd2gvm7bklhMJbM12kZ
wZ2tY0PhMUow9m0rF6nNDGw0tB8sgMacI4mVVMbDI7xWdCcgWVZWt0kvqcDSnAX8xXzH3kaWfR+a
yew=
=0AeB
-----END PGP SIGNATURE-----

--------------BdWh5Q4GWLU11PXamWvh0l80--
