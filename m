Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-db5eur01on0109.outbound.protection.outlook.com ([104.47.2.109]:58688
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932413AbdDRQAD (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 18 Apr 2017 12:00:03 -0400
From: Pavel Butsykin <pbutsykin@virtuozzo.com>
To: <util-linux@vger.kernel.org>
CC: <kzak@redhat.com>, <pbutsykin@virtuozzo.com>
Subject: [PATCH 0/1] libfdisk: allow to change an existing extended partition
Date: Tue, 18 Apr 2017 18:59:17 +0300
Message-ID: <20170418155918.32550-1-pbutsykin@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The sfdisk utility does not allow us to change any extended partition type to
another extended type:
# sfdisk --list /dev/nbd0
Disk /dev/nbd0: 66 GiB, 70866960384 bytes, 138412032 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0x006bf65f

Device      Boot   Start       End   Sectors  Size Id Type
/dev/nbd0p1 *       2048    999423    997376  487M 83 Linux
/dev/nbd0p2      1001470 138412031 137410562 65,5G  5 Extended

# sfdisk --part-type /dev/nbd0 2 0x85
Extended partition already exists.
lt-sfdisk: /dev/nbd0: partition 2: failed to set partition type

But why? As far as I understand, this is done in order to avoid more than one
extented partition on MBR disk (because MBR doesn't support more). But since
extended partition there are three types:
#define IS_EXTENDED(i) \
    ((i) == MBR_DOS_EXTENDED_PARTITION \
     || (i) == MBR_W95_EXTENDED_PARTITION \
     || (i) == MBR_LINUX_EXTENDED_PARTITION)

It would be nice to have the option to change the type of an existing extended
partition.

Pavel Butsykin (1):
  libfdisk: allow to change an existing extended partition

 libfdisk/src/dos.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.11.0

