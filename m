Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:49729 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753450AbcCJKky (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Mar 2016 05:40:54 -0500
Received: from assos.lan ([84.185.129.97]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0McVns-1aMIeB2xE0-00Hggb for
 <util-linux@vger.kernel.org>; Thu, 10 Mar 2016 11:40:51 +0100
From: =?iso-8859-1?q?R=FCdiger_Meier?= <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: sfdisk, stderr/stdout output order
Date: Thu, 10 Mar 2016 11:40:50 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <201603101140.50532.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hi,

I've found such test diffs with musl libc. Maybe it needs some fflush(3) 
calls.

 --- /home/rudi/devel/util-linux/tests/expected/sfdisk/dos-read-dump
+++ /tmp/build-musl/tests/output/sfdisk/dos-read-dump
@@ -1,5 +1,3 @@
-Partition 5 does not start on physical sector boundary.
-Partition 6 does not start on physical sector boundary.
 Checking that no-one is using this disk right now ... OK

 Disk <removed>: 50 MiB, 52428800 bytes, 102400 sectors
@@ -23,7 +21,9 @@
 <removed>1  *     2048   8191    6144   3M 83 Linux
 <removed>2        8192  14335    6144   3M 82 Linux swap / Solaris
 <removed>3       14336  20479    6144   3M 83 Linux
-<removed>4       20480 102399   81920  40M  5 Extended
+<removed>4       Partition 5 does not start on physical sector boundary.
+Partition 6 does not start on physical sector boundary.
+20480 102399   81920  40M  5 Extended
 <removed>5       20481  26624    6144   3M 83 Linux
 <removed>6       26626 102399   75774  37M 83 Linux


cu,
Rudi
