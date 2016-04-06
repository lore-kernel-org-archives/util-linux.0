Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63560 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754512AbcDFHQQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 03:16:16 -0400
Received: from tenfore.ga-group.nl ([2.247.82.193]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LvQkh-1bo1BG1n8t-010gJm for
 <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 09:16:13 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] tests: remove deprecated md5sum based fdisk/bsd test
Date: Wed,  6 Apr 2016 09:16:11 +0200
Message-Id: <1459926971-26313-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1459926971-26313-1-git-send-email-sweet_f_a@gmx.de>
References: <1459926971-26313-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/fdisk/bsd-deprecated | 123 -----------------------------
 tests/ts/fdisk/bsd                  |   6 +-
 tests/ts/fdisk/bsd-deprecated       | 149 ------------------------------------
 3 files changed, 3 insertions(+), 275 deletions(-)
 delete mode 100644 tests/expected/fdisk/bsd-deprecated
 delete mode 100755 tests/ts/fdisk/bsd-deprecated

diff --git a/tests/expected/fdisk/bsd-deprecated b/tests/expected/fdisk/bsd-deprecated
deleted file mode 100644
index 53c13c4..0000000
--- a/tests/expected/fdisk/bsd-deprecated
+++ /dev/null
@@ -1,123 +0,0 @@
-Initialize empty image
-f1c9645dbc14efddc7d8a322685f26eb bsd-deprecated.img
-Create new DOS partition table
-57e721e38d1266c2df055067c18f2cf9 bsd-deprecated.img
-
----layout----------
-Disk <removed>: 10 MiB, 10485760 bytes, 20480 sectors
-Units: sectors of 1 * 512 = 512 bytes
-Sector size (logical/physical): 512 bytes / 512 bytes
-I/O size (minimum/optimal): 512 bytes / <removed> bytes
-Disklabel type: dos
-Disk identifier: <removed>
--------------------
-
-Create 1st primary partition
-ada64ace122978d00d1d1c0e5ee45d26 bsd-deprecated.img
-
----layout----------
-Disk <removed>: 10 MiB, 10485760 bytes, 20480 sectors
-Units: sectors of 1 * 512 = 512 bytes
-Sector size (logical/physical): 512 bytes / 512 bytes
-I/O size (minimum/optimal): 512 bytes / <removed> bytes
-Disklabel type: dos
-Disk identifier: <removed>
-
-Device     Boot Start   End Sectors Size Id Type
-<removed>1       2048  4095    2048   1M 83 Linux
--------------------
-
-Create 2st primary partition
-1bebf87248e05d6e4e62b749da65d023 bsd-deprecated.img
-Set 2nd partition type
-2d8e8dff51a88a045db233418dd73fbe bsd-deprecated.img
-
----layout----------
-Disk <removed>: 10 MiB, 10485760 bytes, 20480 sectors
-Units: sectors of 1 * 512 = 512 bytes
-Sector size (logical/physical): 512 bytes / 512 bytes
-I/O size (minimum/optimal): 512 bytes / <removed> bytes
-Disklabel type: dos
-Disk identifier: <removed>
-
-Device     Boot Start   End Sectors Size Id Type
-<removed>1       2048  4095    2048   1M 83 Linux
-<removed>2       4096 20479   16384   8M a5 FreeBSD
--------------------
-
-Create default BSD
-2e1cee529cb59c9341afef0443f196a1 bsd-deprecated.img
-
----layout----------
-
-Welcome to fdisk <removed>.
-Changes will remain in memory only, until you decide to write them.
-Be careful before using the write command.
-
-
-Command (m for help): Entering nested BSD disklabel.
-
-Command (m for help): Disk <removed>2: 10 MiB, 10485760 bytes, 20480 sectors
-Geometry: 255 heads, 63 sectors/track, 1 cylinders
-Units: sectors of 1 * 512 = 512 bytes
-Sector size (logical/physical): 512 bytes / 512 bytes
-I/O size (minimum/optimal): 512 bytes / <removed> bytes
-Disklabel type: bsd
-
-Slice Start   End Sectors  Size Type     Fsize Bsize Cpg
-c      4096 20479   16384    8M unused       0     0   0
-d         0 16064   16065  7.9M unused       0     0   0
-
-Partition table entries are not in disk order.
-
-Command (m for help): Leaving nested disklabel.
-
-Command (m for help): 
--------------------
-
-b5c121c2091b2ff26b880551feac7112 bsd-deprecated.img
-
----layout----------
-
-Welcome to fdisk <removed>.
-Changes will remain in memory only, until you decide to write them.
-Be careful before using the write command.
-
-
-Command (m for help): Entering nested BSD disklabel.
-
-Command (m for help): Disk <removed>2: 10 MiB, 10485760 bytes, 20480 sectors
-Geometry: 255 heads, 63 sectors/track, 1 cylinders
-Units: sectors of 1 * 512 = 512 bytes
-Sector size (logical/physical): 512 bytes / 512 bytes
-I/O size (minimum/optimal): 512 bytes / <removed> bytes
-Disklabel type: bsd
-
-Slice Start   End Sectors  Size Type     Fsize Bsize Cpg
-a      4096  6144    2049    1M 4.2BSD       0     0   0
-c      4096 20479   16384    8M unused       0     0   0
-d         0 16064   16065  7.9M unused       0     0   0
-
-Partition table entries are not in disk order.
-
-Command (m for help): Leaving nested disklabel.
-
-Command (m for help): 
--------------------
-
-
-
-Changes will remain in memory only, until you decide to write them.
-Be careful before using the write command.
-
-
-Command (m for help): Entering nested BSD disklabel.
-
-Command (m for help): 
- 0  unused           5  4.1BSD           9  4.4LFS           d  boot           
- 1  swap             6  Eighth Edition   a  unknown          e  ADOS           
- 2  Version 6        7  4.2BSD           b  HPFS             f  HFS            
- 3  Version 7        8  MS-DOS           c  ISO-9660        10  AdvFS          
- 4  System V       
-
-Command (m for help): 
diff --git a/tests/ts/fdisk/bsd b/tests/ts/fdisk/bsd
index 19e999b..fa64e1a 100755
--- a/tests/ts/fdisk/bsd
+++ b/tests/ts/fdisk/bsd
@@ -17,12 +17,13 @@
 #
 
 TS_TOPDIR="${0%/*}/../.."
