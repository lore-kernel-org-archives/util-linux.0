Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:46793 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750834Ab3KYKbf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 25 Nov 2013 05:31:35 -0500
Date: Mon, 25 Nov 2013 11:31:24 +0100
From: Karel Zak <kzak@redhat.com>
To: Marc MERLIN <marc@merlins.org>
Cc: util-linux@vger.kernel.org
Subject: Re: Severe fdisk problem leading to data loss?
Message-ID: <20131125103124.GQ5572@x2.net.home>
References: <20131118102051.GA31813@merlins.org>
 <20131124135226.GH11389@merlins.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20131124135226.GH11389@merlins.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Sun, Nov 24, 2013 at 05:52:26AM -0800, Marc MERLIN wrote:
> Disk /dev/sda: 1000.2 GB, 1000204886016 bytes                          
> 255 heads, 63 sectors/track, 121601 cylinders, total 1953525168 sectors
> Units = sectors of 1 * 512 = 512 bytes                                
> Sector size (logical/physical): 512 bytes / 512 bytes                
> I/O size (minimum/optimal): 512 bytes / 512 bytes                   
> Disk identifier: 0x0b8ccbaa                                        
>                                                                   
>    Device Boot      Start         End      Blocks   Id  System   
> /dev/sda1            2048     1050623      524288   83  Linux   
> /dev/sda2         1050624   105908223    52428800    0  Empty  
                                                      ^^^^^^^^^^

Congratulation, you found very old fdisk bug as well as GNU Parted bug :-)

The problem is that the partition has no set partition type, and
fdisk in some situations interprets such partition as unused. 
 
So it lists the partition (print command), but the "add new
partition" command interprets this partition as unused.

> Command (m for help): n
> Partition type:
>    p   primary (1 primary, 0 extended, 3 free)
>    e   extended
> Select (default p): p
> Partition number (1-4, default 3): 
> Using default value 3
> First sector (1050624-1953525167, default 1050624): 105908224 << eek default is bad

 Yep.


It seems that GNU Parted is more consistent, it ignores the partition
at all :-), for example:

# fdisk -l /dev/sdb
...
Device    Boot     Start       End Blocks  Id System
/dev/sdb1           2048     22527  10240  83 Linux
/dev/sdb2          22528    227327 102400   0 Empty


# parted /dev/sdb print
...
Number  Start   End     Size    Type     File system  Flags
 1      1049kB  11.5MB  10.5MB  primary


This is definitely bug too, because Linux does not care about
partition type and kernel is able to use this partition:

# lsblk /dev/sdb
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sdb      8:16   0  600M  0 disk 
├─sdb1   8:17   0   10M  0 part 
└─sdb2   8:18   0  100M  0 part 


Note, don't use -S and -H, fdisk does not care about CHS by default
(you have to enable obsolete DOS mode ('c' command)).

I'm going to make fdisk more robust and prepare also a patch for GNU
parted.

Thanks!
    Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
