Return-Path: util-linux-owner@vger.kernel.org
Received: from mailout-de.gmx.net ([213.165.64.22]:50355 "HELO
	mailout-de.gmx.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S933439Ab2K0KNz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Nov 2012 05:13:55 -0500
Message-ID: <50B4927C.9010200@gmx.de>
Date: Tue, 27 Nov 2012 11:14:20 +0100
From: Ulf Zibis <Ulf.Zibis@gmx.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: question on sfdisk geometry estimation
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

using sfdisk -l I had this output:

Disk /dev/sda: 19457 cylinders, 255 heads, 63 sectors/track
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

    Device Boot Start     End   #cyls    #blocks   Id  System
/dev/sda1   *      0+   3038    3039-  24410736    7  HPFS/NTFS/exFAT
/dev/sda2      18936+  19456-    521-   4180680   12  Compaq diagnostics
/dev/sda3       3039    5390    2352   18892440   83  Linux
/dev/sda4       5391   18935   13545  108800212+   5  Extended
/dev/sda5       9725+  12764    3040-  24418768+   7  HPFS/NTFS/exFAT
/dev/sda6      12765+  18935    6171-  49568526    7  HPFS/NTFS/exFAT

Disk /dev/sdb: 10337 cylinders, 240 heads, 63 sectors/track
Units = cylinders of 7741440 bytes, blocks of 1024 bytes, counting from 0

    Device Boot Start     End   #cyls    #blocks   Id  System
/dev/sdb1   *      0+   4604-   4605-  34812823+   7  HPFS/NTFS/exFAT
/dev/sdb2       9782   10336     555    4195800   12  Compaq diagnostics
/dev/sdb3       5952    9781    3830   28954800    f  W95 Ext'd (LBA)
/dev/sdb4       4604+   5951-   1348-  10183680    7  HPFS/NTFS/exFAT
/dev/sdb5       5952+   9781    3830-  28954768+   b  W95 FAT32


So I'm wondering why sfdisk assumed sdb to be 240 head-aligned instead of 255.
All partitions except the sdb2 match with the 255*63 alignment.

Any hint, how the geometry should be estimated correctly?

Many thanks to your answer,

-Ulf

