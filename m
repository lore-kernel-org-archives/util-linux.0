Return-Path: <SRS0=mE6B=CX=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B03CCC43461
	for <util-linux@archiver.kernel.org>; Mon, 14 Sep 2020 11:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57ED8208DB
	for <util-linux@archiver.kernel.org>; Mon, 14 Sep 2020 11:27:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A/V5veKU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgINL1N (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Mon, 14 Sep 2020 07:27:13 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29613 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726071AbgINL0z (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Mon, 14 Sep 2020 07:26:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600082811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TOXrypTm/1CcHK36v5bCcrH7BFm5K/kV5/6BRiwuBuU=;
        b=A/V5veKUP7tykcJGSbOrdXCrWpSnTR1nGtr80r0KTILAzl9Bd2GcF+LAPc/PdUHJlIg215
        0TSxFBgRA+1ZBsRRkkWo0+FM2buAslxmfFwL9oQ5C078yBfkqoV8Mug/Qx3YpXvdxegDYA
        5QvB+O/HQ2cGywuiwK4rYBqmEEOnhDc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-xEcAF5iHN_66oGiq38z0gA-1; Mon, 14 Sep 2020 07:26:36 -0400
X-MC-Unique: xEcAF5iHN_66oGiq38z0gA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 542AA802B7B;
        Mon, 14 Sep 2020 11:26:35 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.69])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 94B6C60CD1;
        Mon, 14 Sep 2020 11:26:34 +0000 (UTC)
Date:   Mon, 14 Sep 2020 13:26:31 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Emmanuel Kasper <manu@debian.org>
Cc:     util-linux@vger.kernel.org
Subject: Re: libblk / blkid not recognizing Atari FAT16 variation
Message-ID: <20200914112631.2va62jdzgalywiyb@ws.net.home>
References: <c8bd78fd-85c8-4851-b2a6-e836d0d2a389@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8bd78fd-85c8-4851-b2a6-e836d0d2a389@debian.org>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Fri, Sep 11, 2020 at 06:00:25PM +0200, Emmanuel Kasper wrote:
>   truncate --size 64M fs.img
>   mkfs.fat -A fs.img # -A for Atari variant
>   blkid fs.img # nothing
> 
> (a real disk image with partitions can also be downloaded here
> https://subsole.org/st_mint )
> 
> However fsck, and kernel can check and mount this partition.
> The kernel detects properly the fat when mounting a block device,
> without having to force the filesystem on the command line.
> 
> From this doc about the Atari fat format,
> info-coach.fr/atari/documents/_mydoc/Atari_HD_File_Sytem_Reference_Guide.pdf
> 
> I see on page 9
> that the main differences between MS DOS and Atari FAT, is about the fat
> logical sector size,
> which can goes over 512 bytes in the Atari FAT, whereas in MSDOS FAT it
> is always 512 bytes.

This is not the issue. 

The problem is that Atari FAT does not contain any magic string. There
is also missing MBR signature (0x55 0xAA) which is used for old FAT
floppies without magic strings. So, libblkid completely ignores stuff
on the device ...

If I add the first bytes from the device as magic string to libblkid
and disable MBR signature check than the rest of the verification
pass. 

Note that "`.mkdosf" from the begin of the device is mkfs
specific stuff it's probably bad idea use it as a regular magic string.

It's also pretty fragile to avoid magic strings at all in this case,
because something-like-FAT is pretty common used by many random media.

Frankly, it seems better to force Atari users to use "vfat" in the
fstab :-)

BTW, the old good file(1) returns nothing for the Atari FAT too.

    Karel


See Atari FAT (mkfs.fat -A):

$ hexdump -C fs.img
00000000  60 1c 6d 6b 64 6f 73 66  a1 0c 36 00 08 02 01 00  |`.mkdosf..6.....|
00000010  02 00 02 00 80 f8 10 00  20 00 40 00 00 00 00 00  |........ .@.....|
00000020  00 00 00 00 80 00 00 00  00 00 00 00 00 00 00 00  |................|
00000030  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000800  f8 ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000810  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00008800  f8 ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00008810  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
04000000


and now regular FAT16 (mkfs.vfat -F 16):

hexdump -C fs.img
00000000  eb 3c 90 6d 6b 66 73 2e  66 61 74 00 02 04 04 00  |.<.mkfs.fat.....|
00000010  02 00 02 00 00 f8 80 00  20 00 40 00 00 00 00 00  |........ .@.....|
00000020  00 00 02 00 80 00 29 1b  d0 9c a3 4e 4f 20 4e 41  |......)....NO NA|
00000030  4d 45 20 20 20 20 46 41  54 31 36 20 20 20 0e 1f  |ME    FAT16   ..|
00000040  be 5b 7c ac 22 c0 74 0b  56 b4 0e bb 07 00 cd 10  |.[|.".t.V.......|
00000050  5e eb f0 32 e4 cd 16 cd  19 eb fe 54 68 69 73 20  |^..2.......This |
00000060  69 73 20 6e 6f 74 20 61  20 62 6f 6f 74 61 62 6c  |is not a bootabl|
00000070  65 20 64 69 73 6b 2e 20  20 50 6c 65 61 73 65 20  |e disk.  Please |
00000080  69 6e 73 65 72 74 20 61  20 62 6f 6f 74 61 62 6c  |insert a bootabl|
00000090  65 20 66 6c 6f 70 70 79  20 61 6e 64 0d 0a 70 72  |e floppy and..pr|
000000a0  65 73 73 20 61 6e 79 20  6b 65 79 20 74 6f 20 74  |ess any key to t|
000000b0  72 79 20 61 67 61 69 6e  20 2e 2e 2e 20 0d 0a 00  |ry again ... ...|
000000c0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
00000200  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00000800  f8 ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00000810  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
00010800  f8 ff ff ff 00 00 00 00  00 00 00 00 00 00 00 00  |................|
00010810  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
*
04000000



> 
> fsck.vfat -v fs.img
> fsck.fat 4.1 (2017-01-24)
> Checking we can access the last sector of the filesystem
> Boot sector contents:
> System ID "kdosf"
> Media byte 0xf8 (hard disk)
>       2048 bytes per logical sector <---- more than 512 bytes
> 
> 
> However after a quick glance on the code in fat_valid_superblock()
> at
> https://github.com/karelzak/util-linux/blob/master/libblkid/src/superblocks/vfat.c#L218
> 
> it seems to me that libblk should would work with sectors up to 4096
> bytes, so I am bit puzzled.
> Any pointers on what could be missing here ?
> 
> Manu
> 
> 
> -- 
> You know an upstream is nice when they even accept m68k patches.
>   - John Paul Adrian Glaubitz, Debian OpenJDK maintainer
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

