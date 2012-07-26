Return-Path: util-linux-owner@vger.kernel.org
Received: from avasout04.plus.net ([212.159.14.19]:34839 "EHLO
	avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751562Ab2GZAjT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 20:39:19 -0400
Message-ID: <50109E8D.2000702@jelmail.com>
Date: Thu, 26 Jul 2012 02:34:05 +0100
From: John Lane <util-linux@jelmail.com>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: fdisk geometry
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello, I'm in the middle of studying disk organisation to enhance my 
understanding in this area. I have a few questions about fdisk (trying 
to fill a gap in my knowledge if that's ok)...

In the below output of fdisk it shows (correctly) a geometry of 224 
heads, 56 sectors/track. I'm unclear about where this information comes 
from. Normally a disk's geometry would be reported as 255 heads and 63 
sectors. I explicitly partitioned this disk using a 224/56 geometry, so 
the report is correct. I'd just like to understand:

(a) where fdisk gets the information about the geometry from in  this 
specific case?
(b) when fdisk defaults to 255/63 is that because it's hard coded that 
way or is there another reason?

I understand why it's 255/63 by default but haven't been able to 
understand how the geometry is determined. I do know that it's all kind 
of moot these days anyway because of sector based addressing but that 
leads to one other question: given sector based addressing why does 
fdisk even bother displaying a geometry any more ? Doesn't it just serve 
to confuse?

# fdisk /dev/sda
Welcome to fdisk (util-linux 2.21.2).

Changes will remain in memory only, until you decide to write them.
Be careful before using the write command.


Command (m for help): p

Disk /dev/sda: 80.0 GB, 80026361856 bytes
224 heads, 56 sectors/track, 12460 cylinders, total 156301488 sectors
Units = sectors of 1 * 512 = 512 bytes
Sector size (logical/physical): 512 bytes / 512 bytes
I/O size (minimum/optimal): 512 bytes / 512 bytes
Disk identifier: 0xc4c4122e

    Device Boot      Start         End      Blocks   Id  System
/dev/sda1   *          56      501759      250852   83  Linux
/dev/sda2          501760   156298239    77898240   8e  Linux LVM

Command (m for help): q

Many thanks for your time,
John Lane.



