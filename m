Return-Path: <SRS0=om+s=W6=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13CF7C3A5A2
	for <util-linux@archiver.kernel.org>; Tue,  3 Sep 2019 15:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CECA62077B
	for <util-linux@archiver.kernel.org>; Tue,  3 Sep 2019 15:47:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhlycjZk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbfICPrU (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 3 Sep 2019 11:47:20 -0400
Received: from mail-io1-f41.google.com ([209.85.166.41]:39715 "EHLO
        mail-io1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbfICPrU (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 3 Sep 2019 11:47:20 -0400
Received: by mail-io1-f41.google.com with SMTP id d25so34446359iob.6
        for <util-linux@vger.kernel.org>; Tue, 03 Sep 2019 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=wSO8wtQl0jNEnucrBJU/cxm76tkDsc2JiV84QK/H6Tg=;
        b=LhlycjZkceqPCkY1uFOY53FPWSNk9bwyDJS8coPmzHBnoNahbGLGNsOtEvIOPB0CNW
         WQRc2fpKGgIIgnF7oiItapEdq+U3BBXZUP2PaF/eLccnzOb/Sjkd8OS2SJiCcVcOSiux
         Bh8kRyjWtM8HRmm4SkAz9l2horSIfQiYIJg37aCDYGg4SXtr8xw+uS9o4ALKbFL8tgK8
         XIZy/AyfnIMZzUUnmgB72du/vRBXOTIeg4TpyTmj+Rlpf/gMSDQuL17Vq+enXW4+qhKU
         P7Ybc8HdC3Cc1AqytXiQmEe+QN+ZQjMJIwPbeZBxpTPBTTlwf5pqRWkDpWqfbnky5yAY
         7Lyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=wSO8wtQl0jNEnucrBJU/cxm76tkDsc2JiV84QK/H6Tg=;
        b=PRLtg/THwidFYTYavzFxuCikZ2zn1JQkZWcdTQToMW4nSppFXlWPso8uPSFpDzakhg
         ijHqvuZ2yX6e3Bwp/oP5FtG10Zw4wC9qqfCmviKiBTnjjwTd7jdi3k0FubO8hrGaT3Er
         Oqk9+dURUlTUhcquQ07VBQqXGU9S1eBaRzmr7Uu2qs2FApbH2mbj6a16cmHHzybGutQq
         2LsMen7OjelglKIo6kW0NWAjBEE6Tgb5sFt207IQDxzWr3MHAkdRPTN7utHO6mGptbU9
         qjTV8KoApIhwU+uUVDnVXadkYnHh7toO5Ki2f8AzPOlHxTSW5nil/869T1I4l6WLLP+v
         gvow==
X-Gm-Message-State: APjAAAXW1ZAbKRi1TfHdhamr+Wmbk1WNqea4S1wYNslXBN4Pw5MbzITn
        7v3jO/hfc5IZev9Ur19AZwOqV5AE8wd/QGVPB08lYzlS
X-Google-Smtp-Source: APXvYqwlh5Qi4s8TXymExdMlSXReeWyqSV3KfoYAqrGmq2vq4/08hNjuJhIKOvrG8xKAVaMjaFUw4+q3B4RgjnnspyQ=
X-Received: by 2002:a6b:c38f:: with SMTP id t137mr6685393iof.137.1567525638961;
 Tue, 03 Sep 2019 08:47:18 -0700 (PDT)
MIME-Version: 1.0
From:   Hank Barta <hbarta@gmail.com>
Date:   Tue, 3 Sep 2019 10:47:08 -0500
Message-ID: <CABTDG88idFakiMbMYCKB+GmCy5=G_LiAFDK2tW28M8xMDh17BA@mail.gmail.com>
Subject: no result for blkid for EFI partition
To:     util-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

'm running into an issue I don;t understand. Short description:
installing Debian Buster to ZFS root and using LUKS encryption. Long
description: This is esecuting in a chroot in a VM running the Live
USB image for Debian Buster and following the instructions at
https://github.com/zfsonlinux/zfs/wiki/Debian-Buster-Root-on-ZFS.

The issue I'm running into is that `blkid` reports no information for
the EFI partition. The partition is created using
    wipefs -a /dev/disk/by-id/$DRIVE_ID     # useful if the drive
already had ZFS pools
    sgdisk --zap-all /dev/disk/by-id/$DRIVE_ID

    # 2.2 Partition your disk
    # Run this for UEFI booting (for use now or in the future):
    sgdisk     -n2:1M:+1024M -t2:EF00 /dev/disk/by-id/$DRIVE_ID
    export EFI_PART=/dev/disk/by-id/${DRIVE_ID}-part2

and formatted using
mkdosfs -F 32 -s 1 -n EFI ${EFI_PART}

The result is
root@debian:/# blkid /dev/sda2
root@debian:/#

root@debian:/# fdisk /dev/sda

Welcome to fdisk (util-linux 2.33.1).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p
Disk /dev/sda: 8 GiB, 8589934592 bytes, 16777216 sectors
Disk model: VBOX HARDDISK
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: gpt
Disk identifier: E560C0D8-7453-400C-8B08-C4A4E7741BF8

Device       Start      End  Sectors Size Type
/dev/sda2     2048  2099199  2097152   1G EFI System
/dev/sda3  2099200  4196351  2097152   1G Solaris /usr & Apple ZFS
/dev/sda4  4196352 16777182 12580831   6G Linux filesystem

Command (m for help): q

root@debian:/# ls -l /dev/disk/by-id
total 0
lrwxrwxrwx 1 root root  9 Sep  3 04:09 ata-VBOX_CD-ROM_VB2-01700376 -> ../../sr0
lrwxrwxrwx 1 root root  9 Sep  3 09:49
ata-VBOX_HARDDISK_VBed34bc29-2968e615 -> ../../sda
lrwxrwxrwx 1 root root 10 Sep  3 09:49
ata-VBOX_HARDDISK_VBed34bc29-2968e615-part2 -> ../../sda2
lrwxrwxrwx 1 root root 10 Sep  3 09:49
ata-VBOX_HARDDISK_VBed34bc29-2968e615-part3 -> ../../sda3
lrwxrwxrwx 1 root root 10 Sep  3 09:49
ata-VBOX_HARDDISK_VBed34bc29-2968e615-part4 -> ../../sda4
lrwxrwxrwx 1 root root 10 Sep  3 09:19 dm-name-luks1 -> ../../dm-0
lrwxrwxrwx 1 root root 10 Sep  3 09:19
dm-uuid-CRYPT-LUKS2-e21badad6d6b4db59d95d99d1e4fc9b1-luks1 ->
../../dm-0
root@debian:/# blkid
/dev/sda4: UUID="e21badad-6d6b-4db5-9d95-d99d1e4fc9b1"
TYPE="crypto_LUKS" PARTUUID="e0afc765-239f-4b3d-9afa-971a64801b73"
/dev/sda3: LABEL="bpool" UUID="3469266818014148396"
UUID_SUB="48979436116215382" TYPE="zfs_member"
PARTUUID="3c00e355-ee3a-430c-aa58-1478d4f00e36"
/dev/sr0: UUID="2019-07-06-12-12-54-00" LABEL="d-live nf 10.0.0 gn
amd64" TYPE="iso9660" PTUUID="720eaf06" PTTYPE="dos"
/dev/loop0: TYPE="squashfs"
/dev/mapper/luks1: LABEL="rpool" UUID="15828100763890880025"
UUID_SUB="8162042683520056023" TYPE="zfs_member"
root@debian:/# ls -l /dev/disk/by-uuid/
total 0
lrwxrwxrwx 1 root root  9 Sep  3 04:09 2019-07-06-12-12-54-00 -> ../../sr0
lrwxrwxrwx 1 root root 10 Sep  3 09:49 3469266818014148396 -> ../../sda3
lrwxrwxrwx 1 root root 10 Sep  3 09:49
e21badad-6d6b-4db5-9d95-d99d1e4fc9b1 -> ../../sda4
root@debian:/#

Versions installed are
root@debian:/# apt-cache policy util-linux dosfstools
util-linux:
  Installed: 2.33.1-0.1
  Candidate: 2.33.1-0.1
  Version table:
 *** 2.33.1-0.1 500
        500 http://deb.debian.org/debian buster/main amd64 Packages
        100 /var/lib/dpkg/status
dosfstools:
  Installed: 4.1-2
  Candidate: 4.1-2
  Version table:
 *** 4.1-2 500
        500 http://deb.debian.org/debian buster/main amd64 Packages
        100 /var/lib/dpkg/status
root@debian:/#

When I don't format anything using LUKS encryption, I get the expected result.

I think I can work around this but if it is a bug, it seems like I
should report. If it is something I'm doing wrong, it is an
opportunity to learn something.

I did some searching and only found issues where Windows and Linux
were both installed and there was some confusion with the
partitioning.

I'm not sure where to go next with this and appreciate any suggestions.

Thanks!

-- 
'03 BMW F650CS - hers
'98 Dakar K12RS - "BABY K" grew up.
'93 R100R w/ Velorex 700 (MBD starts...)
'95 Miata - "OUR LC"
polish visor: apply squashed bugs, rinse, repeat
Beautiful Sunny Winfield, Illinois
