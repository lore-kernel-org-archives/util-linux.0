Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:3521 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756445AbaJXPOE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 24 Oct 2014 11:14:04 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id s9OFE4QR007306
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL)
	for <util-linux@vger.kernel.org>; Fri, 24 Oct 2014 11:14:04 -0400
From: Federico Simoncelli <fsimonce@redhat.com>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com, lczerner@redhat.com,
        Federico Simoncelli <fsimonce@redhat.com>
Subject: [PATCH 1/3] tests: add blkdiscard offsets test
Date: Fri, 24 Oct 2014 15:13:53 +0000
Message-Id: <1414163635-3940-1-git-send-email-fsimonce@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Federico Simoncelli <fsimonce@redhat.com>
---
 tests/commands.sh                 |  1 +
 tests/expected/blkdiscard/offsets | 16 ++++++++++
 tests/ts/blkdiscard/offsets       | 62 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 79 insertions(+)
 create mode 100644 tests/expected/blkdiscard/offsets
 create mode 100755 tests/ts/blkdiscard/offsets

diff --git a/tests/commands.sh b/tests/commands.sh
index 4c7455e..e11bd2a 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -29,6 +29,7 @@ TS_HELPER_SYSINFO="$top_builddir/test_sysinfo"
 # paths to commands
 TS_CMD_ADDPART=${TS_CMD_ADDPART:-"$top_builddir/addpart"}
 TS_CMD_DELPART=${TS_CMD_DELPART:-"$top_builddir/delpart"}
+TS_CMD_BLKDISCARD=${TS_CMD_BLKID-"$top_builddir/blkdiscard"}
 TS_CMD_BLKID=${TS_CMD_BLKID-"$top_builddir/blkid"}
 TS_CMD_CAL=${TS_CMD_CAL-"$top_builddir/cal"}
 TS_CMD_COLRM=${TS_CMD_COLRM:-"$top_builddir/colrm"}
diff --git a/tests/expected/blkdiscard/offsets b/tests/expected/blkdiscard/offsets
new file mode 100644
index 0000000..766c39d
--- /dev/null
+++ b/tests/expected/blkdiscard/offsets
@@ -0,0 +1,16 @@
+create loop device from image
+testing offsets with full block size
+Discarded 10485760 bytes from the offset 0
+Discarded 10485248 bytes from the offset 512
+Discarded 10485248 bytes from the offset 512
+Discarded 10485248 bytes from the offset 512
+Discarded 10484736 bytes from the offset 1024
+testing offsets with specific length
+Discarded 5242880 bytes from the offset 0
+Discarded 5242880 bytes from the offset 0
+Discarded 5242880 bytes from the offset 0
+Discarded 5242880 bytes from the offset 512
+Discarded 5242880 bytes from the offset 512
+Discarded 5242880 bytes from the offset 512
+Discarded 5242880 bytes from the offset 1024
+detach loop device from image
diff --git a/tests/ts/blkdiscard/offsets b/tests/ts/blkdiscard/offsets
new file mode 100755
index 0000000..04bd437
--- /dev/null
+++ b/tests/ts/blkdiscard/offsets
@@ -0,0 +1,62 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2014 Federico Simoncelli <fsimonce@redhat.com>
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
+TS_DESC="offsets"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_BLKDISCARD"
+
+ts_skip_nonroot
+ts_check_losetup
+
+set -o pipefail
+
+ORIGPWD=$(pwd)
+IMAGE_NAME="${TS_TESTNAME}-loop.img"
+IMAGE_PATH="$TS_OUTDIR/$IMAGE_NAME"
+
+truncate -s 10M $IMAGE_PATH
+
+ts_log "create loop device from image"
+DEVICE=$($TS_CMD_LOSETUP --show -f $IMAGE_PATH)
+CMD_SED_DEVICE="sed s#$DEVICE:\s##"
+
+ts_log "testing offsets with full block size"
+$TS_CMD_BLKDISCARD -v $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -o 1 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -o 511 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -o 512 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -o 1024 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+
+ts_log "testing offsets with specific length"
+$TS_CMD_BLKDISCARD -v -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -l 5242881 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -l 5243391 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -o 1 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -o 511 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -o 512 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+$TS_CMD_BLKDISCARD -v -o 1024 -l 5242880 $DEVICE 2>&1 | $CMD_SED_DEVICE >> $TS_OUTPUT
+
+ts_log "detach loop device from image"
+$TS_CMD_LOSETUP -d $DEVICE 2>&1 >> $TS_OUTPUT
+
+ts_cd "$ORIGPWD"
+
+ts_finalize
-- 
1.9.3

