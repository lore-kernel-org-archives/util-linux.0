Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35823 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751013AbdAWNcE (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 23 Jan 2017 08:32:04 -0500
Received: by mail-wm0-f65.google.com with SMTP id d140so26526932wmd.2
        for <util-linux@vger.kernel.org>; Mon, 23 Jan 2017 05:32:04 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <3425316c-b457-daea-58f9-8e0d9dacf417@wdc.com>
References: <1484816545-28033-1-git-send-email-shaun@tancheff.com> <3425316c-b457-daea-58f9-8e0d9dacf417@wdc.com>
From: Shaun Tancheff <shaun@tancheff.com>
Date: Mon, 23 Jan 2017 20:32:02 +0700
Message-ID: <CAJ48U8VKAmFpK6Cb=UgpYrt4kteS13amwP2iMtJvaMBPEHTuiA@mail.gmail.com>
Subject: Re: [PATCH] Add blkzonecmd and blkreport ZAC/ZBC drives
To: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Karel Zak <kzak@redhat.com>, util-linux@vger.kernel.org,
        Bart Van Assche <bart.vanassche@sandisk.com>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jan 23, 2017 at 2:38 PM, Damien Le Moal <damien.lemoal@wdc.com> wro=
te:
> Shaun,
>
> On 1/19/17 18:02, Shaun Tancheff wrote:
>> +++ b/sys-utils/blkreset.c
>> @@ -0,0 +1,192 @@
>> +/*
> [...]
>> +
>> +     if (ioctl(fd, BLKGETSIZE64, &blksize))
>> +             err(EXIT_FAILURE, _("%s: BLKGETSIZE64 ioctl failed"), path=
);
>> +
>> +     blksectors =3D blksize << 9;
>
> blksize being in bytes here, it looks like the shift is in the wrong
> direction here... i.e.
>
> blksectors =3D blksize >> 9;

Good catch!

Reposting with Karel's suggestion to use blkdev_get_sectors().

Thanks!

>> +
>> +     /* check offset alignment to the chunk size */
>> +     if (zsector & (zsize - 1))
>> +             errx(EXIT_FAILURE, _("%s: zone %" PRIu64 " is not aligned =
"
>> +                      "to zone size %" PRIu64), path, zsector, zsize);
>> +     if (zsector > blksectors)
>> +             errx(EXIT_FAILURE, _("%s: zone %" PRIu64 " is too large "
>> +                      "for device %" PRIu64), path, zsector, blksectors=
);
>> +
>> +     zlen =3D zcount * zsize;
>> +     if (zsector + zlen > blksectors)
>> +             zlen =3D blksectors - zsector;
>> +
>> +     za.sector =3D zsector;
>> +     za.nr_sectors =3D zlen;
>> +     rc =3D ioctl(fd, BLKRESETZONE, &za);
>> +     if (rc =3D=3D -1)
>> +             err(EXIT_FAILURE, _("%s: BLKRESETZONE ioctl failed"), path=
);
>> +
>> +     close(fd);
>> +     return EXIT_SUCCESS;
>> +}
>>
>
> Best regards.
>
> --
> Damien Le Moal, Ph.D.
> Sr Manager, System Software Research Group,
> Western Digital
> Damien.LeMoal@hgst.com
> Tel: (+81) 0466-98-3593 (Ext. 51-3593)
> 1 kirihara-cho, Fujisawa, Kanagawa, 252-0888 Japan
> www.wdc.com, www.hgst.com
> Western Digital Corporation (and its subsidiaries) E-mail Confidentiality=
 Notice & Disclaimer:
>
> This e-mail and any files transmitted with it may contain confidential or=
 legally privileged information of WDC and/or its affiliates, and are inten=
ded solely for the use of the individual or entity to which they are addres=
sed. If you are not the intended recipient, any disclosure, copying, distri=
bution or any action taken or omitted to be taken in reliance on it, is pro=
hibited. If you have received this e-mail in error, please notify the sende=
r immediately and delete the e-mail in its entirety from your system.
>
