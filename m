Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45671 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab2GZOEi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 10:04:38 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: dave@gnu.org
Subject: [PATCH 5/5] tests: update fdisk test (default output format changed)
Date: Thu, 26 Jul 2012 16:04:28 +0200
Message-Id: <1343311468-20206-5-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
References: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 tests/expected/fdisk/align-512-4K           |    3 +--
 tests/expected/fdisk/align-512-4K-63        |    3 +--
 tests/expected/fdisk/align-512-4K-md        |    6 ++----
 tests/expected/fdisk/align-512-512          |    3 +--
 tests/expected/fdisk/align-512-512-topology |    3 +--
 tests/expected/fdisk/oddinput               |    2 +-
 6 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/tests/expected/fdisk/align-512-4K b/tests/expected/fdisk/align-512-4K
index a510c73..293f4ae 100644
--- a/tests/expected/fdisk/align-512-4K
+++ b/tests/expected/fdisk/align-512-4K
@@ -54,8 +54,7 @@ Last sector, +sectors or +size{K,M,G} (90112-102399, default 102399): Using defa
 Partition 7 of type Linux and of size 6 MiB is set
 
 Command (m for help): 
-Disk /dev/...: 52 MB, 52428800 bytes
-32 heads, 32 sectors/track, 100 cylinders, total 102400 sectors
+Disk /dev/...: 52 MB, 52428800 bytes, 102400 sectors
 Units = sectors of 1 * 512 = 512 bytes
 Sector size (logical/physical): 512 bytes / 4096 bytes
 I/O size (minimum/optimal): 4096 bytes / 32768 bytes
diff --git a/tests/expected/fdisk/align-512-4K-63 b/tests/expected/fdisk/align-512-4K-63
index e8192ce..5369ec5 100644
--- a/tests/expected/fdisk/align-512-4K-63
+++ b/tests/expected/fdisk/align-512-4K-63
@@ -54,8 +54,7 @@ Last sector, +sectors or +size{K,M,G} (88063-102399, default 102399): Using defa
 Partition 7 of type Linux and of size 7 MiB is set
 
 Command (m for help): 
-Disk /dev/...: 52 MB, 52428800 bytes
-32 heads, 32 sectors/track, 100 cylinders, total 102400 sectors
+Disk /dev/...: 52 MB, 52428800 bytes, 102400 sectors
 Units = sectors of 1 * 512 = 512 bytes
 Sector size (logical/physical): 512 bytes / 4096 bytes
 I/O size (minimum/optimal): 4096 bytes / 32768 bytes
diff --git a/tests/expected/fdisk/align-512-4K-md b/tests/expected/fdisk/align-512-4K-md
index b0081c6..7b7e4bf 100644
--- a/tests/expected/fdisk/align-512-4K-md
+++ b/tests/expected/fdisk/align-512-4K-md
@@ -25,8 +25,7 @@ Last sector, +sectors or +size{K,M,G} (43008-102399, default 102399): Using defa
 Partition 2 of type Linux and of size 29 MiB is set
 
 Command (m for help): 
-Disk /dev/...: 52 MB, 52428800 bytes
-32 heads, 32 sectors/track, 100 cylinders, total 102400 sectors
+Disk /dev/...: 52 MB, 52428800 bytes, 102400 sectors
 Units = sectors of 1 * 512 = 512 bytes
 Sector size (logical/physical): 512 bytes / 4096 bytes
 I/O size (minimum/optimal): 4096 bytes / 32768 bytes
@@ -69,8 +68,7 @@ Select (default p): Partition number (1-4, default 2): First sector (22528-10009
 Last sector, +sectors or +size{K,M,G} (22528-100095, default 100095): Partition 2 of type Linux and of size 10 MiB is set
 
 Command (m for help): 
-Disk /dev/md8: 51 MB, 51249152 bytes
-2 heads, 4 sectors/track, 12512 cylinders, total 100096 sectors
+Disk /dev/md8: 51 MB, 51249152 bytes, 100096 sectors
 Units = sectors of 1 * 512 = 512 bytes
 Sector size (logical/physical): 512 bytes / 4096 bytes
 I/O size (minimum/optimal): 65536 bytes / 131072 bytes
diff --git a/tests/expected/fdisk/align-512-512 b/tests/expected/fdisk/align-512-512
index 190ad0a..37cfa71 100644
--- a/tests/expected/fdisk/align-512-512
+++ b/tests/expected/fdisk/align-512-512
@@ -50,8 +50,7 @@ Last sector, +sectors or +size{K,M,G} (90112-102399, default 102399): Using defa
 Partition 7 of type Linux and of size 6 MiB is set
 
 Command (m for help): 
-Disk /dev/loop0: 52 MB, 52428800 bytes
-255 heads, 63 sectors/track, 6 cylinders, total 102400 sectors
+Disk /dev/loop0: 52 MB, 52428800 bytes, 102400 sectors
 Units = sectors of 1 * 512 = 512 bytes
 Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes
diff --git a/tests/expected/fdisk/align-512-512-topology b/tests/expected/fdisk/align-512-512-topology
index 2180081..d16233f 100644
--- a/tests/expected/fdisk/align-512-512-topology
+++ b/tests/expected/fdisk/align-512-512-topology
@@ -50,8 +50,7 @@ Last sector, +sectors or +size{K,M,G} (90112-102399, default 102399): Using defa
 Partition 7 of type Linux and of size 6 MiB is set
 
 Command (m for help): 
-Disk /dev/...: 52 MB, 52428800 bytes
-32 heads, 32 sectors/track, 100 cylinders, total 102400 sectors
+Disk /dev/...: 52 MB, 52428800 bytes, 102400 sectors
 Units = sectors of 1 * 512 = 512 bytes
 Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 32768 bytes
diff --git a/tests/expected/fdisk/oddinput b/tests/expected/fdisk/oddinput
index 65feb03..14f2528 100644
--- a/tests/expected/fdisk/oddinput
+++ b/tests/expected/fdisk/oddinput
@@ -2,7 +2,7 @@ Initialize empty image
 f1c9645dbc14efddc7d8a322685f26eb oddinput.img
 Empty image listing
 
-Disk testimage: 10 MB, 10485760 bytes
+Disk testimage: 10 MB, 10485760 bytes, 20480 sectors
 255 heads, 63 sectors/track, 1 cylinders
 Units = cylinders of 16065 * 512 = 8225280 bytes
 Sector size (logical/physical): 512 bytes / 512 bytes
-- 
1.7.7

