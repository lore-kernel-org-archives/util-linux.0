Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34456 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751809AbdHGFkS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 7 Aug 2017 01:40:18 -0400
Received: by mail-oi0-f66.google.com with SMTP id v11so6720793oif.1
        for <util-linux@vger.kernel.org>; Sun, 06 Aug 2017 22:40:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170803122608.bpqcsfdfek3fvf26@ws.net.home>
References: <20170801140309.17646-1-zajec5@gmail.com> <20170802121418.10628-1-zajec5@gmail.com>
 <20170803122608.bpqcsfdfek3fvf26@ws.net.home>
From: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date: Mon, 7 Aug 2017 07:40:17 +0200
Message-ID: <CACna6rwPwb9WjzJor3rYf1WSJs2_NNBKR5S3Ya8YPVEk3EK7tg@mail.gmail.com>
Subject: Re: [PATCH V2] libblkid: add support for UBI superblock
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On 3 August 2017 at 14:26, Karel Zak <kzak@redhat.com> wrote:
> On Wed, Aug 02, 2017 at 02:14:18PM +0200, Rafa=C5=82 Mi=C5=82ecki wrote:
>> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>>
>> UBI is a volume management system that can be used on a raw flash
>> partition for providing multiple logical volumes. Detecting UBI
>> superblock may be useful for tools wanting to simplify or automate
>> attaching UBI.
>>
>> Please note it's not directly related to the ubifs support which is just
>> a filesystem working on top of UBI volume.
>>
>> In other words: UBI can be used on MTD partition (e.g. /dev/mtdblock0)
>> while ubifs can be used on UBI volume (e.g. /dev/ubi0_0).
>>
>> This patch adds simple code reading UBI version and unique number and
>> setting it in the blkid_probe.
>>
>> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>> ---
>> V2: Update commit message (more UBI vs. ubifs details)
>>     Pass &hdr->image_seq to the blkid_probe_sprintf_uuid
>>     Add test
>
> Applied, thanks.
>
>> +ID_FS_TYPE=3Dubi
>> +ID_FS_USAGE=3Dfilesystem
>
> This is probably not ideal. We use "RAID" flag for logic volume
> managers. The advantage is that probing is faster as it does not try
> to check for another signature when "RAID" is detected.
>
> The question is how small could be the UBI device? We don't probe for
> "RAID" on very small devices (<=3D1MiB).

UBI is responsible for bad blocks handling, so it needs enough erase
blocks (PEBs) reserved in order to work. If one's MTD partition is as
small as 1 MiB, it won't have enough of erase blocks (PEBs) [0].

There is some formula for amount of reserved blocks, like:
n_reserved =3D n_max_bad_blocks + n_internal_volumes_blocks  + 1
but basically 1 MiB is said to be too small.

Does it mean we should & we're save to switch from OTHER to the RAID?

[0] http://lists.infradead.org/pipermail/linux-mtd/2014-November/056658.htm=
l
[1] http://www.dubeiko.com/development/FileSystems/UBI/ubidesign.pdf

--=20
Rafa=C5=82
