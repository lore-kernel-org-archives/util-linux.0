Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:53622 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751532AbbFHPfh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 8 Jun 2015 11:35:37 -0400
Date: Mon, 8 Jun 2015 17:35:35 +0200
From: Karel Zak <kzak@redhat.com>
To: Tom Yan <tom.ty89@gmail.com>
Cc: util-linux@vger.kernel.org
Subject: Re: multiple alignment bugs / inconsistencies of fdisk
Message-ID: <20150608153535.GE1992@ws.net.home>
References: <CAGnHSE=QDqKbOKGrBH=4J_mv85V5ZumVmjoQ3Jpqig4CN4MU4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGnHSE=QDqKbOKGrBH=4J_mv85V5ZumVmjoQ3Jpqig4CN4MU4Q@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Mon, Jun 08, 2015 at 03:42:52PM +0800, Tom Yan wrote:
> So I have a disk with weird "optimal i/o size" of 33553920 bytes
> (actually I think it's because of the usb/sata converter):

Nice, the number is not power of 2, that's the problem :-)

It's possible to reproduce by:

  # modprobe scsi_debug dev_size_mb=1000 opt_blks=65535

I have fixed the code, so now:

>     Last sector, +sectors or +size{K,M,G,T,P} (65535-156301487, default 156301487): +500m
... 
>     Device     Boot Start     End Sectors  Size Id Type
>     /dev/sdb1       65535 1114094 1048560  512M 83 Linux

...
>     Last sector, +sectors or +size{K,M,G,T,P} (65535-156301487, default 156301487): +512m
...
>     Device     Boot Start     End Sectors  Size Id Type
>     /dev/sdb1       65535 1114110 1048576  512M 83 Linux


fixed version:

   Device     Boot Start     End Sectors  Size Id Type
   /dev/sdc1       65535 1114094 1048560  512M 83 Linux

for +500m as well as +512m.

> 
>     Command (m for help): n
>     Partition number (1-128, default 1):
>     First sector (65535-156301454, default 65535):
>     Last sector, +sectors or +size{K,M,G,T,P} (65535-156301454,
> default 156301454): +15m
>     Last sector, +sectors or +size{K,M,G,T,P} (65535-156301454,
> default 156301454): +16m

 I have improved the code to not align end of the partition if the
 size is smaller than grain (33553920 bytes in your case).

fixed version:

  Last sector, +sectors or +size{K,M,G,T,P} (65535-2047966, default 2047966): +15m

  Created a new partition 1 of type 'Linux filesystem' and of size 15 MiB.
  ...
  Device     Start   End Sectors Size Type
  /dev/sdc1  65535 96254   30720  15M Linux filesystem


> when I try to create a 1MiB partition, it creates one of 2048 sectors
> for both msdos and gpt, but then when I try to create smaller
> partitions which doesn't naturally "end-align", the result become
> ugly:
...
>     Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default 468862127): +1k
...
>     Device     Boot Start   End Sectors  Size Id Type
>     /dev/sda1        2048  2050       3  1.5K 83 Linux

Fixed, now:

    Device     Boot Start   End Sectors Size Id Type
    /dev/sdc1        2048  2049       2   1K 83 Linux

>     Command (m for help): o
>     Created a new DOS disklabel with disk identifier 0x6f4977c6.
> 
>     Command (m for help): n
>     Partition type
>        p   primary (0 primary, 0 extended, 4 free)
>        e   extended (container for logical partitions)
>     Select (default p):
> 
>     Using default response p.
>     Partition number (1-4, default 1):
>     First sector (2048-468862127, default 2048):
>     Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
> 468862127): +1023k
> 
>     Created a new partition 1 of type 'Linux' and of size 1023.5 KiB.
> 
>     Command (m for help): p
>     Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
>     Units: sectors of 1 * 512 = 512 bytes
>     Sector size (logical/physical): 512 bytes / 512 bytes
>     I/O size (minimum/optimal): 512 bytes / 512 bytes
>     Disklabel type: dos
>     Disk identifier: 0x6f4977c6
> 
>     Device     Boot Start   End Sectors    Size Id Type
>     /dev/sda1        2048  4094    2047 1023.5K 83 Linux

Fixed, now:

    Device     Boot Start   End Sectors  Size Id Type
    /dev/sdc1        2048  4093    2046 1023K 83 Linux

