Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:51872 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755339Ab3A1N40 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 28 Jan 2013 08:56:26 -0500
Received: from mailout-de.gmx.net ([10.1.76.33]) by mrigmx.server.lan
 (mrigmx001) with ESMTP (Nemesis) id 0MSFoz-1USFz13Fsp-00TRSo for
 <util-linux@vger.kernel.org>; Mon, 28 Jan 2013 14:56:24 +0100
Message-ID: <5106838B.3020205@gmx.de>
Date: Mon, 28 Jan 2013 14:56:27 +0100
From: Ulf Zibis <Ulf.Zibis@gmx.de>
MIME-Version: 1.0
To: util-linux@vger.kernel.org
Subject: Bug with sfdisk - input of -d output fails
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi all,

sfdisk /dev/sda > sda.out
produces following output:
 >-------------------------------------->
# partition table of /dev/sda
unit: sectors

/dev/sda1 : start=       63, size= 48821472, Id= 7, bootable
/dev/sda2 : start=239191785, size= 73384920, Id= 7
/dev/sda3 : start= 48821535, size= 37784880, Id=83
/dev/sda4 : start= 86606415, size=152585370, Id= 5
/dev/sda5 : start=156232188, size= 10490382, Id= 7
/dev/sda6 : start=166722633, size= 72469152, Id= 7
/dev/sda7 : start= 86606541, size= 69625584, Id= 7
<--------------------------------------<

Just for test I immediately tried to use this data for input, but it failed ...

 >-------------------------------------->
root@PartedMagic:~# sfdisk /dev/sda < sda.out
Checking that no-one is using this disk right now ...
OK

Disk /dev/sda: 19457 cylinders, 255 heads, 63 sectors/track
Old situation:
Units = cylinders of 8225280 bytes, blocks of 1024 bytes, counting from 0

    Device Boot Start     End   #cyls    #blocks   Id  System
/dev/sda1   *      0+   3038    3039-  24410736    7 HPFS/NTFS/exFAT
/dev/sda2      14889   19456    4568   36692460    7 HPFS/NTFS/exFAT
/dev/sda3       3039    5390    2352   18892440   83  Linux
/dev/sda4       5391   14888    9498   76292685    5  Extended
/dev/sda5       9725+  10377     653-   5245191    7 HPFS/NTFS/exFAT
/dev/sda6      10378+  14888    4511-  36234576    7 HPFS/NTFS/exFAT
/dev/sda7       5391+   9724    4334-  34812792    7 HPFS/NTFS/exFAT
Warning: bad partition start (earliest 166722571)
sfdisk: bad input
root@PartedMagic:~#
<--------------------------------------<

Thanks for your attention,

-Ulf

