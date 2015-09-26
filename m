Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:56733 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751854AbbIZA6N convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 25 Sep 2015 20:58:13 -0400
Received: from md.localnet ([5.146.248.183]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0MFtf4-1ZsGrU3BPK-00EtyS for
 <util-linux@vger.kernel.org>; Sat, 26 Sep 2015 02:58:10 +0200
From: =?iso-8859-1?q?J=F6rg_Jenderek?= <joerg.jen.der.ek@gmx.net>
Reply-To: joerg.jen.der.ek@gmx.net
To: util-linux@vger.kernel.org
Subject: [PATCH] fdisk: to recognize partition type 0xEA (Rufus)
Date: Sat, 26 Sep 2015 02:58:06 +0200
MIME-Version: 1.0
Message-Id: <201509260258.07189.joerg.jen.der.ek@gmx.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dear util-linux maintainer,
i used a partitioning+formatting tool product rufus 2.2. of 
https://rufus.akeo.ie/
This software has an extra format option for older BIOS.
With this fix the main partition is created with some
alignments and for the remaining unallocated space 
a small extra and empty partition with identification 0xEA is created.

On the List of partition identifiers for PCs at
http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
is is said that there is a freedesktop proposal to use also type ea as boot partition

Unfortunately the software fdisk (util-linux-2.27) can not classify that 
partition.
I send for the fdisk program my 2 patches so that fdisk recognize this 
partition type.

pt-mbr-rufus.diff
--- util-linux-2.27/include/pt-mbr.h.old	2015-06-29 13:13:14.670847471 +0200
+++ util-linux-2.27/include/pt-mbr.h	2015-09-19 16:56:35.334002045 +0200
@@ -163,6 +163,7 @@
 	MBR_DOS_ACCESS_PARTITION	= 0xe1, /* DOS access or SpeedStor 12-bit FAT extended partition */
 	MBR_DOS_RO_PARTITION		= 0xe3, /* DOS R/O or SpeedStor */
 	MBR_SPEEDSTOR_EXTENDED_PARTITION = 0xe4, /* SpeedStor 16-bit FAT extended partition < 1024 cyl. */
+	MBR_RUFUS_EXTRA_PARTITION	= 0xea, /* Rufus extra partition for alignment */
 	MBR_BEOS_FS_PARTITION		= 0xeb,
 	MBR_GPT_PARTITION		= 0xee, /* Intel EFI GUID Partition Table */
 	MBR_EFI_SYSTEM_PARTITION	= 0xef, /* Intel EFI System Partition */

pt-mbr-partnames-rufus.diff
--- util-linux-2.27/include/pt-mbr-partnames.h.old	2015-06-29 13:13:14.669847478 +0200
+++ util-linux-2.27/include/pt-mbr-partnames.h	2015-09-19 16:47:15.531289074 +0200
@@ -88,6 +88,7 @@
 	{0xe3, N_("DOS R/O")},		/* DOS R/O or SpeedStor */
 	{0xe4, N_("SpeedStor")},	/* SpeedStor 16-bit FAT extended
 					   partition < 1024 cyl. */
+	{0xea, N_("Rufus alignment")},	/* Rufus extra partition for alignment */
 	{0xeb, N_("BeOS fs")},
 	{0xee, N_("GPT")},		/* Intel EFI GUID Partition Table */
 	{0xef, N_("EFI (FAT-12/16/32)")},/* Intel EFI System Partition */

Signed-off-by: Jörg Jenderek <joerg.jen.der.ek@gmx.net>
Sorry that i do this way, but i have no knowledge about git toys.

Hope you can apply my patches in a future version of  the fdisk program.

thanks,
Jörg Jenderek
-- 
Jörg Jenderek	email:	joerg.jen.der.ek (at) gmx.net
Germany