> The issue(s) seems to be related to how fdisk handle +0/+1 sector:
> 
>     [tom@localhost ~]$ sudo fdisk /dev/sda
> 
>     Welcome to fdisk (util-linux 2.26.2).
>     Changes will remain in memory only, until you decide to write them.
>     Be careful before using the write command.
> 
> 
>     Command (m for help): o
>     Created a new DOS disklabel with disk identifier 0x6473db40.
> 
>     Command (m for help): n
>     Partition type
>        p   primary (0 primary, 0 extended, 4 free)
>        e   extended (container for logical partitions)
>     Select (default p):
> 
>     Using default response p.
>     Partition number (1-4, default 1):
>     First sector (2048-468862127, default 2048):
>     Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
> 468862127): +0

 Now it returns "Value out of range".

>     Created a new partition 1 of type 'Linux' and of size 512 B.
> 
>     Command (m for help): p
>     Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
>     Units: sectors of 1 * 512 = 512 bytes
>     Sector size (logical/physical): 512 bytes / 512 bytes
>     I/O size (minimum/optimal): 512 bytes / 512 bytes
>     Disklabel type: dos
>     Disk identifier: 0x6473db40
> 
>     Device     Boot Start   End Sectors  Size Id Type
>     /dev/sda1        2048  2048       1  512B 83 Linux
> 
>     Command (m for help): o
>     Created a new DOS disklabel with disk identifier 0x344a2daa.
> 
>     Command (m for help): n
>     Partition type
>        p   primary (0 primary, 0 extended, 4 free)
>        e   extended (container for logical partitions)
>     Select (default p):
> 
>     Using default response p.
>     Partition number (1-4, default 1):
>     First sector (2048-468862127, default 2048):
>     Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
> 468862127): +1
> 
>     Created a new partition 1 of type 'Linux' and of size 1 KiB.
> 
>     Command (m for help): p
>     Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
>     Units: sectors of 1 * 512 = 512 bytes
>     Sector size (logical/physical): 512 bytes / 512 bytes
>     I/O size (minimum/optimal): 512 bytes / 512 bytes
>     Disklabel type: dos
>     Disk identifier: 0x344a2daa
> 
>     Device     Boot Start   End Sectors Size Id Type
>     /dev/sda1        2048  2049       2   1K 83 Linux

Fixed, now:

      Device     Boot Start   End Sectors  Size Id Type
      /dev/sdc1        2048  2048       1  512B 83 Linux


>     Command (m for help): o
>     Created a new DOS disklabel with disk identifier 0xc29ce8ba.
> 
>     Command (m for help): n
>     Partition type
>        p   primary (0 primary, 0 extended, 4 free)
>        e   extended (container for logical partitions)
>     Select (default p):
> 
>     Using default response p.
>     Partition number (1-4, default 1):
>     First sector (2048-468862127, default 2048):
>     Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
> 468862127): +2
> 
>     Created a new partition 1 of type 'Linux' and of size 1.5 KiB.
> 
>     Command (m for help): p
>     Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
>     Units: sectors of 1 * 512 = 512 bytes
>     Sector size (logical/physical): 512 bytes / 512 bytes
>     I/O size (minimum/optimal): 512 bytes / 512 bytes
>     Disklabel type: dos
>     Disk identifier: 0xc29ce8ba
> 
>     Device     Boot Start   End Sectors  Size Id Type
>     /dev/sda1        2048  2050       3  1.5K 83 Linux


Fixed, now:

     Device     Boot Start   End Sectors Size Id Type
     /dev/sdc1        2048  2049       2   1K 83 Linux

>     Command (m for help): o
>     Created a new DOS disklabel with disk identifier 0x67872ede.
> 
>     Command (m for help): n
>     Partition type
>        p   primary (0 primary, 0 extended, 4 free)
>        e   extended (container for logical partitions)
>     Select (default p):
> 
>     Using default response p.
>     Partition number (1-4, default 1):
>     First sector (2048-468862127, default 2048):
>     Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
> 468862127): +2048
> 
>     Created a new partition 1 of type 'Linux' and of size 1 MiB.
> 
>     Command (m for help): p
>     Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
>     Units: sectors of 1 * 512 = 512 bytes
>     Sector size (logical/physical): 512 bytes / 512 bytes
>     I/O size (minimum/optimal): 512 bytes / 512 bytes
>     Disklabel type: dos
>     Disk identifier: 0x67872ede
> 
>     Device     Boot Start   End Sectors Size Id Type
>     /dev/sda1        2048  4096    2049   1M 83 Linux

Fixed, now:

      Device     Boot Start   End Sectors Size Id Type
      /dev/sdc1        2048  4095    2048   1M 83 Linux


Thanks!

   Karel

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