-TS_DESC="nested BSD (new)"
+TS_DESC="nested BSD"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
 ts_check_test_command "$TS_CMD_FDISK"
+ts_check_test_command "$TS_CMD_HEXDUMP"
 ts_check_test_command "$TS_HELPER_SYSINFO"
 
 FDISK_CMD_CREATE_DOSLABEL="o\n"              # create dos label
@@ -49,7 +50,7 @@ case $ARCH in
 	# see include/pt-bsd.h
 	*alpha* | *ppc* | *ia64* | *hppa* )
 		BSD_LABELSECTOR=0
-		BSD_LABELOFFSET=64 
+		BSD_LABELOFFSET=64
 		;;
 	*)
 		BSD_LABELSECTOR=1
@@ -72,7 +73,6 @@ echo "BYTE_ORDER=$BYTE_ORDER" >> $TS_OUTPUT
 echo >> $TS_OUTPUT
 
 TS_EXPECTED+="_${BSD_LABELSECTOR}_${BSD_LABELOFFSET}${BSD_EXTRA}.${BYTE_ORDER}"
-#echo $TS_EXPECTED
 
 function print_layout {
 	echo -ne "\n---layout----------\n" >> $TS_OUTPUT
diff --git a/tests/ts/fdisk/bsd-deprecated b/tests/ts/fdisk/bsd-deprecated
deleted file mode 100755
index 5e2cfa4..0000000
--- a/tests/ts/fdisk/bsd-deprecated
+++ /dev/null
@@ -1,149 +0,0 @@
-#!/bin/bash
-#
-# This file is part of util-linux.
-#
-# Copyright (C) 2013-2016 Karel Zak <kzak@redhat.com>
-#
-# This file is free software; you can redistribute it and/or modify
-# it under the terms of the GNU General Public License as published by
-# the Free Software Foundation; either version 2 of the License, or
-# (at your option) any later version.
-#
-# This file is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-#
-
-TS_TOPDIR="${0%/*}/../.."
-TS_DESC="nested BSD"
-
-. $TS_TOPDIR/functions.sh
-ts_init "$*"
-
-ts_check_test_command "$TS_CMD_FDISK"
-ts_check_test_command "$TS_HELPER_SYSINFO"
-
-FDISK_CMD_CREATE_DOSLABEL="o\n"              # create dos label
-FDISK_CMD_SETID="x\ni\n0x1\nr\n"             # set non-random ID
-FDISK_CMD_WRITE_CLOSE="w\nq\n"               # write to image
-FDISK_CMD_CREATE_PRIMARY1="n\np\n1\n\n+1M\n" # 1st primary partition of size 1MiB
-FDISK_CMD_CREATE_PRIMARY2="n\np\n2\n\n\n"    # 2nd primary partition for whole of the disk
-FDISK_CMD_CHANGE_PART2TYPE="t\n2\na5\n"      # change partition type FreeBSD
-
-FDISK_CMD_BSD_CREATE="b\ny\n"                # create nested BSD PT
-FDISK_CMD_BSD_LIST="b\np\nr\nq\n"            # list nested BSD PT and quit
-FDISK_CMD_BSD_CREATE_PART="b\nn\na\n\n+1M\n" # add BSD partition 'a', size 1MiB
-FDISK_CMD_BSD_PARTTYPE="b\nt\na\n7\n"        # set partition 'a' to type 4.2BSD
-FDISK_CMD_BSD_LIST_TYPES="b\nl\nq\n"         # list supported PT types and quit
-
-#set -x
-
-# BSD disklabel depends on sector/offset and endianness. We convert the md5sums
-# into the most common values (little endian, BSD_LABELSECTOR = 1, 
-# BSD_LABELOFFSET = 0) so that they can be easily compared to the expected
-# ones.
-BYTE_ORDER=$($TS_HELPER_SYSINFO byte-order)
-function fdisk_bsd_offset_and_byte_order_clean
-{
-		# expected md5sums are from x86 systems
-		local md5_bsdimg1_LE_0_64="2e1cee529cb59c9341afef0443f196a1"
-		local md5_bsdimg2_LE_0_64="b5c121c2091b2ff26b880551feac7112"
-
-	if [ $BYTE_ORDER = "BE" ] ; then
-		# BSD_LABELSECTOR = 0, BSD_LABELOFFSET = 64
-		sed -i \
-		-e "s/c2273b52976351db75596c47c10b0725/$md5_bsdimg1_LE_0_64/" \
-		-e "s/9a234a5b99e37d2ce0d92b65437b93cd/$md5_bsdimg2_LE_0_64/" \
-		"$TS_OUTPUT"
-
-		# BSD_LABELSECTOR = 1, BSD_LABELOFFSET = 0
-		sed -i \
-		-e "s/e990c8a1c2106a4cd4b008f16d71aaa6/$md5_bsdimg1_LE_0_64/" \
-		-e "s/187a48c26e83d146b866868addc93702/$md5_bsdimg2_LE_0_64/" \
-		"$TS_OUTPUT"
-	else
-		# BSD_LABELSECTOR = 0, BSD_LABELOFFSET = 64
-		sed -i \
-		-e "s/6d760d7a8ef33b27cc6e27f1e8807d48/$md5_bsdimg1_LE_0_64/" \
-		-e "s/3739c7959adb42693a69edb7a99914e8/$md5_bsdimg2_LE_0_64/" \
-		"$TS_OUTPUT"
-
-		# special case for alpha
-		if grep -q "78a922a80361cb73049bced72e0f8f1d" $TS_OUTPUT; then
-			sed -i \
-				-e "s/78a922a80361cb73049bced72e0f8f1d/$md5_bsdimg1_LE_0_64/" \
-				-e "s/fc2803672a0643ffe46da325629616fc/$md5_bsdimg2_LE_0_64/" \
-				-e 's/\(3 *Version 7 *8 *\)ext2  /\1MS-DOS/' \
-				"$TS_OUTPUT"
-		fi
-	fi
-}
-
-function print_layout {
-	echo -ne "\n---layout----------\n" >> $TS_OUTPUT
-	$TS_CMD_FDISK -l ${TEST_IMAGE_NAME}  >> $TS_OUTPUT
-	echo -ne   "-------------------\n\n" >> $TS_OUTPUT
-}
-
-function print_bsd_layout {
-	echo -ne "\n---layout----------\n" >> $TS_OUTPUT
-	echo -e "${FDISK_CMD_BSD_LIST}" | \
-			$TS_CMD_FDISK ${TEST_IMAGE_NAME} >> $TS_OUTPUT
-	echo -ne   "-------------------\n\n" >> $TS_OUTPUT
-}
-
-ts_log "Initialize empty image"
-TEST_IMAGE_NAME=$(ts_image_init 10)
-ts_image_md5sum >> $TS_OUTPUT 2>&1
-
-ts_log "Create new DOS partition table"
-echo -e "${FDISK_CMD_CREATE_DOSLABEL}${FDISK_CMD_SETID}${FDISK_CMD_WRITE_CLOSE}" \
-	 | $TS_CMD_FDISK ${TEST_IMAGE_NAME} &> /dev/null
-ts_image_md5sum >> $TS_OUTPUT 2>&1
-
-print_layout
-
-ts_log "Create 1st primary partition"
-echo -e "${FDISK_CMD_CREATE_PRIMARY1}${FDISK_CMD_WRITE_CLOSE}" | \
-	$TS_CMD_FDISK ${TEST_IMAGE_NAME} &> /dev/null
-ts_image_md5sum >> $TS_OUTPUT 2>&1
-
-print_layout
-
-ts_log "Create 2st primary partition"
-echo -e "${FDISK_CMD_CREATE_PRIMARY2}${FDISK_CMD_WRITE_CLOSE}" | \
-	$TS_CMD_FDISK ${TEST_IMAGE_NAME} &> /dev/null
-ts_image_md5sum >> $TS_OUTPUT 2>&1
-
-ts_log "Set 2nd partition type"
-echo -e "${FDISK_CMD_CHANGE_PART2TYPE}${FDISK_CMD_WRITE_CLOSE}" | \
-	$TS_CMD_FDISK ${TEST_IMAGE_NAME} &> /dev/null
-ts_image_md5sum >> $TS_OUTPUT 2>&1
-
-print_layout
-
-ts_log "Create default BSD"
-echo -e "${FDISK_CMD_BSD_CREATE}${FDISK_CMD_WRITE_CLOSE}" | \
-	$TS_CMD_FDISK ${TEST_IMAGE_NAME} &> /dev/null
-ts_image_md5sum >> $TS_OUTPUT 2>&1
-
-print_bsd_layout
-
-echo -e "${FDISK_CMD_BSD_CREATE_PART}${FDISK_CMD_WRITE_CLOSE}" | \
-	$TS_CMD_FDISK ${TEST_IMAGE_NAME} &> /dev/null
-
-echo -e "${FDISK_CMD_BSD_PARTTYPE}${FDISK_CMD_WRITE_CLOSE}" | \
-	$TS_CMD_FDISK ${TEST_IMAGE_NAME} &> /dev/null
-ts_image_md5sum >> $TS_OUTPUT 2>&1
-
-print_bsd_layout
-
-echo -e "${FDISK_CMD_BSD_LIST_TYPES}" | \
-	$TS_CMD_FDISK ${TEST_IMAGE_NAME} | \
-	sed 's/Reading .*//g; s/Welcome to fdisk .*//' >> $TS_OUTPUT 2>&1
-
-fdisk_bsd_offset_and_byte_order_clean
-ts_fdisk_clean ${TEST_IMAGE_NAME}
-ts_finalize
-- 
1.8.4.5

