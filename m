Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:35206 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752322AbaBPXyf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 18:54:35 -0500
Received: by mail-wi0-f179.google.com with SMTP id hn9so1876369wib.6
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 15:54:34 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/9] tests: avoid executing dirname(1) command
Date: Sun, 16 Feb 2014 23:54:14 +0000
Message-Id: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Bash parameter expansion does the same thing.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/functions.sh                    | 2 +-
 tests/run.sh                          | 2 +-
 tests/ts/bitops/swapbytes             | 2 +-
 tests/ts/blkid/low-probe              | 2 +-
 tests/ts/blkid/lowprobe-pt            | 2 +-
 tests/ts/blkid/md-raid0-whole         | 2 +-
 tests/ts/blkid/md-raid1-part          | 2 +-
 tests/ts/blkid/md-raid1-whole         | 2 +-
 tests/ts/build-sys/config             | 2 +-
 tests/ts/cal/1m                       | 2 +-
 tests/ts/cal/1mw                      | 2 +-
 tests/ts/cal/3m                       | 2 +-
 tests/ts/cal/3mw                      | 2 +-
 tests/ts/cal/bigyear                  | 2 +-
 tests/ts/cal/bigyearw                 | 2 +-
 tests/ts/cal/color                    | 2 +-
 tests/ts/cal/colorw                   | 2 +-
 tests/ts/cal/sep1752                  | 2 +-
 tests/ts/cal/sep1752w                 | 2 +-
 tests/ts/cal/weekarg                  | 2 +-
 tests/ts/cal/weeknum                  | 2 +-
 tests/ts/cal/year                     | 2 +-
 tests/ts/cal/yearw                    | 2 +-
 tests/ts/col/multibyte                | 2 +-
 tests/ts/colrm/rm2-2                  | 2 +-
 tests/ts/column/fillrow               | 2 +-
 tests/ts/column/multi-file            | 2 +-
 tests/ts/column/separator_table       | 2 +-
 tests/ts/cramfs/doubles               | 2 +-
 tests/ts/cramfs/fsck-endianness       | 2 +-
 tests/ts/cramfs/mkfs                  | 2 +-
 tests/ts/cramfs/mkfs-endianness       | 2 +-
 tests/ts/dmesg/console-levels         | 2 +-
 tests/ts/dmesg/decode                 | 2 +-
 tests/ts/dmesg/delta                  | 2 +-
 tests/ts/dmesg/facilities             | 2 +-
 tests/ts/eject/umount                 | 2 +-
 tests/ts/fdisk/align-512-4K           | 2 +-
 tests/ts/fdisk/align-512-4K-63        | 2 +-
 tests/ts/fdisk/align-512-4K-md        | 2 +-
 tests/ts/fdisk/align-512-512          | 2 +-
 tests/ts/fdisk/align-512-512-topology | 2 +-
 tests/ts/fdisk/bsd                    | 2 +-
 tests/ts/fdisk/gpt                    | 2 +-
 tests/ts/fdisk/id                     | 2 +-
 tests/ts/fdisk/mbr-dos-mode           | 2 +-
 tests/ts/fdisk/mbr-nondos-mode        | 2 +-
 tests/ts/fdisk/oddinput               | 2 +-
 tests/ts/fdisk/sunlabel               | 2 +-
 tests/ts/fsck/ismounted               | 2 +-
 tests/ts/hexdump/format-strings       | 2 +-
 tests/ts/hexdump/highlighting         | 2 +-
 tests/ts/hwclock/systohc              | 2 +-
 tests/ts/ipcs/headers                 | 2 +-
 tests/ts/ipcs/limits                  | 2 +-
 tests/ts/ipcs/limits2                 | 2 +-
 tests/ts/ipcs/mk-rm-msg               | 2 +-
 tests/ts/ipcs/mk-rm-sem               | 2 +-
 tests/ts/ipcs/mk-rm-shm               | 2 +-
 tests/ts/isosize/print-size           | 2 +-
 tests/ts/last/ipv6                    | 2 +-
 tests/ts/last/last                    | 2 +-
 tests/ts/libmount/context             | 2 +-
 tests/ts/libmount/context-py          | 2 +-
 tests/ts/libmount/context-utab        | 2 +-
 tests/ts/libmount/context-utab-py     | 2 +-
 tests/ts/libmount/lock                | 2 +-
 tests/ts/libmount/optstr              | 2 +-
 tests/ts/libmount/tabdiff             | 2 +-
 tests/ts/libmount/tabfiles            | 2 +-
 tests/ts/libmount/tabfiles-py         | 2 +-
 tests/ts/libmount/tabfiles-tags       | 2 +-
 tests/ts/libmount/tabfiles-tags-py    | 2 +-
 tests/ts/libmount/update              | 2 +-
 tests/ts/libmount/update-py           | 2 +-
 tests/ts/libmount/utils               | 2 +-
 tests/ts/login/islocal                | 2 +-
 tests/ts/login/logindefs              | 2 +-
 tests/ts/look/separator               | 2 +-
 tests/ts/losetup/losetup              | 2 +-
 tests/ts/lscpu/lscpu                  | 2 +-
 tests/ts/md5/md5                      | 2 +-
 tests/ts/minix/fsck                   | 2 +-
 tests/ts/minix/mkfs                   | 2 +-
 tests/ts/misc/fallocate               | 2 +-
 tests/ts/misc/getopt                  | 2 +-
 tests/ts/misc/ionice                  | 2 +-
 tests/ts/misc/line                    | 2 +-
 tests/ts/misc/mcookie                 | 2 +-
 tests/ts/misc/rev                     | 2 +-
 tests/ts/misc/setarch                 | 2 +-
 tests/ts/misc/setsid                  | 2 +-
 tests/ts/misc/strtosize               | 2 +-
 tests/ts/misc/ul                      | 2 +-
 tests/ts/misc/whereis                 | 2 +-
 tests/ts/more/regexp                  | 2 +-
 tests/ts/more/squeeze                 | 2 +-
 tests/ts/mount/devname                | 2 +-
 tests/ts/mount/fstab-broken           | 2 +-
 tests/ts/mount/fstab-devname          | 2 +-
 tests/ts/mount/fstab-devname2label    | 2 +-
 tests/ts/mount/fstab-devname2uuid     | 2 +-
 tests/ts/mount/fstab-label            | 2 +-
 tests/ts/mount/fstab-label2devname    | 2 +-
 tests/ts/mount/fstab-label2uuid       | 2 +-
 tests/ts/mount/fstab-none             | 2 +-
 tests/ts/mount/fstab-symlink          | 2 +-
 tests/ts/mount/fstab-uuid             | 2 +-
 tests/ts/mount/fstab-uuid2devname     | 2 +-
 tests/ts/mount/fstab-uuid2label       | 2 +-
 tests/ts/mount/label                  | 2 +-
 tests/ts/mount/move                   | 2 +-
 tests/ts/mount/noncanonical           | 2 +-
 tests/ts/mount/paths                  | 2 +-
 tests/ts/mount/regfile                | 2 +-
 tests/ts/mount/remount                | 2 +-
 tests/ts/mount/rlimit                 | 2 +-
 tests/ts/mount/shared-subtree         | 2 +-
 tests/ts/mount/special                | 2 +-
 tests/ts/mount/umount-alltargets      | 2 +-
 tests/ts/mount/umount-recursive       | 2 +-
 tests/ts/mount/uuid                   | 2 +-
 tests/ts/namei/logic                  | 2 +-
 tests/ts/partx/partx                  | 2 +-
 tests/ts/paths/built-in               | 2 +-
 tests/ts/schedutils/cpuset            | 2 +-
 tests/ts/script/race                  | 2 +-
 tests/ts/swapon/devname               | 2 +-
 tests/ts/swapon/fixpgsz               | 2 +-
 tests/ts/swapon/fixsig                | 2 +-
 tests/ts/swapon/label                 | 2 +-
 tests/ts/swapon/uuid                  | 2 +-
 tests/ts/tailf/simple                 | 2 +-
 tests/ts/utmpdump/ipv6tobin           | 2 +-
 tests/ts/utmpdump/ipv6totxt           | 2 +-
 tests/ts/utmpdump/to-binary           | 2 +-
 tests/ts/utmpdump/to-text             | 2 +-
 tests/ts/wipefs/wipefs                | 2 +-
 138 files changed, 138 insertions(+), 138 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index 32b299a..17fa6d2 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -123,7 +123,7 @@ function ts_init_core_subtest_env {
 }
 
 function ts_init_env {
-	local mydir=$(ts_abspath $(dirname $0))
+	local mydir=$(ts_abspath ${0%/*})
 
 	LANG="POSIX"
 	LANGUAGE="POSIX"
diff --git a/tests/run.sh b/tests/run.sh
index 474c21c..8a7924a 100755
--- a/tests/run.sh
+++ b/tests/run.sh
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR=$(cd $(dirname $0) && pwd)
+TS_TOPDIR=$(cd ${0%/*} && pwd)
 SUBTESTS=
 OPTS=
 
diff --git a/tests/ts/bitops/swapbytes b/tests/ts/bitops/swapbytes
index 74f0834..798ad53 100755
--- a/tests/ts/bitops/swapbytes
+++ b/tests/ts/bitops/swapbytes
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="swap bytes"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/blkid/low-probe b/tests/ts/blkid/low-probe
index adf022c..eaee089 100755
--- a/tests/ts/blkid/low-probe
+++ b/tests/ts/blkid/low-probe
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="low-level superblocks probing"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/blkid/lowprobe-pt b/tests/ts/blkid/lowprobe-pt
index a7404af..4e9927b 100755
--- a/tests/ts/blkid/lowprobe-pt
+++ b/tests/ts/blkid/lowprobe-pt
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="partitions probing"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/blkid/md-raid0-whole b/tests/ts/blkid/md-raid0-whole
index e8eeddb..46442bb 100755
--- a/tests/ts/blkid/md-raid0-whole
+++ b/tests/ts/blkid/md-raid0-whole
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="MD raid0 (whole-disks)"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/blkid/md-raid1-part b/tests/ts/blkid/md-raid1-part
index 453d93d..0257e15 100755
--- a/tests/ts/blkid/md-raid1-part
+++ b/tests/ts/blkid/md-raid1-part
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="MD raid1 (last partition)"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/blkid/md-raid1-whole b/tests/ts/blkid/md-raid1-whole
index 9967c0c..fcb55c2 100755
--- a/tests/ts/blkid/md-raid1-whole
+++ b/tests/ts/blkid/md-raid1-whole
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="MD raid1 (whole-disks)"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/build-sys/config b/tests/ts/build-sys/config
index 508bdee..308c34b 100755
--- a/tests/ts/build-sys/config
+++ b/tests/ts/build-sys/config
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2011 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="config"
 
 # Don't execute this test by default, --force required
diff --git a/tests/ts/cal/1m b/tests/ts/cal/1m
index 916959c..295758a 100755
--- a/tests/ts/cal/1m
+++ b/tests/ts/cal/1m
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="1 month"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/1mw b/tests/ts/cal/1mw
index 9923dd1..6664948 100755
--- a/tests/ts/cal/1mw
+++ b/tests/ts/cal/1mw
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="1 month with week numbers"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/3m b/tests/ts/cal/3m
index 489ffe4..50f284e 100755
--- a/tests/ts/cal/3m
+++ b/tests/ts/cal/3m
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="3 months"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/3mw b/tests/ts/cal/3mw
index fcb261c..5ea951e 100755
--- a/tests/ts/cal/3mw
+++ b/tests/ts/cal/3mw
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="3 months with week numbers"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/bigyear b/tests/ts/cal/bigyear
index d382e1b..b5e415c 100755
--- a/tests/ts/cal/bigyear
+++ b/tests/ts/cal/bigyear
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="Year 2147483646"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/bigyearw b/tests/ts/cal/bigyearw
index f7b4aa6..75a18dd 100755
--- a/tests/ts/cal/bigyearw
+++ b/tests/ts/cal/bigyearw
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="Year 2147483646 with week numbers"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/color b/tests/ts/cal/color
index d0a3c28..44e9381 100755
--- a/tests/ts/cal/color
+++ b/tests/ts/cal/color
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="color"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/colorw b/tests/ts/cal/colorw
index 4fcdee5..0092e13 100755
--- a/tests/ts/cal/colorw
+++ b/tests/ts/cal/colorw
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="color with week numbers"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/sep1752 b/tests/ts/cal/sep1752
index f8f8ef5..fa57b9b 100755
--- a/tests/ts/cal/sep1752
+++ b/tests/ts/cal/sep1752
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="September 1752"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/sep1752w b/tests/ts/cal/sep1752w
index 8542801..b229e83 100755
--- a/tests/ts/cal/sep1752w
+++ b/tests/ts/cal/sep1752w
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="September 1752 with week numbers"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/weekarg b/tests/ts/cal/weekarg
index 3d90f64..a798705 100755
--- a/tests/ts/cal/weekarg
+++ b/tests/ts/cal/weekarg
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="week number given as argument"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/weeknum b/tests/ts/cal/weeknum
index d0c300e..0bea00d 100755
--- a/tests/ts/cal/weeknum
+++ b/tests/ts/cal/weeknum
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="week number corner cases"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/year b/tests/ts/cal/year
index 02ace8c..1204b5f 100755
--- a/tests/ts/cal/year
+++ b/tests/ts/cal/year
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="year"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cal/yearw b/tests/ts/cal/yearw
index dacf235..c05b1c2 100755
--- a/tests/ts/cal/yearw
+++ b/tests/ts/cal/yearw
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="year with week numbers"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/col/multibyte b/tests/ts/col/multibyte
index dc9db41..e9c0292 100755
--- a/tests/ts/col/multibyte
+++ b/tests/ts/col/multibyte
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="multibyte input"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/colrm/rm2-2 b/tests/ts/colrm/rm2-2
index a732015..c13e4ec 100755
--- a/tests/ts/colrm/rm2-2
+++ b/tests/ts/colrm/rm2-2
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="basic check"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/column/fillrow b/tests/ts/column/fillrow
index a68d5e9..263a267 100755
--- a/tests/ts/column/fillrow
+++ b/tests/ts/column/fillrow
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="fill row"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/column/multi-file b/tests/ts/column/multi-file
index 591ccd8..76b8686 100755
--- a/tests/ts/column/multi-file
+++ b/tests/ts/column/multi-file
@@ -16,7 +16,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="multiple files"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/column/separator_table b/tests/ts/column/separator_table
index 6591756..8be1e20 100755
--- a/tests/ts/column/separator_table
+++ b/tests/ts/column/separator_table
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="separator & table"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cramfs/doubles b/tests/ts/cramfs/doubles
index b849032..9b1ce2e 100755
--- a/tests/ts/cramfs/doubles
+++ b/tests/ts/cramfs/doubles
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="mkfs doubles"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cramfs/fsck-endianness b/tests/ts/cramfs/fsck-endianness
index c4ea51d..33bd18b 100755
--- a/tests/ts/cramfs/fsck-endianness
+++ b/tests/ts/cramfs/fsck-endianness
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="fsck endianness"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cramfs/mkfs b/tests/ts/cramfs/mkfs
index 66ae0b6..96d6855 100755
--- a/tests/ts/cramfs/mkfs
+++ b/tests/ts/cramfs/mkfs
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="mkfs checksums"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/cramfs/mkfs-endianness b/tests/ts/cramfs/mkfs-endianness
index 424cc92..c7df720 100755
--- a/tests/ts/cramfs/mkfs-endianness
+++ b/tests/ts/cramfs/mkfs-endianness
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="mkfs endianness"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/dmesg/console-levels b/tests/ts/dmesg/console-levels
index 2c2c57e..14c69c9 100755
--- a/tests/ts/dmesg/console-levels
+++ b/tests/ts/dmesg/console-levels
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="levels"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/dmesg/decode b/tests/ts/dmesg/decode
index 5ac17bf..63f3c5c 100755
--- a/tests/ts/dmesg/decode
+++ b/tests/ts/dmesg/decode
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="decode"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/dmesg/delta b/tests/ts/dmesg/delta
index 7d1de3e..da48042 100755
--- a/tests/ts/dmesg/delta
+++ b/tests/ts/dmesg/delta
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="delta"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/dmesg/facilities b/tests/ts/dmesg/facilities
index 646f875..7066ae5 100755
--- a/tests/ts/dmesg/facilities
+++ b/tests/ts/dmesg/facilities
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="facilities"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/eject/umount b/tests/ts/eject/umount
index 940c77b..e781a7b 100755
--- a/tests/ts/eject/umount
+++ b/tests/ts/eject/umount
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="umount"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/align-512-4K b/tests/ts/fdisk/align-512-4K
index c733170..5d70fe1 100755
--- a/tests/ts/fdisk/align-512-4K
+++ b/tests/ts/fdisk/align-512-4K
@@ -20,7 +20,7 @@
 # I/O size (32KiB)
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="align 512/4K"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/align-512-4K-63 b/tests/ts/fdisk/align-512-4K-63
index bcc1c76..65f2a75 100755
--- a/tests/ts/fdisk/align-512-4K-63
+++ b/tests/ts/fdisk/align-512-4K-63
@@ -20,7 +20,7 @@
 # I/O size (32KiB)
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="align 512/4K +alignment_offset"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/align-512-4K-md b/tests/ts/fdisk/align-512-4K-md
index d300b4e..9a2cb88 100755
--- a/tests/ts/fdisk/align-512-4K-md
+++ b/tests/ts/fdisk/align-512-4K-md
@@ -20,7 +20,7 @@
 # I/O size (32KiB)
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="align 512/4K +MD"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/align-512-512 b/tests/ts/fdisk/align-512-512
index 9862b58..8057f93 100755
--- a/tests/ts/fdisk/align-512-512
+++ b/tests/ts/fdisk/align-512-512
@@ -19,7 +19,7 @@
 # topology.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="align 512/512"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/align-512-512-topology b/tests/ts/fdisk/align-512-512-topology
index b11bc9b..f988b4e 100755
--- a/tests/ts/fdisk/align-512-512-topology
+++ b/tests/ts/fdisk/align-512-512-topology
@@ -20,7 +20,7 @@
 # I/O size (32KiB)
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="align 512/512 +topology"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
index 54c0a95..7e3c787 100755
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -16,7 +16,7 @@
 #
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="nested BSD"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/gpt b/tests/ts/fdisk/gpt
index 5737544..3c174e9 100755
--- a/tests/ts/fdisk/gpt
+++ b/tests/ts/fdisk/gpt
@@ -16,7 +16,7 @@
 #
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="GPT"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/id b/tests/ts/fdisk/id
index 2126b66..a24d793 100755
--- a/tests/ts/fdisk/id
+++ b/tests/ts/fdisk/id
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="MBR - id"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/mbr-dos-mode b/tests/ts/fdisk/mbr-dos-mode
index 829d27d..6d517ea 100755
--- a/tests/ts/fdisk/mbr-dos-mode
+++ b/tests/ts/fdisk/mbr-dos-mode
@@ -16,7 +16,7 @@
 #
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="MBR - dos mode"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/mbr-nondos-mode b/tests/ts/fdisk/mbr-nondos-mode
index d6a6af3..9c38f3a 100755
--- a/tests/ts/fdisk/mbr-nondos-mode
+++ b/tests/ts/fdisk/mbr-nondos-mode
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="MBR - non-dos mode"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/oddinput b/tests/ts/fdisk/oddinput
index f71b7e2..8d51220 100755
--- a/tests/ts/fdisk/oddinput
+++ b/tests/ts/fdisk/oddinput
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="invalid input tests"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fdisk/sunlabel b/tests/ts/fdisk/sunlabel
index 46392fa..5bfbb4f 100755
--- a/tests/ts/fdisk/sunlabel
+++ b/tests/ts/fdisk/sunlabel
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="sunlabel tests"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/fsck/ismounted b/tests/ts/fsck/ismounted
index 93c2e81..6856016 100755
--- a/tests/ts/fsck/ismounted
+++ b/tests/ts/fsck/ismounted
@@ -14,7 +14,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="is mounted"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/hexdump/format-strings b/tests/ts/hexdump/format-strings
index 0b30037..229e651 100755
--- a/tests/ts/hexdump/format-strings
+++ b/tests/ts/hexdump/format-strings
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="format-strings"
 FILES="$TS_TOPDIR/ts/hexdump/files"
 #sample input consists of hexdump-ed results of the following py3script:
diff --git a/tests/ts/hexdump/highlighting b/tests/ts/hexdump/highlighting
index 8a0aa1d..f3b8c81 100755
--- a/tests/ts/hexdump/highlighting
+++ b/tests/ts/hexdump/highlighting
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="highlighting"
 FILES="$TS_TOPDIR/ts/hexdump/files"
 OPTS="--color=always"
diff --git a/tests/ts/hwclock/systohc b/tests/ts/hwclock/systohc
index d60adfb..8a3ecca 100755
--- a/tests/ts/hwclock/systohc
+++ b/tests/ts/hwclock/systohc
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="system to hw"
 NTP_SERVER="0.fedora.pool.ntp.org"
 
diff --git a/tests/ts/ipcs/headers b/tests/ts/ipcs/headers
index 6790471..5089ea5 100755
--- a/tests/ts/ipcs/headers
+++ b/tests/ts/ipcs/headers
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="headers"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/ipcs/limits b/tests/ts/ipcs/limits
index b4f71b0..71980b5 100755
--- a/tests/ts/ipcs/limits
+++ b/tests/ts/ipcs/limits
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="limits overflow"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/ipcs/limits2 b/tests/ts/ipcs/limits2
index 769012b..7a7549a 100755
--- a/tests/ts/ipcs/limits2
+++ b/tests/ts/ipcs/limits2
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="basic limits"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/ipcs/mk-rm-msg b/tests/ts/ipcs/mk-rm-msg
index a752173..72f89b8 100755
--- a/tests/ts/ipcs/mk-rm-msg
+++ b/tests/ts/ipcs/mk-rm-msg
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="mk-rm-msg"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/ipcs/mk-rm-sem b/tests/ts/ipcs/mk-rm-sem
index 7fd10c9..3152618 100755
--- a/tests/ts/ipcs/mk-rm-sem
+++ b/tests/ts/ipcs/mk-rm-sem
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="mk-rm-sem"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/ipcs/mk-rm-shm b/tests/ts/ipcs/mk-rm-shm
index 987127a..9695ed1 100755
--- a/tests/ts/ipcs/mk-rm-shm
+++ b/tests/ts/ipcs/mk-rm-shm
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="mk-rm-shm"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/isosize/print-size b/tests/ts/isosize/print-size
index 1476b35..312fdc1 100755
--- a/tests/ts/isosize/print-size
+++ b/tests/ts/isosize/print-size
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="print-size"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/last/ipv6 b/tests/ts/last/ipv6
index a09adea..b9b4de4 100755
--- a/tests/ts/last/ipv6
+++ b/tests/ts/last/ipv6
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="last ipv6"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/last/last b/tests/ts/last/last
index 98ba25b..b6308fc 100755
--- a/tests/ts/last/last
+++ b/tests/ts/last/last
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="last"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/context b/tests/ts/libmount/context
index 3d29d04..35e1a01 100755
--- a/tests/ts/libmount/context
+++ b/tests/ts/libmount/context
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="context"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/context-py b/tests/ts/libmount/context-py
index 917e7d9..8406344 100755
--- a/tests/ts/libmount/context-py
+++ b/tests/ts/libmount/context-py
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="context-py"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/context-utab b/tests/ts/libmount/context-utab
index 61af96e..4d3e3d7 100755
--- a/tests/ts/libmount/context-utab
+++ b/tests/ts/libmount/context-utab
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="context (utab)"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/context-utab-py b/tests/ts/libmount/context-utab-py
index 5eafce6..b454ceb 100755
--- a/tests/ts/libmount/context-utab-py
+++ b/tests/ts/libmount/context-utab-py
@@ -1,7 +1,7 @@
 #!/bin/bash
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="context-py (utab)"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/lock b/tests/ts/libmount/lock
index 5c8bcb6..26f0015 100755
--- a/tests/ts/libmount/lock
+++ b/tests/ts/libmount/lock
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="lock"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/optstr b/tests/ts/libmount/optstr
index f6a5c05..7de299d 100755
--- a/tests/ts/libmount/optstr
+++ b/tests/ts/libmount/optstr
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="options string"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/tabdiff b/tests/ts/libmount/tabdiff
index c988258..80753ea 100755
--- a/tests/ts/libmount/tabdiff
+++ b/tests/ts/libmount/tabdiff
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2011 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="table diffs"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/tabfiles b/tests/ts/libmount/tabfiles
index c6fa360..a60c038 100755
--- a/tests/ts/libmount/tabfiles
+++ b/tests/ts/libmount/tabfiles
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="tab files"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/tabfiles-py b/tests/ts/libmount/tabfiles-py
index b89fb5b..89e4da2 100755
--- a/tests/ts/libmount/tabfiles-py
+++ b/tests/ts/libmount/tabfiles-py
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="tab files-py"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/tabfiles-tags b/tests/ts/libmount/tabfiles-tags
index f52c404..318ccf0 100755
--- a/tests/ts/libmount/tabfiles-tags
+++ b/tests/ts/libmount/tabfiles-tags
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="tags"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/tabfiles-tags-py b/tests/ts/libmount/tabfiles-tags-py
index 05c2c20..237a6d8 100755
--- a/tests/ts/libmount/tabfiles-tags-py
+++ b/tests/ts/libmount/tabfiles-tags-py
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="tags-py"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/update b/tests/ts/libmount/update
index 6d4bce8..89279ba 100755
--- a/tests/ts/libmount/update
+++ b/tests/ts/libmount/update
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="tab update"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/update-py b/tests/ts/libmount/update-py
index e49d33e..da14b9b 100755
--- a/tests/ts/libmount/update-py
+++ b/tests/ts/libmount/update-py
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="tab update-py"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/libmount/utils b/tests/ts/libmount/utils
index 6facaad..211f015 100755
--- a/tests/ts/libmount/utils
+++ b/tests/ts/libmount/utils
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2010 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="utils"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/login/islocal b/tests/ts/login/islocal
index 3c95a0d..bb37270 100755
--- a/tests/ts/login/islocal
+++ b/tests/ts/login/islocal
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="islocal"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/login/logindefs b/tests/ts/login/logindefs
index c3c6385..2db3f89 100755
--- a/tests/ts/login/logindefs
+++ b/tests/ts/login/logindefs
@@ -4,7 +4,7 @@
 #
 # This file is part of util-linux.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="defs"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/look/separator b/tests/ts/look/separator
index bac9b60..c6028e3 100755
--- a/tests/ts/look/separator
+++ b/tests/ts/look/separator
@@ -28,7 +28,7 @@
 #		uniq >  words
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="separator"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/losetup/losetup b/tests/ts/losetup/losetup
index 86b9c38..234c58f 100755
--- a/tests/ts/losetup/losetup
+++ b/tests/ts/losetup/losetup
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="losetup"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/lscpu/lscpu b/tests/ts/lscpu/lscpu
index bd8c81b..4a98b86 100755
--- a/tests/ts/lscpu/lscpu
+++ b/tests/ts/lscpu/lscpu
@@ -17,7 +17,7 @@
 # You should have received a copy of the GNU General Public License
 # along with this program.  If not, see <http://www.gnu.org/licenses/>.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 . $TS_TOPDIR/functions.sh
 
 ts_init "$*"
diff --git a/tests/ts/md5/md5 b/tests/ts/md5/md5
index e94fb63..6fe3f14 100755
--- a/tests/ts/md5/md5
+++ b/tests/ts/md5/md5
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
diff --git a/tests/ts/minix/fsck b/tests/ts/minix/fsck
index b8cfbc7..70ad2fa 100755
--- a/tests/ts/minix/fsck
+++ b/tests/ts/minix/fsck
@@ -14,7 +14,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="mkfs checksums"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/minix/mkfs b/tests/ts/minix/mkfs
index cb124cc..0159c7b 100755
--- a/tests/ts/minix/mkfs
+++ b/tests/ts/minix/mkfs
@@ -14,7 +14,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="mkfs"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/fallocate b/tests/ts/misc/fallocate
index b68395f..cbb25d8 100755
--- a/tests/ts/misc/fallocate
+++ b/tests/ts/misc/fallocate
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="fallocate"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/getopt b/tests/ts/misc/getopt
index 9051947..715ec36 100755
--- a/tests/ts/misc/getopt
+++ b/tests/ts/misc/getopt
@@ -15,7 +15,7 @@
 # This test script is modified version of 'getopt-parse.bash' example
 # file in misc/ directory.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="getopt"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/ionice b/tests/ts/misc/ionice
index 3dc73fb..32b2259 100755
--- a/tests/ts/misc/ionice
+++ b/tests/ts/misc/ionice
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="ionice"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/line b/tests/ts/misc/line
index 97aba72..a17ee28 100755
--- a/tests/ts/misc/line
+++ b/tests/ts/misc/line
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="line"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/mcookie b/tests/ts/misc/mcookie
index d26250a..96e3cc7 100755
--- a/tests/ts/misc/mcookie
+++ b/tests/ts/misc/mcookie
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="mcookie"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/rev b/tests/ts/misc/rev
index 0586044..a3d45e6 100755
--- a/tests/ts/misc/rev
+++ b/tests/ts/misc/rev
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="rev"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/setarch b/tests/ts/misc/setarch
index f351976..9120509 100755
--- a/tests/ts/misc/setarch
+++ b/tests/ts/misc/setarch
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="setarch"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/setsid b/tests/ts/misc/setsid
index 14578a9..baef70d 100755
--- a/tests/ts/misc/setsid
+++ b/tests/ts/misc/setsid
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="setsid"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/strtosize b/tests/ts/misc/strtosize
index 7fb2ff9..4b08b5e 100755
--- a/tests/ts/misc/strtosize
+++ b/tests/ts/misc/strtosize
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="strtosize"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/ul b/tests/ts/misc/ul
index 593f94a..2c2c1da 100755
--- a/tests/ts/misc/ul
+++ b/tests/ts/misc/ul
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="ul"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/misc/whereis b/tests/ts/misc/whereis
index 1fe29fc..ee7ec27 100755
--- a/tests/ts/misc/whereis
+++ b/tests/ts/misc/whereis
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="whereis"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/more/regexp b/tests/ts/more/regexp
index 4fea43e..67c6f62 100755
--- a/tests/ts/more/regexp
+++ b/tests/ts/more/regexp
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="regexp"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/more/squeeze b/tests/ts/more/squeeze
index 629c764..d5b4a6a 100755
--- a/tests/ts/more/squeeze
+++ b/tests/ts/more/squeeze
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="squeeze"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/devname b/tests/ts/mount/devname
index 8de8765..1cab468 100755
--- a/tests/ts/mount/devname
+++ b/tests/ts/mount/devname
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by devname"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/fstab-broken b/tests/ts/mount/fstab-broken
index a6435e0..5934c22 100755
--- a/tests/ts/mount/fstab-broken
+++ b/tests/ts/mount/fstab-broken
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="broken fstab"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/fstab-devname b/tests/ts/mount/fstab-devname
index b3535b0..4dcc4fc 100755
--- a/tests/ts/mount/fstab-devname
+++ b/tests/ts/mount/fstab-devname
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by devname (fstab)"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/fstab-devname2label b/tests/ts/mount/fstab-devname2label
index 0df5021..f804095 100755
--- a/tests/ts/mount/fstab-devname2label
+++ b/tests/ts/mount/fstab-devname2label
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by devname (fstab label)"
 LABEL="testMountD2L"
 
diff --git a/tests/ts/mount/fstab-devname2uuid b/tests/ts/mount/fstab-devname2uuid
index ee5564c..f554826 100755
--- a/tests/ts/mount/fstab-devname2uuid
+++ b/tests/ts/mount/fstab-devname2uuid
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by devname (fstab uuid)"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/fstab-label b/tests/ts/mount/fstab-label
index 757fdac..24fb80f 100755
--- a/tests/ts/mount/fstab-label
+++ b/tests/ts/mount/fstab-label
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by label (fstab)"
 LABEL="testFstabLabel"
 
diff --git a/tests/ts/mount/fstab-label2devname b/tests/ts/mount/fstab-label2devname
index 7ccb887..b2359a5 100755
--- a/tests/ts/mount/fstab-label2devname
+++ b/tests/ts/mount/fstab-label2devname
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by label (fstab devname)"
 LABEL="testMountL2D"
 
diff --git a/tests/ts/mount/fstab-label2uuid b/tests/ts/mount/fstab-label2uuid
index 4079fc4..165426b 100755
--- a/tests/ts/mount/fstab-label2uuid
+++ b/tests/ts/mount/fstab-label2uuid
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by label (fstab uuid)"
 LABEL="testMountL2U"
 
diff --git a/tests/ts/mount/fstab-none b/tests/ts/mount/fstab-none
index 4a107b0..64eb48b 100755
--- a/tests/ts/mount/fstab-none
+++ b/tests/ts/mount/fstab-none
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="none"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/fstab-symlink b/tests/ts/mount/fstab-symlink
index f609b29..ddabcd6 100755
--- a/tests/ts/mount/fstab-symlink
+++ b/tests/ts/mount/fstab-symlink
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by devname (fstab symlink)"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/fstab-uuid b/tests/ts/mount/fstab-uuid
index 860ee73..5d3afb7 100755
--- a/tests/ts/mount/fstab-uuid
+++ b/tests/ts/mount/fstab-uuid
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by uuid (fstab)"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/fstab-uuid2devname b/tests/ts/mount/fstab-uuid2devname
index 62536dd..90f7d91 100755
--- a/tests/ts/mount/fstab-uuid2devname
+++ b/tests/ts/mount/fstab-uuid2devname
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by uuid (fstab devname)"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/fstab-uuid2label b/tests/ts/mount/fstab-uuid2label
index d2e164a..5291688 100755
--- a/tests/ts/mount/fstab-uuid2label
+++ b/tests/ts/mount/fstab-uuid2label
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by uuid (fstab label)"
 LABEL="testMountU2L"
 
diff --git a/tests/ts/mount/label b/tests/ts/mount/label
index d72700e..b0e7ca6 100755
--- a/tests/ts/mount/label
+++ b/tests/ts/mount/label
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by label"
 LABEL="testMountLabel"
 
diff --git a/tests/ts/mount/move b/tests/ts/mount/move
index 63df049..5244887 100755
--- a/tests/ts/mount/move
+++ b/tests/ts/mount/move
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="move"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/noncanonical b/tests/ts/mount/noncanonical
index 0577967..a311577 100755
--- a/tests/ts/mount/noncanonical
+++ b/tests/ts/mount/noncanonical
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="non canonical path"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/paths b/tests/ts/mount/paths
index 2ea1917..edc2837 100755
--- a/tests/ts/mount/paths
+++ b/tests/ts/mount/paths
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="basic paths"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/regfile b/tests/ts/mount/regfile
index 5050929..9f24c72 100755
--- a/tests/ts/mount/regfile
+++ b/tests/ts/mount/regfile
@@ -3,7 +3,7 @@
 # Copyright (C) 2011 Karel Zak <kzak@redhat.com>
 # This file is part of util-linux.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="regular file"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/remount b/tests/ts/mount/remount
index 21e8590..f983ab3 100755
--- a/tests/ts/mount/remount
+++ b/tests/ts/mount/remount
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="remount"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/rlimit b/tests/ts/mount/rlimit
index c28cdc0..13064c8 100755
--- a/tests/ts/mount/rlimit
+++ b/tests/ts/mount/rlimit
@@ -23,7 +23,7 @@
 # calls are successful.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="rlimit-fsize"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/shared-subtree b/tests/ts/mount/shared-subtree
index c1905e8..9715e1d 100755
--- a/tests/ts/mount/shared-subtree
+++ b/tests/ts/mount/shared-subtree
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="shared-subtree"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/special b/tests/ts/mount/special
index b65333c..21edd65 100755
--- a/tests/ts/mount/special
+++ b/tests/ts/mount/special
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="call mount.<type>"
 MOUNTER="/sbin/mount.mytest"
 
diff --git a/tests/ts/mount/umount-alltargets b/tests/ts/mount/umount-alltargets
index fe54145..e3b5aec 100755
--- a/tests/ts/mount/umount-alltargets
+++ b/tests/ts/mount/umount-alltargets
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2013 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="umount-all-targets"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/umount-recursive b/tests/ts/mount/umount-recursive
index 241cc1c..d55f612 100755
--- a/tests/ts/mount/umount-recursive
+++ b/tests/ts/mount/umount-recursive
@@ -2,7 +2,7 @@
 
 # Copyright (C) 2012 Karel Zak <kzak@redhat.com>
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="umount-recursive"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/mount/uuid b/tests/ts/mount/uuid
index 331e2c8..0233064 100755
--- a/tests/ts/mount/uuid
+++ b/tests/ts/mount/uuid
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by uuid"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/namei/logic b/tests/ts/namei/logic
index 21517dd..df48b76 100755
--- a/tests/ts/namei/logic
+++ b/tests/ts/namei/logic
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="basic functionality"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/partx/partx b/tests/ts/partx/partx
index a81ef12..bc612b0 100755
--- a/tests/ts/partx/partx
+++ b/tests/ts/partx/partx
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="partitions probing"
 TS_IMGDIR="$TS_TOPDIR/ts/blkid/images-pt"
 PARTS=3
diff --git a/tests/ts/paths/built-in b/tests/ts/paths/built-in
index 84ee555..f866514 100755
--- a/tests/ts/paths/built-in
+++ b/tests/ts/paths/built-in
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="built-in"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/schedutils/cpuset b/tests/ts/schedutils/cpuset
index ab516c3..f1df597 100755
--- a/tests/ts/schedutils/cpuset
+++ b/tests/ts/schedutils/cpuset
@@ -14,7 +14,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="cpuset"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/script/race b/tests/ts/script/race
index 34c6409..ef7e83f 100755
--- a/tests/ts/script/race
+++ b/tests/ts/script/race
@@ -16,7 +16,7 @@
 # GNU General Public License for more details.
 #
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="race conditions"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/swapon/devname b/tests/ts/swapon/devname
index 43db36b..f8f3121 100755
--- a/tests/ts/swapon/devname
+++ b/tests/ts/swapon/devname
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by devname"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/swapon/fixpgsz b/tests/ts/swapon/fixpgsz
index 70596d3..f0dafe9 100755
--- a/tests/ts/swapon/fixpgsz
+++ b/tests/ts/swapon/fixpgsz
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="fix page size"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/swapon/fixsig b/tests/ts/swapon/fixsig
index 937a2ec..a4d0411 100755
--- a/tests/ts/swapon/fixsig
+++ b/tests/ts/swapon/fixsig
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="fix signature"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/swapon/label b/tests/ts/swapon/label
index 84967e8..03cf017 100755
--- a/tests/ts/swapon/label
+++ b/tests/ts/swapon/label
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by label"
 LABEL="testSwapLabel"
 
diff --git a/tests/ts/swapon/uuid b/tests/ts/swapon/uuid
index 78d9d49..c80e52f 100755
--- a/tests/ts/swapon/uuid
+++ b/tests/ts/swapon/uuid
@@ -15,7 +15,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 #
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="by uuid"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/tailf/simple b/tests/ts/tailf/simple
index 20dc630..955844d 100755
--- a/tests/ts/tailf/simple
+++ b/tests/ts/tailf/simple
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="simple"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/utmpdump/ipv6tobin b/tests/ts/utmpdump/ipv6tobin
index 4e9e974..fac6fb9 100755
--- a/tests/ts/utmpdump/ipv6tobin
+++ b/tests/ts/utmpdump/ipv6tobin
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="IPv6 to binary"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/utmpdump/ipv6totxt b/tests/ts/utmpdump/ipv6totxt
index 17ce2b8..b9da8ab 100755
--- a/tests/ts/utmpdump/ipv6totxt
+++ b/tests/ts/utmpdump/ipv6totxt
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="IPv6 to text"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/utmpdump/to-binary b/tests/ts/utmpdump/to-binary
index effbfdb..e774915 100755
--- a/tests/ts/utmpdump/to-binary
+++ b/tests/ts/utmpdump/to-binary
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="to-binary"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/utmpdump/to-text b/tests/ts/utmpdump/to-text
index cb04175..e982150 100755
--- a/tests/ts/utmpdump/to-text
+++ b/tests/ts/utmpdump/to-text
@@ -12,7 +12,7 @@
 # MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 # GNU General Public License for more details.
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="to-text"
 
 . $TS_TOPDIR/functions.sh
diff --git a/tests/ts/wipefs/wipefs b/tests/ts/wipefs/wipefs
index bd0d8f3..4bd1748 100755
--- a/tests/ts/wipefs/wipefs
+++ b/tests/ts/wipefs/wipefs
@@ -1,6 +1,6 @@
 #!/bin/bash
 
-TS_TOPDIR="$(dirname $0)/../.."
+TS_TOPDIR="${0%/*}/../.."
 TS_DESC="wipefs"
 
 . $TS_TOPDIR/functions.sh
-- 
1.9.0

