Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f46.google.com ([209.85.215.46]:56718 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751095Ab2JVQdI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Oct 2012 12:33:08 -0400
Received: by mail-la0-f46.google.com with SMTP id h6so1734615lag.19
        for <util-linux@vger.kernel.org>; Mon, 22 Oct 2012 09:33:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20121022142813.GD21724@x2.net.home>
References: <CAFSEfh2myyk98cZWRU149rUAm+1e7DiAKxsUU=jBxb5ZNoLABA@mail.gmail.com>
	<20121022142813.GD21724@x2.net.home>
Date: Mon, 22 Oct 2012 22:03:06 +0530
Message-ID: <CAFSEfh3oz2HpUPEtgCNZCvcBFxUbBGPnL48BOUm799kpv8z5wQ@mail.gmail.com>
Subject: Re: libblkid: newbie question about enabling whole disk sysfs probe
From: Venkatraman S <venkat@linaro.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi Karel,
On 22 October 2012 19:58, Karel Zak <kzak@redhat.com> wrote:
> On Mon, Oct 22, 2012 at 06:15:57PM +0530, Venkatraman S wrote:
>>        blkid_probe_enable_topology(pr, 1);
>
> This is strings based interface (NAME=value). It's probably
> better to use:
>
>    tp = blkid_probe_get_topology(pr);
>
>    blkid_topology_get_alignment_offset(tp);
>
> see libblkid/samples/topology.c.
>
>
>> I am able to get to the property value (which is set from the sysfs
>> value for the disk).
>>
>> But when mkswap is invokded with /dev/sdbX, then sysfs_probe is not
>> able to discover the parent disk's sysfs property.
>
> Really? It should be able to translate the partition name to the
> whole-disk name and us it.
>
> # ./sample-topology /dev/sdd1
> ----- binary interface:
>         alignment offset     : 0
>         minimum io size      : 4096
>         optimal io size      : 262144
>         logical sector size  : 4096
>         physical sector size : 4096
> ----- NAME=value interface (values: 4):
>         MINIMUM_IO_SIZE = 4096
>         OPTIMAL_IO_SIZE = 262144
>         PHYSICAL_SECTOR_SIZE = 4096
>         LOGICAL_SECTOR_SIZE = 4096
>
I understand. I assume this works because each of these are present in both
/sys/block/sda/ and /sys/block/sdaX/. But I am seeking a new property
(for which I have already coded the appropriate lookup hooks in topology.c)
The property (device/preferred_erase_size is present usually in eMMC
and SD cards,
 and not regular hard disks, and it only present in the root device node sysfs

I think it would be easier for you after looking at the patches that I
already have
(crude with lots of hacks and debug). I'll post them now

>
>
>> Any help would be great.
>
>  What exactly is your goal?
>

My objective is to implement / experiment some of the ideas that were bounced
around in kernel mailing list for optimizing swap on flash media [1]
[2] and make compatible
changes in both kernel and mkswap.
The changes revolve around embedding useful information in swap header that the
kernel can use to optimize it's swap algorithm.

[1] https://lkml.org/lkml/2012/3/30/410
[2] http://thread.gmane.org/gmane.linux.kernel.mmc/14864
