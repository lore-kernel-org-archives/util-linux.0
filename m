Return-Path: util-linux-owner@vger.kernel.org
Received: from thot02.seeweb.it ([85.94.213.58]:53647 "EHLO thot02.seeweb.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752173Ab1HQGaQ convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 17 Aug 2011 02:30:16 -0400
Received: from i3.golden.dom ([151.58.205.50])
	(authenticated bits=0)
	by thot02.seeweb.it (8.14.3/8.14.3/Debian-5) with ESMTP id p7H6DMQp029754
	for <util-linux@vger.kernel.org>; Wed, 17 Aug 2011 08:13:23 +0200
From: Giulio <giulioo@gmail.com>
To: util-linux@vger.kernel.org
Subject: sfdisk: trying to create aligned partitions: fail
Date: Wed, 17 Aug 2011 08:13:06 +0200
Reply-To: giulioo@pobox.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20110817061256.BB29DF815@i3.golden.dom>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Linux 2.6.18-238.12.1.el5
sfdisk from util-linux 2.20-rc1
fdisk (util-linux 2.20-rc1)
200GB VMware SCSI disk

It seems it's not immediately possible to create aligned partitions (ie:
starting at 1MB/2048 sectors) with sfdisk.

1) 1st try, using MBs as unit of measure:

dd if=/dev/zero of=/dev/sda bs=1 count=512
sfdisk -L -uM /dev/sda <<-EOF
1,1001,83
,,83
;
;
EOF

Results (starts at sector 1 instead of 1MB):
$ fdisk -lu /dev/sda
 
Disk /dev/sda: 214.7 GB, 214748364800 bytes
255 heads, 63 sectors/track, 26108 cylinders, total 419430400 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000
 
   Device Boot      Start         End      Blocks   Id  System
/dev/sda1               1     2056319     1028159+  83  Linux
/dev/sda2         2056320   419425019   208684350   83  Linux


2) 2nd try, using sectors as unit of measure:

dd if=/dev/zero of=/dev/sda bs=1 count=512
sfdisk -L -uS /dev/sda <<-EOF
2048,2050048,83
,,83
;
;
EOF

Results (wrong 2nd partition created):
$ fdisk -lu /dev/sda
 
Disk /dev/sda: 214.7 GB, 214748364800 bytes
255 heads, 63 sectors/track, 26108 cylinders, total 419430400 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x00000000
 
   Device Boot      Start         End      Blocks   Id  System
/dev/sda1            2048     2052095     1025024   83  Linux
/dev/sda2               1        2047        1023+  83  Linux
/dev/sda3         2052096   419430399   208689152   83  Linux
 
Partition table entries are not in disk order


===

Is there some option to enable alignment?

Thanks
