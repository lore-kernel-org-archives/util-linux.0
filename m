Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC794C433E0
	for <util-linux@archiver.kernel.org>; Thu, 24 Dec 2020 01:15:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC56922517
	for <util-linux@archiver.kernel.org>; Thu, 24 Dec 2020 01:15:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgLXBPk (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 23 Dec 2020 20:15:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:48854 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728128AbgLXBPk (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Wed, 23 Dec 2020 20:15:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1608772453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type;
        bh=N4CqOjyH9b2AalVrjLCMZM6RJvLEOuuH6qVcZNTVt4A=;
        b=EmneHkpZHSLfR+/tdubay4ss3a7/34VfwZZyT9BGfYf1uaA9gatIZvW53boOQT0pJV+2a0
        HIXn/AmgAtUDmmpX8h7py/sO4FQgqGegOVt1+mPfzsxd38vywfufpQkINVrSAz88j+oOd2
        Grc7gwrUnWVGiOv+SrY68Qd1VLymcQA=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-bV3l-TZvNqikxeRO0W-T2A-1; Wed, 23 Dec 2020 20:14:11 -0500
X-MC-Unique: bV3l-TZvNqikxeRO0W-T2A-1
Received: by mail-pl1-f197.google.com with SMTP id 98so427310pla.12
        for <util-linux@vger.kernel.org>; Wed, 23 Dec 2020 17:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:message-id:date:user-agent
         :mime-version;
        bh=N4CqOjyH9b2AalVrjLCMZM6RJvLEOuuH6qVcZNTVt4A=;
        b=mtXvlkh/jnrZuS29hLGZeum2cXeAqfJ/jvMM/8NDh6h44hsrxiGrG9u0FTmgswx5nq
         tEoCAzK9OAqn/gumrcEKB94B6S75f92uEa6OT9+JQq6shVLQBt+RC0qlL45YOba4hbzF
         CpA3mKLuIwKg2oOdfPv1OffRKKoLHbeHPDYjZJ0hwc0Zz0CRlijyLOAA7hGXJneEYORj
         lmgwIZcuuSGUnO5qguuSe4QQXR61dylejpk5N2ckD9rlQp3aC3pTKE0aCwh0kcjCUcNX
         KruW7V2shqiBnjEp+eJsFjk09ZTNoZ5BRm/EP/FASM6EZHpmLtQAThvDmgh3Hi0ikV6B
         Tlsg==
X-Gm-Message-State: AOAM533J7vTj2z/PzVssctUMan9f5Re+kxxrLwKmro8DAkNRFtgXuzxK
        55GJmLrqL3QxNWzD/knzRY8MizW36rdfDIDkL8PVi8O95zTjWGNNAfWx/ByWU27oFWXfl11LnJy
        rJY8Ukojq+L+SVb5vApK3sg==
X-Received: by 2002:a17:90a:46c2:: with SMTP id x2mr2090362pjg.15.1608772450317;
        Wed, 23 Dec 2020 17:14:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwCKC6ENrXa0h1afZfeJh8GCeyvoxMfLvVbJA9jpycnFAzqW0+b78Dxqk1I9TQRqOSoc/MpiA==
X-Received: by 2002:a17:90a:46c2:: with SMTP id x2mr2090346pjg.15.1608772450054;
        Wed, 23 Dec 2020 17:14:10 -0800 (PST)
Received: from solaris.milky.way ([118.209.30.19])
        by smtp.gmail.com with ESMTPSA id n4sm24486795pfu.150.2020.12.23.17.14.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Dec 2020 17:14:08 -0800 (PST)
From:   David O'Brien <daobrien@redhat.com>
To:     util-linux@vger.kernel.org
Subject: Bug in lsblk command or man page?
Message-ID: <ed3332cf-794f-b0d3-caca-16fb65dfd5ac@redhat.com>
Date:   Thu, 24 Dec 2020 11:14:04 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="8dxUdkdzsEVnoO2DSCKwel1c0cEvdsUMt"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--8dxUdkdzsEVnoO2DSCKwel1c0cEvdsUMt
Content-Type: multipart/mixed; boundary="5h7qVfUQLG35Lyxx2pjWrn1XYtadTquuK";
 protected-headers="v1"
From: David O'Brien <daobrien@redhat.com>
To: util-linux@vger.kernel.org
Message-ID: <ed3332cf-794f-b0d3-caca-16fb65dfd5ac@redhat.com>
Subject: Bug in lsblk command or man page?

--5h7qVfUQLG35Lyxx2pjWrn1XYtadTquuK
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I don't know if this is expected or not, but it seems very odd:

# lsblk -o=3DUUID /stratis/labpool/labfs
lsblk: unknown column: =3DUUID

[root@serverb ~]# lsblk -o UUID /stratis/labpool/labfs
UUID
0118efb8-66fe-406a-837c-725961bdad4d

[root@serverb ~]# lsblk --output=3DUUID /stratis/labpool/labfs
UUID
0118efb8-66fe-406a-837c-725961bdad4d


=46rom the man(8) page:
-o, --output list
              Specify which output columns to print.  Use --help to get
              a list of all supported columns.  The columns may affect
              tree-like output.  The default is to use tree for the
              column 'NAME' (see also --tree).

              The default list of columns may be extended if list is
              specified in the format +list (e.g., lsblk -o +UUID).

There is no mention of "=3D" being required, causing failures, etc. I fou=
nd this quite frustrating.

I'm on Fedora 32.

Thanks.
--=20
David
Introvert/Unclubbable/Cool

Red Hat's core values are freedom, courage, commitment, and accountabilit=
y.


--5h7qVfUQLG35Lyxx2pjWrn1XYtadTquuK--

--8dxUdkdzsEVnoO2DSCKwel1c0cEvdsUMt
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEygp1l6BPbI+4B6BYZuPTn0fqi0wFAl/j61wFAwAAAAAACgkQZuPTn0fqi0xv
cgf+M8Gzqz8YSWN5Y70+GQJqSrfvG4qzeCYBgxI32cwRdJDY42PwORksYk04U+IQf4mHDfI7pb4W
JZwd8g7GXpEy9GhTbscRQbBBHeU4pR9G8+CBT1sXXT+avun4X04m9KLjhs8dLLcAS/PRhHkMLX3Y
cRi7I9KnS6b1u7bvaUHze0BAR7gU2Pe3J3Dn4JVn6QrG0v0xslhMQRFK8fKmdWMAxs7n0GYVwW6b
VqWXwz0Nz49SSYJ0uNo+Q4ZQlDCowbhiHXcIirPdbZMG/e6ZqTtneR8ogilK38SlqsiLj5dxx+Tp
l1LxcYkFui3aiuzcBjq9buG/KhHUcdC1Ys3qRQPrdg==
=lY8Q
-----END PGP SIGNATURE-----

--8dxUdkdzsEVnoO2DSCKwel1c0cEvdsUMt--

