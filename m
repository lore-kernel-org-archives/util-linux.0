Return-Path: <util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A480BC433DB
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 14:10:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 703C520770
	for <util-linux@archiver.kernel.org>; Tue,  5 Jan 2021 14:10:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbhAEOKi (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 5 Jan 2021 09:10:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53711 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726597AbhAEOKh (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 5 Jan 2021 09:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1609855750;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=i00onFSaX3GwlAqAsZwwgGDN7DL4AV8pQuAzGcJfp4c=;
        b=CYYxLtQp/4Vu75DIlUlxCrui5nFIEpTlnlUn8+13UYH4on5tCb6Y9C+pO/nus5GYQjMj4v
        6QMRFxpiplRDuam//DObow7sXmbfJ6tx2WKa47Djaedp3WAdPqMq5mETAq2VtItRJYvZCv
        cm9Wkf2C32cVIzaub4Mi9UyLgC5lcaI=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-7FB8N3w6Oly0x7AUq25OVA-1; Tue, 05 Jan 2021 09:09:08 -0500
X-MC-Unique: 7FB8N3w6Oly0x7AUq25OVA-1
Received: by mail-pg1-f200.google.com with SMTP id y2so24101015pgq.23
        for <util-linux@vger.kernel.org>; Tue, 05 Jan 2021 06:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to;
        bh=i00onFSaX3GwlAqAsZwwgGDN7DL4AV8pQuAzGcJfp4c=;
        b=JwA/3j89jd4K8dVTfmMUBwjXuKeDGbUyjdu5pt4Ww6rcuu8XBgT1GekM8FtYcopjSM
         e7X+Usm6w9+Q1SaAZKKaa9sGyiY4iOgQtQtFj9z8ywxNcHMbGdpzVTwkYkQBP/a5sJC7
         /lt6EP1MRDQAPmT3SwKhCPKO41Qt4LgC4vkuxlz7xsLxBR4SHqBzC8xDxYORy7txx2vV
         3Cq04xUAaGrh6ZHK6nJkig0swxX1/u0mSSJnoa88dcEb5kCn+6YaEWnLAqCbGASOwL1t
         HPgV80nv/53B6b76LJOOqK/7xj+sxtWQ9LScs9kAwT73T3m/xuXW9yFh0tTUv8X+NqC3
         ZSMA==
X-Gm-Message-State: AOAM530czSk8p6t0OXA/qSEduU1tbO+88TjW5NzYIcil9+4OOVU8dvw1
        aSrXhFuXf+OwUvqAUUvPUduANcbSnrwGCGV7X2XqYV2KKEsBGqhWRuMt6MCd5nQCzQzlGszxCs2
        qJpk2w7oTOkcynvOPYIrRoQ==
X-Received: by 2002:a17:90a:13c8:: with SMTP id s8mr4351520pjf.6.1609855747557;
        Tue, 05 Jan 2021 06:09:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzXbg6iMlFVIApi+D/OA3BkTNuOH1cer82Fpu0WYhOSr0KcFYXvG3gutgohyoW5nzk9fk5XJw==
X-Received: by 2002:a17:90a:13c8:: with SMTP id s8mr4351494pjf.6.1609855747219;
        Tue, 05 Jan 2021 06:09:07 -0800 (PST)
Received: from solaris.milky.way ([118.209.2.28])
        by smtp.gmail.com with ESMTPSA id ck20sm2953934pjb.20.2021.01.05.06.08.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jan 2021 06:09:00 -0800 (PST)
Subject: Re: Bug in lsblk command or man page?
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <ed3332cf-794f-b0d3-caca-16fb65dfd5ac@redhat.com>
 <20210105102730.w5qxkr3qg353evlr@ws.net.home>
From:   David O'Brien <daobrien@redhat.com>
Message-ID: <c04e1ccc-4053-bb3e-3479-512f263f679e@redhat.com>
Date:   Wed, 6 Jan 2021 00:08:54 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.0
MIME-Version: 1.0
In-Reply-To: <20210105102730.w5qxkr3qg353evlr@ws.net.home>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="5O1lLcF685LTvdQgdUAJtJa9sptfpS7Cq"
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--5O1lLcF685LTvdQgdUAJtJa9sptfpS7Cq
Content-Type: multipart/mixed; boundary="mmJRxBIEWtqQOC5Y1FsWRniLtO9VS7GXy";
 protected-headers="v1"
From: David O'Brien <daobrien@redhat.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Message-ID: <c04e1ccc-4053-bb3e-3479-512f263f679e@redhat.com>
Subject: Re: Bug in lsblk command or man page?
References: <ed3332cf-794f-b0d3-caca-16fb65dfd5ac@redhat.com>
 <20210105102730.w5qxkr3qg353evlr@ws.net.home>
In-Reply-To: <20210105102730.w5qxkr3qg353evlr@ws.net.home>

--mmJRxBIEWtqQOC5Y1FsWRniLtO9VS7GXy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/5/21 8:27 PM, Karel Zak wrote:
> On Thu, Dec 24, 2020 at 11:14:04AM +1000, David O'Brien wrote:
>> I don't know if this is expected or not, but it seems very odd:
>>
>> # lsblk -o=3DUUID /stratis/labpool/labfs
>> lsblk: unknown column: =3DUUID
>>
>> [root@serverb ~]# lsblk -o UUID /stratis/labpool/labfs
>> UUID
>> 0118efb8-66fe-406a-837c-725961bdad4d
>>
>> [root@serverb ~]# lsblk --output=3DUUID /stratis/labpool/labfs
>> UUID
>> 0118efb8-66fe-406a-837c-725961bdad4d
>>
>>
>> From the man(8) page:
>> -o, --output list
>>               Specify which output columns to print.  Use --help to ge=
t
>>               a list of all supported columns.  The columns may affect=

>>               tree-like output.  The default is to use tree for the
>>               column 'NAME' (see also --tree).
>>
>>               The default list of columns may be extended if list is
>>               specified in the format +list (e.g., lsblk -o +UUID).
>>
>> There is no mention of "=3D" being required, causing failures, etc. I =
found this quite frustrating.
>>
>=20
> This is common getopt_long() behavior where equal sign is usable only f=
or
> long options (and sometimes for optional arguments).
>=20
>  lsblk -o UUID
>  lsblk --output UUID
>  lsblk --output=3DUUID
>=20
> this is how "=3D" works in almost all commands and I don't see reason
> why we need to be explicit about it for "lsblk -o".
>=20
>     Karel
>=20
ok. If it's common and expected that's fine. I don't spend a lot of time =
with this class/type of command and it was just
new to me and seemed odd.

cheers
--=20
David
Introvert/Unclubbable/Cool

Red Hat's core values are freedom, courage, commitment, and accountabilit=
y.


--mmJRxBIEWtqQOC5Y1FsWRniLtO9VS7GXy--

--5O1lLcF685LTvdQgdUAJtJa9sptfpS7Cq
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEygp1l6BPbI+4B6BYZuPTn0fqi0wFAl/0cvYFAwAAAAAACgkQZuPTn0fqi0zR
1Af/aeykytS5RKQ468IHD27bNJgYt9WBzN9FARawi5raC7kP6J8nU6XJ2QfiEPglYdlx7pTJZH4g
X6RVNSEA2te2/of+yzJFQ+wBWu4jPuorEvq7J9nb5p7iODGuSeW6wj/oEuvWha9/pZP2FkFKVUuh
5DP+rjaQqko6dyWVslVRr0Tgv7dPbFg6TPgePpfmz1nKmJpSDIvXlHF8UPF8S3nvkAkqYKIeRjN3
tRHit/AYbKt9UtAI2k8VOHuGjtQ+n3cDa6B72Fd1HN1Acr3EnRKHHgWjTe0UhdFm4fDT3dlgJsDq
Oh3p0LPiwvx2/RcBr2xQToLTXHDRn78EgoYM1fpK9g==
=NmxD
-----END PGP SIGNATURE-----

--5O1lLcF685LTvdQgdUAJtJa9sptfpS7Cq--

