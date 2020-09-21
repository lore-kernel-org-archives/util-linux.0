Return-Path: <SRS0=FFMN=C6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7841C43465
	for <util-linux@archiver.kernel.org>; Mon, 21 Sep 2020 16:03:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 579CD2151B
	for <util-linux@archiver.kernel.org>; Mon, 21 Sep 2020 16:03:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="TB4rK+H0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgIUQDP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 21 Sep 2020 12:03:15 -0400
Received: from mout.web.de ([217.72.192.78]:43967 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727321AbgIUQDM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 21 Sep 2020 12:03:12 -0400
X-Greylist: delayed 96773 seconds by postgrey-1.27 at vger.kernel.org; Mon, 21 Sep 2020 12:03:12 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1600704187;
        bh=nqvnyoIhFtUVXGAu7wG8/aVyar4/ul9jVj1Hzktu1j0=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date:In-Reply-To;
        b=TB4rK+H0+Vx/87SizrXWPkfSm5A7EZ+81s6eLnVreHrUck63Q5hEFdOs6LOt5RvvD
         IGSIGS9xvPIGWJ3DW3MR2EM5NfQk0zbkc0WT3O8eG7RRXKPhtSOsprDlYp8LE2Gi9u
         L5ftm5FgGfxPe2MeQ7kxv2mI3/zInMj/wi9RU5fs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from localhost ([92.252.88.59]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MVLWc-1jxoH72bfC-00YhEj; Mon, 21
 Sep 2020 18:03:07 +0200
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Cc:     <util-linux@vger.kernel.org>
Subject: Re: [PATCH 1/4] column: Optionally keep empty lines in cols/rows
 mode
From:   "Lennard Hofmann" <lennard.hofmann@web.de>
To:     "Karel Zak" <kzak@redhat.com>
Date:   Mon, 21 Sep 2020 18:00:18 +0200
Message-Id: <C5T67UMNHUQJ.GSTUR3UATWLS@archbook>
In-Reply-To: <20200921130709.zvyf4siigxrdg77p@ws.net.home>
X-Provags-ID: V03:K1:LuOVlZIcXydG0gVxorDKzlScolIrsmnWO9ZW68dG7OSB7fSpwj+
 1UA9aJjQQ5ojDAsy1oiMLQXEfUWorXu8KHV3o9/rPTrzuneoSOq32GAMw7Ot5D4zvAK88jN
 Oo7n+FGvO4lEN8CfW/KvaGPUx/XQ7GfJ7R648D7dxiU9X9cvOxPGwIsUgA+sfjmiw/KW15x
 HOm2AWct4DZ6jxcT3o3RA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:e30UP9ezr4Q=:2ZLAGgSydAWL/DeHkgYdmp
 SxtDLjMV/U7DRnHQh5AJpZurQ9MNxa8qmAtRD9vhLmGbwtJCWPLKF72sO3loHU9sLfiFxwhHi
 bFRWOS34wUxmmExt8qyBGO1bKWSs8Gez4nEZKpJzvEVqXCm8EKqfZNgUtUgK3c2RGTHSCkgq3
 59WaVDtnWc5zlkgcMjcjoOsFpbYWJgPuR9ViPjRVyi+hhLOpxNqjI7k3r2fbFzsaEVd90ftOn
 M0R5BIl1nIajDv6vX4U0f+qL/Rb2nC35OFlwd5RA/JwNP6Ad/4vQL0JW9atgU6rzWwbtISzpT
 azMhK7OmFLks6FdlwmoCK9aRyV5xMHUIrXl+FPQQmMpcuj3E9P3Q02S8I7+RlHmlFgwG2PAbw
 rzMIJ+1KgRyhNkm3lig3vMfS8UgnuQg1qM2RN+Y7yJLGinLI9nWSG31aRDNRZJL6cOq32R6zZ
 qAENAq2gwajMgr/Nl2dsZ2Z4kaI9iIXAkStNEhPInR4bQWNveeu9jUejHPgndFPo6Fz5f0XnF
 MenuO6iFH2XmgAyVNMY2Uw08MYBAf5ok7wUsKFLusnwRtlTMLHfX1vdG3r1xcatu9CI7nAIB5
 UUGCqDWbQAPKWpq7691LvzgGYo4sKU8shy8WK6mwcM9EoTu8FIz9MF6J2TofprVwNFXdoTafv
 JlnoYm0w8M3u+np4nqCVtvj3eopdZ0xTKYoCOusu7TmgX1x0qiUZCNlzuPPTGsMj/H7h31Yse
 BOlglA0Npu6SbKtqCnS+R8eCBGFZwapIQMbgoE2pbQNaSSMrckd6GqC17w97V5qpDrUe6xU8s
 CKn+Y5KYHNYx6da9nar3aFvITC5xVYqE/FNRM19nC08iD6e4oj2mA/QvC5ObnZJkd/gstysHG
 O4IYJOs9akjV5lQsASjO4IsfygylGPpE08luqSt7ghdY1UuKhcJsplHsgAeuE+Y5Fjs1qn4Ua
 sowxSPqGY+jvb8ccPufJGpvPMacfQNp3RICUCW/MRh1FBDTSBlWFp3tYq4EV6LG6Uv+YrgIOe
 SePzOgBnF6uiaGEUagM/NkhHg9YpdWVKUNQQ04eE7Eu1PPvb15EXJpNcv6GmgYEHRWgu7C08m
 DOjVn7WF+NcJmZ2EZLf6nwbOpH8cZ3u2qy9TJpmo8OQnA5qCEC9Ex80DwGxg0imhEQsIEx9Ax
 445KM+l7Q7lEMKBiQUT0LqM95sX5vG8O4OcxQk5hIHmB+IEGiB2UYofKi5XrIe6HbFfShQn0j
 8Ebppe6p3Xk/ESpvj7/KFYnThQKW9ft11Pd5KyA==
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

> It would be more robust to add also
>=20
>     ctl->nents++;
>=20
> to this function.

Agreed. I thought that would require making this ugly change

-len =3D width(ctl->ents[ctl->nents]);
+len =3D width(ctl->ents[ctl->nents - 1]);

but `len =3D width(wcs);` is much better!

I will send patch v2 that includes patches 1 to 3 with your suggestions add=
ed.

Lennard
