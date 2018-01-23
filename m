Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:57325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751406AbeAWP7c (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Jan 2018 10:59:32 -0500
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0M5uLh-1f1yn51Ihl-00xp9P for <util-linux@vger.kernel.org>; Tue, 23 Jan 2018
 16:59:30 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/7] tests: rewrite fsck-bad-header
Date: Tue, 23 Jan 2018 16:59:24 +0100
Message-Id: <20180123155928.7629-4-sweet_f_a@gmx.de>
In-Reply-To: <20180123155928.7629-1-sweet_f_a@gmx.de>
References: <20180123155928.7629-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Fix test for systems with pagesize != 4096
Loop over many combinations of sizes, endianness and blocksizes.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/cramfs/fsck-bad-header             |  1 -
 tests/expected/cramfs/fsck-bad-header-nopad-4K-be | 29 +++++++++
 tests/expected/cramfs/fsck-bad-header-nopad-4K-le | 29 +++++++++
 tests/expected/cramfs/fsck-bad-header-pad-4K-be   | 29 +++++++++
 tests/expected/cramfs/fsck-bad-header-pad-4K-le   | 29 +++++++++
 tests/expected/cramfs/fsck-bad-header-pad-64K-be  | 29 +++++++++
 tests/expected/cramfs/fsck-bad-header-pad-64K-le  | 29 +++++++++
 tests/ts/cramfs/fsck-bad-header                   | 74 +++++++++++++++++++++--
 8 files changed, 243 insertions(+), 6 deletions(-)
 delete mode 100644 tests/expected/cramfs/fsck-bad-header
 create mode 100644 tests/expected/cramfs/fsck-bad-header-nopad-4K-be
 create mode 100644 tests/expected/cramfs/fsck-bad-header-nopad-4K-le
 create mode 100644 tests/expected/cramfs/fsck-bad-header-pad-4K-be
 create mode 100644 tests/expected/cramfs/fsck-bad-header-pad-4K-le
 create mode 100644 tests/expected/cramfs/fsck-bad-header-pad-64K-be
 create mode 100644 tests/expected/cramfs/fsck-bad-header-pad-64K-le

