Return-Path: heiko.carstens@de.ibm.com
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org, Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: [PATCH 4/4] lsmem: add testcase
Date: Wed, 12 Oct 2016 14:00:47 +0200
In-Reply-To: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
References: <20161012120047.60732-1-heiko.carstens@de.ibm.com>
Message-Id: <20161012120047.60732-5-heiko.carstens@de.ibm.com>
List-ID: <util-linux.vger.kernel.org>

Add a single s390 specific test case to verify that the contents of
various output formats do not change in incompatible way if the
lsmem code is changed.

This is based on a patch from Clemens von Mann.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 tests/commands.sh                        |   1 +
 tests/expected/lsmem/lsmem-s390-zvm-6g   |  91 +++++++++++++++++++++++++++++++
 tests/ts/lsmem/dumps/s390-zvm-6g.tar.bz2 | Bin 0 -> 2459 bytes
 tests/ts/lsmem/lsmem                     |  52 ++++++++++++++++++
 tests/ts/lsmem/mk-input.sh               |  22 ++++++++
 5 files changed, 166 insertions(+)
 create mode 100644 tests/expected/lsmem/lsmem-s390-zvm-6g
 create mode 100644 tests/ts/lsmem/dumps/s390-zvm-6g.tar.bz2
 create mode 100755 tests/ts/lsmem/lsmem
 create mode 100755 tests/ts/lsmem/mk-input.sh

diff --git a/tests/commands.sh b/tests/commands.sh
index e0a9b0d13831..1ec7d258417d 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -67,6 +67,7 @@ TS_CMD_LOOK=${TS_CMD_LOOK-"$top_builddir/look"}
 TS_CMD_LOSETUP=${TS_CMD_LOSETUP:-"$top_builddir/losetup"}
 TS_CMD_LSBLK=${TS_CMD_LSBLK-"$top_builddir/lsblk"}
 TS_CMD_LSCPU=${TS_CMD_LSCPU-"$top_builddir/lscpu"}
+TS_CMD_LSMEM=${TS_CMD_LSMEM-"$top_builddir/lsmem"}
 TS_CMD_MCOOKIE=${TS_CMD_MCOOKIE-"$top_builddir/mcookie"}
 TS_CMD_MKCRAMFS=${TS_CMD_MKCRAMFS:-"$top_builddir/mkfs.cramfs"}
 TS_CMD_MKMINIX=${TS_CMD_MKMINIX:-"$top_builddir/mkfs.minix"}
