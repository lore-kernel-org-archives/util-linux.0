Return-Path: util-linux-owner@vger.kernel.org
Received: from magic.merlins.org ([209.81.13.136]:50391 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752510Ab3KXNw3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 24 Nov 2013 08:52:29 -0500
Received: from [123.231.255.242] (port=58374 helo=gandalfthegreat.merlins.org)
	by mail1.merlins.org with esmtpa (Exim 4.80 #2)
	id 1Vka6u-0006Yw-HJ by authid <merlins.org> with srv_auth_plain
	for <util-linux@vger.kernel.org>; Sun, 24 Nov 2013 05:52:28 -0800
Received: from merlin by gandalfthegreat.merlins.org with local (Exim 4.80)
	(envelope-from <merlin@gandalfthegreat.merlins.org>)
	id 1Vka6s-0003M0-K5
	for util-linux@vger.kernel.org; Sun, 24 Nov 2013 05:52:26 -0800
Date: Sun, 24 Nov 2013 05:52:26 -0800
From: Marc MERLIN <marc@merlins.org>
To: util-linux@vger.kernel.org
Subject: Severe fdisk problem leading to data loss?
Message-ID: <20131124135226.GH11389@merlins.org>
References: <20131118102051.GA31813@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131118102051.GA31813@merlins.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

I recently lost 10H of work because fdisk did something very bad: it created
multiple partitions starting in the same place, and when I mkfs'ed sda2, it
overwrote enough of sda4 to trash it beyond repair as well as killed linux by
writing over its swap on sda3

This is what my partitions looked like before I lost my system:

Disk /dev/sda: 1000.2 GB, 1000204886016 bytes                                                          
255 heads, 63 sectors/track, 121601 cylinders, total 1953525168 sectors                                
Units = sectors of 1 * 512 = 512 bytes                                                                 
Sector size (logical/physical): 512 bytes / 512 bytes                                                  
I/O size (minimum/optimal): 512 bytes / 512 bytes                                                      
Disk identifier: 0x0b8ccbaa                                                                            
                                                                                                       
   Device Boot      Start         End      Blocks   Id  System                                         
/dev/sda1            2048     1050623      524288   83  Linux                                          
/dev/sda2         1050624   105908223    52428800    0  Empty                                          
/dev/sda3         1050624    34605055    16777216   82  Linux swap / Solaris                           
/dev/sda4        34605056  1953525167   959460056   83  Linux        

Sure enough, it's reproduceable.
I'm kind of very late and should go to bed (doing a full restore of my laptop now from 
backup). Would you be able to pass this to the right folks?

gandalfthegreat:~# dpkg -l util-linux
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                Version        Architecture   Description
+++-===================-==============-==============-============================================
ii  util-linux          2.20.1-5.5     amd64          Miscellaneous system utilities
gandalfthegreat:~# fdisk -v
fdisk (util-linux 2.20.1)
gandalfthegreat:~# 


(I'm using -H32 -S32 here, but last time, I ran fdisk without them)
gandalfthegreat:/var/tmp# fdisk -H32 -S32 /dev/sda

Command (m for help): p

Disk /dev/sda: 1000.2 GB, 1000204886016 bytes
32 heads, 32 sectors/track, 1907739 cylinders, total 1953525168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0b8ccbaa

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1            2048     1050623      524288   83  Linux
/dev/sda2         1050624   105908223    52428800    0  Empty

Command (m for help): n
Partition type:
   p   primary (1 primary, 0 extended, 3 free)
   e   extended
Select (default p): p
Partition number (1-4, default 3): 
Using default value 3
First sector (1050624-1953525167, default 1050624): 105908224 << eek default is bad
Last sector, +sectors or +size{K,M,G} (105908224-1953525167, default 1953525167): +16G

Command (m for help): n
Partition type:
   p   primary (2 primary, 0 extended, 2 free)
   e   extended
Select (default p): p
Selected partition 4
First sector (1050624-1953525167, default 1050624):   << eek default is bad again
Using default value 1050624
Last sector, +sectors or +size{K,M,G} (1050624-105908223, default 105908223): 
Using default value 105908223

Command (m for help): p

Disk /dev/sda: 1000.2 GB, 1000204886016 bytes
32 heads, 32 sectors/track, 1907739 cylinders, total 1953525168 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0x0b8ccbaa

   Device Boot      Start         End      Blocks   Id  System
/dev/sda1            2048     1050623      524288   83  Linux
/dev/sda2         1050624   105908223    52428800    0  Empty
/dev/sda3       105908224   139462655    16777216   83  Linux
/dev/sda4         1050624   105908223    52428800   83  Linux

This looks like a severe bug. 
Kernel was 3.11 if that helps.

Disk is:
Device Model:     Samsung SSD 840 EVO 1TB
Serial Number:    S1D9NEAD934600N
LU WWN Device Id: 5 002538 85009a8ff
Firmware Version: EXT0BB0Q
User Capacity:    1,000,204,886,016 bytes [1.00 TB]
ATA Standard is:  ATA-8-ACS revision 4c

Thanks,
Marc
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
