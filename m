Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62197 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797AbcCCBLw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 2 Mar 2016 20:11:52 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/7] tests: minix, some corrections and cleanup
Date: Thu,  3 Mar 2016 02:11:01 +0100
Message-Id: <1456967465-16128-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
References: <1456967465-16128-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

 - move generic "check_minix_fs_type" tests to the top
 - add some todos/notes about potential issues
 - add "real" badblocks test (-l)
 - don't check sed's but fsck's return value
 - to see debian bug 773892 we would need "-f"
 - add some more hexdumps

CC: Sami Kerola <kerolasa@iki.fi>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/minix/fsck-images-auto-fix    |  2 +-
 tests/expected/minix/fsck-images-badblocks   | 35 ++++++++++++++++++++++++++++
 tests/expected/minix/fsck-images-broken-root |  2 +-
 tests/expected/minix/fsck-images-bug.773892  |  2 +-
 tests/ts/minix/fsck-images                   | 29 ++++++++++++++---------
 5 files changed, 56 insertions(+), 14 deletions(-)
 create mode 100644 tests/expected/minix/fsck-images-badblocks

diff --git a/tests/expected/minix/fsck-images-auto-fix b/tests/expected/minix/fsck-images-auto-fix
index b22c191..74a6487 100644
--- a/tests/expected/minix/fsck-images-auto-fix
+++ b/tests/expected/minix/fsck-images-auto-fix
@@ -27,7 +27,7 @@ Inode 1 not used, marked used in the bitmap.
 ----------------------------
 FILE SYSTEM HAS BEEN CHANGED
 ----------------------------
-0
+fsck reports changed and uncorrected: 7
 00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
 *
 00000400  10 00 00 00 00 00 01 00  01 00 05 00 00 00 00 00  |................|
diff --git a/tests/expected/minix/fsck-images-badblocks b/tests/expected/minix/fsck-images-badblocks
new file mode 100644
index 0000000..e521e23
--- /dev/null
+++ b/tests/expected/minix/fsck-images-badblocks
@@ -0,0 +1,35 @@
+32 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=268966912
+
+2 bad blocks
+mkfs return value: 0
+fsck return value: 0
+00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000400  20 00 10 00 01 00 01 00  05 00 00 00 00 1c 08 10  | ...............|
+00000410  8f 13 01 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00000420  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00000800  07 00 00 00 fe ff ff ff  ff ff ff ff ff ff ff ff  |................|
+00000810  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00000c00  33 f0 ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |3...............|
+00000c10  ff ff ff ff ff ff ff ff  ff ff ff ff ff ff ff ff  |................|
+*
+00001000  ed 41 00 00 60 00 00 00  34 29 bd 55 00 02 05 00  |.A..`...4).U....|
+00001010  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001020  00 80 00 00 00 08 00 00  34 29 bd 55 00 01 08 00  |........4).U....|
+00001030  09 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001040  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00001400  01 00 2e 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001410  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001420  01 00 2e 2e 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001430  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+00001440  02 00 2e 62 61 64 62 6c  6f 63 6b 73 00 00 00 00  |...badblocks....|
+00001450  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |................|
+*
+00004000
diff --git a/tests/expected/minix/fsck-images-broken-root b/tests/expected/minix/fsck-images-broken-root
index d851b83..2c78bdf 100644
--- a/tests/expected/minix/fsck-images-broken-root
+++ b/tests/expected/minix/fsck-images-broken-root
@@ -4,4 +4,4 @@ Read error: bad block in file '/'
 Read error: bad block in file '/'
 /: bad directory: '..' isn't second
 Inode 1 not used, marked used in the bitmap.
-4
+fsck reports uncorrected: 4
diff --git a/tests/expected/minix/fsck-images-bug.773892 b/tests/expected/minix/fsck-images-bug.773892
index 573541a..6e22927 100644
--- a/tests/expected/minix/fsck-images-bug.773892
+++ b/tests/expected/minix/fsck-images-bug.773892
@@ -1 +1 @@
-0
+fsck reports uncorrected: 4
diff --git a/tests/ts/minix/fsck-images b/tests/ts/minix/fsck-images
index 2248602..4c5f675 100755
--- a/tests/ts/minix/fsck-images
+++ b/tests/ts/minix/fsck-images
@@ -19,6 +19,7 @@ TS_DESC="fsck images"
 ts_init "$*"
 
 # inode contains UID and GID, use always UID=0 to get the same checksum
+# TODO any mkfs should use UID=0 per default (custom uid optionally) like mk2fs
 ts_skip_nonroot
 
 ts_check_test_command "$TS_CMD_FSCKMINIX"
@@ -46,28 +47,34 @@ check_minix_fs_type 'v2c14' '-2 -n 14'
 check_minix_fs_type 'v2c30' '-2 -n 30'
 check_minix_fs_type 'v3c60' '-3 -n 60'
 
+bad="$TS_OUTDIR/${TS_TESTNAME}.badlist"
+# TODO seems that mkfs produces non-sense if badblock are greater when device.
+echo -e "8\n9" > $bad
+
+# Note, -c with -l ignores -l.
+check_minix_fs_type 'check-blocks' "-l $bad -c"
+check_minix_fs_type 'badblocks' "-l $bad"
+
+rm -f $bad
+
+# NOTE this seems odd: a 2nd fsck run would again modify the FS
 ts_init_subtest "auto-fix"
 img=${TS_OUTPUT}.img
 cp "$TS_SELF/broken-root" $img
-"$TS_CMD_FSCKMINIX" -sav $img |
-	sed 's/Filesystem on .* is dirty/Filesystem auto-fix is dirty/' > $TS_OUTPUT 2>&1
-echo $? >> $TS_OUTPUT
+$TS_CMD_FSCKMINIX -sav $img >> $TS_OUTPUT 2>&1
+echo "fsck reports changed and uncorrected: $?" >> $TS_OUTPUT
 $TS_CMD_HEXDUMP -C $img >> $TS_OUTPUT 2>&1
+sed -i 's/Filesystem on .* is dirty/Filesystem auto-fix is dirty/' $TS_OUTPUT
 ts_finalize_subtest
 
 ts_init_subtest "bug.773892"
-"$TS_CMD_FSCKMINIX" "$TS_SELF/debian.bug.773892" > $TS_OUTPUT 2>&1
-echo $? >> $TS_OUTPUT
+"$TS_CMD_FSCKMINIX" -f "$TS_SELF/debian.bug.773892" >>$TS_OUTPUT 2>&1 >/dev/null
+echo "fsck reports uncorrected: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
 ts_init_subtest "broken-root"
 "$TS_CMD_FSCKMINIX" "$TS_SELF/broken-root" > $TS_OUTPUT 2>&1
-echo $? >> $TS_OUTPUT
+echo "fsck reports uncorrected: $?" >> $TS_OUTPUT
 ts_finalize_subtest
 
-img="$TS_OUTDIR/${TS_TESTNAME}.badlist"
-echo "42" > $img
-check_minix_fs_type 'check-blocks' "-l $img -c"
-rm -f $img
-
 ts_finalize
-- 
1.8.4.5

