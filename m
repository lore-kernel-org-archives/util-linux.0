Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:47344 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759357Ab1LOTDK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Dec 2011 14:03:10 -0500
Received: by mail-ee0-f46.google.com with SMTP id c4so2431824eek.19
        for <util-linux@vger.kernel.org>; Thu, 15 Dec 2011 11:03:10 -0800 (PST)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 13/13] tests: update fdisk tests
Date: Thu, 15 Dec 2011 20:02:49 +0100
Message-Id: <1323975769-21929-13-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
References: <1323975769-21929-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 tests/expected/fdisk/align-512-4K           |   12 ++++++------
 tests/expected/fdisk/align-512-4K-63        |   12 ++++++------
 tests/expected/fdisk/align-512-4K-md        |   24 ++++++++++++------------
 tests/expected/fdisk/align-512-512          |    6 +++---
 tests/expected/fdisk/align-512-512-topology |    6 +++---
 tests/expected/fdisk/oddinput               |    1 -
 6 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/tests/expected/fdisk/align-512-4K b/tests/expected/fdisk/align-512-4K
index 615d609..a510c73 100644
--- a/tests/expected/fdisk/align-512-4K
+++ b/tests/expected/fdisk/align-512-4K
@@ -1,16 +1,16 @@
 Create partitions
-Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
+Device does not contain a recognized partition table
+
 
 The device presents a logical sector size that is smaller than
 the physical sector size. Aligning to a physical sector (or optimal
 I/O) size boundary is recommended, or performance may be impacted.
 
-
-Changes will remain in memory only, until you decide to write them.
-Be careful before using the write command.
-
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
diff --git a/tests/expected/fdisk/align-512-4K-63 b/tests/expected/fdisk/align-512-4K-63
index 63cef9c..e8192ce 100644
--- a/tests/expected/fdisk/align-512-4K-63
+++ b/tests/expected/fdisk/align-512-4K-63
@@ -1,16 +1,16 @@
 Create partitions
-Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
+Device does not contain a recognized partition table
+
 
 The device presents a logical sector size that is smaller than
 the physical sector size. Aligning to a physical sector (or optimal
 I/O) size boundary is recommended, or performance may be impacted.
 
-
-Changes will remain in memory only, until you decide to write them.
-Be careful before using the write command.
-
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
diff --git a/tests/expected/fdisk/align-512-4K-md b/tests/expected/fdisk/align-512-4K-md
index 3a0e7d5..b0081c6 100644
--- a/tests/expected/fdisk/align-512-4K-md
+++ b/tests/expected/fdisk/align-512-4K-md
@@ -1,16 +1,16 @@
 Create partitions
-Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
+Device does not contain a recognized partition table
+
 
 The device presents a logical sector size that is smaller than
 the physical sector size. Aligning to a physical sector (or optimal
 I/O) size boundary is recommended, or performance may be impacted.
 
-
-Changes will remain in memory only, until you decide to write them.
-Be careful before using the write command.
-
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
@@ -44,18 +44,18 @@ Alignment offsets:
 0
 0
 Create partitions (MD)
-Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
+Device does not contain a recognized partition table
+
 
 The device presents a logical sector size that is smaller than
 the physical sector size. Aligning to a physical sector (or optimal
 I/O) size boundary is recommended, or performance may be impacted.
 
-
-Changes will remain in memory only, until you decide to write them.
-Be careful before using the write command.
-
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
diff --git a/tests/expected/fdisk/align-512-512 b/tests/expected/fdisk/align-512-512
index 7f1cdb9..190ad0a 100644
--- a/tests/expected/fdisk/align-512-512
+++ b/tests/expected/fdisk/align-512-512
@@ -1,12 +1,12 @@
 Create partitions
-Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
-
-Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
 
 Changes will remain in memory only, until you decide to write them.
 Be careful before using the write command.
 
+Device does not contain a recognized partition table
+
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
diff --git a/tests/expected/fdisk/align-512-512-topology b/tests/expected/fdisk/align-512-512-topology
index 3623f0b..2180081 100644
--- a/tests/expected/fdisk/align-512-512-topology
+++ b/tests/expected/fdisk/align-512-512-topology
@@ -1,12 +1,12 @@
 Create partitions
-Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
-
-Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
 
 Changes will remain in memory only, until you decide to write them.
 Be careful before using the write command.
 
+Device does not contain a recognized partition table
+
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
diff --git a/tests/expected/fdisk/oddinput b/tests/expected/fdisk/oddinput
index 7fd14b5..8714f63 100644
--- a/tests/expected/fdisk/oddinput
+++ b/tests/expected/fdisk/oddinput
@@ -8,7 +8,6 @@ Disk testimage: 10 MB, 10485760 bytes
 Units = cylinders of 16065 * 512 = 8225280 bytes
 Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
-Disk identifier: 0x00000000
 
 Nonexistant file
 Too small file
-- 
1.7.7