diff --git a/tests/expected/cramfs/fsck-bad-header b/tests/expected/cramfs/fsck-bad-header
deleted file mode 100644
index 41c2c125e..000000000
--- a/tests/expected/cramfs/fsck-bad-header
+++ /dev/null
@@ -1 +0,0 @@
-fsck.cramfs: superblock size (76) too small
diff --git a/tests/expected/cramfs/fsck-bad-header-nopad-4K-be b/tests/expected/cramfs/fsck-bad-header-nopad-4K-be
new file mode 100644
index 000000000..397d1ba29
--- /dev/null
+++ b/tests/expected/cramfs/fsck-bad-header-nopad-4K-be
@@ -0,0 +1,29 @@
+## size: 0
+fsck.cramfs: superblock size (0) too small
+ret: 4
+
+## size: 75
+fsck.cramfs: superblock size (75) too small
+ret: 4
+
+## size: 76
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 4095
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 4096
+ret: 0
+
+## size: 4097
+fsck.cramfs: file length too short
+ret: 4
+
+## size: 4294967295
+fsck.cramfs: file length too short
+ret: 4
+
diff --git a/tests/expected/cramfs/fsck-bad-header-nopad-4K-le b/tests/expected/cramfs/fsck-bad-header-nopad-4K-le
new file mode 100644
index 000000000..397d1ba29
--- /dev/null
+++ b/tests/expected/cramfs/fsck-bad-header-nopad-4K-le
@@ -0,0 +1,29 @@
+## size: 0
+fsck.cramfs: superblock size (0) too small
+ret: 4
+
+## size: 75
+fsck.cramfs: superblock size (75) too small
+ret: 4
+
+## size: 76
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 4095
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 4096
+ret: 0
+
+## size: 4097
+fsck.cramfs: file length too short
+ret: 4
+
+## size: 4294967295
+fsck.cramfs: file length too short
+ret: 4
+
diff --git a/tests/expected/cramfs/fsck-bad-header-pad-4K-be b/tests/expected/cramfs/fsck-bad-header-pad-4K-be
new file mode 100644
index 000000000..8e2316183
--- /dev/null
+++ b/tests/expected/cramfs/fsck-bad-header-pad-4K-be
@@ -0,0 +1,29 @@
+## size: 76
+fsck.cramfs: superblock size (76) too small
+ret: 4
+
+## size: 587
+fsck.cramfs: superblock size (587) too small
+ret: 4
+
+## size: 588
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 4095
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 4096
+ret: 0
+
+## size: 4097
+fsck.cramfs: file length too short
+ret: 4
+
+## size: 4294967295
+fsck.cramfs: file length too short
+ret: 4
+
diff --git a/tests/expected/cramfs/fsck-bad-header-pad-4K-le b/tests/expected/cramfs/fsck-bad-header-pad-4K-le
new file mode 100644
index 000000000..8e2316183
--- /dev/null
+++ b/tests/expected/cramfs/fsck-bad-header-pad-4K-le
@@ -0,0 +1,29 @@
+## size: 76
+fsck.cramfs: superblock size (76) too small
+ret: 4
+
+## size: 587
+fsck.cramfs: superblock size (587) too small
+ret: 4
+
+## size: 588
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 4095
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 4096
+ret: 0
+
+## size: 4097
+fsck.cramfs: file length too short
+ret: 4
+
+## size: 4294967295
+fsck.cramfs: file length too short
+ret: 4
+
diff --git a/tests/expected/cramfs/fsck-bad-header-pad-64K-be b/tests/expected/cramfs/fsck-bad-header-pad-64K-be
new file mode 100644
index 000000000..15d4ff190
--- /dev/null
+++ b/tests/expected/cramfs/fsck-bad-header-pad-64K-be
@@ -0,0 +1,29 @@
+## size: 76
+fsck.cramfs: superblock size (76) too small
+ret: 4
+
+## size: 587
+fsck.cramfs: superblock size (587) too small
+ret: 4
+
+## size: 588
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 65535
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 65536
+ret: 0
+
+## size: 65537
+fsck.cramfs: file length too short
+ret: 4
+
+## size: 4294967295
+fsck.cramfs: file length too short
+ret: 4
+
diff --git a/tests/expected/cramfs/fsck-bad-header-pad-64K-le b/tests/expected/cramfs/fsck-bad-header-pad-64K-le
new file mode 100644
index 000000000..15d4ff190
--- /dev/null
+++ b/tests/expected/cramfs/fsck-bad-header-pad-64K-le
@@ -0,0 +1,29 @@
+## size: 76
+fsck.cramfs: superblock size (76) too small
+ret: 4
+
+## size: 587
+fsck.cramfs: superblock size (587) too small
+ret: 4
+
+## size: 588
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 65535
+fsck.cramfs: file extends past end of filesystem
+fsck.cramfs: crc error
+ret: 4
+
+## size: 65536
+ret: 0
+
+## size: 65537
+fsck.cramfs: file length too short
+ret: 4
+
+## size: 4294967295
+fsck.cramfs: file length too short
+ret: 4
+
diff --git a/tests/ts/cramfs/fsck-bad-header b/tests/ts/cramfs/fsck-bad-header
index add388577..c71782bde 100755
--- a/tests/ts/cramfs/fsck-bad-header
+++ b/tests/ts/cramfs/fsck-bad-header
@@ -25,14 +25,78 @@ ts_check_test_command "$TS_CMD_MKCRAMFS"
 ts_check_test_command "$TS_CMD_FSCKCRAMFS"
 ts_check_prog "dd"
 
