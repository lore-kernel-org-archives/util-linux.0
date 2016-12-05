Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:47498 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751677AbcLEMCt (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 5 Dec 2016 07:02:49 -0500
Date: Mon, 5 Dec 2016 13:02:46 +0100
From: Karel Zak <kzak@redhat.com>
To: Constantine Kharlamov <hi-angel@ya.ru>
Cc: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: Re: sfdisk: -X option doesn't work
Message-ID: <20161205120246.o75mjcwqjl2ea4p7@ws.net.home>
References: <5303721479553110@web15g.yandex.ru>
 <20161202121904.gqkjkhwg2tsemtry@ws.net.home>
 <12434941480833821@web26o.yandex.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <12434941480833821@web26o.yandex.ru>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Dec 04, 2016 at 09:43:41AM +0300, Constantine Kharlamov wrote:
> Beforehands, the problem have been solved by removing the iso9660
> filesystem by offset. Back then the question have been asked on
> forum https://bbs.archlinux.org/viewtopic.php?pid=1670463 so I still
> have an output of wipefs's POV:
> 
>         $ sudo wipefs -n /dev/sdc
>         offset type
>         ----------------------------------------------------------------
>         0x1fe PMBR [partition table]
 
GPT is always

   (protective) MBR + GPT header

the MBR is there to keep the disk used and full for old partitioning
tools that do not have a clue about GPT. MBR in this case contains
one partition (type 0xee) for all disk. For example my disk:

        # fdisk -l /dev/sda
        Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
        Units: sectors of 1 * 512 = 512 bytes
        Sector size (logical/physical): 512 bytes / 512 bytes
        I/O size (minimum/optimal): 512 bytes / 512 bytes
        Disklabel type: gpt
        Disk identifier: E471810B-5954-48E6-B4F0-5D369ADCC514

        Device         Start       End   Sectors   Size Type
        /dev/sda1       2048    411647    409600   200M EFI System
        /dev/sda2     411648    821247    409600   200M Linux filesystem
        /dev/sda3     821248 274087935 273266688 130.3G Linux filesystem
        /dev/sda4  274087936 378945535 104857600    50G Linux filesystem
        /dev/sda5  378945536 452476927  73531392  35.1G Linux filesystem
        /dev/sda6  452476928 468860927  16384000   7.8G Linux swap

but if you disable GPT and enable MBR only:

        # fdisk --type mbr -l /dev/sda
        Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
        Units: sectors of 1 * 512 = 512 bytes
        Sector size (logical/physical): 512 bytes / 512 bytes
        I/O size (minimum/optimal): 512 bytes / 512 bytes
        Disklabel type: dos
        Disk identifier: 0x00000000

        Device     Boot Start       End   Sectors   Size Id Type
        /dev/sda1           1 468862127 468862127 223.6G ee GPT


>         0x8001 iso9660 [filesystem]
>                                                  LABEL: Ubuntu 15.10 amd64
>                                                  UUID: 2015-10-21-16-17-40-00
> 
> I'm still curious about what happened though. α) iso9660 resides
> (offset 0x8001) faar inside the real (i.e. by MBR) filesystem
> (having offset 2048 ≅ 0x800). Hence, given the system shows the
> label of iso9660, the system (together with most partition
> utilities) assumed that sdc is using GPT. But β) I removed GPT
> completely with gdisk (expert command → wipe out GPT), so unless
> gdisk is buggy, it couldn't have happened!

Seems like a crazy boot image that distros generate to be bootable on
all possible situations. If yes, then don't waste time to try
understand what the begin of the image means :-) It's almost always
total mess where multiple stuff (iso, MBR, etc.) share the area.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
