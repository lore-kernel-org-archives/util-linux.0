Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wy0-f174.google.com ([74.125.82.174]:50296 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751581Ab1HPWTO (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 16 Aug 2011 18:19:14 -0400
Received: by mail-wy0-f174.google.com with SMTP id 24so281588wyg.19
        for <util-linux@vger.kernel.org>; Tue, 16 Aug 2011 15:19:13 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH 5/5] tests: update fdisk and blkid MD tests
Date: Wed, 17 Aug 2011 00:19:06 +0200
Message-Id: <1313533146-2806-5-git-send-email-cosoleto@gmail.com>
In-Reply-To: <1313533146-2806-1-git-send-email-cosoleto@gmail.com>
References: <1313533146-2806-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 tests/expected/blkid/md-raid0-whole         |   11 +++++++----
 tests/expected/blkid/md-raid1-part          |   11 +++++++----
 tests/expected/blkid/md-raid1-whole         |   13 ++++++++-----
 tests/expected/fdisk/align-512-4K           |   24 ++++++++++++++++--------
 tests/expected/fdisk/align-512-4K-63        |   24 ++++++++++++++++--------
 tests/expected/fdisk/align-512-4K-md        |   24 +++++++++++++++---------
 tests/expected/fdisk/align-512-512          |   24 ++++++++++++++++--------
 tests/expected/fdisk/align-512-512-topology |   24 ++++++++++++++++--------
 tests/functions.sh                          |    1 +
 9 files changed, 102 insertions(+), 54 deletions(-)

diff --git a/tests/expected/blkid/md-raid0-whole b/tests/expected/blkid/md-raid0-whole
index 54e4012..83fc54e 100644
--- a/tests/expected/blkid/md-raid0-whole
+++ b/tests/expected/blkid/md-raid0-whole
@@ -3,21 +3,24 @@ Create RAID device
 Create partitions on RAID device
 Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Changes will remain in memory only, until you decide to write them.
-After that, of course, the previous content won't be recoverable.
-
 Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
 Select (default p): Partition number (1-4, default 1): First sector (2048-204543, default 2048): Using default value 2048
-Last sector, +sectors or +size{K,M,G} (2048-204543, default 204543): 
+Last sector, +sectors or +size{K,M,G} (2048-204543, default 204543): Partition 1 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (1 primary, 0 extended, 3 free)
    e   extended
 Select (default p): Partition number (1-4, default 2): First sector (22528-204543, default 22528): Using default value 22528
 Last sector, +sectors or +size{K,M,G} (22528-204543, default 204543): Using default value 204543
+Partition 2 of type Linux and of size 88.9 MiB is set
 
 Command (m for help): 
 Disk /dev/md8: 104 MB, 104726528 bytes
diff --git a/tests/expected/blkid/md-raid1-part b/tests/expected/blkid/md-raid1-part
index 659f896..df595b8 100644
--- a/tests/expected/blkid/md-raid1-part
+++ b/tests/expected/blkid/md-raid1-part
@@ -1,21 +1,24 @@
 Create partitions
 Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Changes will remain in memory only, until you decide to write them.
-After that, of course, the previous content won't be recoverable.
-
 Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
 Select (default p): Partition number (1-4, default 1): First sector (2048-104447, default 2048): Using default value 2048
-Last sector, +sectors or +size{K,M,G} (2048-104447, default 104447): 
+Last sector, +sectors or +size{K,M,G} (2048-104447, default 104447): Partition 1 of type Linux and of size 25 MiB is set
+
 Command (m for help): Partition type:
    p   primary (1 primary, 0 extended, 3 free)
    e   extended
 Select (default p): Partition number (1-4, default 2): First sector (53248-104447, default 53248): Using default value 53248
 Last sector, +sectors or +size{K,M,G} (53248-104447, default 104447): Using default value 104447
+Partition 2 of type Linux and of size 25 MiB is set
 
 Command (m for help): 
 Disk /dev/...: 53 MB, 53477376 bytes
diff --git a/tests/expected/blkid/md-raid1-whole b/tests/expected/blkid/md-raid1-whole
index cbdbb7b..2536a5c 100644
--- a/tests/expected/blkid/md-raid1-whole
+++ b/tests/expected/blkid/md-raid1-whole
@@ -3,21 +3,24 @@ Create RAID device
 Create partitions on RAID device
 Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Changes will remain in memory only, until you decide to write them.
-After that, of course, the previous content won't be recoverable.
-
 Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
 Select (default p): Partition number (1-4, default 1): First sector (2048-102271, default 2048): Using default value 2048
-Last sector, +sectors or +size{K,M,G} (2048-102271, default 102271): 
+Last sector, +sectors or +size{K,M,G} (2048-102271, default 102271): Partition 1 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (1 primary, 0 extended, 3 free)
    e   extended
 Select (default p): Partition number (1-4, default 2): First sector (22528-102271, default 22528): Using default value 22528
-Last sector, +sectors or +size{K,M,G} (22528-102271, default 102271): 
+Last sector, +sectors or +size{K,M,G} (22528-102271, default 102271): Partition 2 of type Linux and of size 10 MiB is set
+
 Command (m for help): 
 Disk /dev/md8: 52 MB, 52363264 bytes
 2 heads, 4 sectors/track, 12784 cylinders, total 102272 sectors
diff --git a/tests/expected/fdisk/align-512-4K b/tests/expected/fdisk/align-512-4K
index ed1e03b..615d609 100644
--- a/tests/expected/fdisk/align-512-4K
+++ b/tests/expected/fdisk/align-512-4K
@@ -1,49 +1,57 @@
 Create partitions
 Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Changes will remain in memory only, until you decide to write them.
-After that, of course, the previous content won't be recoverable.
-
 Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
 The device presents a logical sector size that is smaller than
 the physical sector size. Aligning to a physical sector (or optimal
 I/O) size boundary is recommended, or performance may be impacted.
 
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
 Select (default p): Partition number (1-4, default 1): First sector (2048-102399, default 2048): Using default value 2048
-Last sector, +sectors or +size{K,M,G} (2048-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (2048-102399, default 102399): Partition 1 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (1 primary, 0 extended, 3 free)
    e   extended
 Select (default p): Partition number (1-4, default 2): First sector (22528-102399, default 22528): Using default value 22528
-Last sector, +sectors or +size{K,M,G} (22528-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (22528-102399, default 102399): Partition 2 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (2 primary, 0 extended, 2 free)
    e   extended
 Select (default p): Partition number (1-4, default 3): First sector (43008-102399, default 43008): Using default value 43008
-Last sector, +sectors or +size{K,M,G} (43008-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (43008-102399, default 102399): Partition 3 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (3 primary, 0 extended, 1 free)
    e   extended
 Select (default e): Selected partition 4
 First sector (63488-102399, default 63488): Using default value 63488
 Last sector, +sectors or +size{K,M,G} (63488-102399, default 102399): Using default value 102399
+Partition 4 of type Extended and of size 19 MiB is set
 
 Command (m for help): All primary partitions are in use
 Adding logical partition 5
 First sector (65536-102399, default 65536): Using default value 65536
-Last sector, +sectors or +size{K,M,G} (65536-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (65536-102399, default 102399): Partition 5 of type Linux and of size 5 MiB is set
+
 Command (m for help): All primary partitions are in use
 Adding logical partition 6
 First sector (77824-102399, default 77824): Using default value 77824
-Last sector, +sectors or +size{K,M,G} (77824-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (77824-102399, default 102399): Partition 6 of type Linux and of size 5 MiB is set
+
 Command (m for help): All primary partitions are in use
 Adding logical partition 7
 First sector (90112-102399, default 90112): Using default value 90112
 Last sector, +sectors or +size{K,M,G} (90112-102399, default 102399): Using default value 102399
+Partition 7 of type Linux and of size 6 MiB is set
 
 Command (m for help): 
 Disk /dev/...: 52 MB, 52428800 bytes
diff --git a/tests/expected/fdisk/align-512-4K-63 b/tests/expected/fdisk/align-512-4K-63
index 261f54c..63cef9c 100644
--- a/tests/expected/fdisk/align-512-4K-63
+++ b/tests/expected/fdisk/align-512-4K-63
@@ -1,49 +1,57 @@
 Create partitions
 Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Changes will remain in memory only, until you decide to write them.
-After that, of course, the previous content won't be recoverable.
-
 Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
 The device presents a logical sector size that is smaller than
 the physical sector size. Aligning to a physical sector (or optimal
 I/O) size boundary is recommended, or performance may be impacted.
 
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
 Select (default p): Partition number (1-4, default 1): First sector (7-102399, default 7): Using default value 7
-Last sector, +sectors or +size{K,M,G} (7-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (7-102399, default 102399): Partition 1 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (1 primary, 0 extended, 3 free)
    e   extended
 Select (default p): Partition number (1-4, default 2): First sector (20487-102399, default 20487): Using default value 20487
-Last sector, +sectors or +size{K,M,G} (20487-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (20487-102399, default 102399): Partition 2 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (2 primary, 0 extended, 2 free)
    e   extended
 Select (default p): Partition number (1-4, default 3): First sector (40967-102399, default 40967): Using default value 40967
-Last sector, +sectors or +size{K,M,G} (40967-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (40967-102399, default 102399): Partition 3 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (3 primary, 0 extended, 1 free)
    e   extended
 Select (default e): Selected partition 4
 First sector (61447-102399, default 61447): Using default value 61447
 Last sector, +sectors or +size{K,M,G} (61447-102399, default 102399): Using default value 102399
+Partition 4 of type Extended and of size 20 MiB is set
 
 Command (m for help): All primary partitions are in use
 Adding logical partition 5
 First sector (61454-102399, default 63487): Using default value 63487
-Last sector, +sectors or +size{K,M,G} (63487-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (63487-102399, default 102399): Partition 5 of type Linux and of size 5 MiB is set
+
 Command (m for help): All primary partitions are in use
 Adding logical partition 6
 First sector (61454-102399, default 75775): Using default value 75775
-Last sector, +sectors or +size{K,M,G} (75775-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (75775-102399, default 102399): Partition 6 of type Linux and of size 5 MiB is set
+
 Command (m for help): All primary partitions are in use
 Adding logical partition 7
 First sector (61454-102399, default 88063): Using default value 88063
 Last sector, +sectors or +size{K,M,G} (88063-102399, default 102399): Using default value 102399
+Partition 7 of type Linux and of size 7 MiB is set
 
 Command (m for help): 
 Disk /dev/...: 52 MB, 52428800 bytes
diff --git a/tests/expected/fdisk/align-512-4K-md b/tests/expected/fdisk/align-512-4K-md
index 7de6d2e..3a0e7d5 100644
--- a/tests/expected/fdisk/align-512-4K-md
+++ b/tests/expected/fdisk/align-512-4K-md
@@ -1,25 +1,28 @@
 Create partitions
 Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Changes will remain in memory only, until you decide to write them.
-After that, of course, the previous content won't be recoverable.
-
 Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
 The device presents a logical sector size that is smaller than
 the physical sector size. Aligning to a physical sector (or optimal
 I/O) size boundary is recommended, or performance may be impacted.
 
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
 Select (default p): Partition number (1-4, default 1): First sector (2048-102399, default 2048): Using default value 2048
-Last sector, +sectors or +size{K,M,G} (2048-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (2048-102399, default 102399): Partition 1 of type Linux and of size 20 MiB is set
+
 Command (m for help): Partition type:
    p   primary (1 primary, 0 extended, 3 free)
    e   extended
 Select (default p): Partition number (1-4, default 2): First sector (43008-102399, default 43008): Using default value 43008
 Last sector, +sectors or +size{K,M,G} (43008-102399, default 102399): Using default value 102399
+Partition 2 of type Linux and of size 29 MiB is set
 
 Command (m for help): 
 Disk /dev/...: 52 MB, 52428800 bytes
@@ -43,25 +46,28 @@ Alignment offsets:
 Create partitions (MD)
 Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Changes will remain in memory only, until you decide to write them.
-After that, of course, the previous content won't be recoverable.
-
 Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
 The device presents a logical sector size that is smaller than
 the physical sector size. Aligning to a physical sector (or optimal
 I/O) size boundary is recommended, or performance may be impacted.
 
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
 Select (default p): Partition number (1-4, default 1): First sector (2048-100095, default 2048): Using default value 2048
-Last sector, +sectors or +size{K,M,G} (2048-100095, default 100095): 
+Last sector, +sectors or +size{K,M,G} (2048-100095, default 100095): Partition 1 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (1 primary, 0 extended, 3 free)
    e   extended
 Select (default p): Partition number (1-4, default 2): First sector (22528-100095, default 22528): Using default value 22528
-Last sector, +sectors or +size{K,M,G} (22528-100095, default 100095): 
+Last sector, +sectors or +size{K,M,G} (22528-100095, default 100095): Partition 2 of type Linux and of size 10 MiB is set
+
 Command (m for help): 
 Disk /dev/md8: 51 MB, 51249152 bytes
 2 heads, 4 sectors/track, 12512 cylinders, total 100096 sectors
diff --git a/tests/expected/fdisk/align-512-512 b/tests/expected/fdisk/align-512-512
index 13931d4..7f1cdb9 100644
--- a/tests/expected/fdisk/align-512-512
+++ b/tests/expected/fdisk/align-512-512
@@ -1,45 +1,53 @@
 Create partitions
 Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Changes will remain in memory only, until you decide to write them.
-After that, of course, the previous content won't be recoverable.
-
 Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
 Select (default p): Partition number (1-4, default 1): First sector (2048-102399, default 2048): Using default value 2048
-Last sector, +sectors or +size{K,M,G} (2048-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (2048-102399, default 102399): Partition 1 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (1 primary, 0 extended, 3 free)
    e   extended
 Select (default p): Partition number (1-4, default 2): First sector (22528-102399, default 22528): Using default value 22528
-Last sector, +sectors or +size{K,M,G} (22528-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (22528-102399, default 102399): Partition 2 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (2 primary, 0 extended, 2 free)
    e   extended
 Select (default p): Partition number (1-4, default 3): First sector (43008-102399, default 43008): Using default value 43008
-Last sector, +sectors or +size{K,M,G} (43008-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (43008-102399, default 102399): Partition 3 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (3 primary, 0 extended, 1 free)
    e   extended
 Select (default e): Selected partition 4
 First sector (63488-102399, default 63488): Using default value 63488
 Last sector, +sectors or +size{K,M,G} (63488-102399, default 102399): Using default value 102399
+Partition 4 of type Extended and of size 19 MiB is set
 
 Command (m for help): All primary partitions are in use
 Adding logical partition 5
 First sector (65536-102399, default 65536): Using default value 65536
-Last sector, +sectors or +size{K,M,G} (65536-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (65536-102399, default 102399): Partition 5 of type Linux and of size 5 MiB is set
+
 Command (m for help): All primary partitions are in use
 Adding logical partition 6
 First sector (77824-102399, default 77824): Using default value 77824
-Last sector, +sectors or +size{K,M,G} (77824-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (77824-102399, default 102399): Partition 6 of type Linux and of size 5 MiB is set
+
 Command (m for help): All primary partitions are in use
 Adding logical partition 7
 First sector (90112-102399, default 90112): Using default value 90112
 Last sector, +sectors or +size{K,M,G} (90112-102399, default 102399): Using default value 102399
+Partition 7 of type Linux and of size 6 MiB is set
 
 Command (m for help): 
 Disk /dev/loop0: 52 MB, 52428800 bytes
diff --git a/tests/expected/fdisk/align-512-512-topology b/tests/expected/fdisk/align-512-512-topology
index af86955..3623f0b 100644
--- a/tests/expected/fdisk/align-512-512-topology
+++ b/tests/expected/fdisk/align-512-512-topology
@@ -1,45 +1,53 @@
 Create partitions
 Device contains neither a valid DOS partition table, nor Sun, SGI or OSF disklabel
 
-Changes will remain in memory only, until you decide to write them.
-After that, of course, the previous content won't be recoverable.
-
 Warning: invalid flag 0x0000 of partition table 4 will be corrected by w(rite)
 
+
+Changes will remain in memory only, until you decide to write them.
+Be careful before using the write command.
+
 Command (m for help): Partition type:
    p   primary (0 primary, 0 extended, 4 free)
    e   extended
 Select (default p): Partition number (1-4, default 1): First sector (2048-102399, default 2048): Using default value 2048
-Last sector, +sectors or +size{K,M,G} (2048-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (2048-102399, default 102399): Partition 1 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (1 primary, 0 extended, 3 free)
    e   extended
 Select (default p): Partition number (1-4, default 2): First sector (22528-102399, default 22528): Using default value 22528
-Last sector, +sectors or +size{K,M,G} (22528-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (22528-102399, default 102399): Partition 2 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (2 primary, 0 extended, 2 free)
    e   extended
 Select (default p): Partition number (1-4, default 3): First sector (43008-102399, default 43008): Using default value 43008
-Last sector, +sectors or +size{K,M,G} (43008-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (43008-102399, default 102399): Partition 3 of type Linux and of size 10 MiB is set
+
 Command (m for help): Partition type:
    p   primary (3 primary, 0 extended, 1 free)
    e   extended
 Select (default e): Selected partition 4
 First sector (63488-102399, default 63488): Using default value 63488
 Last sector, +sectors or +size{K,M,G} (63488-102399, default 102399): Using default value 102399
+Partition 4 of type Extended and of size 19 MiB is set
 
 Command (m for help): All primary partitions are in use
 Adding logical partition 5
 First sector (65536-102399, default 65536): Using default value 65536
-Last sector, +sectors or +size{K,M,G} (65536-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (65536-102399, default 102399): Partition 5 of type Linux and of size 5 MiB is set
+
 Command (m for help): All primary partitions are in use
 Adding logical partition 6
 First sector (77824-102399, default 77824): Using default value 77824
-Last sector, +sectors or +size{K,M,G} (77824-102399, default 102399): 
+Last sector, +sectors or +size{K,M,G} (77824-102399, default 102399): Partition 6 of type Linux and of size 5 MiB is set
+
 Command (m for help): All primary partitions are in use
 Adding logical partition 7
 First sector (90112-102399, default 90112): Using default value 90112
 Last sector, +sectors or +size{K,M,G} (90112-102399, default 102399): Using default value 102399
+Partition 7 of type Linux and of size 6 MiB is set
 
 Command (m for help): 
 Disk /dev/...: 52 MB, 52428800 bytes
diff --git a/tests/functions.sh b/tests/functions.sh
index acfbbee..71ff7da 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -398,5 +398,6 @@ function ts_fdisk_clean {
 	[ x"${DEVNAME}" != x"" ] && sed -i -e "s/\/dev\/${DEVNAME}/\/dev\/.../g" $TS_OUTPUT
 	sed -i -e 's/Disk identifier:.*//g' \
 	       -e 's/Building a new.*//g' \
+	       -e 's/Welcome to fdisk.*//g' \
 	       $TS_OUTPUT
 }
-- 
1.7.3.4

