Return-Path: <SRS0=I2d6=MY=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A14AC6786C
	for <util-linux@archiver.kernel.org>; Fri, 12 Oct 2018 14:35:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 501F620835
	for <util-linux@archiver.kernel.org>; Fri, 12 Oct 2018 14:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cardoe.com header.i=@cardoe.com header.b="aKcDyIRk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 501F620835
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cardoe.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbeJLWIF (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 12 Oct 2018 18:08:05 -0400
Received: from mail-yw1-f68.google.com ([209.85.161.68]:34661 "EHLO
        mail-yw1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbeJLWIF (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 12 Oct 2018 18:08:05 -0400
Received: by mail-yw1-f68.google.com with SMTP id m129-v6so5034825ywc.1
        for <util-linux@vger.kernel.org>; Fri, 12 Oct 2018 07:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cardoe.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LU0N/XInQ/mFrdL1SeyvFAiOzPiGsQrqDpcXIg8YdaY=;
        b=aKcDyIRkm3x9PqQsf4NHwYt0ZQxTM7MwnwbfoYbj8J5cZyu7fJpIpL7nEr66w2LCU8
         0Rkz4v4Hgo8qCAUYnmRh+3Znbv7AjFFv41PmOuKOyKswAb54N2lOIyrk2QaXiEArtdH4
         g4XQHSsvTEeB+QL5T9c8X2SGrxAsqsvaUxB/g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=LU0N/XInQ/mFrdL1SeyvFAiOzPiGsQrqDpcXIg8YdaY=;
        b=k1CwgYYwh0bCz5APnQF9keJD6BA+AHtuDsqDbZMWJ6lbfHpGTM5jgzGqn/ZfFaoHHN
         q/xjHb+7gRJAp7ONDy8YUZ+XNfdcv9HrNRgCaY9WHJxr/96ZLPqxqOcgiUKFFvYPQS2h
         LXpVBcZurA6JfIYEsn64LwewJPA4NuGP8aSdaetueLrojU4DWE/hqJMED6L3H/2AOgj6
         9M9NMQL8GDUhnaGqGWMWhdl6blCY5yDg7gpYYMxNj8Z1SwZ2F9csQkqRU5qqdxt/afSf
         3bOPnuxN6yYfaJG6Auj5MCbfXay+zBy+/5K7+CejG42m3jQ9TM4ZOxq5X0Yfl/zNSt6f
         uR/A==
X-Gm-Message-State: ABuFfohsg8gVaw00gZz7QCsGkVg+pZ11+71+xLUOmvuDfEZWTzKre8Vv
        4Rr8ztREaU+++Xs4iQNwLwY9Rg==
X-Google-Smtp-Source: ACcGV63B3UHDdaX4hs27aKa9Izmv6bd8U8EjJDubj85VTLE9WHeUXnEDsAYmyjzsC9rLs6uufxqIfA==
X-Received: by 2002:a0d:cf05:: with SMTP id r5-v6mr3496726ywd.51.1539354921750;
        Fri, 12 Oct 2018 07:35:21 -0700 (PDT)
Received: from ?IPv6:2600:1700:7b90:52f0:845c:c03d:7907:8fd1? ([2600:1700:7b90:52f0:845c:c03d:7907:8fd1])
        by smtp.gmail.com with ESMTPSA id s187-v6sm301159ywe.10.2018.10.12.07.35.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Oct 2018 07:35:21 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: Future of dosfstools project (FAT)
From:   Doug Goldstein <cardoe@cardoe.com>
X-Mailer: iPhone Mail (16A404)
In-Reply-To: <20181012124026.3v3b6v46hpszkgrt@pali>
Date:   Fri, 12 Oct 2018 09:35:05 -0500
Cc:     Andreas Henriksson <andreas@fatal.se>,
        Jaroslav Skarvada <jskarvad@redhat.com>,
        linux-fsdevel@vger.kernel.org, util-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, mpluskal@suse.com,
        base-system@gentoo.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Karel Zak <kzak@redhat.com>, Andreas Bombe <aeb@debian.org>,
        Andreas Bombe <andreas.bombe@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Richard Weinberger <richard.weinberger@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C7878199-A18E-4FA9-A061-C6911E117A67@cardoe.com>
References: <20180929084038.an6pfhnsd6tblejl@pali> <20181002081654.jxesr3kj62snzez5@pali> <510499199.34825028.1538469850257.JavaMail.zimbra@redhat.com> <20181012091941.o22srnhse4kzqjhf@fatal.se> <20181012124026.3v3b6v46hpszkgrt@pali>
To:     =?utf-8?Q?Pali_Roh=C3=A1r?= <pali.rohar@gmail.com>
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org


> On Oct 12, 2018, at 7:40 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> wrote:=

>=20
>> On Friday 12 October 2018 11:19:41 Andreas Henriksson wrote:
>> Hello everyone,
>>=20
>>> On Tue, Oct 02, 2018 at 04:44:10AM -0400, Jaroslav Skarvada wrote:
>>> I am downstream maintainer of dosfstools in Fedora/RHEL. My personal opi=
nion
>>> with such kind of projects is that one or two years without activity doe=
sn't
>>> mean the project is dead. I don't know what happened with Andreas, but
>>> in case of no response my +1 for the GitHub fork. I think it's non offen=
sive
>>> solution which can be easily reverted if needed. Please let me know if y=
ou do it
>>=20
>> It seems Andreas is a Debian Developer (like myself), so I used the
>> debian tooling for 'missing in action' (mia-query) and it seems
>> he is occationally active (but showing obvious signs of busyness).
>>=20
>> I even found his irc nick and found him online. I told him about this
>> mailing list thread and he replied that he has been extremely busy
>> with things in his personal life lately and said he should really
>> try to find some time to catch up with things, but since he hasn't
>> replied here I thought I'd just let you know about the situation.
>> Hopefully things calms down for him soon to allow him to catch up.
>>=20
>> I hope you find a good way to handle things in the mean time. More
>> people probably need to help out reviewing incoming issues/PRs and other
>> things that can help Andreas out with the maintenance burden, but with
>> his current lack of time it might be better if someone motivated and
>> capable just forks the project on github and starts doing the
>> maintenance work in the fork. If things works out well, maybe this gives
>> Andreas confidence he can safely hand over the official maintainer role
>> to someone with more time for it (and you can 'unfork' again).
>>=20
>> Regards,
>> Andreas Henriksson
>=20
> Ok, so it would be great if somebody can help Andreas with reviewing
> opened dosfstools pull requests on github...
>=20
> https://github.com/dosfstools/dosfstools/pulls
>=20
> --=20
> Pali Roh=C3=A1r
> pali.rohar@gmail.com

Rather than fork it could he give someone access as a maintainer to the exis=
ting project?=
