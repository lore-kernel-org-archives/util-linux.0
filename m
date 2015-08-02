Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:35493 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbbHBS3M (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Aug 2015 14:29:12 -0400
Received: by wibxm9 with SMTP id xm9so93676459wib.0
        for <util-linux@vger.kernel.org>; Sun, 02 Aug 2015 11:29:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] tests: add fsck.minix checks
Date: Sun,  2 Aug 2015 19:29:00 +0100
Message-Id: <1438540140-959-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1438540140-959-1-git-send-email-kerolasa@iki.fi>
References: <1438540140-959-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The debian bug was fixed in commit 730ae9c89971, and the rest are about
having test coverity for various file name lenghts and minix fs versions.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/minix/fsck-images-auto-fix     |  31 ++++++++++++
 tests/expected/minix/fsck-images-broken-root  |   7 +++
 tests/expected/minix/fsck-images-bug.773892   |   1 +
 tests/expected/minix/fsck-images-check-blocks |   9 ++++
 tests/expected/minix/fsck-images-v1c14        |   9 ++++
 tests/expected/minix/fsck-images-v1c30        |   9 ++++
 tests/expected/minix/fsck-images-v2c14        |   9 ++++
 tests/expected/minix/fsck-images-v2c30        |   9 ++++
 tests/expected/minix/fsck-images-v3c60        |   9 ++++
 tests/ts/minix/broken-root                    | Bin 0 -> 5120 bytes
 tests/ts/minix/debian.bug.773892              | Bin 0 -> 16384 bytes
 tests/ts/minix/fsck-images                    |  67 ++++++++++++++++++++++++++
 12 files changed, 160 insertions(+)
 create mode 100644 tests/expected/minix/fsck-images-auto-fix
 create mode 100644 tests/expected/minix/fsck-images-broken-root
 create mode 100644 tests/expected/minix/fsck-images-bug.773892
 create mode 100644 tests/expected/minix/fsck-images-check-blocks
 create mode 100644 tests/expected/minix/fsck-images-v1c14
 create mode 100644 tests/expected/minix/fsck-images-v1c30
 create mode 100644 tests/expected/minix/fsck-images-v2c14
 create mode 100644 tests/expected/minix/fsck-images-v2c30
 create mode 100644 tests/expected/minix/fsck-images-v3c60
 create mode 100644 tests/ts/minix/broken-root
 create mode 100644 tests/ts/minix/debian.bug.773892
 create mode 100755 tests/ts/minix/fsck-images

