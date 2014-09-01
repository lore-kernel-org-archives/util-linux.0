Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:59015 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751082AbaIARt2 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 1 Sep 2014 13:49:28 -0400
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1XOViq-00066y-Gn
	for util-linux@vger.kernel.org; Mon, 01 Sep 2014 19:48:56 +0200
Received: from 79-139-19-75.prenet.pl ([79.139.19.75])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 01 Sep 2014 19:48:56 +0200
Received: from jb.1234abcd by 79-139-19-75.prenet.pl with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Mon, 01 Sep 2014 19:48:56 +0200
To: util-linux@vger.kernel.org
From: jb <jb.1234abcd@gmail.com>
Subject: mount errors on /dev/sr0 (cd-rw)
Date: Mon, 1 Sep 2014 17:48:25 +0000 (UTC)
Message-ID: <loom.20140901T194119-339@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,
this is tested on Fedora 20
util-linux.i686        2.24.2-1.fc20         @update

# mount -t auto /dev/sr0 /media/
mount: /dev/sr0 is write-protected, mounting read-only
mount: /dev/sr0: can't read superblock
#

# dmesg -T
[Mon Sep  1 17:35:40 2014] sr 0:0:1:0: [sr0]  
[Mon Sep  1 17:35:40 2014] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[Mon Sep  1 17:35:40 2014] sr 0:0:1:0: [sr0]  
[Mon Sep  1 17:35:40 2014] Sense Key : Illegal Request [current] 
[Mon Sep  1 17:35:40 2014] sr 0:0:1:0: [sr0]  
[Mon Sep  1 17:35:40 2014] Add. Sense: Logical block address out of range
[Mon Sep  1 17:35:40 2014] sr 0:0:1:0: [sr0] CDB: 
[Mon Sep  1 17:35:40 2014] Read(10): 28 00 00 00 00 00 00 00 01 00
[Mon Sep  1 17:35:40 2014] end_request: I/O error, dev sr0, sector 0
[Mon Sep  1 17:35:40 2014] Buffer I/O error on device sr0, logical block 0
[Mon Sep  1 17:35:40 2014] sr 0:0:1:0: [sr0]  
[Mon Sep  1 17:35:40 2014] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
...
[Mon Sep  1 17:35:43 2014] sr 0:0:1:0: [sr0] CDB: 
[Mon Sep  1 17:35:43 2014] Read(10): 28 00 00 00 00 00 00 00 01 00
[Mon Sep  1 17:35:43 2014] FAT-fs (sr0): unable to read boot sector
#

What is the last line about ??? FAT-fs on sr0 ???

# mount -t iso9660 /dev/sr0 /media/
mount: /dev/sr0 is write-protected, mounting read-only
mount: wrong fs type, bad option, bad superblock on /dev/sr0,
       missing codepage or helper program, or other error

       In some cases useful info is found in syslog - try
       dmesg | tail or so.
#

# dmesg -T
...
[Mon Sep  1 17:55:15 2014] sr 0:0:1:0: [sr0]  
[Mon Sep  1 17:55:15 2014] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE
[Mon Sep  1 17:55:15 2014] sr 0:0:1:0: [sr0]  
[Mon Sep  1 17:55:15 2014] Sense Key : Illegal Request [current] 
[Mon Sep  1 17:55:15 2014] sr 0:0:1:0: [sr0]  
[Mon Sep  1 17:55:15 2014] Add. Sense: Logical block address out of range
[Mon Sep  1 17:55:15 2014] sr 0:0:1:0: [sr0] CDB: 
[Mon Sep  1 17:55:15 2014] Read(10): 28 00 00 00 00 10 00 00 01 00
[Mon Sep  1 17:55:15 2014] blk_update_request: 59 callbacks suppressed
[Mon Sep  1 17:55:15 2014] end_request: I/O error, dev sr0, sector 64
[Mon Sep  1 17:55:15 2014] isofs_fill_super: bread failed, dev=sr0,
iso_blknum=16, block=16
#

I see this problem historically present in many distros.

# isoinfo -d -i test.iso 
CD-ROM is in ISO 9660 format
System id: LINUX
Volume id: CDROM
Volume set id: 
Publisher id: 
Data preparer id: 
Application id: GENISOIMAGE ISO 9660/HFS FILESYSTEM CREATOR (C) 1993
E.YOUNGDALE (C) 1997-2006 J.PEARSON/J.SCHILLING (C) 2006-2007 CDRKIT TEAM
Copyright File id: 
Abstract File id: 
Bibliographic File id: 
Volume set size is: 1
Volume set sequence number is: 1
Logical block size is: 2048
Volume size is: 183
Joliet with UCS level 3 found
Rock Ridge signatures version 1 found
# 

# isoinfo -l -i test.iso 

Directory listing of /
d---------   0    0    0            2048 Sep  1 2014 [     28 02]  . 
d---------   0    0    0            2048 Sep  1 2014 [     28 02]  .. 
----------   0    0    0             121 Sep  1 2014 [     31 00] 
DISK_WAR.TXT;1 
----------   0    0    0             144 Sep  1 2014 [     32 00] 
HDPARM_T.OUT;1 
# 

jb


