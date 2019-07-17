Return-Path: <SRS0=VPyL=VO=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28754C76186
	for <util-linux@archiver.kernel.org>; Wed, 17 Jul 2019 10:16:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F083C21743
	for <util-linux@archiver.kernel.org>; Wed, 17 Jul 2019 10:16:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbfGQKQ3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Wed, 17 Jul 2019 06:16:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57638 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725893AbfGQKQ3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 17 Jul 2019 06:16:29 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CFC87308FBAF;
        Wed, 17 Jul 2019 10:16:28 +0000 (UTC)
Received: from ws.net.home (ovpn-204-41.brq.redhat.com [10.40.204.41])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 147615C232;
        Wed, 17 Jul 2019 10:16:27 +0000 (UTC)
Date:   Wed, 17 Jul 2019 12:16:25 +0200
From:   Karel Zak <kzak@redhat.com>
To:     Mike Fleetwood <mike.fleetwood@googlemail.com>
Cc:     util-linux@vger.kernel.org
Subject: Re: fdisk not wiping sector 0 before writing new MBR
Message-ID: <20190717101625.vz657vj5g2ir5gcy@ws.net.home>
References: <CAMU1PDj4Vtvzw_=o_a5_S=j22Ro7_JqTwwh7k2dBDGk56Ns5LQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMU1PDj4Vtvzw_=o_a5_S=j22Ro7_JqTwwh7k2dBDGk56Ns5LQ@mail.gmail.com>
User-Agent: NeoMutt/20180716-1584-710bcd
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.43]); Wed, 17 Jul 2019 10:16:28 +0000 (UTC)
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

On Thu, Jul 04, 2019 at 10:55:16PM +0100, Mike Fleetwood wrote:
> Hi,
> 
> This is a bit more of a speculative than my other recent one, but I saw
> this quote in aix.c:
>     "All fdisk-like programs has to properly wipe the first sector.
>     Everything other is a bug."
>
> Using fdisk to create an MBR over the top of a whole disk FAT32 (and
> probably FAT16) file system doesn't clear any of the FAT32 boot record
> (aka super block).  Blkid and wipefs report this as just an MBR, but
> because the boot record is intact, GNU parted reports this still as a
> whole disk FAT32 file system.

This is bug. MBR probing code in fdisk is weak and it does not check for 
false positives like blkid, so FAT32 is interpreted as MBR and the bootbits
are not wiped (fdisk wipes first sector only if it creates a new
partition table).

In another case like

  # dd if=/dev/urandom of=/dev/sdc bs=512 count=1
  # hexdump -C -n 512 /dev/sdc
  # fdisk /dev/sdc                 (...create MBR)

  # hexdump -C -n 512 /dev/sdc
  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  *
  000001b0  00 00 00 00 00 00 00 00  0b b7 83 76 00 00 00 00  |...........v....|
  000001c0  31 0a 83 03 f2 ff 00 08  00 00 00 18 03 00 00 00  |1...............|
  000001d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
  *
  000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
  00000200



> 
> This is from a GParted issue report where a user had an SD card that
> must have originally come with a whole disk FAT32 file system and then
> the user partitioned it over the top with fdisk.
>    GitLab GParted issue 64 - Add support for Nobbs-partitioned SD cards
>     https://gitlab.gnome.org/GNOME/gparted/issues/64
> 
> Test case:
> 
> Create a whole disk FAT32 file system.
>     # dd if=/dev/zero bs=1M of=/dev/sdb
>     # mkfs.fat -F32 -I /dev/sdb
>     # ./blkid /dev/sdb
>     /dev/sdb: UUID="1EF0-1723" TYPE="vfat"
>     # ./wipefs /dev/sdb
>     DEVICE OFFSET TYPE UUID      LABEL
>     sdb    0x52   vfat 1EF0-1723
>     sdb    0x0    vfat 1EF0-1723
>     sdb    0x1fe  vfat 1EF0-1723
> 
> Create a single primary partition covering the whole disk.
>     # ./fdisk --version
>     lt-fdisk from util-linux 2.34.24-e3bb9
>     # ./fdisk /dev/sdb
>       n
>       p
>       [Return]   (defaults to 1)
>       [Return]   (defaults to 2048)
>       [Return]   (defaults to 16777215)
>       w
>     # ./fdisk -l /dev/sdb
>     Disk /dev/sdb: 8 GiB, 8589934592 bytes, 16777216 sectors
>     Disk model: VBOX HARDDISK
>     Units: sectors of 1 * 512 = 512 bytes
>     Sector size (logical/physical): 512 bytes / 512 bytes
>     I/O size (minimum/optimal): 512 bytes / 512 bytes
>     Disklabel type: dos
>     Disk identifier: 0x00000000
> 
>     Device     Boot Start      End  Sectors Size Id Type
>     /dev/sdb1        2048 16777215 16775168   8G 83 Linux
> 
> util-linux tools now report this as only containing an MBR.
>     # ./blkid /dev/sdb
>     /dev/sdb: PTTYPE="dos"
>     # ./wipefs /dev/sdb
>     DEVICE OFFSET TYPE UUID LABEL
>     sdb    0x1fe  dos
> 
> But GNU parted still sees this as a whole disk FAT32 file system.
>     # parted --version
>     parted (GNU parted) 3.2
>     ...
>     # parted /dev/sdb unit s print
>     Model: ATA VBOX HARDDISK (scsi)
>     Disk /dev/sdb: 16777216s
>     Sector size (logical/physical): 512B/512B
>     Partition Table: loop
>     Disk Flags:
> 
>     Number  Start  End
>      1      0s
> 
> I used hexdump -C to look at sector 0 after writing the FAT32 and after
> writing the MBR.  The only bytes which changed were those 16 bytes
> storing partition 1 in the MBR.  None of the other bytes in sector 0
> changed, hence why parted was able to misidentify this as a FAT32 file
> system.
> 
> Then just remove that partition and blkid and wipefs again detect it as
> a whole disk FAT32 file system.
>     # ./fdisk /dev/sdb
>       d
>       w
>     # ./blkid /dev/sdb
>     /dev/sdb: UUID="1EF0-1723" TYPE="vfat"
>     # ./wipefs /dev/sdb
>     DEVICE OFFSET TYPE UUID      LABEL
>     sdb    0x52   vfat 1EF0-1723
>     sdb    0x0    vfat 1EF0-1723
>     sdb    0x1fe  vfat 1EF0-1723
> 
> I don't think a user can have any expectation that if a whole disk FAT32
> file system "superfloppy" was bootable, that after using fdisk to write
> an MBR over the top, that it can still be bootable, without writing new
> boot code to the disk.
> 
> Thank you for your consideration,
> Mike
> 

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
