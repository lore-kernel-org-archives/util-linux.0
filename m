Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f67.google.com ([209.85.218.67]:38768 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752423AbdHBIlx (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 2 Aug 2017 04:41:53 -0400
Received: by mail-oi0-f67.google.com with SMTP id s21so4978511oie.5
        for <util-linux@vger.kernel.org>; Wed, 02 Aug 2017 01:41:53 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170802083748.ui36mn4lvpdbgrt2@ws.net.home>
References: <CACna6rwn+Kf+DCqRS_TQTdv5WakGCNaEqQgc3QwibuyV3KM5=A@mail.gmail.com>
 <20170802083748.ui36mn4lvpdbgrt2@ws.net.home>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Wed, 2 Aug 2017 10:41:52 +0200
Message-ID: <CACna6rzCrVjXrzCWKrzhKHkCYQBZ45zgFMqkFy=5oEG4UOh3Dg@mail.gmail.com>
Subject: Re: libblkid: broken calculation of blkid_probe size for ubiN_M
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 2 August 2017 at 10:37, Karel Zak <kzak@redhat.com> wrote:
> On Tue, Aug 01, 2017 at 03:25:40PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
>> Today I discovered libblkid can't recognize my UBI volume with ubifs
>> filesystem. The code in libblkid/src/superblocks/ubifs.c seems
>> alright, but it's never used because of:
>> # LIBBLKID_DEBUG=3Dlowprobe,buffer blkid /dev/ubi0_0
>> (...)
>> 4166: libblkid: LOWPROBE: [59] ubifs:
>> 4166: libblkid:   BUFFER:         ignore: request out of probing area
>>
>> Above error comes from blkid_probe_get_buffer and its
>> pr->off + pr->size < real_off + len
>> condition. In my case its evaulated as:
>> 0 + 1 < 0 + 4
>> (pr->size is 1 which looks wrong obviously).
>
> Version? Is it the current git master branch?
>
> I fixed something like this two weeks ago:
>
>         commit 4360f56cf6e40b10ab6ace4cf74073de2381c192
>         Author: Karel Zak <kzak@redhat.com>
>         Date:   Tue Jul 11 12:17:40 2017 +0200
>
>             libblkid: don't check for size on UBI (char dev)
>
>             Signed-off-by: Karel Zak <kzak@redhat.com>
>
>  and now the condition is not used for char devices:
>
>     if (len =3D=3D 0 || (!S_ISCHR(pr->mode) && pr->off + pr->size < real_=
off + len))

Sorry for missing that info. I was testing & debugging with 2.29.2.
I'll give your commit a try, thanks!

--=20
Rafa=C5=82
