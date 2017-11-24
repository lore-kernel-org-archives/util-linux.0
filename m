Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:4400 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753071AbdKXKbm (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Fri, 24 Nov 2017 05:31:42 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH v2 6/7] lsns: add a case for testing nsfs column
Date: Fri, 24 Nov 2017 19:31:09 +0900
Message-Id: <20171124103110.17077-8-yamato@redhat.com>
In-Reply-To: <20171124103110.17077-1-yamato@redhat.com>
References: <20171124103110.17077-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 tests/expected/lsns/nsfs |  1 +
 tests/ts/lsns/nsfs       | 68 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 tests/expected/lsns/nsfs
 create mode 100644 tests/ts/lsns/nsfs

diff --git a/tests/expected/lsns/nsfs b/tests/expected/lsns/nsfs
new file mode 100644
index 000000000..573541ac9
--- /dev/null
+++ b/tests/expected/lsns/nsfs
@@ -0,0 +1 @@
+0
diff --git a/tests/ts/lsns/nsfs b/tests/ts/lsns/nsfs
new file mode 100644
index 000000000..7f2b46bbe
--- /dev/null
+++ b/tests/ts/lsns/nsfs
@@ -0,0 +1,68 @@
+#!/bin/bash
+#
+# Copyright (C) 2017 Masatake YAMATO <yamato@redhat.com>
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
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="list NSFS for namespaces created by ip-netns-add"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_LSNS"
+
+ts_skip_nonroot
+
+ts_cd "$TS_OUTDIR"
+
+NAME1=ABC
+NAME2=XYZ
+PATH1=/run/netns/$NAME1
+PATH2=$TS_OUTDIR/$NAME2
+FIFO=$TS_OUTDIR/UTIL-LINUX-LSNS-TEST-FIFO
+NULL=/dev/null
+
+ip netns delete $NAME1 2> /dev/null || :
+umount $PATH2 2>/dev/null || :
+rm -f $PATH2
+
+rm -f $FIFO
+mkfifo $FIFO
+
+if ip netns add $NAME1 &&
+	touch ${PATH2} &&
+	mount -o bind ${PATH1} ${PATH2}; then
+    ip netns exec $NAME1 dd if=$FIFO bs=1 count=2 of=$NULL 2> $NULL &
+    PID=$!
+fi
+{
+    dd if=/dev/zero bs=1 count=1 2> $NULL
+    NSFS_NAMES_MLINES=$($TS_CMD_LSNS -n -o NSFS --type net --task $PID | { while read VAL; do echo $VAL; done; } )
+    NSFS_NAMES_1LINE=$($TS_CMD_LSNS -n -o NSFS --nowrap --type net --task $PID | { while read VAL; do echo $VAL; done; } )
+    dd if=/dev/zero bs=1 count=1 2> $NULL
+} > $FIFO
+
+rm $FIFO
+
+umount $PATH2
+rm -f $PATH2
+ip netns delete $NAME1
+
+test "$NSFS_NAMES_MLINES" = "$PATH1
+$PATH2" && test "$NSFS_NAMES_1LINE" = "$PATH1,$PATH2"
+
+echo $? >> $TS_OUTPUT
+
+ts_finalize
-- 
2.13.6

