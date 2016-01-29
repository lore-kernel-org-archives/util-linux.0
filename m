Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:50007 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750914AbcA2Kbc (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 29 Jan 2016 05:31:32 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LraSn-1ZxUBL36rN-013M7X for
 <util-linux@vger.kernel.org>; Fri, 29 Jan 2016 11:31:30 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: test sfdisk, optimal_iosize
Date: Fri, 29 Jan 2016 11:31:28 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201601291131.29201.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I've got some test failures like

--- /home/abuild/rpmbuild/BUILD/util-linux-2.27.git247.4c01c/tests/expected/sfdisk/dos-activate
+++ /home/abuild/rpmbuild/BUILD/util-linux-2.27.git247.4c01c/tests/output/sfdisk/dos-activate
@@ -6,7 +6,7 @@
 Disk <removed>: 50 MiB, 52428800 bytes, 102400 sectors
 Units: sectors of 1 * 512 = 512 bytes
 Sector size (logical/physical): 512 bytes / 4096 bytes
-I/O size (minimum/optimal): 4096 bytes / 32768 bytes
+I/O size (minimum/optimal): 4096 bytes / 64 bytes
 Disklabel type: dos
 Disk identifier: <removed>


optimal < minimum ... is this a bug?

Where does this optimal iosize come from, scsi_debug module?
Is there a commandline tool to get this iosize, maybe blkid?

cu,
Rudi
