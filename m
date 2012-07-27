Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:50897 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752150Ab2G0JGN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jul 2012 05:06:13 -0400
Message-ID: <50125A02.9030004@bernhard-voelker.de>
Date: Fri, 27 Jul 2012 11:06:10 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] tests: use ts_is_mounted in mount/regfile
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The following patch fixes a test framework failure.

However, even with this patch applied, mount/regfile still fails
because umount fails:

  $ /home/berny/ul/umount /home/berny/ul/tests/output/mount/regfile.img
  umount: /home/berny/ul/tests/output/mount/regfile.img: not mounted

  $ mount | grep regfile
  /media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img on
/media/sdb5/berny/git/util-linux/tests/output/mount/regfile-mnt type ext3
(rw,relatime,errors=continue,barrier=1,data=ordered)

  $ ls -l /home/berny/ul/tests/output/mount/regfile.img $(readlink -f /home/berny/ul/tests/output/mount/regfile.img )
  -rw-r--r-- 1 root root 5242880 Jul 27 10:51 /home/berny/ul/tests/output/mount/regfile.img
  -rw-r--r-- 1 root root 5242880 Jul 27 10:51 /media/sdb5/berny/git/util-linux/tests/output/mount/regfile.img

:(

Have a nice day,
Berny



>From 2bc401aed37d73665b23a17a4c6ad0f6d4572a76 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Fri, 27 Jul 2012 11:00:17 +0200
Subject: [PATCH] tests: use ts_is_mounted in mount/regfile

If the test directory is on a symlink, then mount/regfile failed because
it did not search for the mount point in /proc/mounts canonicalized.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 tests/ts/mount/regfile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/ts/mount/regfile b/tests/ts/mount/regfile
index c47c7d7..8d786ad 100755
--- a/tests/ts/mount/regfile
+++ b/tests/ts/mount/regfile
@@ -21,7 +21,7 @@ $TS_CMD_MOUNT $IMAGE $TS_MOUNTPOINT 2>&1 >> $TS_OUTPUT

 DEVICE=$(awk '/regfile/ { print $1 }' /proc/mounts)

-grep -q "$TS_MOUNTPOINT" /proc/mounts || ts_die "Cannot find $TS_MOUNTPOINT in /proc/mounts"
+ts_is_mounted "$TS_MOUNTPOINT" || ts_die "Cannot find $TS_MOUNTPOINT in /proc/mounts"

 if [ -f "/sys/block/$(basename $DEVICE)/loop/backing_file" ]; then
 	$TS_CMD_UMOUNT $IMAGE || ts_die "Cannot umount $IMAGE"
@@ -30,7 +30,7 @@ else
 	ts_skip "too old kernel"
 fi

-grep -q "$TS_MOUNTPOINT" /proc/mounts && ts_die "$TS_MOUNTPOINT still in /proc/mounts"
+ts_is_mounted "$TS_MOUNTPOINT" && ts_die "$TS_MOUNTPOINT still in /proc/mounts"

 ts_log "Success"
 ts_finalize
-- 
1.7.7


