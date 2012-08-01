Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:56292 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754592Ab2HAHhr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 1 Aug 2012 03:37:47 -0400
Message-ID: <5018DCC8.1050803@bernhard-voelker.de>
Date: Wed, 01 Aug 2012 09:37:44 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] tests: fix layout info in dos and non-dos mode fdisk test
Content-Type: multipart/mixed;
 boundary="------------090909020600070900060703"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is a multi-part message in MIME format.
--------------090909020600070900060703
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Karel,

since you added the layout info to ts/fdisk/mbr-dos-mode, that test fails.
It seems you inserted too many blanks in the header line (... or that test
behaves differently on my machine).
Likewise with the new mbr-nondos-mode test.

Given the result is not hosed on my machine, I've attached a patch
to adapt the expected output of both tests.

Example:
-                                                                   Device Boot      Start         End      Blocks   Id
 System
+                                                               Device Boot      Start         End      Blocks   Id  System

(I attached it because the lines are rather long and I don't want
any mail software in between to break the lines).

Have a nice day,
Berny


--------------090909020600070900060703
Content-Type: text/x-patch;
 name="tests-fdisk-mbr-layout.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tests-fdisk-mbr-layout.diff"

>From 7bfad48f215fcd963d13d76b23c542892e3ecf06 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Wed, 1 Aug 2012 09:30:57 +0200
Subject: [PATCH] tests: fix layout info in dos and non-dos mode fdisk test

* tests/expected/fdisk/mbr-dos-mode: Change identation of layout info
header to match actual number of leading blanks.
* tests/expected/fdisk/mbr-nondos-mode: Likewise.
Bug introduced in v2.22-rc1-17-g2650cac and v2.22-rc1-20-g675c1ff.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 tests/expected/fdisk/mbr-dos-mode    |   22 +++++++++++-----------
 tests/expected/fdisk/mbr-nondos-mode |   24 ++++++++++++------------
 2 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/tests/expected/fdisk/mbr-dos-mode b/tests/expected/fdisk/mbr-dos-mode
index 16de4d5..ebf7265 100644
--- a/tests/expected/fdisk/mbr-dos-mode
+++ b/tests/expected/fdisk/mbr-dos-mode
@@ -11,7 +11,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 -------------------
 
 Create primary partition
@@ -25,7 +25,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1               1           1        8001   83  Linux
 -------------------
 
@@ -40,7 +40,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1               1           1        8001   bf  Solaris
 -------------------
 
@@ -55,7 +55,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1   *           1           1        8001   bf  Solaris
 -------------------
 
@@ -70,7 +70,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1               1           1        8001   83  Linux
 -------------------
 
@@ -85,7 +85,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1               1           1        8001   83  Linux
 __ts_dev__2               2          12       88357+   5  Extended
 -------------------
@@ -101,7 +101,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1               1           1        8001   83  Linux
 __ts_dev__2               2          12       88357+   5  Extended
 __ts_dev__5               2           3       16033+  83  Linux
@@ -121,7 +121,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1               1           1        8001   83  Linux
 __ts_dev__2               2          12       88357+   5  Extended
 __ts_dev__5               6           7       16033+  83  Linux
@@ -138,7 +138,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1               1           1        8001   83  Linux
 __ts_dev__2               2          12       88357+   5  Extended
 __ts_dev__5               6           7       16033+  83  Linux
@@ -158,7 +158,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 __ts_dev__2               2          12       88357+   5  Extended
 __ts_dev__5               6           7       16033+  83  Linux
 __ts_dev__6               2           3       16033+  83  Linux
@@ -177,6 +177,6 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                   Device Boot      Start         End      Blocks   Id  System
+                                                               Device Boot      Start         End      Blocks   Id  System
 -------------------
 
diff --git a/tests/expected/fdisk/mbr-nondos-mode b/tests/expected/fdisk/mbr-nondos-mode
index 088ce67..058ba3c 100644
--- a/tests/expected/fdisk/mbr-nondos-mode
+++ b/tests/expected/fdisk/mbr-nondos-mode
@@ -10,7 +10,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 -------------------
 
 Create 1st primary partition
@@ -23,7 +23,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1            2048        8191        3072   83  Linux
 -------------------
 
@@ -37,7 +37,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1   *        2048        8191        3072   83  Linux
 -------------------
 
@@ -51,7 +51,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1            2048        8191        3072   83  Linux
 -------------------
 
@@ -65,7 +65,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1            2048        8191        3072   83  Linux
 __ts_dev__2            8192       12287        2048   83  Linux
 -------------------
@@ -80,7 +80,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1            2048        8191        3072   83  Linux
 __ts_dev__2            8192       12287        2048   83  Linux
 __ts_dev__3           12288       40959       14336    5  Extended
@@ -96,7 +96,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1            2048        8191        3072   83  Linux
 __ts_dev__2            8192       12287        2048   83  Linux
 __ts_dev__3           12288       40959       14336    5  Extended
@@ -116,7 +116,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1            2048        8191        3072   83  Linux
 __ts_dev__2            8192       12287        2048   83  Linux
 __ts_dev__3           12288       40959       14336    5  Extended
@@ -133,7 +133,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 __ts_dev__1            2048        8191        3072   83  Linux
 __ts_dev__2            8192       12287        2048   83  Linux
 __ts_dev__3           12288       40959       14336    5  Extended
@@ -153,7 +153,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 __ts_dev__2            8192       12287        2048   83  Linux
 __ts_dev__3           12288       40959       14336    5  Extended
 __ts_dev__5           26624       30719        2048   83  Linux
@@ -172,7 +172,7 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 __ts_dev__3           12288       40959       14336    5  Extended
 __ts_dev__5           26624       30719        2048   83  Linux
 __ts_dev__6           14336       18431        2048   83  Linux
@@ -190,6 +190,6 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
 Disk identifier: 0x00000001
 
-                                                                      Device Boot      Start         End      Blocks   Id  System
+                                                                  Device Boot      Start         End      Blocks   Id  System
 -------------------
 
-- 
1.7.7


--------------090909020600070900060703--
