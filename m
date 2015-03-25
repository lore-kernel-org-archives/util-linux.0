Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:54416 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752203AbbCYSoG convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Mar 2015 14:44:06 -0400
Received: from md.localnet ([176.198.153.195]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0MdXSC-1YrRKJ0Nrg-00PPqF for
 <util-linux@vger.kernel.org>; Wed, 25 Mar 2015 19:44:03 +0100
From: =?iso-8859-1?q?J=F6rg_Jenderek?= <joerg.jen.der.ek@gmx.net>
Reply-To: joerg.jen.der.ek@gmx.net
To: util-linux@vger.kernel.org
Subject: [PATCH] fdisk: to recognize FAT32 partitions hidden by Acronis software
Date: Wed, 25 Mar 2015 20:44:01 +0200
MIME-Version: 1.0
Message-Id: <201503251944.01461.joerg.jen.der.ek@gmx.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dear util-linux maintainer,
i used a partitioning backup product of 
http://www.acronis.de/products/trueimage/
This software creates an extra partition named "ACRONIS Secure Zone " with 
the Recovery program and/or boot selector.

After some examination i found out that the partition contains a standard 
FAT32 file system with a special initial program loader in boot sector, 
which tries to load Acronis loader F11.SYS or BOOTWIZ.SYS  in older 
versions)
To avoid that an user or a virus can compromise the restore software the 
partition is hidden by adding 0xb0=176 to partition number.
So an FAT32 LBA (0x0c=12) gets number 0xbc=188.
Maybe also partition with ids 01, 04, 06, 07, 0b, 0c, 0e are hidden in this 
way. See List of partition identifiers for PCs at
http://www.win.tue.nl/~aeb/partitions/partition_types-1.html
Unfortunately the software fdisk (util-linux-ng 2.13-rc2 and 
util-linux-ng-2.14-rc3 and util-linux-2.26) can not classify that 
partition.
I send for the fdisk program my 2 patches so that fdisk recognize the Acronis partitions.

pt-mbr-acronis.diff
--- util-linux-2.26/include/pt-mbr.h.old	2015-02-10 10:49:46.000000000 +0100
+++ util-linux-2.26/include/pt-mbr.h	2015-03-25 19:30:49.000000000 +0100
@@ -150,2 +150,3 @@
 	MBR_BOOTWIZARD_HIDDEN_PARTITION	= 0xbb,
+	MBR_ACRONIS_FAT32LBA_PARTITION  = 0xbc, /* Acronis Secure Zone with ipl for loader F11.SYS */
 	MBR_SOLARIS_BOOT_PARTITION	= 0xbe,

pt-mbr-partnames-acronis.diff
--- util-linux-2.26/include/pt-mbr-partnames.h.old	2015-02-10 10:49:46.000000000 +0100
+++ util-linux-2.26/include/pt-mbr-partnames.h	2015-03-25 19:18:53.000000000 +0100
@@ -73,2 +73,6 @@
 	{0xbb, N_("Boot Wizard hidden")},
+	{0xbc, N_("Acronis FAT32 LBA")},/* hidden (+0xb0) FAT32 LBA with 
+					   ipl for Acronis loader F11.SYS 
+					   by Acronis partition backup software
+					   is called Acronis Secure Zone */
 	{0xbe, N_("Solaris boot")},
Signed-off-by: Jörg Jenderek <joerg.jen.der.ek@gmx.net>
Sorry that i do this way, but i have no knowledge about git toys.

Hope you can apply my patches in a future version of  the fdisk program.

thanks,
joerg jenderek
-- 
Jörg Jenderek	email:	joerg.jen.der.ek (at) gmx.net
Germany
