Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:60759 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754142Ab3ASAKH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:10:07 -0500
Received: by mail-wg0-f49.google.com with SMTP id 15so2459210wgd.28
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:10:05 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 21/22] tests: add ipcmk(1) and ipcrm(1) checks
Date: Sat, 19 Jan 2013 00:09:10 +0000
Message-Id: <1358554151-25985-22-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh             |  2 ++
 tests/expected/ipcs/mk-rm-msg |  2 ++
 tests/expected/ipcs/mk-rm-sem |  2 ++
 tests/expected/ipcs/mk-rm-shm |  2 ++
 tests/ts/ipcs/functions.sh    | 17 +++++++++++++++++
 tests/ts/ipcs/mk-rm-msg       | 36 ++++++++++++++++++++++++++++++++++++
 tests/ts/ipcs/mk-rm-sem       | 36 ++++++++++++++++++++++++++++++++++++
 tests/ts/ipcs/mk-rm-shm       | 36 ++++++++++++++++++++++++++++++++++++
 8 files changed, 133 insertions(+)
 create mode 100644 tests/expected/ipcs/mk-rm-msg
 create mode 100644 tests/expected/ipcs/mk-rm-sem
 create mode 100644 tests/expected/ipcs/mk-rm-shm
 create mode 100755 tests/ts/ipcs/mk-rm-msg
 create mode 100755 tests/ts/ipcs/mk-rm-sem
 create mode 100755 tests/ts/ipcs/mk-rm-shm

diff --git a/tests/commands.sh b/tests/commands.sh
index 4792ce1..3138fbf 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -79,3 +79,5 @@ TS_CMD_SETARCH=${TS_CMD_SETARCH-"$top_builddir/setarch"}
 TS_CMD_FALLOCATE=${TS_CMD_FALLOCATE-"$top_builddir/fallocate"}
 TS_CMD_ISOSIZE=${TS_CMD_ISOSIZE-"$top_builddir/isosize"}
 TS_CMD_WHEREIS=${TS_CMD_WHEREIS-"$top_builddir/whereis"}
+TS_CMD_IPCMK=${TS_CMD_IPCMK-"$top_builddir/ipcmk"}
+TS_CMD_IPCRM=${TS_CMD_IPCRM-"$top_builddir/ipcrm"}
diff --git a/tests/expected/ipcs/mk-rm-msg b/tests/expected/ipcs/mk-rm-msg
new file mode 100644
index 0000000..8a82b94
--- /dev/null
+++ b/tests/expected/ipcs/mk-rm-msg
@@ -0,0 +1,2 @@
+Message queue id: <was_number>
+Message queue id: <was_number>
diff --git a/tests/expected/ipcs/mk-rm-sem b/tests/expected/ipcs/mk-rm-sem
new file mode 100644
index 0000000..a9c3f46
--- /dev/null
+++ b/tests/expected/ipcs/mk-rm-sem
@@ -0,0 +1,2 @@
+Semaphore id: <was_number>
+Semaphore id: <was_number>
diff --git a/tests/expected/ipcs/mk-rm-shm b/tests/expected/ipcs/mk-rm-shm
new file mode 100644
index 0000000..49d5867
--- /dev/null
+++ b/tests/expected/ipcs/mk-rm-shm
@@ -0,0 +1,2 @@
+Shared memory id: <was_number>
+Shared memory id: <was_number>
diff --git a/tests/ts/ipcs/functions.sh b/tests/ts/ipcs/functions.sh
index 24ea445..297d34f 100644
--- a/tests/ts/ipcs/functions.sh
+++ b/tests/ts/ipcs/functions.sh
@@ -81,3 +81,20 @@ function ipcs_limits_check {
 	done
 }
 
