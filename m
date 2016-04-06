Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:49975 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754342AbcDFHQQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 03:16:16 -0400
Received: from tenfore.ga-group.nl ([2.247.82.193]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LpwZn-1bQrb13ebP-00ffRG for
 <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 09:16:13 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] tests: add fdisk/bsd hexdump for alpha
Date: Wed,  6 Apr 2016 09:16:09 +0200
Message-Id: <1459926971-26313-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Taken from Debian build logs:
https://buildd.debian.org/status/fetch.php?pkg=util-linux&arch=alpha&ver=2.28~rc2-1&stamp=1459443555

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/fdisk/bsd_0_64_alpha.LE | 217 +++++++++++++++++++++++++++++++++
 1 file changed, 217 insertions(+)
 create mode 100644 tests/expected/fdisk/bsd_0_64_alpha.LE

diff --git a/tests/expected/fdisk/bsd_0_64_alpha.LE b/tests/expected/fdisk/bsd_0_64_alpha.LE
new file mode 100644
index 0000000..1c2a368
--- /dev/null
+++ b/tests/expected/fdisk/bsd_0_64_alpha.LE
@@ -0,0 +1,217 @@
+BSD_LABELSECTOR=0
+BSD_LABELOFFSET=64
+BSD_EXTRA=_alpha
+BYTE_ORDER=LE
+
+Initialize empty image
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00a00000
+Create new DOS partition table
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000001b0  00 00 00 00 00 00 00 00  01 00 00 00 00 00 00 00  |................|
+000001c0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
+00000200  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00a00000
+
+---layout----------
+Disk <removed>: 10 MiB, 10485760 bytes, 20480 sectors
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: dos
+Disk identifier: <removed>
+-------------------
+
+Create 1st primary partition
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000001b0  00 00 00 00 00 00 00 00  01 00 00 00 00 00 00 20  |............... |
+000001c0  21 00 83 41 01 00 00 08  00 00 00 08 00 00 00 00  |!..A............|
+000001d0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
+00000200  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00a00000
+
+---layout----------
+Disk <removed>: 10 MiB, 10485760 bytes, 20480 sectors
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: dos
+Disk identifier: <removed>
+
+Device     Boot Start   End Sectors Size Id Type
+<removed>1       2048  4095    2048   1M 83 Linux
+-------------------
+
+Create 2st primary partition
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000001b0  00 00 00 00 00 00 00 00  01 00 00 00 00 00 00 20  |............... |
+000001c0  21 00 83 41 01 00 00 08  00 00 00 08 00 00 00 04  |!..A............|
+000001d0  01 3e 83 13 41 36 00 10  00 00 00 40 00 00 00 00  |.>..A6.....@....|
+000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
+00000200  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00a00000
+Set 2nd partition type
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000001b0  00 00 00 00 00 00 00 00  01 00 00 00 00 00 00 20  |............... |
+000001c0  21 00 83 41 01 00 00 08  00 00 00 08 00 00 00 04  |!..A............|
+000001d0  01 3e a5 13 41 36 00 10  00 00 00 40 00 00 00 00  |.>..A6.....@....|
+000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
+00000200  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00a00000
+
+---layout----------
+Disk <removed>: 10 MiB, 10485760 bytes, 20480 sectors
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: dos
+Disk identifier: <removed>
+
+Device     Boot Start   End Sectors Size Id Type
+<removed>1       2048  4095    2048   1M 83 Linux
+<removed>2       4096 20479   16384   8M a5 FreeBSD
+-------------------
+
+Create default BSD
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000001b0  00 00 00 00 00 00 00 00  01 00 00 00 00 00 00 20  |............... |
+000001c0  21 00 83 41 01 00 00 08  00 00 00 08 00 00 00 04  |!..A............|
+000001d0  01 3e a5 13 41 36 00 10  00 00 00 40 00 00 00 00  |.>..A6.....@....|
+000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
+00000200  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00200040  57 45 56 82 06 00 00 00  00 00 00 00 00 00 00 00  |WEV.............|
+00200050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00200060  00 00 00 00 00 00 00 00  00 02 00 00 3f 00 00 00  |............?...|
+00200070  ff 00 00 00 01 00 00 00  c1 3e 00 00 c1 3e 00 00  |.........>...>..|
+00200080  00 00 00 00 00 00 00 00  10 0e 01 00 00 00 00 00  |................|
+00200090  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+002000c0  00 00 00 00 57 45 56 82  13 62 04 00 00 20 00 00  |....WEV..b... ..|
+002000d0  00 20 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |. ..............|
+002000e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+002000f0  00 00 00 00 00 40 00 00  00 10 00 00 00 00 00 00  |.....@..........|
+00200100  00 00 00 00 c1 3e 00 00  00 00 00 00 00 00 00 00  |.....>..........|
+00200110  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+002001f0  00 00 00 00 00 00 00 00  3a 27 5c 82 1f 23 57 82  |........:'\..#W.|
+00200200  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00a00000
+
+---layout----------
+
+Welcome to fdisk <removed>.
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
+
+Command (m for help): Entering nested BSD disklabel.
+
+Command (m for help): Disk <removed>2: 10 MiB, 10485760 bytes, 20480 sectors
+Geometry: 255 heads, 63 sectors/track, 1 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: bsd
+
+Slice Start   End Sectors  Size Type     Fsize Bsize Cpg
+c      4096 20479   16384    8M unused       0     0   0
+d         0 16064   16065  7.9M unused       0     0   0
+
+Partition table entries are not in disk order.
+
+Command (m for help): Leaving nested disklabel.
+
+Command (m for help): 
+-------------------
+
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+000001b0  00 00 00 00 00 00 00 00  01 00 00 00 00 00 00 20  |............... |
+000001c0  21 00 83 41 01 00 00 08  00 00 00 08 00 00 00 04  |!..A............|
+000001d0  01 3e a5 13 41 36 00 10  00 00 00 40 00 00 00 00  |.>..A6.....@....|
+000001e0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+000001f0  00 00 00 00 00 00 00 00  00 00 00 00 00 00 55 aa  |..............U.|
+00000200  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00200040  57 45 56 82 06 00 00 00  00 00 00 00 00 00 00 00  |WEV.............|
+00200050  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00200060  00 00 00 00 00 00 00 00  00 02 00 00 3f 00 00 00  |............?...|
+00200070  ff 00 00 00 01 00 00 00  c1 3e 00 00 c1 3e 00 00  |.........>...>..|
+00200080  00 00 00 00 00 00 00 00  10 0e 01 00 00 00 00 00  |................|
+00200090  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+002000c0  00 00 00 00 57 45 56 82  15 7a 04 00 00 20 00 00  |....WEV..z... ..|
+002000d0  00 20 00 00 01 08 00 00  00 10 00 00 00 00 00 00  |. ..............|
+002000e0  07 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+002000f0  00 00 00 00 00 40 00 00  00 10 00 00 00 00 00 00  |.....@..........|
+00200100  00 00 00 00 c1 3e 00 00  00 00 00 00 00 00 00 00  |.....>..........|
+00200110  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+002001f0  00 00 00 00 00 00 00 00  43 4f 5c 82 20 2b 57 82  |........CO\. +W.|
+00200200  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00a00000
+
+---layout----------
+
+Welcome to fdisk <removed>.
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
+
+Command (m for help): Entering nested BSD disklabel.
+
+Command (m for help): Disk <removed>2: 10 MiB, 10485760 bytes, 20480 sectors
+Geometry: 255 heads, 63 sectors/track, 1 cylinders
+Units: sectors of 1 * 512 = 512 bytes
+Sector size (logical/physical): 512 bytes / 512 bytes
+I/O size (minimum/optimal): 512 bytes / <removed> bytes
+Disklabel type: bsd
+
+Slice Start   End Sectors  Size Type     Fsize Bsize Cpg
+a      4096  6144    2049    1M 4.2BSD       0     0   0
+c      4096 20479   16384    8M unused       0     0   0
+d         0 16064   16065  7.9M unused       0     0   0
+
+Partition table entries are not in disk order.
+
+Command (m for help): Leaving nested disklabel.
+
+Command (m for help): 
+-------------------
+
+
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
+
+Command (m for help): Entering nested BSD disklabel.
+
+Command (m for help): 
+ 0  unused           5  4.1BSD           9  4.4LFS           d  boot           
+ 1  swap             6  Eighth Edition   a  unknown          e  ADOS           
+ 2  Version 6        7  4.2BSD           b  HPFS             f  HFS            
+ 3  Version 7        8  ext2             c  ISO-9660        10  AdvFS          
+ 4  System V       
+
+Command (m for help): 
-- 
1.8.4.5

