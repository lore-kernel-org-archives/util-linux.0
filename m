Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f48.google.com ([209.85.192.48]:35577 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752141AbbFHHmx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Jun 2015 03:42:53 -0400
Received: by qgg3 with SMTP id 3so21306598qgg.2
        for <util-linux@vger.kernel.org>; Mon, 08 Jun 2015 00:42:52 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 8 Jun 2015 15:42:52 +0800
Message-ID: <CAGnHSE=QDqKbOKGrBH=4J_mv85V5ZumVmjoQ3Jpqig4CN4MU4Q@mail.gmail.com>
Subject: multiple alignment bugs / inconsistencies of fdisk
From: Tom Yan <tom.ty89@gmail.com>
To: util-linux@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

So I have a disk with weird "optimal i/o size" of 33553920 bytes
(actually I think it's because of the usb/sata converter):

    [tom@localhost ~]$ sudo fdisk -l /dev/sdb
    Disk /dev/sdb: 74.5 GiB, 80026361856 bytes, 156301488 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 33553920 bytes

and fdisk make use of that to determine its alignment. I don't
consider that a problem yet, but the inconsistency of fdisk alignment
policy:

    [tom@localhost ~]$ sudo fdisk /dev/sdb

    Welcome to fdisk (util-linux 2.26.2).
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.

    Device does not contain a recognized partition table.
    Created a new DOS disklabel with disk identifier 0x604d5491.

    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):

    Using default response p.
    Partition number (1-4, default 1):
    First sector (65535-156301487, default 65535):
    Last sector, +sectors or +size{K,M,G,T,P} (65535-156301487,
default 156301487): +500m

    Created a new partition 1 of type 'Linux' and of size 512 MiB.

    Command (m for help): p
    Disk /dev/sdb: 74.5 GiB, 80026361856 bytes, 156301488 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 33553920 bytes
    Disklabel type: dos
    Disk identifier: 0x604d5491

    Device     Boot Start     End Sectors  Size Id Type
    /dev/sdb1       65535 1114094 1048560  512M 83 Linux

    Command (m for help): o
    Created a new DOS disklabel with disk identifier 0x77cb1fd6.

    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):

    Using default response p.
    Partition number (1-4, default 1):
    First sector (65535-156301487, default 65535):
    Last sector, +sectors or +size{K,M,G,T,P} (65535-156301487,
default 156301487): +512m

    Created a new partition 1 of type 'Linux' and of size 512 MiB.

    Command (m for help): p
    Disk /dev/sdb: 74.5 GiB, 80026361856 bytes, 156301488 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 33553920 bytes
    Disklabel type: dos
    Disk identifier: 0x77cb1fd6

    Device     Boot Start     End Sectors  Size Id Type
    /dev/sdb1       65535 1114110 1048576  512M 83 Linux

    Command (m for help): q


As you can see/calculate, when I try to make a 500MiB partition, fdisk
try to round the size up so that the partition end at the alignment
boundary, yet when I try to add a 512MiB partition, it doesn't do any
rounding up or down. This happen for both msdos and gpt. Then I try to
add a 1MiB partition, more weird things happened:

    [tom@localhost ~]$ sudo fdisk /dev/sdb

    Welcome to fdisk (util-linux 2.26.2).
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.

    Device does not contain a recognized partition table.
    Created a new DOS disklabel with disk identifier 0xe6e360c0.

    Command (m for help): g
    Created a new GPT disklabel (GUID: 09418DB1-FB4B-4CC5-9259-60561C0A352B).

    Command (m for help): n
    Partition number (1-128, default 1):
    First sector (65535-156301454, default 65535):
    Last sector, +sectors or +size{K,M,G,T,P} (65535-156301454,
default 156301454): +15m
    Last sector, +sectors or +size{K,M,G,T,P} (65535-156301454,
default 156301454): +16m

    Created a new partition 1 of type 'Linux filesystem' and of size 32 MiB.

    Command (m for help): p
    Disk /dev/sdb: 74.5 GiB, 80026361856 bytes, 156301488 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 33553920 bytes
    Disklabel type: gpt
    Disk identifier: 09418DB1-FB4B-4CC5-9259-60561C0A352B

    Device     Start    End Sectors Size Type
    /dev/sdb1  65535 131069   65535  32M Linux filesystem

    Command (m for help): o
    Created a new DOS disklabel with disk identifier 0x7bbf0050.

    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):

    Using default response p.
    Partition number (1-4, default 1):
    First sector (65535-156301487, default 65535):
    Last sector, +sectors or +size{K,M,G,T,P} (65535-156301487,
default 156301487): +1m

    Created a new partition 1 of type 'Linux' and of size 1 MiB.

    Command (m for help): p
    Disk /dev/sdb: 74.5 GiB, 80026361856 bytes, 156301488 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 33553920 bytes
    Disklabel type: dos
    Disk identifier: 0x7bbf0050

    Device     Boot Start   End Sectors Size Id Type
    /dev/sdb1       65535 67583    2049   1M 83 Linux

    Command (m for help): q


