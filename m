Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout-de.gmx.net ([213.165.64.22]:53261 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754030Ab2K0OnG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Nov 2012 09:43:06 -0500
Message-ID: <50B4D192.70800@gmx.de>
Date: Tue, 27 Nov 2012 15:43:30 +0100
From: Ulf Zibis <Ulf.Zibis@gmx.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Re: question on sfdisk geometry estimation
References: <50B4927C.9010200@gmx.de>
In-Reply-To: <50B4927C.9010200@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Oops,

by now *completely* converting output of sfdisk -d, I now can see, that I was mostly in error, see 
below ...

Am 27.11.2012 11:14, schrieb Ulf Zibis:
> Hi,
>
> using sfdisk -l I had this output:
>
>
> Disk /dev/sdb: 10337 cylinders, 240 heads, 63 sectors/track
> Units = cylinders of 7741440 bytes, blocks of 1024 bytes, counting from 0
>
>    Device Boot Start     End   #cyls    #blocks   Id  System
> /dev/sdb1   *      0+   4604-   4605-  34812823+   7 HPFS/NTFS/exFAT
> /dev/sdb2       9782   10336     555    4195800   12  Compaq diagnostics
> /dev/sdb3       5952    9781    3830   28954800    f  W95 Ext'd (LBA)
> /dev/sdb4       4604+   5951-   1348-  10183680    7 HPFS/NTFS/exFAT
> /dev/sdb5       5952+   9781    3830-  28954768+   b  W95 FAT32

# partition table of /dev/sdb
unit: sectors

/dev/sdb1 : start=       63, size= 69625647, Id= 7, bootable
/dev/sdb2 : start=147903840, size=  8391600, Id=12
/dev/sdb3 : start= 89994240, size= 57909600, Id= f
/dev/sdb4 : start= 69625856, size= 20367360, Id= 7
/dev/sdb5 : start= 89994303, size= 57909537, Id= b

unit: C/H/S - 10337.4 cylinders, 240 heads, 63 sectors/track

/dev/sdb1 : start=    0/1/0,    size= 4604/209/0, Id= 7, bootable
/dev/sdb2 : start= 9782/0/0,    size=  555/0/0,   Id=12
/dev/sdb3 : start= 5952/0/0,    size= 3830/0/0,   Id= f
/dev/sdb4 : start= 4604/212/20, size= 1347/11/27, Id= 7
/dev/sdb5 : start= 5952/1/0,    size= 3829/239/0, Id= b

unit: C/H/S - 9729.3 cylinders, 255 heads, 63 sectors/track

/dev/sdb1 : start=    0/0/63,  size= 4333/254/0,  Id= 7, bootable
/dev/sdb2 : start= 9206/150/0, size=  522/90/0,   Id=12
/dev/sdb3 : start= 5601/225/0, size= 3604/180/0,  Id= f
/dev/sdb4 : start= 4334/2/20,  size= 1267/206/27, Id= 7
/dev/sdb5 : start= 5601/226/0, size= 3604/179/0,  Id= b

Thanks,

-Ulf