+# Read 'ipcmk' output, such as 'Shared memory id: 22839299' and
+# write the message to two files: (1) something what one can
+# compare as test output, and (2) id which ipcrm later will use
+# for deletion.
+ipcmk_output_handler() {
+	awk -v text=$1 -v num=$2 '
+	function isnum(x) {
+		return(x == x + 0)
+	}
+	{
+		if (isnum($NF)) {
+			print $NF >> num
+			$NF="<was_number>"
+		}
+		print $0 >> text
+	}'
+}
diff --git a/tests/ts/ipcs/mk-rm-msg b/tests/ts/ipcs/mk-rm-msg
new file mode 100755
index 0000000..21ecb9c
--- /dev/null
+++ b/tests/ts/ipcs/mk-rm-msg
@@ -0,0 +1,36 @@
+#!/bin/bash
+
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
+
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="mk-rm-msg"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+. $TS_SELF/functions.sh
+
+rm -f $TS_SELF/id-msg
+$TS_CMD_IPCMK -Q 2>>$TS_OUTPUT | ipcmk_output_handler $TS_OUTPUT $TS_SELF/id-msg
+$TS_CMD_IPCRM -q $(cat $TS_SELF/id-msg) >>$TS_OUTPUT 2>&1
+
+rm -f $TS_SELF/id-msg
+$TS_CMD_IPCMK -Q 2>>$TS_OUTPUT | ipcmk_output_handler $TS_OUTPUT $TS_SELF/id-msg
+$TS_CMD_IPCRM -Q $(
+	$TS_CMD_IPCS -q |
+	awk -v id=$(cat $TS_SELF/id-msg) '{if ($2 == id){print $1}}'
+) >>$TS_OUTPUT 2>&1
+
+rm -f $TS_SELF/id-msg
+
+ts_finalize
diff --git a/tests/ts/ipcs/mk-rm-sem b/tests/ts/ipcs/mk-rm-sem
new file mode 100755
index 0000000..754940b
--- /dev/null
+++ b/tests/ts/ipcs/mk-rm-sem
@@ -0,0 +1,36 @@
+#!/bin/bash
+
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
+
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="mk-rm-sem"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+. $TS_SELF/functions.sh
+
+rm -f $TS_SELF/id-sem
+$TS_CMD_IPCMK -S 1 2>>$TS_OUTPUT | ipcmk_output_handler $TS_OUTPUT $TS_SELF/id-sem
+$TS_CMD_IPCRM -s $(cat $TS_SELF/id-sem) >>$TS_OUTPUT 2>&1
+
+rm -f $TS_SELF/id-sem
+$TS_CMD_IPCMK -S 1 2>>$TS_OUTPUT | ipcmk_output_handler $TS_OUTPUT $TS_SELF/id-sem
+$TS_CMD_IPCRM -S $(
+	$TS_CMD_IPCS -s |
+	awk -v id=$(cat $TS_SELF/id-sem) '{if ($2 == id){print $1}}'
+) >>$TS_OUTPUT 2>&1
+
+rm -f $TS_SELF/id-sem
+
+ts_finalize
diff --git a/tests/ts/ipcs/mk-rm-shm b/tests/ts/ipcs/mk-rm-shm
new file mode 100755
index 0000000..707d359
--- /dev/null
+++ b/tests/ts/ipcs/mk-rm-shm
@@ -0,0 +1,36 @@
+#!/bin/bash
+
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
+
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="mk-rm-shm"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+. $TS_SELF/functions.sh
+
+rm -f $TS_SELF/id-shm
+$TS_CMD_IPCMK -M 1 2>>$TS_OUTPUT | ipcmk_output_handler $TS_OUTPUT $TS_SELF/id-shm
+$TS_CMD_IPCRM -m $(cat $TS_SELF/id-shm) >>$TS_OUTPUT 2>&1
+rm -f $TS_SELF/id-shm
+
+$TS_CMD_IPCMK -M 1 2>>$TS_OUTPUT | ipcmk_output_handler $TS_OUTPUT $TS_SELF/id-shm
+$TS_CMD_IPCRM -M $(
+	$TS_CMD_IPCS -m |
+	awk -v id=$(cat $TS_SELF/id-shm) '{if ($2 == id){print $1}}'
+) >>$TS_OUTPUT 2>&1
+
+rm -f $TS_SELF/id-shm
+
+ts_finalize
-- 
1.8.1.1