As you can see, for gpt it only creates a "end-aligned" partition of
32MiB until the number I enter reach 16, but for msdos it creates a
weird partition of 2049 sectors (instead of 2048).

Then I move on testing with a disk of "normal" sector and i/o sizes:

    [tom@localhost ~]$ sudo fdisk -l /dev/sda
    Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes


when I try to create a 1MiB partition, it creates one of 2048 sectors
for both msdos and gpt, but then when I try to create smaller
partitions which doesn't naturally "end-align", the result become
ugly:

    [tom@localhost ~]$ sudo fdisk /dev/sda

    Welcome to fdisk (util-linux 2.26.2).
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.


    Command (m for help): o
    Created a new DOS disklabel with disk identifier 0xb84f3480.

    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):

    Using default response p.
    Partition number (1-4, default 1):
    First sector (2048-468862127, default 2048):
    Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
468862127): +1k

    Created a new partition 1 of type 'Linux' and of size 1.5 KiB.

    Command (m for help): p
    Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0xb84f3480

    Device     Boot Start   End Sectors  Size Id Type
    /dev/sda1        2048  2050       3  1.5K 83 Linux

    Command (m for help): o
    Created a new DOS disklabel with disk identifier 0x6f4977c6.

    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):

    Using default response p.
    Partition number (1-4, default 1):
    First sector (2048-468862127, default 2048):
    Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
468862127): +1023k

    Created a new partition 1 of type 'Linux' and of size 1023.5 KiB.

    Command (m for help): p
    Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x6f4977c6

    Device     Boot Start   End Sectors    Size Id Type
    /dev/sda1        2048  4094    2047 1023.5K 83 Linux

    Command (m for help): o
    Created a new DOS disklabel with disk identifier 0x7e1a99b9.

    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):

    Using default response p.
    Partition number (1-4, default 1):
    First sector (2048-468862127, default 2048):
    Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
468862127): +1024k

    Created a new partition 1 of type 'Linux' and of size 1 MiB.

    Command (m for help): p
    Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x7e1a99b9

    Device     Boot Start   End Sectors Size Id Type
    /dev/sda1        2048  4095    2048   1M 83 Linux

    Command (m for help): q

Before it reach 1MiB, it creates ".5 KiB" partitions of odd numbers of
sectors. This happens for msdos only; for gpt it doesn't allow
partition smaller than 1MiB and round it up once the number reach 512.

The issue(s) seems to be related to how fdisk handle +0/+1 sector:

    [tom@localhost ~]$ sudo fdisk /dev/sda

    Welcome to fdisk (util-linux 2.26.2).
    Changes will remain in memory only, until you decide to write them.
    Be careful before using the write command.


    Command (m for help): o
    Created a new DOS disklabel with disk identifier 0x6473db40.

    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):

    Using default response p.
    Partition number (1-4, default 1):
    First sector (2048-468862127, default 2048):
    Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
468862127): +0

    Created a new partition 1 of type 'Linux' and of size 512 B.

    Command (m for help): p
    Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x6473db40

    Device     Boot Start   End Sectors  Size Id Type
    /dev/sda1        2048  2048       1  512B 83 Linux

    Command (m for help): o
    Created a new DOS disklabel with disk identifier 0x344a2daa.

    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):

    Using default response p.
    Partition number (1-4, default 1):
    First sector (2048-468862127, default 2048):
    Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
468862127): +1

    Created a new partition 1 of type 'Linux' and of size 1 KiB.

    Command (m for help): p
    Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x344a2daa

    Device     Boot Start   End Sectors Size Id Type
    /dev/sda1        2048  2049       2   1K 83 Linux

    Command (m for help): o
    Created a new DOS disklabel with disk identifier 0xc29ce8ba.

    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):

    Using default response p.
    Partition number (1-4, default 1):
    First sector (2048-468862127, default 2048):
    Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
468862127): +2

    Created a new partition 1 of type 'Linux' and of size 1.5 KiB.

    Command (m for help): p
    Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0xc29ce8ba

    Device     Boot Start   End Sectors  Size Id Type
    /dev/sda1        2048  2050       3  1.5K 83 Linux

    Command (m for help): o
    Created a new DOS disklabel with disk identifier 0x67872ede.

    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p):

    Using default response p.
    Partition number (1-4, default 1):
    First sector (2048-468862127, default 2048):
    Last sector, +sectors or +size{K,M,G,T,P} (2048-468862127, default
468862127): +2048

    Created a new partition 1 of type 'Linux' and of size 1 MiB.

    Command (m for help): p
    Disk /dev/sda: 223.6 GiB, 240057409536 bytes, 468862128 sectors
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 512 bytes
    I/O size (minimum/optimal): 512 bytes / 512 bytes
    Disklabel type: dos
    Disk identifier: 0x67872ede

    Device     Boot Start   End Sectors Size Id Type
    /dev/sda1        2048  4096    2049   1M 83 Linux

    Command (m for help): q

As you can see, it consider "+0" as 1 sector, "+1" as 2 sectors, and
so on. IMHO this also cause inconvenience when someone actually try to
create partitions by entering number of sectors (one always need to
"minus one" for that). It's the same case for gpt, except you can't do
"+0" for it.
