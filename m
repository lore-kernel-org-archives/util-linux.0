Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:49951 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752810AbbJGJlK convert rfc822-to-8bit (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 7 Oct 2015 05:41:10 -0400
Received: from md.localnet ([5.146.248.95]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LpKY5-1aDcO63xqf-00f9sf for
 <util-linux@vger.kernel.org>; Wed, 07 Oct 2015 11:41:07 +0200
From: =?iso-8859-1?q?J=F6rg_Jenderek?= <joerg.jen.der.ek@gmx.net>
Reply-To: joerg.jen.der.ek@gmx.net
To: util-linux@vger.kernel.org
Subject: [PATCH] fdisk: to recognize Intel Rapid Start hibernation partition
Date: Wed, 7 Oct 2015 11:41:23 +0200
MIME-Version: 1.0
Message-Id: <201510071141.23757.joerg.jen.der.ek@gmx.net>
Content-Type: text/plain;
  charset="iso-8859-1"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Dear util-linux maintainer,
i use Intel Rapid Start Technology on my PC. According to their 
User Guide "Rapid_Start_Technology_User_Guide_v1.4.pdf"
 i create a partition with id=84 for hibernation by this Technology.

Unfortunately the software fdisk (util-linux-2.27) classifies that partition 
as "OS/2 hidden C:".  That is not wrong, but 
on website https://en.wikipedia.org/wiki/Partition_type is written, that id 0x84
beside using for hiding drive C: this type is a also used as hibernation partition
for Microsoft  APM and also for Intel Rapid Start

So i patched 2 header files so that fdisk recognize this partition type variation

pt-mbr-intel-hibernation.diff
--- util-linux-2.27/include/pt-mbr.h.old	2015-06-29 13:13:14.670847471 +0200
+++ util-linux-2.27/include/pt-mbr.h	2015-10-05 19:18:44.948641032 +0200
@@ -129,7 +129,8 @@
 	MBR_LINUX_SWAP_PARTITION	= 0x82,
 	MBR_SOLARIS_X86_PARTITION	= MBR_LINUX_SWAP_PARTITION,
 	MBR_LINUX_DATA_PARTITION	= 0x83,
-	MBR_OS2_HIDDEN_DRIVE_PARTITION	= 0x84,
+	MBR_OS2_HIDDEN_DRIVE_PARTITION	= 0x84, /* also hibernation MS APM, Intel Rapid Start */
+	MBR_INTEL_HIBERNATION_PARTITION	= MBR_OS2_HIDDEN_DRIVE_PARTITION,
 	MBR_LINUX_EXTENDED_PARTITION	= 0x85,
 	MBR_NTFS_VOL_SET1_PARTITION	= 0x86,
 	MBR_NTFS_VOL_SET2_PARTITION	= 0x87,

pt-mbr-partnames-intel-hibernation.diff
--- util-linux-2.27/include/pt-mbr-partnames.h.old	2015-06-29 13:13:14.669847478 +0200
+++ util-linux-2.27/include/pt-mbr-partnames.h	2015-10-05 19:23:02.997989894 +0200
@@ -51,7 +51,9 @@
 	{0x81, N_("Minix / old Linux")},/* Minix 1.4b and later */
 	{0x82, N_("Linux swap / Solaris")},
 	{0x83, N_("Linux")},
-	{0x84, N_("OS/2 hidden C: drive")},
+	{0x84, N_("OS/2 h. C:|Intel hibernation")},/* OS/2 hidden C: drive,
+					   hibernation type Microsoft APM
+					   or hibernation Intel Rapid Start */
 	{0x85, N_("Linux extended")},
 	{0x86, N_("NTFS volume set")},
 	{0x87, N_("NTFS volume set")},


Signed-off-by: Jörg Jenderek <joerg.jen.der.ek@gmx.net>
Sorry that i do this way, but i have no knowledge about git toys.

Hope you can apply my patches in a future version of  the fdisk program.

thanks,
Jörg Jenderek
-- 
Jörg Jenderek	email:	joerg.jen.der.ek (at) gmx.net
Germany

