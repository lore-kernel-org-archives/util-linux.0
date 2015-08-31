Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752735AbbHaLV6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 31 Aug 2015 07:21:58 -0400
Date: Mon, 31 Aug 2015 13:21:56 +0200
From: Karel Zak <kzak@redhat.com>
To: Matt Turner <mattst88@gmail.com>
Cc: util-linux@vger.kernel.org, alpha@gentoo.org
Subject: Re: fdisk BSD disklabel support?
Message-ID: <20150831112156.GH2726@ws.net.home>
References: <CAEdQ38F9RxBHgA+zKdwLKxdQncMUyqzowGcGidf-Vc1xbsXQOg@mail.gmail.com>
 <20150807195408.GA18302@ws.net.home>
 <CAEdQ38HMOG+dWU5CwLrQ+nGKe8n=p4WJ_RMF5NGcSX3C-jt6jg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CAEdQ38HMOG+dWU5CwLrQ+nGKe8n=p4WJ_RMF5NGcSX3C-jt6jg@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Fri, Aug 28, 2015 at 10:14:11PM -0700, Matt Turner wrote:
> Thanks for the reply.
> 
> We have a user reporting that this is not sufficient to make a
> bootable disk layout for DEC Alpha/SRM. Please see
> https://forums.gentoo.org/viewtopic-t-1025044.html

It would be nice to discuss with the user at util-linux@vger.kernel.org, 
he does not have to subscribe, the list is open.

It would be also nice to know how he uses fdisk v2.12 (copy & past) so
we can improve the current version.

> I take it that this is unexpected?

I have fixed (or improved) the issue with 'w', now it warns if you
write BSD disklabel, but parental DOS label is still in memory only.

Now about the partitions, the concept of the nested disklabel is not
our invention. For example Linux kernel does not accept another way
for {Free,Open,Net}BSD, Minix and Unixware partitions.

The important detail is that the BSD partitions (slices) has to be
marked as used (fdisk default is unused) and the size of the partition
has to be different than the parental DOS partition otherwise it's
ignored by Linux kernel.

You do not have to reboot and install extra hard disk to play with
fdisk -- all you need is scsi_debug kernel module to create virtual
disk (it uses RAM, so be careful with the disk size).

# modprobe scsi_debug dev_size_mb=500
# fdisk /dev/sdc

 ------ prepare parental DOS partition:

Welcome to fdisk (util-linux 2.27.rc2-19-1b766).
Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.

Device does not contain a recognized partition table.
Created a new DOS disklabel with disk identifier 0x3682a876.

Command (m for help): n
Partition type
   p   primary (0 primary, 0 extended, 4 free)
   e   extended (container for logical partitions)
Select (default p): 

Using default response p.
Partition number (1-4, default 1): 
First sector (2048-1023999, default 2048): 
Last sector, +sectors or +size{K,M,G,T,P} (2048-1023999, default 1023999): 

Created a new partition 1 of type 'Linux' and of size 499 MiB.

Command (m for help): t
Selected partition 1
Partition type (type L to list all types): a5
Changed type of partition 'Linux' to 'FreeBSD'.


  ------ create two ('a' and 'b') nested BSD partitions:

Command (m for help): b
The device /dev/sdc1 does not contain BSD disklabel.

Do you want to create a BSD disklabel? [Y]es/[N]o: Y

Entering nested BSD disklabel.

Command (m for help): p
Disk /dev/sdc1: 500 MiB, 524288000 bytes, 1024000 sectors
Geometry: 17 heads, 59 sectors/track, 1020 cylinders
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 32768 bytes
Disklabel type: bsd

Slice Start     End Sectors   Size Type     Fsize Bsize Cpg
c      2048 1023999 1021952   499M unused       0     0   0
d         0 1023059 1023060 499.6M unused       0     0   0

Partition table entries are not in disk order.

Command (m for help): n
Partition number (a,b,e-p, default a): 
First sector (2048-1023999, default 2048): 
Last sector, +sectors or +size{K,M,G,T,P} (2048-1023999, default 1023999): +50M

