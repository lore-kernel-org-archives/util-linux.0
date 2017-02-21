Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:57824 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753584AbdBUQth (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 21 Feb 2017 11:49:37 -0500
Date: Tue, 21 Feb 2017 17:49:28 +0100
From: Karel Zak <kzak@redhat.com>
To: =?utf-8?Q?Bart=C5=82omiej_Solarz-Nies=C5=82uchowski?=
        <Bartlomiej.Solarz-Niesluchowski@wit.edu.pl>
Cc: util-linux@vger.kernel.org, Lukasz Trabinski <lukasz@trabinski.net>
Subject: Re: label-id and sfdisk problem
Message-ID: <20170221164928.geha65vjytxjsed5@ws.net.home>
References: <a1e37c78-0162-2c2a-813e-1b1abee27fcb@wit.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <a1e37c78-0162-2c2a-813e-1b1abee27fcb@wit.edu.pl>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Tue, Feb 21, 2017 at 05:31:25PM +0100, Bartłomiej Solarz-Niesłuchowski wrote:
> Dear List,
> 
> I have problem with setting label-id of dos partition table
> The problem occurs when i use sfdisk:
> 1. I "save" the partition table with sfdisk -d /dev/sda > saved.table (saved
> file has label-id of partition table)
> 2. then i restore this via sfdisk /dev/sda < saved.table
> BUT
> label-id of dos partition table can be changed in this operation e.g.:
> when i run command such:
> sfdisk -d /dev/sda > saved.table
> sfdisk /dev/sda < saved.table
> sfdisk -d /dev/sda
> sfdisk /dev/sda < saved.table
> sfdisk -d /dev/sda
> sfdisk /dev/sda < saved.table
> sfdisk -d /dev/sda
> 
> each time when i restore partition table label-id of dos type partition
> table is changed!
> 
> For me it is essential that label-id is set exactly as previous because
> after that i restore windows operationg system on this partitions and
> windows take care about label-id of boot disk partition table
> 
> Currently i use fdisk (expert option i) for setting label-id of partition,
> but why it is not possible thru sfdisk?

Version? I'm not able to reproduce this problem (v2.28.2 as well as
upstream tree with incoming v2.30).
    
       Karel


# modprobe scsi_debug dev_size_mb=100;
# echo ',,L' | sfdisk  /dev/sdc

        Disk /dev/sdc: 100 MiB, 104857600 bytes, 204800 sectors
        Units: sectors of 1 * 512 = 512 bytes
        Sector size (logical/physical): 512 bytes / 512 bytes
        I/O size (minimum/optimal): 512 bytes / 524288 bytes

        >>> Created a new DOS disklabel with disk identifier 0x6061f502.
        Created a new partition 1 of type 'Linux' and of size 99 MiB.
        /dev/sdc2:
        New situation:

        Device     Boot Start    End Sectors Size Id Type
        /dev/sdc1        2048 204799  202752  99M 83 Linux

# sfdisk -d /dev/sdc > saved
# cat saved

        label: dos
        label-id: 0x6061f502
        device: /dev/sdc
        unit: sectors

        /dev/sdc1 : start=        2048, size=      202752, type=83


# sfdisk  /dev/sdc < saved

        Disk /dev/sdc: 100 MiB, 104857600 bytes, 204800 sectors
        Units: sectors of 1 * 512 = 512 bytes
        Sector size (logical/physical): 512 bytes / 512 bytes
        I/O size (minimum/optimal): 512 bytes / 524288 bytes
        Disklabel type: dos
        Disk identifier: 0x6061f502

        Old situation:

        Device     Boot Start    End Sectors Size Id Type
        /dev/sdc1        2048 204799  202752  99M 83 Linux

        >>> Script header accepted.
        >>> Script header accepted.
        >>> Script header accepted.
        >>> Script header accepted.
        >>> Created a new DOS disklabel with disk identifier 0x6061f502.
        Created a new partition 1 of type 'Linux' and of size 99 MiB.
        /dev/sdc2: 
        New situation:

        Device     Boot Start    End Sectors Size Id Type
        /dev/sdc1        2048 204799  202752  99M 83 Linux

# sfdisk -d /dev/sdc 

        label: dos
        label-id: 0x6061f502
        device: /dev/sdc
        unit: sectors

        /dev/sdc1 : start=        2048, size=      202752, type=83


> 
> Best Regards
> 
> -- 
> Bartłomiej Solarz-Niesłuchowski, Administrator WSISiZ
> e-mail: Bartlomiej.Solarz-Niesluchowski@wit.edu.pl
> tel. 223486547, fax 223486501
> JID: solarz@jabber.wit.edu.pl
> 01-447 Warszawa, ul. Newelska 6, pokój 404, pon.-pt. 8-16
> Motto - Jak sobie pościelisz tak sie wyśpisz
> 
> 



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
