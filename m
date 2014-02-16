Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f179.google.com ([74.125.82.179]:41907 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbaBPPXQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 10:23:16 -0500
Received: by mail-we0-f179.google.com with SMTP id q58so9735411wes.24
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 07:23:14 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 4/4] tests: check commands needed for running a test exist
Date: Sun, 16 Feb 2014 15:22:56 +0000
Message-Id: <1392564176-11596-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
References: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/functions.sh                    | 10 ++++++++--
 tests/ts/bitops/swapbytes             |  2 ++
 tests/ts/blkid/low-probe              |  4 +---
 tests/ts/blkid/lowprobe-pt            |  4 +---
 tests/ts/blkid/md-raid0-whole         |  4 ++++
 tests/ts/blkid/md-raid1-part          |  4 ++++
 tests/ts/blkid/md-raid1-whole         |  4 ++++
 tests/ts/cal/1m                       |  2 ++
 tests/ts/cal/1mw                      |  2 ++
 tests/ts/cal/3m                       |  2 ++
 tests/ts/cal/3mw                      |  2 ++
 tests/ts/cal/bigyear                  |  2 ++
 tests/ts/cal/bigyearw                 |  2 ++
 tests/ts/cal/color                    |  2 ++
 tests/ts/cal/colorw                   |  2 ++
 tests/ts/cal/sep1752                  |  2 ++
 tests/ts/cal/sep1752w                 |  2 ++
 tests/ts/cal/weekarg                  |  2 ++
 tests/ts/cal/weeknum                  |  4 +++-
 tests/ts/cal/year                     |  2 ++
 tests/ts/cal/yearw                    |  2 ++
 tests/ts/col/multibyte                |  2 ++
 tests/ts/colrm/rm2-2                  |  2 ++
 tests/ts/column/fillrow               |  2 ++
 tests/ts/column/multi-file            |  4 +++-
 tests/ts/column/separator_table       |  2 ++
 tests/ts/cramfs/doubles               |  5 +++++
 tests/ts/cramfs/fsck-endianness       |  4 ++++
 tests/ts/cramfs/mkfs                  |  6 ++++++
 tests/ts/cramfs/mkfs-endianness       |  3 +++
 tests/ts/dmesg/console-levels         |  2 ++
 tests/ts/dmesg/decode                 |  2 ++
 tests/ts/dmesg/delta                  |  2 ++
 tests/ts/dmesg/facilities             |  2 ++
 tests/ts/eject/umount                 |  8 ++++++--
 tests/ts/fdisk/align-512-4K           |  3 +++
 tests/ts/fdisk/align-512-4K-63        |  3 +++
 tests/ts/fdisk/align-512-4K-md        |  3 +++
 tests/ts/fdisk/align-512-512          |  3 +++
 tests/ts/fdisk/align-512-512-topology |  3 +++
 tests/ts/fdisk/bsd                    |  4 +++-
 tests/ts/fdisk/gpt                    |  4 +++-
 tests/ts/fdisk/id                     |  2 ++
 tests/ts/fdisk/mbr-dos-mode           |  2 ++
 tests/ts/fdisk/mbr-nondos-mode        |  6 ++++--
 tests/ts/fdisk/oddinput               |  2 ++
 tests/ts/fdisk/sunlabel               |  2 ++
 tests/ts/fsck/ismounted               |  4 ++++
 tests/ts/hexdump/format-strings       |  2 +-
 tests/ts/hwclock/systohc              |  3 +++
 tests/ts/ipcs/headers                 |  2 ++
 tests/ts/ipcs/limits                  |  3 +++
 tests/ts/ipcs/limits2                 |  3 +++
 tests/ts/ipcs/mk-rm-msg               |  4 ++++
 tests/ts/ipcs/mk-rm-sem               |  4 ++++
 tests/ts/ipcs/mk-rm-shm               |  4 ++++
 tests/ts/isosize/print-size           |  2 ++
 tests/ts/last/ipv6                    |  2 +-
 tests/ts/last/last                    |  2 +-
 tests/ts/libmount/context             |  7 ++++++-
 tests/ts/libmount/context-py          |  6 ++++++
 tests/ts/libmount/context-utab        |  4 ++++
 tests/ts/libmount/context-utab-py     |  5 +++++
 tests/ts/login/islocal                |  2 ++
 tests/ts/login/logindefs              |  2 ++
 tests/ts/look/separator               |  2 ++
 tests/ts/losetup/losetup              |  3 +++
 tests/ts/lscpu/lscpu                  |  4 +++-
 tests/ts/minix/fsck                   |  5 +++--
 tests/ts/minix/mkfs                   |  5 +++--
 tests/ts/misc/fallocate               |  2 ++
 tests/ts/misc/getopt                  |  2 ++
 tests/ts/misc/ionice                  |  2 ++
 tests/ts/misc/line                    |  4 +---
 tests/ts/misc/mcookie                 |  2 ++
 tests/ts/misc/rev                     |  2 ++
 tests/ts/misc/setarch                 |  2 ++
 tests/ts/misc/setsid                  |  2 ++
 tests/ts/misc/ul                      |  2 ++
 tests/ts/misc/whereis                 |  2 ++
 tests/ts/more/regexp                  |  2 ++
 tests/ts/more/squeeze                 |  2 ++
 tests/ts/mount/devname                |  4 ++++
 tests/ts/mount/fstab-broken           |  5 +++++
 tests/ts/mount/fstab-devname          |  4 ++++
 tests/ts/mount/fstab-devname2label    |  4 ++++
 tests/ts/mount/fstab-devname2uuid     |  4 ++++
 tests/ts/mount/fstab-label            |  4 ++++
 tests/ts/mount/fstab-label2devname    |  4 ++++
 tests/ts/mount/fstab-label2uuid       |  4 ++++
 tests/ts/mount/fstab-none             |  5 +++++
 tests/ts/mount/fstab-symlink          |  4 ++++
 tests/ts/mount/fstab-uuid             |  4 ++++
 tests/ts/mount/fstab-uuid2devname     |  4 ++++
 tests/ts/mount/fstab-uuid2label       |  4 ++++
 tests/ts/mount/label                  |  4 ++++
 tests/ts/mount/move                   |  5 +++++
 tests/ts/mount/noncanonical           |  3 +++
 tests/ts/mount/paths                  |  3 +++
 tests/ts/mount/regfile                |  4 ++++
 tests/ts/mount/remount                |  4 ++++
 tests/ts/mount/rlimit                 |  4 ++++
 tests/ts/mount/shared-subtree         |  5 +++++
 tests/ts/mount/special                |  3 +++
 tests/ts/mount/umount-alltargets      |  5 +++++
 tests/ts/mount/umount-recursive       |  5 +++++
 tests/ts/mount/uuid                   |  4 ++++
 tests/ts/namei/logic                  |  2 ++
 tests/ts/partx/partx                  |  7 +++++--
 tests/ts/schedutils/cpuset            |  2 ++
 tests/ts/script/race                  |  2 ++
 tests/ts/swapon/devname               |  5 +++++
 tests/ts/swapon/fixpgsz               |  5 +++++
 tests/ts/swapon/fixsig                |  5 +++++
 tests/ts/swapon/label                 |  5 +++++
 tests/ts/swapon/uuid                  |  5 +++++
 tests/ts/tailf/simple                 |  2 ++
 tests/ts/utmpdump/ipv6tobin           |  2 ++
 tests/ts/utmpdump/ipv6totxt           |  2 ++
 tests/ts/utmpdump/to-binary           |  2 ++
 tests/ts/utmpdump/to-text             |  2 ++
 tests/ts/wipefs/wipefs                |  2 ++
 122 files changed, 374 insertions(+), 30 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index f210204..32b299a 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -31,6 +31,12 @@ function ts_canonicalize {
 	fi
 }
 
+function ts_check_test_command {
+	if [ ! -x "$1" ]; then
+		ts_skip "${1##*/} not found"
+	fi
+}
+
 function ts_skip_subtest {
 	echo " IGNORE ($1)"
 }
@@ -351,7 +357,7 @@ function ts_die {
 	ts_log "$1"
 	if [ -n "$2" ] && [ -b "$2" ]; then
 		ts_device_deinit "$2"
-		ts_fstab_clean		# for sure... 
+		ts_fstab_clean		# for sure...
 	fi
 	ts_finalize
 }
