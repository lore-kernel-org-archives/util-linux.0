Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:36535 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750768AbaHSJzK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 19 Aug 2014 05:55:10 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1XJg87-0002dw-RB
	for util-linux@vger.kernel.org; Tue, 19 Aug 2014 11:55:04 +0200
Received: from 79-139-19-75.prenet.pl ([79.139.19.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 19 Aug 2014 11:55:03 +0200
Received: from jb.1234abcd by 79-139-19-75.prenet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Tue, 19 Aug 2014 11:55:03 +0200
To: util-linux@vger.kernel.org
From: jb <jb.1234abcd@gmail.com>
Subject: lsblk vice fdisk, etc
Date: Tue, 19 Aug 2014 09:51:35 +0000 (UTC)
Message-ID: <loom.20140819T114407-592@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
I think there is a need to fix and reconcile lsblk with fdisk, cfdisk, etc,
as demonstrated on example of usb flash drive, shown as /dev/sdb device.

$ lsblk
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sda      8:0    0 37.3G  0 disk 
├─sda1   8:1    0   20G  0 part 
├─sda2   8:2    0  1.5G  0 part [SWAP]
├─sda3   8:3    0 13.4G  0 part /
├─sda4   8:4    0    1K  0 part 
└─sda5   8:5    0  2.4G  0 part 
sdb      8:16   1  7.3G  0 disk 
└─sdb1   8:17   1  683M  0 part 
sr0     11:0    1 1024M  0 rom  
$

Where does sr0's size of 1024M come from ?
 
$ lsblk -f
NAME   FSTYPE  LABEL             UUID                                 MOUNTPOINT
sda                                                                   
├─sda1 ext4                      38b23ec9-4947-46ae-a2b2-d48f4582af3f 
├─sda2 swap                      8074aa4f-489e-4adc-a356-ff09d633534f [SWAP]
├─sda3 ext4                      d067602d-f15d-49c0-abad-865adab2cc8f /
├─sda4                                                                
└─sda5 ext4                      4f168c8f-ac1d-4048-ac3f-254fa4392c60 
sdb    iso9660 Test
                                 2014-07-22-17-24-48-12               
└─sdb1 iso9660 Test
                                 2014-07-22-17-24-48-12               
sr0                                                                   
$

The line
sdb    iso9660 Test
should be consistent with sda and show
sdb

The line
└─sdb1 iso9660 Test
should be reconciled with what fdisk, etc show.

# fdisk -l /dev/sdb
...
Device     Boot Start     End Sectors  Size Id Type
/dev/sdb1  *        0 1398783 1398784  683M 17 Hidden HPFS/NTFS

# cfdisk /dev/sdb
...
Device       Boot     Start       End   Sectors   Size  Id Type
/dev/sdb1    *            0   1398783   1398784   683M  17 Hidden HPFS/NTFS 
Free space          1398784  15356159  13957376   6.7G
 
# parted -l
...
Number  Start   End     Size    Type      File system     Flags
 1      1049kB  21.4GB  21.4GB  primary   ext4            boot
 2      21.4GB  23.0GB  1578MB  primary   linux-swap(v1)
 3      23.0GB  37.4GB  14.4GB  primary   ext4
 4      37.4GB  40.0GB  2579MB  extended
 5      37.4GB  40.0GB  2579MB  logical   ext4


Error: Invalid partition table - recursive partition on /dev/sdb.
Ignore/Cancel?
#

# partprobe 
Error: Invalid partition table - recursive partition on /dev/sdb.

# partx -s /dev/sdb
NR START     END SECTORS SIZE NAME UUID
 1     0 1398783 1398784 683M      3054920d-01
# partx -o type,flags,scheme /dev/sdb
TYPE FLAGS SCHEME
0x17 0x80  dos

Note: TYPE shows 0x17, which represents "Hidden HPFS/NTFS"

jb


