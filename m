Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaid.dreamhost.com ([208.97.132.83]:41806 "EHLO
	homiemail-a38.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751061Ab2GZJ3r (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 05:29:47 -0400
Subject: Re: fdisk geometry
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: John Lane <util-linux@jelmail.com>
Cc: util-linux@vger.kernel.org
In-Reply-To: <50109E8D.2000702@jelmail.com>
References: <50109E8D.2000702@jelmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 26 Jul 2012 11:29:40 +0200
Message-ID: <1343294980.2609.4.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Thu, 2012-07-26 at 02:34 +0100, John Lane wrote:
> Hello, I'm in the middle of studying disk organisation to enhance my 
> understanding in this area. I have a few questions about fdisk (trying 
> to fill a gap in my knowledge if that's ok)...

use the source, Luke :)

> 
> In the below output of fdisk it shows (correctly) a geometry of 224 
> heads, 56 sectors/track. I'm unclear about where this information comes 
> from. Normally a disk's geometry would be reported as 255 heads and 63 
> sectors. I explicitly partitioned this disk using a 224/56 geometry, so 
> the report is correct. I'd just like to understand:
> 
> (a) where fdisk gets the information about the geometry from in  this 
> specific case?

fdisk gets the information from (i) user input, (ii) what the
kernel/bios thinks the geometry is, with the HDIO_GETGEO ioctl and (iii)
by inferring it from the partition table geometry.

> (b) when fdisk defaults to 255/63 is that because it's hard coded that 
> way or is there another reason?

Correct.

> 
> I understand why it's 255/63 by default but haven't been able to 
> understand how the geometry is determined. I do know that it's all kind 
> of moot these days anyway because of sector based addressing but that 
> leads to one other question: given sector based addressing why does 
> fdisk even bother displaying a geometry any more ? Doesn't it just serve 
> to confuse?

That's because fdisk is/was mostly legacy code, we are currently
updating the program.

Cheers,
Davidlohr

> 
> # fdisk /dev/sda
> Welcome to fdisk (util-linux 2.21.2).
> 
> Changes will remain in memory only, until you decide to write them.
> Be careful before using the write command.
> 
> 
> Command (m for help): p
> 
> Disk /dev/sda: 80.0 GB, 80026361856 bytes
> 224 heads, 56 sectors/track, 12460 cylinders, total 156301488 sectors
> Units = sectors of 1 * 512 = 512 bytes
> Sector size (logical/physical): 512 bytes / 512 bytes
> I/O size (minimum/optimal): 512 bytes / 512 bytes
> Disk identifier: 0xc4c4122e
> 
>     Device Boot      Start         End      Blocks   Id  System
> /dev/sda1   *          56      501759      250852   83  Linux
> /dev/sda2          501760   156298239    77898240   8e  Linux LVM
> 
> Command (m for help): q
> 
> Many thanks for your time,
> John Lane.
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe util-linux" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


