Return-Path: util-linux-owner@vger.kernel.org
Received: from elasmtp-kukur.atl.sa.earthlink.net ([209.86.89.65]:34653 "EHLO
	elasmtp-kukur.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753692AbaHED03 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 4 Aug 2014 23:26:29 -0400
Received: from [24.144.107.77] (helo=[192.168.0.11])
	by elasmtp-kukur.atl.sa.earthlink.net with esmtpa (Exim 4.67)
	(envelope-from <mrmazda@earthlink.net>)
	id 1XEVON-00087c-Ic
	for util-linux@vger.kernel.org; Mon, 04 Aug 2014 23:26:27 -0400
Message-ID: <53E04EE1.1090107@earthlink.net>
Date: Mon, 04 Aug 2014 23:26:25 -0400
From: Felix Miata <mrmazda@earthlink.net>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: ? fdisk -l bug: wrong devices listed ?
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Rawhide util-linux-2.25-2.fc22.i686

In system with:
HD on ICH5 IDE (/dev/sda)
DVD-drive on ICH5 IDE (door open/empty drive; /dev/sr0)
USB stick on USB Bus 001 Device 002: ID 0781:556b SanDisk Corp. (/dev/sdb)

# lsusb

Bus 001 Device 002: ID 0781:556b SanDisk Corp.
Bus 001 Device 001: ID 1d6b:0002 Linux Foundation 2.0 root hub
Bus 005 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 004 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 003 Device 002: ID 046d:c408 Logitech, Inc. Marble Mouse (4-button)
Bus 003 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub
Bus 002 Device 001: ID 1d6b:0001 Linux Foundation 1.1 root hub

# fdisk -l

Disk /dev/sda: 232.9 GiB, 250059350016 bytes, 488397168 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xdf5ee116

Device     Boot     Start       End   Sectors   Size Id Type
/dev/sda1              63     80324     80262  39.2M  6 FAT16
/dev/sda2           80325    578339    498015 243.2M 1b Hidden W95 FAT32
/dev/sda3  *       578340   1397654    819315 400.1M 83 Linux
/dev/sda4         1397655 234372284 232974630 111.1G  5 Extended
/dev/sda5         1397718   1783214    385497 188.2M 82 Linux swap / Solaris
/dev/sda6         1783278   1799279     16002   7.8M 11 Hidden FAT12
/dev/sda7         1799343   2313359    514017   251M 16 Hidden FAT16
/dev/sda8         2313423  13783769  11470347   5.5G  7 HPFS/NTFS/exFAT
/dev/sda9        13783833  23615549   9831717   4.7G 83 Linux
/dev/sda10       23615613  33447329   9831717   4.7G 83 Linux
/dev/sda11       33447393  43279109   9831717   4.7G 83 Linux
/dev/sda12       43279173  53110889   9831717   4.7G 83 Linux
/dev/sda13       53110953  67858559  14747607     7G 83 Linux
/dev/sda14       67858623  72051524   4192902     2G 83 Linux
/dev/sda15       72051588  89642699  17591112   8.4G 83 Linux
/dev/sda16       89642763  99474479   9831717   4.7G 83 Linux
/dev/sda17       99474543 109306259   9831717   4.7G 83 Linux
/dev/sda18      109306323 119138039   9831717   4.7G 83 Linux
/dev/sda19      119138103 128969819   9831717   4.7G 83 Linux
/dev/sda20      128969883 138801599   9831717   4.7G 83 Linux
/dev/sda21      138801663 148633379   9831717   4.7G 83 Linux
/dev/sda22      148633443 158465159   9831717   4.7G 83 Linux
/dev/sda23      158465223 168296939   9831717   4.7G 83 Linux
/dev/sda24      168297003 178128719   9831717   4.7G 83 Linux
/dev/sda25      178128783 187960499   9831717   4.7G 83 Linux
/dev/sda26      187960563 197792279   9831717   4.7G 83 Linux
/dev/sda27      197792343 221841584  24049242  11.5G  7 HPFS/NTFS/fdisk: cannot open /dev/sr0: No medium found
exFAT
/dev/sda28      221841648 233311994  11470347   5.5G d7 unknown
/dev/sda29      233312058 234356219   1044162 509.9M 1b Hidden W95 FAT32
/dev/sda30      234356283 234372284     16002   7.8M  1 FAT12

# fdisk -l /dev/sdb

Disk /dev/sdb: 7.5 GiB, 8004304896 bytes, 15633408 sectors
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disklabel type: dos
Disk identifier: 0xdf5ee121

Device     Boot Start      End  Sectors  Size Id Type
/dev/sdb1  *       32 15632383 15632352  7.5G  c W95 FAT32 (LBA)

Is it intended that simply 'fdisk -l' skip listing the available USB stick, while trying to list content for the empty OM reader, while 'fdisk -l /dev/sdb' works sensibly as in openSUSE's fdisk from util-linux-2.21.2?
-- 
"The wise are known for their understanding, and pleasant
words are persuasive." Proverbs 16:21 (New Living Translation)

 Team OS/2 ** Reg. Linux User #211409 ** a11y rocks!

Felix Miata  ***  http://fm.no-ip.com/
