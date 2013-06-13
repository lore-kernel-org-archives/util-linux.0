Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:55956 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756999Ab3FMNkG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 13 Jun 2013 09:40:06 -0400
Received: by mail-wg0-f45.google.com with SMTP id j13so2757469wgh.24
        for <util-linux@vger.kernel.org>; Thu, 13 Jun 2013 06:40:04 -0700 (PDT)
Message-ID: <51B9CBB1.90703@gmail.com>
Date: Thu, 13 Jun 2013 15:40:01 +0200
From: Gabriel de Perthuis <g2p.code@gmail.com>
MIME-Version: 1.0
To: Karel Zak <kzak@redhat.com>
CC: util-linux <util-linux@vger.kernel.org>,
        Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: PTUUID and PARTUUID (was: [PATCH v3] libblkid: print PTUUID,
 the partition table uuid)
References: <51B217E4.1000800@gmail.com> <20130613133035.GA22795@x2.net.home>
In-Reply-To: <20130613133035.GA22795@x2.net.home>
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Le jeu. 13 juin 2013 15:30:35 CEST, Karel Zak a écrit :
> On Fri, Jun 07, 2013 at 07:27:00PM +0200, Gabriel de Perthuis wrote:
>> ---
>> v3: Call it ID_PART_TABLE_UUID in udev rules
>
> I have applied a little bit different version. Anyway, you have to
> modify udevd to make it usable with in built-in blkid. It also
> exports MBR ID (so the change is not GPT specific) as partition
> table pseudo UUID. Examples:
>
>  # blkid -p -o udev /dev/sda
>  ID_PART_TABLE_UUID=3549290f-417c-4941-8503-f7835109b821
>  ID_PART_TABLE_TYPE=gpt
>
>  # blkid -p -o udev /dev/sdb
>  ID_PART_TABLE_UUID=54e743a7
>  ID_PART_TABLE_TYPE=dos
>
>
> Note that I have also add support for Dos partitions pseudo-uuids. The
> implementation is compatible with Linux kernel root=PARTUUID= command
> line option.

v1 of the patch had those MBR ids, I deliberately removed them in v2
because they weren't unique on the disks I had.
Calling those UUIDs will create false expectations.

> The PARTUUID for Dos partitions is based on MBR Id and partition number,
> for example:
>
>   # blkid /dev/sdb1
>   /dev/sdb1: TYPE="ext2" PARTUUID="54e743a7-01" 
>
> is the first partition on disk with PTUUID=54e743a7. So you can use
>
>   # mount PARTUUID="54e743a7-01" /mnt/test
>
>     Karel