-IMAGE_SOURCE="$TS_OUTDIR/${TS_TESTNAME}-data/root"
+function num2binary()
+{
+	local num=$1
+	local endian=$2
+
+	test "$num" -ge 0 -a "$num" -le 4294967295 || return 1
+	test "$endian" = "be" -o "$endian" = "le" || return 1
+
+	# how to do that easier?
+	if test "$endian" = "be"; then
+		echo -en "$(printf "%08x" "$1" | sed 's/\(..\)/\\x\1/g')"
+	else
+		echo -en "$(printf "%08x" "$1" | sed 's/^\(..\)\(..\)\(..\)\(..\)$/\\x\4\\x\3\\x\2\\x\1/')"
+	fi
+}
+
+function fsck_loop_sizes()
+{
+	local endian=$1  # be, le
+	local seek=$2    # 4 for nopad, 516 for pad
+	shift 2          # the rest are sizes to loop over
+
+	for size in "$@"; do
+		ts_log "## size: $size"
+		cp -a "$IMAGE_FILE" "$IMAGE_FILE.tmp"
+		num2binary "$size" $endian |
+			dd of="$IMAGE_FILE.tmp" bs=1 seek="$seek" count=4 conv=notrunc &> /dev/null
+		$TS_CMD_FSCKCRAMFS "$IMAGE_FILE.tmp" >> $TS_OUTPUT 2>&1
+		ts_log "ret: $?
+"
+	done
+	rm -f "$IMAGE_FILE"
+}
+
+
+IMAGE_SOURCE="$TS_OUTDIR/${TS_TESTNAME}-data"
 IMAGE_FILE="$TS_OUTDIR/${TS_TESTNAME}-cramfs.img"
 
 mkdir -p "${IMAGE_SOURCE}/subdir" &> /dev/null
-$TS_CMD_MKCRAMFS -p -N big $IMAGE_SOURCE $IMAGE_FILE &> /dev/null
-echo -ne \\00\\x4c |
-	dd of=$IMAGE_FILE bs=1 seek=518 count=2 conv=notrunc &> /dev/null
-$TS_CMD_FSCKCRAMFS $IMAGE_FILE >> $TS_OUTPUT 2>&1
+
+ts_init_subtest "nopad-4K-be"
+$TS_CMD_MKCRAMFS -N big -b 4096 $IMAGE_SOURCE $IMAGE_FILE &> /dev/null
+fsck_loop_sizes be 4  0 75 76 4095 4096 4097 4294967295
+rm -f "$IMAGE_FILE"
+ts_finalize_subtest
+
+ts_init_subtest "nopad-4K-le"
+$TS_CMD_MKCRAMFS -N little -b 4096 $IMAGE_SOURCE $IMAGE_FILE &> /dev/null
+fsck_loop_sizes le 4  0 75 76 4095 4096 4097 4294967295
+ts_finalize_subtest
+
+ts_init_subtest "pad-4K-be"
+$TS_CMD_MKCRAMFS -p -N big -b 4096 $IMAGE_SOURCE $IMAGE_FILE &> /dev/null
+fsck_loop_sizes be 516  76 587 588 4095 4096 4097 4294967295
+ts_finalize_subtest
+
+ts_init_subtest "pad-4K-le"
+$TS_CMD_MKCRAMFS -p -N little -b 4096 $IMAGE_SOURCE $IMAGE_FILE &> /dev/null
+fsck_loop_sizes le 516  76 587 588 4095 4096 4097 4294967295
+ts_finalize_subtest
+
+ts_init_subtest "pad-64K-be"
+$TS_CMD_MKCRAMFS -p -N big -b 65536 $IMAGE_SOURCE $IMAGE_FILE &> /dev/null
+fsck_loop_sizes be 516  76 587 588 65535 65536 65537 4294967295
+ts_finalize_subtest
+
+ts_init_subtest "pad-64K-le"
+$TS_CMD_MKCRAMFS -p -N little -b 65536 $IMAGE_SOURCE $IMAGE_FILE &> /dev/null
+fsck_loop_sizes le 516  76 587 588 65535 65536 65537 4294967295
+ts_finalize_subtest
+
+rm -rf "$IMAGE_SOURCE" "$IMAGE_FILE.tmp"
 
 ts_finalize
 
-- 
2.13.6