Command (m for help): p

Disk /dev/sdc1: 500 MiB, 524288000 bytes, 1024000 sectors
Geometry: 17 heads, 59 sectors/track, 1020 cylinders
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 32768 bytes
Disklabel type: bsd

Slice Start     End Sectors   Size Type     Fsize Bsize Cpg
a      2048  104448  102401    50M unused       0     0   0
c      2048 1023999 1021952   499M unused       0     0   0
d         0 1023059 1023060 499.6M unused       0     0   0

Partition table entries are not in disk order.

Command (m for help): n
Partition number (b,e-p, default b): 
First sector (2048-1023999, default 2048): 104449
                                           ^^^^^^
    ----> note that the default is useless in this case, you have 
          to specify sector after 'a' partition.

Last sector, +sectors or +size{K,M,G,T,P} (104449-1023999, default 1023999): 

Command (m for help): p

Disk /dev/sdc1: 500 MiB, 524288000 bytes, 1024000 sectors
Geometry: 17 heads, 59 sectors/track, 1020 cylinders
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 32768 bytes
Disklabel type: bsd

Slice  Start     End Sectors   Size Type     Fsize Bsize Cpg
a       2048  104448  102401    50M unused       0     0   0
b     104449 1023999  919551   449M unused       0     0   0
c       2048 1023999 1021952   499M unused       0     0   0
d          0 1023059 1023060 499.6M unused       0     0   0

Partition table entries are not in disk order.

   ------- unset "unused" flag!

Command (m for help): t
Partition number (a-d, default d): a
Partition type (type L to list all types): 7

Changed type of partition 'unused' to '4.2BSD'.

Command (m for help): t
Partition number (a-d, default d): b
Partition type (type L to list all types): 7

Changed type of partition 'unused' to '4.2BSD'.

Command (m for help): p
Disk /dev/sdc1: 500 MiB, 524288000 bytes, 1024000 sectors
Geometry: 17 heads, 59 sectors/track, 1020 cylinders
Units: sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 32768 bytes
Disklabel type: bsd

Slice  Start     End Sectors   Size Type     Fsize Bsize Cpg
a       2048  104448  102401    50M 4.2BSD       0     0   0
b     104449 1023999  919551   449M 4.2BSD       0     0   0
c       2048 1023999 1021952   499M unused       0     0   0
d          0 1023059 1023060 499.6M unused       0     0   0

Partition table entries are not in disk order.

Command (m for help): w
Syncing disks.
Disklabel written to /dev/sdc1 (don't forget to write /dev/sdc disklable too).

Command (m for help): r
Leaving nested disklabel.

Command (m for help): w
The partition table has been altered.
Calling ioctl() to re-read partition table.
Syncing disks.

   ------- see what kernel thinks about the partitions:

#  dmesg | tail -1
      sdc1: <bsd: sdc5 sdc6 >


# lsblk /dev/sdc
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
sdc      8:32   0  500M  0 disk 
├─sdc1   8:33   0  499M  0 part 
├─sdc5   8:37   0   50M  0 part 
└─sdc6   8:38   0  449M  0 part 

# mkfs.ext4 /dev/sdc5
mke2fs 1.42.12 (29-Aug-2014)
Creating filesystem with 51200 1k blocks and 12824 inodes
Filesystem UUID: 02a2bf04-d021-47fe-90b9-b411908c82b3
Superblock backups stored on blocks: 
	8193, 24577, 40961

Allocating group tables: done                            
Writing inode tables: done                            
Creating journal (4096 blocks): done
Writing superblocks and filesystem accounting information: done

# mount /dev/sdc5 /mnt/test
# ll /mnt/test
total 12
drwx------ 2 root root 12288 Aug 31 12:59 lost+found


... it's really no perfect and use-freindly, but I'm able to create BDS
partitions that are compatible with parser in Linux kernel. Well, I'm 
not sure about another OS, but it's another story :-)

	Karel


-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