@@ -364,7 +370,7 @@ function ts_image_md5sum {
 function ts_image_init {
 	local mib=${1:-"5"}	# size in MiBs
 	local img=${2:-"$TS_OUTDIR/${TS_TESTNAME}.img"}
-	
+
 	dd if=/dev/zero of="$img" bs=1M count=$mib &> /dev/null
 	echo "$img"
 	return 0
diff --git a/tests/ts/bitops/swapbytes b/tests/ts/bitops/swapbytes
index 62e380c..74f0834 100755
--- a/tests/ts/bitops/swapbytes
+++ b/tests/ts/bitops/swapbytes
@@ -21,6 +21,8 @@ TS_DESC="swap bytes"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_HELPER_BYTESWAP"
+
 $TS_HELPER_BYTESWAP >> $TS_OUTPUT
 
 ts_finalize
diff --git a/tests/ts/blkid/low-probe b/tests/ts/blkid/low-probe
index 0ecc664..adf022c 100755
--- a/tests/ts/blkid/low-probe
+++ b/tests/ts/blkid/low-probe
@@ -23,9 +23,7 @@ TS_DESC="low-level superblocks probing"
 
 ts_init "$*"
 
-if [ ! -x "$TS_CMD_BLKID" ]; then
-	ts_skip "blkid disabled"
-fi
+ts_check_test_command "$TS_CMD_BLKID"
 
 mkdir -p $TS_OUTDIR/images-fs
 
diff --git a/tests/ts/blkid/lowprobe-pt b/tests/ts/blkid/lowprobe-pt
index b88dd60..a7404af 100755
--- a/tests/ts/blkid/lowprobe-pt
+++ b/tests/ts/blkid/lowprobe-pt
@@ -23,9 +23,7 @@ TS_DESC="partitions probing"
 
 ts_init "$*"
 
-if [ ! -x "$TS_HELPER_PARTITIONS" ]; then
-	ts_skip "blkid disabled"
-fi
+ts_check_test_command "$TS_HELPER_PARTITIONS"
 
 mkdir -p $TS_OUTDIR/images-pt
 
diff --git a/tests/ts/blkid/md-raid0-whole b/tests/ts/blkid/md-raid0-whole
index bf95f77..e8eeddb 100755
--- a/tests/ts/blkid/md-raid0-whole
+++ b/tests/ts/blkid/md-raid0-whole
@@ -21,6 +21,10 @@ TS_DESC="MD raid0 (whole-disks)"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_CMD_BLKID"
+
 ts_skip_nonroot
 [ -x /sbin/mdadm ] || ts_skip "missing mdadm"
 
diff --git a/tests/ts/blkid/md-raid1-part b/tests/ts/blkid/md-raid1-part
index 30900ea..453d93d 100755
--- a/tests/ts/blkid/md-raid1-part
+++ b/tests/ts/blkid/md-raid1-part
@@ -21,6 +21,10 @@ TS_DESC="MD raid1 (last partition)"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_CMD_BLKID"
+
 ts_skip_nonroot
 
 DEVICE=$(ts_scsi_debug_init dev_size_mb=51 sector_size=512)
diff --git a/tests/ts/blkid/md-raid1-whole b/tests/ts/blkid/md-raid1-whole
index fe41901..9967c0c 100755
--- a/tests/ts/blkid/md-raid1-whole
+++ b/tests/ts/blkid/md-raid1-whole
@@ -21,6 +21,10 @@ TS_DESC="MD raid1 (whole-disks)"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_CMD_BLKID"
+
 ts_skip_nonroot
 [ -x /sbin/mdadm ] || ts_skip "missing mdadm"
 
diff --git a/tests/ts/cal/1m b/tests/ts/cal/1m
index cf77095..916959c 100755
--- a/tests/ts/cal/1m
+++ b/tests/ts/cal/1m
@@ -22,6 +22,8 @@ TS_DESC="1 month"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
diff --git a/tests/ts/cal/1mw b/tests/ts/cal/1mw
index 2997f14..9923dd1 100755
--- a/tests/ts/cal/1mw
+++ b/tests/ts/cal/1mw
@@ -22,6 +22,8 @@ TS_DESC="1 month with week numbers"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
diff --git a/tests/ts/cal/3m b/tests/ts/cal/3m
index dc6de1e..489ffe4 100755
--- a/tests/ts/cal/3m
+++ b/tests/ts/cal/3m
@@ -21,6 +21,8 @@ TS_DESC="3 months"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
diff --git a/tests/ts/cal/3mw b/tests/ts/cal/3mw
index d3b1228..fcb261c 100755
--- a/tests/ts/cal/3mw
+++ b/tests/ts/cal/3mw
@@ -21,6 +21,8 @@ TS_DESC="3 months with week numbers"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 
 USETERM=$( ts_has_option "useterm" "$*" )
diff --git a/tests/ts/cal/bigyear b/tests/ts/cal/bigyear
index e1f4a85..d382e1b 100755
--- a/tests/ts/cal/bigyear
+++ b/tests/ts/cal/bigyear
@@ -18,6 +18,8 @@ TS_DESC="Year 2147483646"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
diff --git a/tests/ts/cal/bigyearw b/tests/ts/cal/bigyearw
index 6fddb0b..f7b4aa6 100755
--- a/tests/ts/cal/bigyearw
+++ b/tests/ts/cal/bigyearw
@@ -18,6 +18,8 @@ TS_DESC="Year 2147483646 with week numbers"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
diff --git a/tests/ts/cal/color b/tests/ts/cal/color
index 12a48b3..d0a3c28 100755
--- a/tests/ts/cal/color
+++ b/tests/ts/cal/color
@@ -20,6 +20,8 @@ TS_DESC="color"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 # --color output depends on terminal type
 export TERM=linux
 
diff --git a/tests/ts/cal/colorw b/tests/ts/cal/colorw
index b08656e..4fcdee5 100755
--- a/tests/ts/cal/colorw
+++ b/tests/ts/cal/colorw
@@ -20,6 +20,8 @@ TS_DESC="color with week numbers"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 # --color output depends on terminal type
 export TERM=linux
 
diff --git a/tests/ts/cal/sep1752 b/tests/ts/cal/sep1752
index df86b73..f8f8ef5 100755
--- a/tests/ts/cal/sep1752
+++ b/tests/ts/cal/sep1752
@@ -18,6 +18,8 @@ TS_DESC="September 1752"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
diff --git a/tests/ts/cal/sep1752w b/tests/ts/cal/sep1752w
index 293df39..8542801 100755
--- a/tests/ts/cal/sep1752w
+++ b/tests/ts/cal/sep1752w
@@ -18,6 +18,8 @@ TS_DESC="September 1752 with week numbers"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
diff --git a/tests/ts/cal/weekarg b/tests/ts/cal/weekarg
index 507b564..3d90f64 100755
--- a/tests/ts/cal/weekarg
+++ b/tests/ts/cal/weekarg
@@ -21,6 +21,8 @@ TS_DESC="week number given as argument"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
diff --git a/tests/ts/cal/weeknum b/tests/ts/cal/weeknum
index e25b71b..d0c300e 100755
--- a/tests/ts/cal/weeknum
+++ b/tests/ts/cal/weeknum
@@ -21,6 +21,8 @@ TS_DESC="week number corner cases"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
@@ -29,7 +31,7 @@ USETERM=$( ts_has_option "useterm" "$*" )
 [ "$USETERM" == "yes" ] && TS_VERBOSE="yes"
 ts_log ""
 
-for x in 2001 2002 2003 2009 2010 2011 2012 ; do 
+for x in 2001 2002 2003 2009 2010 2011 2012 ; do
 MYTIME="1 $x"
 
 ts_log "Gregorian - Monday-based week with week numbers - year $x"
diff --git a/tests/ts/cal/year b/tests/ts/cal/year
index 78b3546..02ace8c 100755
--- a/tests/ts/cal/year
+++ b/tests/ts/cal/year
@@ -21,6 +21,8 @@ TS_DESC="year"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
diff --git a/tests/ts/cal/yearw b/tests/ts/cal/yearw
index 9c72590..dacf235 100755
--- a/tests/ts/cal/yearw
+++ b/tests/ts/cal/yearw
@@ -21,6 +21,8 @@ TS_DESC="year with week numbers"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CAL"
+
 set -o pipefail
 export TERM=linux
 
diff --git a/tests/ts/col/multibyte b/tests/ts/col/multibyte
index 7001029..dc9db41 100755
--- a/tests/ts/col/multibyte
+++ b/tests/ts/col/multibyte
@@ -21,6 +21,8 @@ TS_DESC="multibyte input"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_COL"
+
 cat $TS_SELF/multibyte.data | $TS_CMD_COL > /dev/null  2> $TS_OUTPUT
 
 ts_finalize
diff --git a/tests/ts/colrm/rm2-2 b/tests/ts/colrm/rm2-2
index a8419cb..a732015 100755
--- a/tests/ts/colrm/rm2-2
+++ b/tests/ts/colrm/rm2-2
@@ -21,6 +21,8 @@ TS_DESC="basic check"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_COLRM"
+
 printf "a       b\nc\td\nef\b\tg\n" | $TS_CMD_COLRM 2 2 > $TS_OUTPUT 2>&1
 
 ts_finalize
diff --git a/tests/ts/column/fillrow b/tests/ts/column/fillrow
index 172e858..a68d5e9 100755
--- a/tests/ts/column/fillrow
+++ b/tests/ts/column/fillrow
@@ -21,6 +21,8 @@ TS_DESC="fill row"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_COLUMN"
+
 cd $TS_OUTDIR
 
 $TS_CMD_COLUMN -x -c 50 $TS_SELF/input >> $TS_OUTPUT 2>&1
diff --git a/tests/ts/column/multi-file b/tests/ts/column/multi-file
index 654a1da..591ccd8 100755
--- a/tests/ts/column/multi-file
+++ b/tests/ts/column/multi-file
@@ -2,7 +2,7 @@
 
 #
 # Copyright (C) 2011 Sami Kerola <kerolasa@iki.fi>
-#               2011 Karel Zak <kzak@redhat.com> 
+#               2011 Karel Zak <kzak@redhat.com>
 #
 # This file is part of util-linux.
 #
@@ -22,6 +22,8 @@ TS_DESC="multiple files"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_COLUMN"
+
 cd $TS_OUTDIR
 
 $TS_CMD_COLUMN -x -c 50 $TS_SELF/input \
diff --git a/tests/ts/column/separator_table b/tests/ts/column/separator_table
index fe6f83c..6591756 100755
--- a/tests/ts/column/separator_table
+++ b/tests/ts/column/separator_table
@@ -21,6 +21,8 @@ TS_DESC="separator & table"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_COLUMN"
+
 cd $TS_OUTDIR
 
 $TS_CMD_COLUMN -s 2 -t $TS_SELF/input >> $TS_OUTPUT 2>&1
diff --git a/tests/ts/cramfs/doubles b/tests/ts/cramfs/doubles
index ed4e4aa..b849032 100755
--- a/tests/ts/cramfs/doubles
+++ b/tests/ts/cramfs/doubles
@@ -20,6 +20,11 @@ TS_DESC="mkfs doubles"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKCRAMFS"
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/cramfs/fsck-endianness b/tests/ts/cramfs/fsck-endianness
index 6a98c9e..c4ea51d 100755
--- a/tests/ts/cramfs/fsck-endianness
+++ b/tests/ts/cramfs/fsck-endianness
@@ -20,6 +20,10 @@ TS_DESC="fsck endianness"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKCRAMFS"
+ts_check_test_command "$TS_CMD_FSCKCRAMFS"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/cramfs/mkfs b/tests/ts/cramfs/mkfs
index 5facfe9..66ae0b6 100755
--- a/tests/ts/cramfs/mkfs
+++ b/tests/ts/cramfs/mkfs
@@ -20,6 +20,12 @@ TS_DESC="mkfs checksums"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKCRAMFS"
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+ts_check_test_command "$TS_CMD_LOSETUP"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/cramfs/mkfs-endianness b/tests/ts/cramfs/mkfs-endianness
index 68237c0..424cc92 100755
--- a/tests/ts/cramfs/mkfs-endianness
+++ b/tests/ts/cramfs/mkfs-endianness
@@ -20,6 +20,9 @@ TS_DESC="mkfs endianness"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKCRAMFS"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/dmesg/console-levels b/tests/ts/dmesg/console-levels
index b87d3fd..2c2c57e 100755
--- a/tests/ts/dmesg/console-levels
+++ b/tests/ts/dmesg/console-levels
@@ -18,6 +18,8 @@ TS_DESC="levels"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_DMESG"
+
 for I in {-1..8}; do
 	$TS_CMD_DMESG -F $TS_SELF/input -l $I >> $TS_OUTPUT 2>/dev/null
 done
diff --git a/tests/ts/dmesg/decode b/tests/ts/dmesg/decode
index a1afa6f..5ac17bf 100755
--- a/tests/ts/dmesg/decode
+++ b/tests/ts/dmesg/decode
@@ -18,6 +18,8 @@ TS_DESC="decode"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_DMESG"
+
 $TS_CMD_DMESG -x -F $TS_SELF/input >> $TS_OUTPUT 2>/dev/null
 
 ts_finalize
diff --git a/tests/ts/dmesg/delta b/tests/ts/dmesg/delta
index 774ffb1..7d1de3e 100755
--- a/tests/ts/dmesg/delta
+++ b/tests/ts/dmesg/delta
@@ -18,6 +18,8 @@ TS_DESC="delta"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_DMESG"
+
 $TS_CMD_DMESG -d -F $TS_SELF/input >> $TS_OUTPUT 2>/dev/null
 
 ts_finalize
diff --git a/tests/ts/dmesg/facilities b/tests/ts/dmesg/facilities
index 1b7b0d4..646f875 100755
--- a/tests/ts/dmesg/facilities
+++ b/tests/ts/dmesg/facilities
@@ -18,6 +18,8 @@ TS_DESC="facilities"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_DMESG"
+
 for I in {-1..12}; do
 	$TS_CMD_DMESG -F $TS_SELF/input -f $I >> $TS_OUTPUT 2>/dev/null
 done
diff --git a/tests/ts/eject/umount b/tests/ts/eject/umount
index 3c1f84e..940c77b 100755
--- a/tests/ts/eject/umount
+++ b/tests/ts/eject/umount
@@ -5,10 +5,14 @@ TS_DESC="umount"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_CMD_EJECT"
+
 ts_skip_nonroot
 
 #
-# Note that eject --force is required because scsi_debug is 
+# Note that eject --force is required because scsi_debug is
 # not removable device.
 #
 
@@ -35,7 +39,7 @@ p
 w
 EOF
 	udevadm settle
-	mkfs.ext2 -q ${dev}1 
+	mkfs.ext2 -q ${dev}1
 	mkfs.ext2 -q ${dev}2
 	udevadm settle
 }
diff --git a/tests/ts/fdisk/align-512-4K b/tests/ts/fdisk/align-512-4K
index c5ea72e..c733170 100755
--- a/tests/ts/fdisk/align-512-4K
+++ b/tests/ts/fdisk/align-512-4K
@@ -25,6 +25,9 @@ TS_DESC="align 512/4K"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+
 ts_skip_nonroot
 
 DEVICE=$(ts_scsi_debug_init dev_size_mb=50 sector_size=512 physblk_exp=3)
diff --git a/tests/ts/fdisk/align-512-4K-63 b/tests/ts/fdisk/align-512-4K-63
index 4ec8198..bcc1c76 100755
--- a/tests/ts/fdisk/align-512-4K-63
+++ b/tests/ts/fdisk/align-512-4K-63
@@ -25,6 +25,9 @@ TS_DESC="align 512/4K +alignment_offset"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+
 ts_skip_nonroot
 
 DEVICE=$(ts_scsi_debug_init dev_size_mb=50 sector_size=512 physblk_exp=3 lowest_aligned=7)
diff --git a/tests/ts/fdisk/align-512-4K-md b/tests/ts/fdisk/align-512-4K-md
index ad5568a..d300b4e 100755
--- a/tests/ts/fdisk/align-512-4K-md
+++ b/tests/ts/fdisk/align-512-4K-md
@@ -25,6 +25,9 @@ TS_DESC="align 512/4K +MD"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+
 ts_skip_nonroot
 
 DEVICE=$(ts_scsi_debug_init dev_size_mb=50 sector_size=512 physblk_exp=3)
diff --git a/tests/ts/fdisk/align-512-512 b/tests/ts/fdisk/align-512-512
index 03133a6..9862b58 100755
--- a/tests/ts/fdisk/align-512-512
+++ b/tests/ts/fdisk/align-512-512
@@ -24,6 +24,9 @@ TS_DESC="align 512/512"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+
 ts_skip_nonroot
 
 DEVICE=$(ts_device_init 50)
diff --git a/tests/ts/fdisk/align-512-512-topology b/tests/ts/fdisk/align-512-512-topology
index 9354e45..b11bc9b 100755
--- a/tests/ts/fdisk/align-512-512-topology
+++ b/tests/ts/fdisk/align-512-512-topology
@@ -25,6 +25,9 @@ TS_DESC="align 512/512 +topology"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+
 ts_skip_nonroot
 
 
diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
index 288388d..54c0a95 100755
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -22,6 +22,8 @@ TS_DESC="nested BSD"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_FDISK"
+
 FDISK_CMD_CREATE_DOSLABEL="o\n"              # create dos label
 FDISK_CMD_SETID="x\ni\n0x1\nr\n"             # set non-random ID
 FDISK_CMD_WRITE_CLOSE="w\nq\n"               # write to image
@@ -35,7 +37,7 @@ FDISK_CMD_BSD_CREATE_PART="b\nn\na\n\n+1M\n" # add BSD partition 'a', size 1MiB
 FDISK_CMD_BSD_PARTTYPE="b\nt\na\n7\n"        # set partition 'a' to type 4.2BSD
 FDISK_CMD_BSD_LIST_TYPES="b\nl\nq\n"         # list supported PT types and quit
 
-#set -x 
+#set -x
 
 function print_layout {
 	echo -ne "\n---layout----------" >> $TS_OUTPUT
diff --git a/tests/ts/fdisk/gpt b/tests/ts/fdisk/gpt
index 2507907..5737544 100755
--- a/tests/ts/fdisk/gpt
+++ b/tests/ts/fdisk/gpt
@@ -22,6 +22,8 @@ TS_DESC="GPT"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_FDISK"
+
 FDISK_CMD_CREATE_GPTLABEL="g\n"              # create GPT label
 FDISK_CMD_WRITE_CLOSE="w\nq\n"               # write to image
 
@@ -29,7 +31,7 @@ FDISK_CMD_CHANGE_TYPE_BY_NUM="t\n1\n1\n"     # set 1st partition to EFI System
                                              # set 5th partition to Linux swap
 FDISK_CMD_CHANGE_TYPE_BY_UUID="t\n5\n0657FD6D-A4AB-43C4-84E5-0933C84B4F4F\n"
 
-FDISK_CMD_DELETE_PART="d\n2\n"               # delete 2nd partition	
+FDISK_CMD_DELETE_PART="d\n2\n"               # delete 2nd partition
 FDISK_CMD_CREATE_PART="n\n2\n\n\n"           # create 2nd partition
 
 function print_layout {
diff --git a/tests/ts/fdisk/id b/tests/ts/fdisk/id
index 2c76f42..2126b66 100755
--- a/tests/ts/fdisk/id
+++ b/tests/ts/fdisk/id
@@ -20,6 +20,8 @@ TS_DESC="MBR - id"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_FDISK"
+
 FDISK_CMD_ID1="x\ni\n0x1\nr\nw\n"
 FDISK_CMD_ID2="x\ni\n0x2\nr\nw\n"
 
diff --git a/tests/ts/fdisk/mbr-dos-mode b/tests/ts/fdisk/mbr-dos-mode
index b16e95c..829d27d 100755
--- a/tests/ts/fdisk/mbr-dos-mode
+++ b/tests/ts/fdisk/mbr-dos-mode
@@ -22,6 +22,8 @@ TS_DESC="MBR - dos mode"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_FDISK"
+
 FDISK_CMD_INIT="x\ni\n0x1\nr\n"
 FDISK_CMD_WRITE_CLOSE="w\nq\n"
 FDISK_CMD_CREATE_DOSLABEL="o\n" #create dos label
diff --git a/tests/ts/fdisk/mbr-nondos-mode b/tests/ts/fdisk/mbr-nondos-mode
index 88a80e6..d6a6af3 100755
--- a/tests/ts/fdisk/mbr-nondos-mode
+++ b/tests/ts/fdisk/mbr-nondos-mode
@@ -20,6 +20,8 @@ TS_DESC="MBR - non-dos mode"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_FDISK"
+
 # cmd to changes system id to 0x1
 FDISK_CMD_INIT="x\ni\n0x1\nr\n"
 FDISK_CMD_WRITE_CLOSE="w\nq\n"
@@ -27,7 +29,7 @@ FDISK_CMD_CREATE_DOSLABEL="o\n" #create dos label
 FDISK_CMD_CREATE_1PRIMARY="n\np\n\n\n+3M\n" # create primary partition of size 3MiB
 FDISK_CMD_CREATE_2PRIMARY="n\np\n\n\n+2M\n" # create primary partition of size 2MiB
 FDISK_CMD_SET_ACTIVE="a\n1\n" # set first partition active
-FDISK_CMD_CREATE_EXTENDED="n\ne\n\n\n\n" # create extended partition 
+FDISK_CMD_CREATE_EXTENDED="n\ne\n\n\n\n" # create extended partition
 FDISK_CMD_CREATE_LOGICAL="n\nl\n\n+2M\n" # create next logical partition of size 10 sectors
 FDISK_CMD_DELETE_LOGICALS="d\n6\nd\n5\nd\n6\n" # delete middle, head, tail, last partitions
 FDISK_CMD_DELETE_1PRIMARY="d\n1\n" # delete first primary
@@ -40,7 +42,7 @@ function print_layout {
 	echo -ne   "-------------------\n\n" >> $TS_OUTPUT
 }
 
-#set -x 
+#set -x
 
 ts_log "Initialize empty image"
 TEST_IMAGE_NAME=$(ts_image_init 20)	# 20 MiB
diff --git a/tests/ts/fdisk/oddinput b/tests/ts/fdisk/oddinput
index 5b9bb31..f71b7e2 100755
--- a/tests/ts/fdisk/oddinput
+++ b/tests/ts/fdisk/oddinput
@@ -20,6 +20,8 @@ TS_DESC="invalid input tests"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_FDISK"
+
 #set -x
 
 ts_log "Initialize empty image"
diff --git a/tests/ts/fdisk/sunlabel b/tests/ts/fdisk/sunlabel
index f610ad8..46392fa 100755
--- a/tests/ts/fdisk/sunlabel
+++ b/tests/ts/fdisk/sunlabel
@@ -20,6 +20,8 @@ TS_DESC="sunlabel tests"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_FDISK"
+
 FDISK_CMD_INIT="s\n" # create new sunlabel
 FDISK_CMD_WRITE_CLOSE="w\nq\n"
 FDISK_CMD_DELETEALL="d\n1\nd\n2\nd\n3\nd\n4\nd\n5\nd\n6\nd\n7\nd\n8\n" # delete all partitions
diff --git a/tests/ts/fsck/ismounted b/tests/ts/fsck/ismounted
index 6b7f0f7..93c2e81 100755
--- a/tests/ts/fsck/ismounted
+++ b/tests/ts/fsck/ismounted
@@ -19,6 +19,10 @@ TS_DESC="is mounted"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_CMD_MOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/hexdump/format-strings b/tests/ts/hexdump/format-strings
index 9b6745c..0b30037 100755
--- a/tests/ts/hexdump/format-strings
+++ b/tests/ts/hexdump/format-strings
@@ -22,7 +22,7 @@ FILES="$TS_TOPDIR/ts/hexdump/files"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-[ -x $TS_CMD_HEXDUMP ] || ts_skip "hexdump not compiled"
+ts_check_test_command "$TS_CMD_HEXDUMP"
 
 #885314
 ts_init_subtest "empty-format"
diff --git a/tests/ts/hwclock/systohc b/tests/ts/hwclock/systohc
index 401ee93..d60adfb 100755
--- a/tests/ts/hwclock/systohc
+++ b/tests/ts/hwclock/systohc
@@ -22,6 +22,9 @@ NTP_SERVER="0.fedora.pool.ntp.org"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_HWCLOCK"
+
 ts_skip_nonroot
 
 PATH='/usr/sbin:/usr/bin:/sbin:/bin'
diff --git a/tests/ts/ipcs/headers b/tests/ts/ipcs/headers
index 99b82a3..6790471 100755
--- a/tests/ts/ipcs/headers
+++ b/tests/ts/ipcs/headers
@@ -21,6 +21,8 @@ TS_DESC="headers"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_IPCS"
+
 ts_log "test: shm headers"
 $TS_CMD_IPCS -m -t | grep --after-context=1 "^---"  >> $TS_OUTPUT
 $TS_CMD_IPCS -m -p | grep --after-context=1 "^---"  >> $TS_OUTPUT
diff --git a/tests/ts/ipcs/limits b/tests/ts/ipcs/limits
index b44adb1..b4f71b0 100755
--- a/tests/ts/ipcs/limits
+++ b/tests/ts/ipcs/limits
@@ -22,6 +22,9 @@ TS_DESC="limits overflow"
 . $TS_TOPDIR/functions.sh
 
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_IPCS"
+
 ts_skip_nonroot
 type bc >/dev/null 2>&1 || ts_skip "cannot find bc command"
 
diff --git a/tests/ts/ipcs/limits2 b/tests/ts/ipcs/limits2
index f99a354..769012b 100755
--- a/tests/ts/ipcs/limits2
+++ b/tests/ts/ipcs/limits2
@@ -21,6 +21,9 @@ TS_DESC="basic limits"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_IPCS"
+
 type bc >/dev/null 2>&1 || ts_skip "cannot find bc command"
 
 . $TS_SELF/functions.sh
diff --git a/tests/ts/ipcs/mk-rm-msg b/tests/ts/ipcs/mk-rm-msg
index 529d861..a752173 100755
--- a/tests/ts/ipcs/mk-rm-msg
+++ b/tests/ts/ipcs/mk-rm-msg
@@ -18,6 +18,10 @@ TS_DESC="mk-rm-msg"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_IPCS"
+ts_check_test_command "$TS_CMD_IPCMK"
+ts_check_test_command "$TS_CMD_IPCRM"
+
 . $TS_SELF/functions.sh
 
 rm -f $TS_OUTDIR/id-msg
diff --git a/tests/ts/ipcs/mk-rm-sem b/tests/ts/ipcs/mk-rm-sem
index 2eb149d..7fd10c9 100755
--- a/tests/ts/ipcs/mk-rm-sem
+++ b/tests/ts/ipcs/mk-rm-sem
@@ -18,6 +18,10 @@ TS_DESC="mk-rm-sem"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_IPCS"
+ts_check_test_command "$TS_CMD_IPCMK"
+ts_check_test_command "$TS_CMD_IPCRM"
+
 . $TS_SELF/functions.sh
 
 rm -f $TS_OUTDIR/id-sem
diff --git a/tests/ts/ipcs/mk-rm-shm b/tests/ts/ipcs/mk-rm-shm
index f2bc33e..987127a 100755
--- a/tests/ts/ipcs/mk-rm-shm
+++ b/tests/ts/ipcs/mk-rm-shm
@@ -18,6 +18,10 @@ TS_DESC="mk-rm-shm"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_IPCS"
+ts_check_test_command "$TS_CMD_IPCMK"
+ts_check_test_command "$TS_CMD_IPCRM"
+
 . $TS_SELF/functions.sh
 
 rm -f $TS_OUTDIR/id-shm
diff --git a/tests/ts/isosize/print-size b/tests/ts/isosize/print-size
index cd260a0..1476b35 100755
--- a/tests/ts/isosize/print-size
+++ b/tests/ts/isosize/print-size
@@ -18,6 +18,8 @@ TS_DESC="print-size"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_ISOSIZE"
+
 gzip -cd $TS_SELF/sample.iso.gz > $TS_OUTDIR/sample.iso
 $TS_CMD_ISOSIZE $TS_OUTDIR/sample.iso >| $TS_OUTPUT 2>&1
 
diff --git a/tests/ts/last/ipv6 b/tests/ts/last/ipv6
index 60b72bd..a09adea 100755
--- a/tests/ts/last/ipv6
+++ b/tests/ts/last/ipv6
@@ -18,7 +18,7 @@ TS_DESC="last ipv6"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-[ -x $TS_CMD_LAST ] || ts_skip "last not enabled"
+ts_check_test_command "$TS_CMD_LAST"
 
 export LANG=C
 export TZ=GMT
diff --git a/tests/ts/last/last b/tests/ts/last/last
index 83b7f8d..98ba25b 100755
--- a/tests/ts/last/last
+++ b/tests/ts/last/last
@@ -18,7 +18,7 @@ TS_DESC="last"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-[ -x $TS_CMD_LAST ] || ts_skip "last not enabled"
+ts_check_test_command "$TS_CMD_LAST"
 
 export LANG=C
 export TZ=GMT
diff --git a/tests/ts/libmount/context b/tests/ts/libmount/context
index 0c3bce9..3d29d04 100755
--- a/tests/ts/libmount/context
+++ b/tests/ts/libmount/context
@@ -7,8 +7,13 @@ TS_DESC="context"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
-ts_skip_nonroot
 
+ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_CMD_FINDMNT"
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
+ts_skip_nonroot
 TESTPROG="$TS_HELPER_LIBMOUNT_CONTEXT"
 LABEL=libmount-test
 UUID=$(uuidgen)
diff --git a/tests/ts/libmount/context-py b/tests/ts/libmount/context-py
index 4be19dd..917e7d9 100755
--- a/tests/ts/libmount/context-py
+++ b/tests/ts/libmount/context-py
@@ -7,6 +7,12 @@ TS_DESC="context-py"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_CMD_FINDMNT"
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_init_py libmount
 ts_skip_nonroot
 
diff --git a/tests/ts/libmount/context-utab b/tests/ts/libmount/context-utab
index b3aaff9..61af96e 100755
--- a/tests/ts/libmount/context-utab
+++ b/tests/ts/libmount/context-utab
@@ -7,6 +7,10 @@ TS_DESC="context (utab)"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_CMD_FINDMNT"
+ts_check_test_command "$TS_CMD_WIPEFS"
 ts_skip_nonroot
 
 TESTPROG="$TS_HELPER_LIBMOUNT_CONTEXT"
diff --git a/tests/ts/libmount/context-utab-py b/tests/ts/libmount/context-utab-py
index ed379d4..5eafce6 100755
--- a/tests/ts/libmount/context-utab-py
+++ b/tests/ts/libmount/context-utab-py
@@ -6,6 +6,11 @@ TS_DESC="context-py (utab)"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_CMD_FINDMNT"
+ts_check_test_command "$TS_CMD_WIPEFS"
+
 ts_init_py libmount
 ts_skip_nonroot
 
diff --git a/tests/ts/login/islocal b/tests/ts/login/islocal
index c25da6a..3c95a0d 100755
--- a/tests/ts/login/islocal
+++ b/tests/ts/login/islocal
@@ -21,6 +21,8 @@ TS_DESC="islocal"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_HELPER_ISLOCAL"
+
 $TS_HELPER_ISLOCAL "$TS_SELF/islocal.data" root nobody "" youngman youngman2 \
     abcdefghx nobo long rot al malformed \
     nonl znobody >> $TS_OUTPUT
diff --git a/tests/ts/login/logindefs b/tests/ts/login/logindefs
index 10caed7..c3c6385 100755
--- a/tests/ts/login/logindefs
+++ b/tests/ts/login/logindefs
@@ -10,6 +10,8 @@ TS_DESC="defs"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_HELPER_LOGINDEFS"
+
 # list all items
 $TS_HELPER_LOGINDEFS "$TS_SELF/logindefs.data" | sed 's:'$TS_SELF'/::g' >> $TS_OUTPUT
 
diff --git a/tests/ts/look/separator b/tests/ts/look/separator
index 51e96c9..bac9b60 100755
--- a/tests/ts/look/separator
+++ b/tests/ts/look/separator
@@ -34,6 +34,8 @@ TS_DESC="separator"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_LOOK"
+
 $TS_CMD_LOOK apple-pie $TS_TOPDIR/ts/look/words >> $TS_OUTPUT
 ts_finalize
 
diff --git a/tests/ts/losetup/losetup b/tests/ts/losetup/losetup
index 29d4b42..86b9c38 100755
--- a/tests/ts/losetup/losetup
+++ b/tests/ts/losetup/losetup
@@ -21,6 +21,9 @@ TS_DESC="losetup"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_LOSETUP"
+
 ts_skip_nonroot
 
 DEVICE=$(ts_scsi_debug_init dev_size_mb=11)
diff --git a/tests/ts/lscpu/lscpu b/tests/ts/lscpu/lscpu
index a7d7a95..bd8c81b 100755
--- a/tests/ts/lscpu/lscpu
+++ b/tests/ts/lscpu/lscpu
@@ -22,6 +22,8 @@ TS_TOPDIR="$(dirname $0)/../.."
 
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_LSCPU"
+
 for dump in $(ls $TS_SELF/dumps/*.tar.gz | sort); do
 	name=$(basename $dump .tar.gz)
 	dumpdir="$TS_OUTDIR/dumps"
@@ -29,7 +31,7 @@ for dump in $(ls $TS_SELF/dumps/*.tar.gz | sort); do
 	ts_init_subtest $name
 	mkdir -p $dumpdir
 
-	tar -C $dumpdir -zxf $dump 
+	tar -C $dumpdir -zxf $dump
 
 	# Architecture information is not applicable with -s.
 	"${TS_CMD_LSCPU}" -s "${dumpdir}/${name}" | \
diff --git a/tests/ts/minix/fsck b/tests/ts/minix/fsck
index f635fc1..b8cfbc7 100755
--- a/tests/ts/minix/fsck
+++ b/tests/ts/minix/fsck
@@ -19,12 +19,13 @@ TS_DESC="mkfs checksums"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKMINIX"
+
 ts_skip_nonroot
 
 set -o pipefail
 
-[ -x $TS_CMD_FSCKMINIX ] || ts_skip "fsck.minix not compiled"
-
 IMAGE="$TS_OUTDIR/${TS_TESTNAME}-loop.img"
 DEVICE=$(ts_device_init)
 
diff --git a/tests/ts/minix/mkfs b/tests/ts/minix/mkfs
index 39185ad..cb124cc 100755
--- a/tests/ts/minix/mkfs
+++ b/tests/ts/minix/mkfs
@@ -19,12 +19,13 @@ TS_DESC="mkfs"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKMINIX"
+
 ts_skip_nonroot
 
 set -o pipefail
 
-[ -x $TS_CMD_MKMINIX ] || ts_skip "mkfs.minix not compiled"
-
 IMAGE="$TS_OUTDIR/${TS_TESTNAME}-loop.img"
 DEVICE=$(ts_device_init)
 
diff --git a/tests/ts/misc/fallocate b/tests/ts/misc/fallocate
index 735baab..b68395f 100755
--- a/tests/ts/misc/fallocate
+++ b/tests/ts/misc/fallocate
@@ -18,6 +18,8 @@ TS_DESC="fallocate"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_FALLOCATE"
+
 IMAGE=${TS_OUTDIR}/${TS_TESTNAME}.file
 rm -f $IMAGE
 
diff --git a/tests/ts/misc/getopt b/tests/ts/misc/getopt
index a6b91cb..9051947 100755
--- a/tests/ts/misc/getopt
+++ b/tests/ts/misc/getopt
@@ -21,6 +21,8 @@ TS_DESC="getopt"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_GETOPT"
+
 TEMP=$($TS_CMD_GETOPT -o ab:c:: --long a-long,b-long:,c-long:: -n 'example.bash' -- -a -b 1 -c2  --a-long --b-long 3 --c-long foo bar)
 
 if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
diff --git a/tests/ts/misc/ionice b/tests/ts/misc/ionice
index d0cca8e..3dc73fb 100755
--- a/tests/ts/misc/ionice
+++ b/tests/ts/misc/ionice
@@ -18,6 +18,8 @@ TS_DESC="ionice"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_IONICE"
+
 $TS_CMD_IONICE -p $$ -n 0 -c 0 >> $TS_OUTPUT 2>&1
 $TS_CMD_IONICE -p $$ -n 3 -c 7 >> $TS_OUTPUT 2>&1
 $TS_CMD_IONICE -p $$ -n 4 -c 7 >> $TS_OUTPUT 2>&1
diff --git a/tests/ts/misc/line b/tests/ts/misc/line
index 3863a3f..97aba72 100755
--- a/tests/ts/misc/line
+++ b/tests/ts/misc/line
@@ -18,9 +18,7 @@ TS_DESC="line"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-if [ ! -x "$TS_CMD_LINE" ]; then
-	ts_skip "line disabled"
-fi
+ts_check_test_command "$TS_CMD_LINE"
 
 printf "a\nb\n" |
 	$TS_CMD_LINE > $TS_OUTPUT 2>&1
diff --git a/tests/ts/misc/mcookie b/tests/ts/misc/mcookie
index 9e650b2..d26250a 100755
--- a/tests/ts/misc/mcookie
+++ b/tests/ts/misc/mcookie
@@ -18,6 +18,8 @@ TS_DESC="mcookie"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_MCOOKIE"
+
 $TS_CMD_MCOOKIE -f /etc/services |
 	# The sed will convert only 32 characters long hexadecimal string
 	# to expected string, but nothing else.
diff --git a/tests/ts/misc/rev b/tests/ts/misc/rev
index 035ce82..0586044 100755
--- a/tests/ts/misc/rev
+++ b/tests/ts/misc/rev
@@ -18,6 +18,8 @@ TS_DESC="rev"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_REV"
+
 for I in {0..512}; do printf "%s " {a..z}; done | md5sum >> $TS_OUTPUT 2>&1
 
 for I in {0..512}; do printf "%s " {a..z}; done | \
diff --git a/tests/ts/misc/setarch b/tests/ts/misc/setarch
index 8050556..f351976 100755
--- a/tests/ts/misc/setarch
+++ b/tests/ts/misc/setarch
@@ -18,6 +18,8 @@ TS_DESC="setarch"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_SETARCH"
+
 $TS_CMD_SETARCH $(uname -m) -vRFZLXBIST3 --uname-2.6 echo "success" >$TS_OUTPUT 2>&1
 
 ts_finalize
diff --git a/tests/ts/misc/setsid b/tests/ts/misc/setsid
index 43a76f9..14578a9 100755
--- a/tests/ts/misc/setsid
+++ b/tests/ts/misc/setsid
@@ -18,6 +18,8 @@ TS_DESC="setsid"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_SETSID"
+
 $TS_CMD_SETSID echo "success" > $TS_OUTPUT 2>&1
 
 ts_finalize
diff --git a/tests/ts/misc/ul b/tests/ts/misc/ul
index bc0ecf7..593f94a 100755
--- a/tests/ts/misc/ul
+++ b/tests/ts/misc/ul
@@ -18,6 +18,8 @@ TS_DESC="ul"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_UL"
+
 printf "a\x08ab\x5F\x08c\\n\\ttab\\f\\b\\r" |
 	$TS_CMD_UL -t xterm > $TS_OUTPUT 2>&1
 
diff --git a/tests/ts/misc/whereis b/tests/ts/misc/whereis
index 853b27a..1fe29fc 100755
--- a/tests/ts/misc/whereis
+++ b/tests/ts/misc/whereis
@@ -18,6 +18,8 @@ TS_DESC="whereis"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_WHEREIS"
+
 LS_COUNT=$($TS_CMD_WHEREIS ls | wc -w)
 if [ $LS_COUNT -lt 2 ]; then
 	echo "ls binary nor manual not found?" > $TS_OUTPUT
diff --git a/tests/ts/more/regexp b/tests/ts/more/regexp
index 06a00a2..4fea43e 100755
--- a/tests/ts/more/regexp
+++ b/tests/ts/more/regexp
@@ -18,6 +18,8 @@ TS_DESC="regexp"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_HELPER_MORE"
+
 printf "abba\nbar\nfoo\nxyzzy\n" |
 	$TS_HELPER_MORE +/foo > $TS_OUTPUT 2>&1
 
diff --git a/tests/ts/more/squeeze b/tests/ts/more/squeeze
index d448fc1..629c764 100755
--- a/tests/ts/more/squeeze
+++ b/tests/ts/more/squeeze
@@ -18,6 +18,8 @@ TS_DESC="squeeze"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_HELPER_MORE"
+
 printf "a\n\n\nb\n" |
 	$TS_HELPER_MORE -s > $TS_OUTPUT 2>&1
 
diff --git a/tests/ts/mount/devname b/tests/ts/mount/devname
index 8f32ef1..8de8765 100755
--- a/tests/ts/mount/devname
+++ b/tests/ts/mount/devname
@@ -21,6 +21,10 @@ TS_DESC="by devname"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-broken b/tests/ts/mount/fstab-broken
index 48fe1a1..a6435e0 100755
--- a/tests/ts/mount/fstab-broken
+++ b/tests/ts/mount/fstab-broken
@@ -20,6 +20,11 @@ TS_DESC="broken fstab"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+ts_check_test_command "$TS_CMD_FINDMNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-devname b/tests/ts/mount/fstab-devname
index 9af8db6..b3535b0 100755
--- a/tests/ts/mount/fstab-devname
+++ b/tests/ts/mount/fstab-devname
@@ -20,6 +20,10 @@ TS_DESC="by devname (fstab)"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-devname2label b/tests/ts/mount/fstab-devname2label
index 34214db..0df5021 100755
--- a/tests/ts/mount/fstab-devname2label
+++ b/tests/ts/mount/fstab-devname2label
@@ -21,6 +21,10 @@ LABEL="testMountD2L"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-devname2uuid b/tests/ts/mount/fstab-devname2uuid
index 859bcda..ee5564c 100755
--- a/tests/ts/mount/fstab-devname2uuid
+++ b/tests/ts/mount/fstab-devname2uuid
@@ -20,6 +20,10 @@ TS_DESC="by devname (fstab uuid)"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-label b/tests/ts/mount/fstab-label
index 2c1e7eb..757fdac 100755
--- a/tests/ts/mount/fstab-label
+++ b/tests/ts/mount/fstab-label
@@ -21,6 +21,10 @@ LABEL="testFstabLabel"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-label2devname b/tests/ts/mount/fstab-label2devname
index 0d10f1b..7ccb887 100755
--- a/tests/ts/mount/fstab-label2devname
+++ b/tests/ts/mount/fstab-label2devname
@@ -21,6 +21,10 @@ LABEL="testMountL2D"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-label2uuid b/tests/ts/mount/fstab-label2uuid
index 0ad4f05..4079fc4 100755
--- a/tests/ts/mount/fstab-label2uuid
+++ b/tests/ts/mount/fstab-label2uuid
@@ -22,6 +22,10 @@ LABEL="testMountL2U"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-none b/tests/ts/mount/fstab-none
index 62a89ca..4a107b0 100755
--- a/tests/ts/mount/fstab-none
+++ b/tests/ts/mount/fstab-none
@@ -5,6 +5,11 @@ TS_DESC="none"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+ts_check_test_command "$TS_CMD_FINDMNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-symlink b/tests/ts/mount/fstab-symlink
index 7f9d91f..f609b29 100755
--- a/tests/ts/mount/fstab-symlink
+++ b/tests/ts/mount/fstab-symlink
@@ -21,6 +21,10 @@ TS_DESC="by devname (fstab symlink)"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-uuid b/tests/ts/mount/fstab-uuid
index 8c65b4d..860ee73 100755
--- a/tests/ts/mount/fstab-uuid
+++ b/tests/ts/mount/fstab-uuid
@@ -20,6 +20,10 @@ TS_DESC="by uuid (fstab)"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-uuid2devname b/tests/ts/mount/fstab-uuid2devname
index 51bac14..62536dd 100755
--- a/tests/ts/mount/fstab-uuid2devname
+++ b/tests/ts/mount/fstab-uuid2devname
@@ -20,6 +20,10 @@ TS_DESC="by uuid (fstab devname)"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/fstab-uuid2label b/tests/ts/mount/fstab-uuid2label
index 442cdb7..d2e164a 100755
--- a/tests/ts/mount/fstab-uuid2label
+++ b/tests/ts/mount/fstab-uuid2label
@@ -21,6 +21,10 @@ LABEL="testMountU2L"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/label b/tests/ts/mount/label
index 873ea95..d72700e 100755
--- a/tests/ts/mount/label
+++ b/tests/ts/mount/label
@@ -22,6 +22,10 @@ LABEL="testMountLabel"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/move b/tests/ts/mount/move
index ea37685..63df049 100755
--- a/tests/ts/mount/move
+++ b/tests/ts/mount/move
@@ -20,6 +20,11 @@ TS_DESC="move"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+ts_check_test_command "$TS_CMD_FINDMNT"
+
 ts_skip_nonroot
 
 DIR_PRIVATE2="$TS_OUTDIR/mnt-move-private2"
diff --git a/tests/ts/mount/noncanonical b/tests/ts/mount/noncanonical
index 1d28304..0577967 100755
--- a/tests/ts/mount/noncanonical
+++ b/tests/ts/mount/noncanonical
@@ -20,6 +20,9 @@ TS_DESC="non canonical path"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+
 ts_skip_nonroot
 
 [ ! -e "/etc" ] && ts_skip "/etc not such file of directory"
diff --git a/tests/ts/mount/paths b/tests/ts/mount/paths
index 0b3432b..2ea1917 100755
--- a/tests/ts/mount/paths
+++ b/tests/ts/mount/paths
@@ -20,6 +20,9 @@ TS_DESC="basic paths"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+
 ts_skip_nonroot
 
 $TS_CMD_MOUNT -V | grep -q "libmount"
diff --git a/tests/ts/mount/regfile b/tests/ts/mount/regfile
index 8d786ad..5050929 100755
--- a/tests/ts/mount/regfile
+++ b/tests/ts/mount/regfile
@@ -8,6 +8,10 @@ TS_DESC="regular file"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/mount/remount b/tests/ts/mount/remount
index 051c595..21e8590 100755
--- a/tests/ts/mount/remount
+++ b/tests/ts/mount/remount
@@ -20,6 +20,10 @@ TS_DESC="remount"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_FINDMNT"
+
 ts_skip_nonroot
 
 # mountpoint
diff --git a/tests/ts/mount/rlimit b/tests/ts/mount/rlimit
index 7d7e42b..c28cdc0 100755
--- a/tests/ts/mount/rlimit
+++ b/tests/ts/mount/rlimit
@@ -28,6 +28,10 @@ TS_DESC="rlimit-fsize"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 [ -L /etc/mtab ] && ts_skip "mtab is symlink"
diff --git a/tests/ts/mount/shared-subtree b/tests/ts/mount/shared-subtree
index 995aed2..c1905e8 100755
--- a/tests/ts/mount/shared-subtree
+++ b/tests/ts/mount/shared-subtree
@@ -5,6 +5,11 @@ TS_DESC="shared-subtree"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+ts_check_test_command "$TS_CMD_FINDMNT"
+
 ts_skip_nonroot
 
 [ -d $TS_MOUNTPOINT ] || mkdir -p $TS_MOUNTPOINT
diff --git a/tests/ts/mount/special b/tests/ts/mount/special
index 6e198b3..b65333c 100755
--- a/tests/ts/mount/special
+++ b/tests/ts/mount/special
@@ -21,6 +21,9 @@ MOUNTER="/sbin/mount.mytest"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+
 ts_skip_nonroot
 
 cat > $MOUNTER <<\EOF
diff --git a/tests/ts/mount/umount-alltargets b/tests/ts/mount/umount-alltargets
index 434ecab..fe54145 100755
--- a/tests/ts/mount/umount-alltargets
+++ b/tests/ts/mount/umount-alltargets
@@ -7,6 +7,11 @@ TS_DESC="umount-all-targets"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+ts_check_test_command "$TS_CMD_FDISK"
+
 ts_skip_nonroot
 
 $TS_CMD_UMOUNT --help | grep -q all-targets
diff --git a/tests/ts/mount/umount-recursive b/tests/ts/mount/umount-recursive
index 85e54df..241cc1c 100755
--- a/tests/ts/mount/umount-recursive
+++ b/tests/ts/mount/umount-recursive
@@ -7,6 +7,11 @@ TS_DESC="umount-recursive"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+ts_check_test_command "$TS_CMD_FDISK"
+
 ts_skip_nonroot
 
 $TS_CMD_UMOUNT --help | grep -q recursive
diff --git a/tests/ts/mount/uuid b/tests/ts/mount/uuid
index e29ad39..331e2c8 100755
--- a/tests/ts/mount/uuid
+++ b/tests/ts/mount/uuid
@@ -20,6 +20,10 @@ TS_DESC="by uuid"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MOUNT"
+ts_check_test_command "$TS_CMD_UMOUNT"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/namei/logic b/tests/ts/namei/logic
index eda5d1b..21517dd 100755
--- a/tests/ts/namei/logic
+++ b/tests/ts/namei/logic
@@ -21,6 +21,8 @@ TS_DESC="basic functionality"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_NAMEI"
+
 cd $TS_OUTDIR
 
 mkdir -p namei1/namei2
diff --git a/tests/ts/partx/partx b/tests/ts/partx/partx
index 76d1db4..a81ef12 100755
--- a/tests/ts/partx/partx
+++ b/tests/ts/partx/partx
@@ -24,9 +24,12 @@ PARTS=3
 . $TS_TOPDIR/functions.sh
 
 ts_init "$*"
-ts_skip_nonroot
 
-[ ! -x "$TS_CMD_PARTX" ] && ts_skip "partx disabled"
+ts_check_test_command "$TS_CMD_PARTX"
+ts_check_test_command "$TS_CMD_ADDPART"
+ts_check_test_command "$TS_CMD_DELPART"
+
+ts_skip_nonroot
 
 mkdir -p $TS_OUTDIR/images-pt
 for img in $(ls $TS_IMGDIR/*.img.bz2 | sort); do
diff --git a/tests/ts/schedutils/cpuset b/tests/ts/schedutils/cpuset
index f3f11dd..ab516c3 100755
--- a/tests/ts/schedutils/cpuset
+++ b/tests/ts/schedutils/cpuset
@@ -20,6 +20,8 @@ TS_DESC="cpuset"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_CPUSET"
+
 MASKS=" 0x00000001 \
 	0x00000002 \
 	0x00000003 \
diff --git a/tests/ts/script/race b/tests/ts/script/race
index e482264..34c6409 100755
--- a/tests/ts/script/race
+++ b/tests/ts/script/race
@@ -22,6 +22,8 @@ TS_DESC="race conditions"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_SCRIPT"
+
 bingofile="$TS_OUTDIR/${TS_TESTNAME}-bingo"
 
 set -o pipefail
diff --git a/tests/ts/swapon/devname b/tests/ts/swapon/devname
index cbab128..43db36b 100755
--- a/tests/ts/swapon/devname
+++ b/tests/ts/swapon/devname
@@ -20,6 +20,11 @@ TS_DESC="by devname"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKSWAP"
+ts_check_test_command "$TS_CMD_SWAPON"
+ts_check_test_command "$TS_CMD_SWAPOFF"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/swapon/fixpgsz b/tests/ts/swapon/fixpgsz
index 0a694ad..70596d3 100755
--- a/tests/ts/swapon/fixpgsz
+++ b/tests/ts/swapon/fixpgsz
@@ -5,6 +5,11 @@ TS_DESC="fix page size"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKSWAP"
+ts_check_test_command "$TS_CMD_SWAPON"
+ts_check_test_command "$TS_CMD_SWAPOFF"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/swapon/fixsig b/tests/ts/swapon/fixsig
index 2005dec..937a2ec 100755
--- a/tests/ts/swapon/fixsig
+++ b/tests/ts/swapon/fixsig
@@ -5,6 +5,11 @@ TS_DESC="fix signature"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKSWAP"
+ts_check_test_command "$TS_CMD_SWAPON"
+ts_check_test_command "$TS_CMD_SWAPOFF"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/swapon/label b/tests/ts/swapon/label
index 5df0541..84967e8 100755
--- a/tests/ts/swapon/label
+++ b/tests/ts/swapon/label
@@ -21,6 +21,11 @@ LABEL="testSwapLabel"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKSWAP"
+ts_check_test_command "$TS_CMD_SWAPON"
+ts_check_test_command "$TS_CMD_SWAPOFF"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/swapon/uuid b/tests/ts/swapon/uuid
index f40720c..78d9d49 100755
--- a/tests/ts/swapon/uuid
+++ b/tests/ts/swapon/uuid
@@ -20,6 +20,11 @@ TS_DESC="by uuid"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+
+ts_check_test_command "$TS_CMD_MKSWAP"
+ts_check_test_command "$TS_CMD_SWAPON"
+ts_check_test_command "$TS_CMD_SWAPOFF"
+
 ts_skip_nonroot
 
 set -o pipefail
diff --git a/tests/ts/tailf/simple b/tests/ts/tailf/simple
index e8bdb50..20dc630 100755
--- a/tests/ts/tailf/simple
+++ b/tests/ts/tailf/simple
@@ -18,6 +18,8 @@ TS_DESC="simple"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_TAILF"
+
 INPUT=$TS_OUTDIR/$TS_TESTNAME.input
 
 rm -f $INPUT
diff --git a/tests/ts/utmpdump/ipv6tobin b/tests/ts/utmpdump/ipv6tobin
index 6de99ad..4e9e974 100755
--- a/tests/ts/utmpdump/ipv6tobin
+++ b/tests/ts/utmpdump/ipv6tobin
@@ -18,6 +18,8 @@ TS_DESC="IPv6 to binary"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_UTMPDUMP"
+
 export LANG=C
 export TZ=GMT
 $TS_CMD_UTMPDUMP -r $TS_SELF/ipv6txt >| $TS_OUTPUT 2>/dev/null
diff --git a/tests/ts/utmpdump/ipv6totxt b/tests/ts/utmpdump/ipv6totxt
index fb81f39..17ce2b8 100755
--- a/tests/ts/utmpdump/ipv6totxt
+++ b/tests/ts/utmpdump/ipv6totxt
@@ -18,6 +18,8 @@ TS_DESC="IPv6 to text"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_UTMPDUMP"
+
 export LANG=C
 export TZ=GMT
 $TS_CMD_UTMPDUMP $TS_SELF/ipv6bin >| $TS_OUTPUT 2>/dev/null
diff --git a/tests/ts/utmpdump/to-binary b/tests/ts/utmpdump/to-binary
index f2ec324..effbfdb 100755
--- a/tests/ts/utmpdump/to-binary
+++ b/tests/ts/utmpdump/to-binary
@@ -18,6 +18,8 @@ TS_DESC="to-binary"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_UTMPDUMP"
+
 export LANG=C
 export TZ=GMT
 $TS_CMD_UTMPDUMP -r $TS_SELF/text >| $TS_OUTPUT 2>/dev/null
diff --git a/tests/ts/utmpdump/to-text b/tests/ts/utmpdump/to-text
index 220f4d0..cb04175 100755
--- a/tests/ts/utmpdump/to-text
+++ b/tests/ts/utmpdump/to-text
@@ -18,6 +18,8 @@ TS_DESC="to-text"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_UTMPDUMP"
+
 export LANG=C
 export TZ=GMT
 $TS_CMD_UTMPDUMP $TS_SELF/binary >| $TS_OUTPUT 2>/dev/null
diff --git a/tests/ts/wipefs/wipefs b/tests/ts/wipefs/wipefs
index 38dbedb..bd0d8f3 100755
--- a/tests/ts/wipefs/wipefs
+++ b/tests/ts/wipefs/wipefs
@@ -7,6 +7,8 @@ TS_DESC="wipefs"
 ts_skip_nonroot
 ts_init "$*"
 
+ts_check_test_command "$TS_CMD_WIPEFS"
+
 DEVICE=$(ts_scsi_debug_init dev_size_mb=50 num_parts=2)
 
 # remove old backups
-- 
1.8.5.5