diff --git a/tests/expected/lsmem/lsmem-s390-zvm-6g b/tests/expected/lsmem/lsmem-s390-zvm-6g
new file mode 100644
index 000000000000..be244ad5c488
--- /dev/null
+++ b/tests/expected/lsmem/lsmem-s390-zvm-6g
@@ -0,0 +1,91 @@
+>lsmem
+RANGE                                 SIZE STATE   REMOVABLE BLOCK
+0x0000000000000000-0x000000006fffffff 1.8G online  yes       0-6
+0x0000000070000000-0x000000007fffffff 256M online  no        7
+0x0000000080000000-0x000000009fffffff 512M online  yes       8-9
+0x00000000a0000000-0x00000000bfffffff 512M online  no        10-11
+0x00000000c0000000-0x00000000dfffffff 512M online  yes       12-13
+0x00000000e0000000-0x00000000efffffff 256M offline -         14
+0x00000000f0000000-0x00000000ffffffff 256M online  yes       15
+0x0000000100000000-0x000000011fffffff 512M online  no        16-17
+0x0000000120000000-0x000000013fffffff 512M online  yes       18-19
+0x0000000140000000-0x000000017fffffff   1G offline -         20-23
+
+Memory block size   :     256M
+Total online memory :     4.8G
+Total offline memory:     1.3G
+
+>lsmem -a
+RANGE                                 SIZE STATE   REMOVABLE BLOCK
+0x0000000000000000-0x000000000fffffff 256M online  yes       0
+0x0000000010000000-0x000000001fffffff 256M online  yes       1
+0x0000000020000000-0x000000002fffffff 256M online  yes       2
+0x0000000030000000-0x000000003fffffff 256M online  yes       3
+0x0000000040000000-0x000000004fffffff 256M online  yes       4
+0x0000000050000000-0x000000005fffffff 256M online  yes       5
+0x0000000060000000-0x000000006fffffff 256M online  yes       6
+0x0000000070000000-0x000000007fffffff 256M online  no        7
+0x0000000080000000-0x000000008fffffff 256M online  yes       8
+0x0000000090000000-0x000000009fffffff 256M online  yes       9
+0x00000000a0000000-0x00000000afffffff 256M online  no        10
+0x00000000b0000000-0x00000000bfffffff 256M online  no        11
+0x00000000c0000000-0x00000000cfffffff 256M online  yes       12
+0x00000000d0000000-0x00000000dfffffff 256M online  yes       13
+0x00000000e0000000-0x00000000efffffff 256M offline -         14
+0x00000000f0000000-0x00000000ffffffff 256M online  yes       15
+0x0000000100000000-0x000000010fffffff 256M online  no        16
+0x0000000110000000-0x000000011fffffff 256M online  no        17
+0x0000000120000000-0x000000012fffffff 256M online  yes       18
+0x0000000130000000-0x000000013fffffff 256M online  yes       19
+0x0000000140000000-0x000000014fffffff 256M offline -         20
+0x0000000150000000-0x000000015fffffff 256M offline -         21
+0x0000000160000000-0x000000016fffffff 256M offline -         22
+0x0000000170000000-0x000000017fffffff 256M offline -         23
+
+Memory block size   :     256M
+Total online memory :     4.8G
+Total offline memory:     1.3G
+
+>lsmem -e
+RANGE                                 SIZE STATE   REMOVABLE BLOCK NODE
+0x0000000000000000-0x000000006fffffff 1.8G online  yes       0-6   0
+0x0000000070000000-0x000000007fffffff 256M online  no        7     0
+0x0000000080000000-0x000000009fffffff 512M online  yes       8-9   0
+0x00000000a0000000-0x00000000bfffffff 512M online  no        10-11 0
+0x00000000c0000000-0x00000000dfffffff 512M online  yes       12-13 0
+0x00000000e0000000-0x00000000efffffff 256M offline -         14    0
+0x00000000f0000000-0x00000000ffffffff 256M online  yes       15    0
+0x0000000100000000-0x000000011fffffff 512M online  no        16-17 0
+0x0000000120000000-0x000000013fffffff 512M online  yes       18-19 0
+0x0000000140000000-0x000000017fffffff   1G offline -         20-23 0
+
+Memory block size   :     256M
+Total online memory :     4.8G
+Total offline memory:     1.3G
+
+>lsmem -p -a
+# RANGE,SIZE,STATE,REMOVABLE,BLOCK,NODE
+0x0000000000000000-0x000000000fffffff,268435456,online,yes,0,0
+0x0000000010000000-0x000000001fffffff,268435456,online,yes,1,0
+0x0000000020000000-0x000000002fffffff,268435456,online,yes,2,0
+0x0000000030000000-0x000000003fffffff,268435456,online,yes,3,0
+0x0000000040000000-0x000000004fffffff,268435456,online,yes,4,0
+0x0000000050000000-0x000000005fffffff,268435456,online,yes,5,0
+0x0000000060000000-0x000000006fffffff,268435456,online,yes,6,0
+0x0000000070000000-0x000000007fffffff,268435456,online,no,7,0
+0x0000000080000000-0x000000008fffffff,268435456,online,yes,8,0
+0x0000000090000000-0x000000009fffffff,268435456,online,yes,9,0
+0x00000000a0000000-0x00000000afffffff,268435456,online,no,10,0
+0x00000000b0000000-0x00000000bfffffff,268435456,online,no,11,0
+0x00000000c0000000-0x00000000cfffffff,268435456,online,yes,12,0
+0x00000000d0000000-0x00000000dfffffff,268435456,online,yes,13,0
+0x00000000e0000000-0x00000000efffffff,268435456,offline,-,14,0
+0x00000000f0000000-0x00000000ffffffff,268435456,online,yes,15,0
+0x0000000100000000-0x000000010fffffff,268435456,online,no,16,0
+0x0000000110000000-0x000000011fffffff,268435456,online,no,17,0
+0x0000000120000000-0x000000012fffffff,268435456,online,yes,18,0
+0x0000000130000000-0x000000013fffffff,268435456,online,yes,19,0
+0x0000000140000000-0x000000014fffffff,268435456,offline,-,20,0
+0x0000000150000000-0x000000015fffffff,268435456,offline,-,21,0
+0x0000000160000000-0x000000016fffffff,268435456,offline,-,22,0
+0x0000000170000000-0x000000017fffffff,268435456,offline,-,23,0
diff --git a/tests/ts/lsmem/dumps/s390-zvm-6g.tar.bz2 b/tests/ts/lsmem/dumps/s390-zvm-6g.tar.bz2
new file mode 100644
index 0000000000000000000000000000000000000000..b4dab8ed827fb3633d5803c6f04883c995f25ec2
GIT binary patch
literal 2459
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
K;qGKd>i!41ZDW`K

literal 0
HcmV?d00001

diff --git a/tests/ts/lsmem/lsmem b/tests/ts/lsmem/lsmem
new file mode 100755
index 000000000000..7e6e2f959cda
--- /dev/null
+++ b/tests/ts/lsmem/lsmem
@@ -0,0 +1,52 @@
+#!/bin/bash
+#
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 3 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+TS_TOPDIR="${0%/*}/../.."
+. $TS_TOPDIR/functions.sh
+
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_LSMEM"
+
+for dump in $(ls $TS_SELF/dumps/*.tar.bz2 | sort); do
+	name=$(basename $dump .tar.bz2)
+	dumpdir="$TS_OUTDIR/dumps"
+
+	ts_init_subtest $name
+	mkdir -p $dumpdir
+
+	tar -C $dumpdir -jxf $dump
+
+	echo ">lsmem" >>"${TS_OUTPUT}"
+	"${TS_CMD_LSMEM}" -s "${dumpdir}/${name}" >>"${TS_OUTPUT}" 2>&1
+
+	echo >>"${TS_OUTPUT}"
+	echo ">lsmem -a" >>"${TS_OUTPUT}"
+	"${TS_CMD_LSMEM}" -a -s "${dumpdir}/${name}" >>"${TS_OUTPUT}" 2>&1
+
+	echo >>"${TS_OUTPUT}"
+	echo ">lsmem -e" >>"${TS_OUTPUT}"
+	"${TS_CMD_LSMEM}" -e -s "${dumpdir}/${name}" >>"${TS_OUTPUT}" 2>&1
+
+	echo >>"${TS_OUTPUT}"
+	echo ">lsmem -p -a" >>"${TS_OUTPUT}"
+	"${TS_CMD_LSMEM}" -p -a -s "${dumpdir}/${name}" >>"${TS_OUTPUT}" 2>&1
+
+	ts_finalize_subtest
+done
+
+ts_finalize
diff --git a/tests/ts/lsmem/mk-input.sh b/tests/ts/lsmem/mk-input.sh
new file mode 100755
index 000000000000..e9a4e7206b7f
--- /dev/null
+++ b/tests/ts/lsmem/mk-input.sh
@@ -0,0 +1,22 @@
+#!/bin/bash
+#
+# This script makes a copy of relevant files from /sys.
+# The files are useful for lscpu(1) regression tests.
+#
+progname=$(basename $0)
+
+if [ -z "$1" ]; then
+	echo -e "\nusage: $progname <testname>\n"
+	exit 1
+fi
+
+TS_NAME="$1"
+TS_DUMP="$TS_NAME"
+CP="cp -r --parent"
+
+mkdir -p $TS_DUMP/sys/devices/system
+
+$CP /sys/devices/system/memory $TS_DUMP
+
+tar jcvf $TS_NAME.tar.bz2 $TS_DUMP
+rm -rf $TS_DUMP
-- 
2.8.4
