Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757211AbdKOC7Z (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 14 Nov 2017 21:59:25 -0500
From: Masatake YAMATO <yamato@redhat.com>
To: util-linux@vger.kernel.org
Cc: yamato@redhat.com
Subject: [PATCH 2/2] lsns: add a case for testing netnsid column
Date: Wed, 15 Nov 2017 11:59:19 +0900
Message-Id: <20171115025920.22394-2-yamato@redhat.com>
In-Reply-To: <20171115025920.22394-1-yamato@redhat.com>
References: <20171115025920.22394-1-yamato@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Masatake YAMATO <yamato@redhat.com>
---
 tests/commands.sh           |  1 +
 tests/expected/lsns/netnsid |  1 +
 tests/ts/lsns/netnsid       | 65 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 67 insertions(+)
 create mode 100644 tests/expected/lsns/netnsid
 create mode 100644 tests/ts/lsns/netnsid

diff --git a/tests/commands.sh b/tests/commands.sh
index 655344102..502935ede 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -74,6 +74,7 @@ TS_CMD_LOSETUP=${TS_CMD_LOSETUP:-"$top_builddir/losetup"}
 TS_CMD_LSBLK=${TS_CMD_LSBLK-"$top_builddir/lsblk"}
 TS_CMD_LSCPU=${TS_CMD_LSCPU-"$top_builddir/lscpu"}
 TS_CMD_LSMEM=${TS_CMD_LSMEM-"$top_builddir/lsmem"}
+TS_CMD_LSNS=${TS_CMD_LSNS-"$top_builddir/lsns"}
 TS_CMD_MCOOKIE=${TS_CMD_MCOOKIE-"$top_builddir/mcookie"}
 TS_CMD_MKCRAMFS=${TS_CMD_MKCRAMFS:-"$top_builddir/mkfs.cramfs"}
 TS_CMD_MKMINIX=${TS_CMD_MKMINIX:-"$top_builddir/mkfs.minix"}
diff --git a/tests/expected/lsns/netnsid b/tests/expected/lsns/netnsid
new file mode 100644
index 000000000..573541ac9
--- /dev/null
+++ b/tests/expected/lsns/netnsid
@@ -0,0 +1 @@
+0
diff --git a/tests/ts/lsns/netnsid b/tests/ts/lsns/netnsid
new file mode 100644
index 000000000..ad93dd49c
--- /dev/null
+++ b/tests/ts/lsns/netnsid
@@ -0,0 +1,65 @@
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
+TS_DESC="compare NETNSID reported by lsns and that by ip-link"
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
+vetha=lsns-vetha
+vethb=lsns-vethb
+NS=UTIL-LINUX-LSNS-TEST-NS
+FIFO=$TS_OUTDIR/UTIL-LINUX-LSNS-TEST-FIFO
+NULL=/dev/null
+
+ip netns delete $NS 2> $NULL || :
+ip link delete  $vetha 2> $NULL || :
+
+rm -f $FIFO
+mkfifo $FIFO
+
+if ip netns add $NS &&
+	ip link add name $vetha type veth peer name $vethb &&
+	ip link set $vethb netns $NS; then
+    ip netns exec $NS dd if=$FIFO bs=1 count=2 of=$NULL 2> $NULL &
+    PID=$!
+fi
+{
+    dd if=/dev/zero bs=1 count=1 2> $NULL
+    {
+	ip -o link show dev $vetha > $NULL
+	IP_ID=$(ip -o link show dev $vetha | sed -ne 's/.* *link-netnsid *\([0-9]*\)/\1/p')
+	LSNS_ID=$($TS_CMD_LSNS -n -o NETNSID --type net --task $PID | { read VAL; echo $VAL; } )
+    }
+    dd if=/dev/zero bs=1 count=1 2> $NULL
+} > $FIFO
+
+rm $FIFO
+ip link delete $vetha
+ip netns delete $NS
+
+test "$IP_ID" = "$LSNS_ID"
+echo $? >> $TS_OUTPUT
+
+ts_finalize
-- 
2.13.6

