Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48312 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751528AbbDGJpm (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 7 Apr 2015 05:45:42 -0400
Date: Tue, 7 Apr 2015 11:45:35 +0200
From: Karel Zak <kzak@redhat.com>
To: "Jean-Loup 'clippix' Bogalho" <clippix@lse.epita.fr>
Cc: util-linux@vger.kernel.org, gabriel@lse.epita.fr
Subject: Re: [PATCH V2] dos: copy previous bootsector for dos partition table
Message-ID: <20150407094535.GF3923@ws.net.home>
References: <20150404160526.GA24261@clippix.lab.lse.epita.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20150404160526.GA24261@clippix.lab.lse.epita.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sat, Apr 04, 2015 at 06:05:26PM +0200, Jean-Loup 'clippix' Bogalho wrote:
> In order to create a dos partition scheme, libfdisk erase the first disk sector
> and then add the needed values (partitions, magic numbers).
> In the case the disk already contains code in the bootsection, it will be
> erased.  

 Yes.

> This was not the case in v2.25 of util-linux.

 Are you sure? I see fdisk_init_firstsector_buffer() in 

    git show v2.25:libfdisk/src/utils.c

 and we zeroize the first sector all time, for example see
 create_doslabel() and get_boot() from 

    git show v2.13:fdisk/fdisk.c


 I have tested v2.17:

 # hexdump -C /dev/sdc
 00000000  48 45 4c 4c 4f 0a 00 00  00 00 00 00 00 00 00 00  |HELLO...........|
 00000010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *

 # fdisk /dev/sdc
 ... create MBR ....


 # hexdump -C /dev/sdc
 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 000001b0  00 00 00 00 00 00 00 00  b4 19 30 de 00 00 00 01  |..........0.....|
 000001c0  01 00 83 10 fb fb 3b 00  00 00 19 9c 0f 00 00 00  |......;.........|
 000001d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|


> Since fdisk can be used to repair messed partition tables, maybe we don't want
> to have to rewrite the boot section.

 That's question. If you keep the begin of the device unchanged then
 you can create horrible mix of more labels or you can keep any unwanted
 filesystem or raid superblock on the device. I don't think we want this 
 by default. (Well, in many cases this problem should be detected by 
 warn_wipe() in context.c.)

 Note that GNU parted also modifies the begin of the device (it
 tries to be smart and it writes some generic "boot code" there:-)
 
 Maybe it would be better to add --protect-bootsector command line option;
 if you want to implement it:

    - add protect_boot flag to struct fdisk_context (fdiskP.h)
    - add a new function fdisk_protect_boot(cxt, enable) to set/unset the new flag

    - extend fdisk_init_firstsector_buffer() to protect specified area:
         fdisk_init_firstsector_buffer(cxt, 0, 446)

    - call fdisk_init_firstsector_buffer() from dos_create_disklabel()
      with proper offset and size when the protect_boot flag is enabled

    - add fdisk_protect_boot() to 
        libfdisk/src/libfdisk.h.in
        libfdisk/src/libfdisk.sym
        libfdisk/docs/libfdisk-sections.txt

  Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