diff --git a/tests/expected/minix/fsck-images-auto-fix b/tests/expected/minix/fsck-images-auto-fix
new file mode 100644
index 0000000..d017dfb
--- /dev/null
+++ b/tests/expected/minix/fsck-images-auto-fix
@@ -0,0 +1,31 @@
+Filesystem auto-fix is dirty, needs checking.
+Read error: bad block in file '/'
+16 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=2147483647
+namelen=60
+
+Read error: bad block in file '/'
+/: bad directory: '.' isn't first
+Read error: bad block in file '/'
+/: bad directory: '..' isn't second
+Inode 1 not used, marked used in the bitmap.
+
+     0 inodes used (0%)
+     6 zones used (37%)
+
+     0 regular files
+     0 directories
+     0 character device files
+     0 block device files
+     1 links
+     0 symbolic links
+------
+     1 files
+----------------------------
+FILE SYSTEM HAS BEEN CHANGED
+----------------------------
+0
+29f0edbcb7e405bbc56e614af3c3cb7c auto-fix
diff --git a/tests/expected/minix/fsck-images-broken-root b/tests/expected/minix/fsck-images-broken-root
new file mode 100644
index 0000000..d851b83
--- /dev/null
+++ b/tests/expected/minix/fsck-images-broken-root
@@ -0,0 +1,7 @@
+Read error: bad block in file '/'
+Read error: bad block in file '/'
+/: bad directory: '.' isn't first
+Read error: bad block in file '/'
+/: bad directory: '..' isn't second
+Inode 1 not used, marked used in the bitmap.
+4
diff --git a/tests/expected/minix/fsck-images-bug.773892 b/tests/expected/minix/fsck-images-bug.773892
new file mode 100644
index 0000000..573541a
--- /dev/null
+++ b/tests/expected/minix/fsck-images-bug.773892
@@ -0,0 +1 @@
+0
diff --git a/tests/expected/minix/fsck-images-check-blocks b/tests/expected/minix/fsck-images-check-blocks
new file mode 100644
index 0000000..c255d2b
--- /dev/null
+++ b/tests/expected/minix/fsck-images-check-blocks
@@ -0,0 +1,9 @@
+32 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=268966912
+
+mkfs return value: 0
+fsck return value: 0
+a00e2f45adc97da6ccb5aade7b129b42
diff --git a/tests/expected/minix/fsck-images-v1c14 b/tests/expected/minix/fsck-images-v1c14
new file mode 100644
index 0000000..519fc7e
--- /dev/null
+++ b/tests/expected/minix/fsck-images-v1c14
@@ -0,0 +1,9 @@
+32 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=268966912
+
+mkfs return value: 0
+fsck return value: 0
+9d9bf9d22274bb996938812ab01dd891
diff --git a/tests/expected/minix/fsck-images-v1c30 b/tests/expected/minix/fsck-images-v1c30
new file mode 100644
index 0000000..c255d2b
--- /dev/null
+++ b/tests/expected/minix/fsck-images-v1c30
@@ -0,0 +1,9 @@
+32 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=268966912
+
+mkfs return value: 0
+fsck return value: 0
+a00e2f45adc97da6ccb5aade7b129b42
diff --git a/tests/expected/minix/fsck-images-v2c14 b/tests/expected/minix/fsck-images-v2c14
new file mode 100644
index 0000000..2b3a173
--- /dev/null
+++ b/tests/expected/minix/fsck-images-v2c14
@@ -0,0 +1,9 @@
+16 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=2147483647
+
+mkfs return value: 0
+fsck return value: 0
+d836636da820de16325370caf494cdab
diff --git a/tests/expected/minix/fsck-images-v2c30 b/tests/expected/minix/fsck-images-v2c30
new file mode 100644
index 0000000..168e66a
--- /dev/null
+++ b/tests/expected/minix/fsck-images-v2c30
@@ -0,0 +1,9 @@
+16 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=2147483647
+
+mkfs return value: 0
+fsck return value: 0
+3e5796ddbd8d08b98c29c42199685bcb
diff --git a/tests/expected/minix/fsck-images-v3c60 b/tests/expected/minix/fsck-images-v3c60
new file mode 100644
index 0000000..4505dcd
--- /dev/null
+++ b/tests/expected/minix/fsck-images-v3c60
@@ -0,0 +1,9 @@
+16 inodes
+16 blocks
+Firstdatazone=5 (5)
+Zonesize=1024
+Maxsize=2147483647
+
+mkfs return value: 0
+fsck return value: 0
+e4acad302d186a5c8788acedb7021255
diff --git a/tests/ts/minix/broken-root b/tests/ts/minix/broken-root
new file mode 100644
index 0000000000000000000000000000000000000000..37ee84e0c5913154271a0a008932d6f4d207948c
GIT binary patch
literal 5120
zcmZQz7zLvtFd70QH3S5}9%p1=WMBoe{{R194-$*=1rjV^p;2Nq1V%$(n1%o|!#`k_
z9|fZ!Fd70QF$9=Dj6`3L`gt@2MneD;0&g9e7+x^HU~T}mZ)Vu;425AxZ(x`<dPco9
L8Umvs01g2Fn^FSw

literal 0
HcmV?d00001

diff --git a/tests/ts/minix/debian.bug.773892 b/tests/ts/minix/debian.bug.773892
new file mode 100644
index 0000000000000000000000000000000000000000..db9784887a264b991f7281ddf55123b6e9ca85c3
GIT binary patch
literal 16384
zcmeI#u?@m75J1s05fWu2S_(S4%s_Tv0YW;EC>VqR*n!QED5!yi0n$+3vrAi+{;SRr
z76AfT1=dkV8TNbxSS{-7vSg*uO(2~>H59);76Aeo1*&JpYRv=)i~^7LRkp(n&~9$K
ze)jtXq?>^R6UZu1qM1xDai6{rO}Fp6)A?|`Og`k0009C72oNAZfB*pk1PBlyK!5-N
h0t5&UAV7cs0RjXF5FkK+009C72oNAZfB=EN1-|D^{dWKW

literal 0
HcmV?d00001

diff --git a/tests/ts/minix/fsck-images b/tests/ts/minix/fsck-images
new file mode 100755
index 0000000..afd2f9b
--- /dev/null
+++ b/tests/ts/minix/fsck-images
@@ -0,0 +1,67 @@
+#!/bin/bash
+#
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="fsck images"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_FSCKMINIX"
+ts_check_test_command "$TS_HELPER_MKFS_MINIX"
+
+export MKFS_MINIX_TEST_SECOND_SINCE_EPOCH='1438460212'
+
+check_minix_fs_type() {
+	ts_init_subtest $1
+	dd if=/dev/zero bs=1024 count=16 of=$TS_OUTDIR/$1 >/dev/null 2>&1
+	$TS_HELPER_MKFS_MINIX $2 $TS_OUTDIR/$1 >> $TS_OUTPUT 2>&1
+	echo "mkfs return value: $?" >> $TS_OUTPUT
+	$TS_CMD_FSCKMINIX $TS_OUTDIR/$1 >> $TS_OUTPUT 2>&1
+	echo "fsck return value: $?" >> $TS_OUTPUT
+	md5sum $TS_OUTDIR/$1 | awk '{print $1}' >> $TS_OUTPUT 2>&1
+	rm -f $TS_OUTDIR/$1
+	ts_finalize_subtest
+}
+
+check_minix_fs_type 'v1c14' '-1 -n 14'
+check_minix_fs_type 'v1c30' '-1 -n 30'
+check_minix_fs_type 'v2c14' '-2 -n 14'
+check_minix_fs_type 'v2c30' '-2 -n 30'
+check_minix_fs_type 'v3c60' '-3 -n 60'
+
+ts_init_subtest "auto-fix"
+cp "$TS_SELF/broken-root" "$TS_OUTDIR/auto-fix"
+"$TS_CMD_FSCKMINIX" -sav "$TS_OUTDIR/auto-fix" |
+	sed 's/Filesystem on .*auto-fix is dirty/Filesystem auto-fix is dirty/' > $TS_OUTPUT 2>&1
+echo $? >> $TS_OUTPUT
+md5sum "$TS_OUTDIR/auto-fix" |
+	sed 's/  .*auto-fix/ auto-fix/' >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest "bug.773892"
+"$TS_CMD_FSCKMINIX" "$TS_SELF/debian.bug.773892" > $TS_OUTPUT 2>&1
+echo $? >> $TS_OUTPUT
+ts_finalize_subtest
+
+ts_init_subtest "broken-root"
+"$TS_CMD_FSCKMINIX" "$TS_SELF/broken-root" > $TS_OUTPUT 2>&1
+echo $? >> $TS_OUTPUT
+ts_finalize_subtest
+
+echo "42" > $TS_OUTDIR/badlist
+check_minix_fs_type 'check-blocks' "-l $TS_OUTDIR/badlist -c"
+rm -f $TS_OUTDIR/badlist
+
+ts_finalize
-- 
2.5.0

