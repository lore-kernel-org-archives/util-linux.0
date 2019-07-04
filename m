Return-Path: <SRS0=CFid=VB=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E454CC0650E
	for <util-linux@archiver.kernel.org>; Thu,  4 Jul 2019 21:55:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B382E21850
	for <util-linux@archiver.kernel.org>; Thu,  4 Jul 2019 21:55:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="mnTic1Fs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfGDVz3 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Thu, 4 Jul 2019 17:55:29 -0400
Received: from mail-yw1-f47.google.com ([209.85.161.47]:36899 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfGDVz2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 4 Jul 2019 17:55:28 -0400
Received: by mail-yw1-f47.google.com with SMTP id u141so1799584ywe.4
        for <util-linux@vger.kernel.org>; Thu, 04 Jul 2019 14:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Z52z456iztbGPT/DbMU6ZDucf698k5nARHUFsDMebmo=;
        b=mnTic1FsbLyt4Hd+t7fenT32xeZaAnLmd2fjeaS1ES+WKJD3ceFoA25QykeQ3PMLNa
         7c0lPuDo2P89pkblZOshRIjJ6IfoSfAEH6yh3qdwqldv1H1UgJVnj0UWfeY7jh1hXDBr
         0LFvIflxNLRNB0LlZXRsmEso3I3d/D7MTetMOcotyI5+fOABMY82r0PXOmvDi032m7GF
         1o/Is+u6O7ubk5JoWnKneWJqArtOGkRMwxeGD6stuY8xQF19t3lnZHIFpaqPS6/WO19q
         pDpP9/7cET77h2zeQu3ShEbDlhxV5NA/f9psQIzefDm4pf2CbBG5B69cDeAk2SGLmCpR
         GL1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Z52z456iztbGPT/DbMU6ZDucf698k5nARHUFsDMebmo=;
        b=T49je9hpHqqGN7CNE4jW+9Hu+hTF/SCZLIhTRHiLdayy+V1UZG+Z34Gg8z5aqNjnf/
         K9VuD6Zc8s6QUf/PVnw+gvkD4XOO+c0WlHz8gNKrQFxqW4jGpk5lrqGGLCBIAR63Kmcj
         P3jdJiJyyDCS1Ks5T9m+LCrlfVSgXjImgLxmEGOcsAUCD5xqlmsPc2GkOgF4kwpdTqLi
         JqPnQDlACPll+GWdZXnfD+G9Pl4j4ZDsSJ7YKRyV3nCHrTBDk5fnlgag2qLh3xTW8WRN
         DOh0gGCc4AjO6p9Uu6ZDUXcFzZJlZlhy8ZmoLODP1Sijshj3s9ClMrfN5GlKbxf1ifPc
         XGMw==
X-Gm-Message-State: APjAAAWRjG6zO+T8hT94u9OwaoM2yJjoNkBRHy2/kakVBnFQqyi49FQ5
        FrR3vXnZdrdpx2T31h9Dr2fPblJ+YiuF6DRkbjYc6AHO
X-Google-Smtp-Source: APXvYqxPqe66ndy/k+x8lzgbxy03nR0/CtG5iJJhkuqTPpD7h4hU8A30vH4an7AGdb53WToPF4mOibHRJn0SfvG7FkU=
X-Received: by 2002:a81:58c5:: with SMTP id m188mr174002ywb.208.1562277327947;
 Thu, 04 Jul 2019 14:55:27 -0700 (PDT)
MIME-Version: 1.0
From:   Mike Fleetwood <mike.fleetwood@googlemail.com>
Date:   Thu, 4 Jul 2019 22:55:16 +0100
Message-ID: <CAMU1PDj4Vtvzw_=o_a5_S=j22Ro7_JqTwwh7k2dBDGk56Ns5LQ@mail.gmail.com>
Subject: fdisk not wiping sector 0 before writing new MBR
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

Hi,

This is a bit more of a speculative than my other recent one, but I saw
this quote in aix.c:
    "All fdisk-like programs has to properly wipe the first sector.
    Everything other is a bug."

Using fdisk to create an MBR over the top of a whole disk FAT32 (and
probably FAT16) file system doesn't clear any of the FAT32 boot record
(aka super block).  Blkid and wipefs report this as just an MBR, but
because the boot record is intact, GNU parted reports this still as a
whole disk FAT32 file system.

This is from a GParted issue report where a user had an SD card that
must have originally come with a whole disk FAT32 file system and then
the user partitioned it over the top with fdisk.
   GitLab GParted issue 64 - Add support for Nobbs-partitioned SD cards
    https://gitlab.gnome.org/GNOME/gparted/issues/64

Test case:

Create a whole disk FAT32 file system.
    # dd if=/dev/zero bs=1M of=/dev/sdb
    # mkfs.fat -F32 -I /dev/sdb
    # ./blkid /dev/sdb
    /dev/sdb: UUID="1EF0-1723" TYPE="vfat"
    # ./wipefs /dev/sdb
    DEVICE OFFSET TYPE UUID      LABEL
    sdb    0x52   vfat 1EF0-1723
    sdb    0x0    vfat 1EF0-1723
    sdb    0x1fe  vfat 1EF0-1723

Create a single primary partition covering the whole disk.
    # ./fdisk --version
    lt-fdisk from util-linux 2.34.24-e3bb9
    # ./fdisk /dev/sdb
      n
      p
      [Return]   (defaults to 1)
      [Return]   (defaults to 2048)
      [Return]   (defaults to 16777215)
      w
    # ./fdisk -l /dev/sdb
    Disk /dev/sdb: 8 GiB, 8589934592 bytes, 16777216 sectors
    Disk model: VBOX HARDDISK
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x00000000

    Device     Boot Start      End  Sectors Size Id Type
    /dev/sdb1        2048 16777215 16775168   8G 83 Linux

util-linux tools now report this as only containing an MBR.
    # ./blkid /dev/sdb
    /dev/sdb: PTTYPE="dos"
    # ./wipefs /dev/sdb
    DEVICE OFFSET TYPE UUID LABEL
    sdb    0x1fe  dos

But GNU parted still sees this as a whole disk FAT32 file system.
    # parted --version
    parted (GNU parted) 3.2
    ...
    # parted /dev/sdb unit s print
    Model: ATA VBOX HARDDISK (scsi)
    Disk /dev/sdb: 16777216s
    Sector size (logical/physical): 512B/512B
    Partition Table: loop
    Disk Flags:

    Number  Start  End
     1      0s

I used hexdump -C to look at sector 0 after writing the FAT32 and after
writing the MBR.  The only bytes which changed were those 16 bytes
storing partition 1 in the MBR.  None of the other bytes in sector 0
changed, hence why parted was able to misidentify this as a FAT32 file
system.

Then just remove that partition and blkid and wipefs again detect it as
a whole disk FAT32 file system.
    # ./fdisk /dev/sdb
      d
      w
    # ./blkid /dev/sdb
    /dev/sdb: UUID="1EF0-1723" TYPE="vfat"
    # ./wipefs /dev/sdb
    DEVICE OFFSET TYPE UUID      LABEL
    sdb    0x52   vfat 1EF0-1723
    sdb    0x0    vfat 1EF0-1723
    sdb    0x1fe  vfat 1EF0-1723

I don't think a user can have any expectation that if a whole disk FAT32
file system "superfloppy" was bootable, that after using fdisk to write
an MBR over the top, that it can still be bootable, without writing new
boot code to the disk.

Thank you for your consideration,
Mike
