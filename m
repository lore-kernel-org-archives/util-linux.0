Return-Path: <SRS0=Q91q=CZ=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB7C2C43461
	for <util-linux@archiver.kernel.org>; Wed, 16 Sep 2020 17:30:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3EED222C8
	for <util-linux@archiver.kernel.org>; Wed, 16 Sep 2020 17:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgIPRaP (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 16 Sep 2020 13:30:15 -0400
Received: from mslow2.mail.gandi.net ([217.70.178.242]:58928 "EHLO
        mslow2.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727073AbgIPR3n (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Wed, 16 Sep 2020 13:29:43 -0400
Received: from relay1-d.mail.gandi.net (unknown [217.70.183.193])
        by mslow2.mail.gandi.net (Postfix) with ESMTP id 27E373AF084
        for <util-linux@vger.kernel.org>; Wed, 16 Sep 2020 16:30:31 +0000 (UTC)
X-Originating-IP: 80.110.88.233
Received: from [192.168.0.2] (80-110-88-233.cgn.dynamic.surfer.at [80.110.88.233])
        (Authenticated sender: emmanuel@libera.cc)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id ECD1F240002;
        Wed, 16 Sep 2020 16:29:08 +0000 (UTC)
Subject: Re: libblk / blkid not recognizing Atari FAT16 variation
To:     Karel Zak <kzak@redhat.com>
Cc:     util-linux@vger.kernel.org
References: <c8bd78fd-85c8-4851-b2a6-e836d0d2a389@debian.org>
 <20200914112631.2va62jdzgalywiyb@ws.net.home>
From:   Emmanuel Kasper <manu@debian.org>
Autocrypt: addr=manu@debian.org; prefer-encrypt=mutual; keydata=
 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
 hytJdg==
Message-ID: <19538f76-3870-5e8b-c26c-dd0ede2b904d@debian.org>
Date:   Wed, 16 Sep 2020 18:29:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200914112631.2va62jdzgalywiyb@ws.net.home>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Le 14/09/2020 à 13:26, Karel Zak a écrit :
> On Fri, Sep 11, 2020 at 06:00:25PM +0200, Emmanuel Kasper wrote:
>>   truncate --size 64M fs.img
>>   mkfs.fat -A fs.img # -A for Atari variant
>>   blkid fs.img # nothing
>>
>> (a real disk image with partitions can also be downloaded here
>> https://subsole.org/st_mint )
>>
>> However fsck, and kernel can check and mount this partition.
>> The kernel detects properly the fat when mounting a block device,
>> without having to force the filesystem on the command line.
>>
>> From this doc about the Atari fat format,
>> info-coach.fr/atari/documents/_mydoc/Atari_HD_File_Sytem_Reference_Guide.pdf
>>
>> I see on page 9
>> that the main differences between MS DOS and Atari FAT, is about the fat
>> logical sector size,
>> which can goes over 512 bytes in the Atari FAT, whereas in MSDOS FAT it
>> is always 512 bytes.
> 
> This is not the issue. 
> 
> The problem is that Atari FAT does not contain any magic string. There
> is also missing MBR signature (0x55 0xAA) which is used for old FAT
> floppies without magic strings. So, libblkid completely ignores stuff
> on the device ...
> 
> If I add the first bytes from the device as magic string to libblkid
> and disable MBR signature check than the rest of the verification
> pass. 
> 
> Note that "`.mkdosf" from the begin of the device is mkfs
> specific stuff it's probably bad idea use it as a regular magic string.
> 
> It's also pretty fragile to avoid magic strings at all in this case,
> because something-like-FAT is pretty common used by many random media.
> 
> Frankly, it seems better to force Atari users to use "vfat" in the
> fstab :-)
> 
> BTW, the old good file(1) returns nothing for the Atari FAT too.

indeed but disktype, available in the Debian archive, recognizes an
Atari bootable sector :)

$ curl  http://www.subsole.org/static/retrocomputing/st_mint-1.2.img.zip
| funzip > ahdi.img
$ dd if=ahdi.img of=boot.sector skip=1024 count=512 bs=1

$ disktype boot.sector

--- boot.sector
Regular file, size 512 bytes
FAT16 file system (hints score 3 of 5, ATARI ST bootable)
  Unusual sector size 4096 bytes
  Volume size 63.95 MiB (67051520 bytes, 8185 clusters of 8 KiB)

I had a look at how disktype does this internally and disktype computes
the Atari m68k specific checksum
described in https://en.wikipedia.or/wiki/Design_of_the_FAT_file_system.

see
https://sources.debian.org/src/disktype/9-10/dos.c/#L477

Now for my use case I am not actually using an Atari Computer with
Linux, but I am using removable media between an Atari and a PC.
The lack of support for the Atari FAT prevents udisks and friends to
mount the partition as an unpriviledged user via `udisksctl mount`
Also people using emulators have to do loops around to access the
content of a disk image
(https://hatari.tuxfamily.org/doc/manual.html#Moving_files_to_from_hard_disk_images)

Is that something we could consider ?

Manu
