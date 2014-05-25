Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:55693 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751092AbaEYV6b (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 May 2014 17:58:31 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so7298848wes.27
        for <util-linux@vger.kernel.org>; Sun, 25 May 2014 14:58:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/2] tests: add rename(1) checks
Date: Sun, 25 May 2014 22:58:23 +0100
Message-Id: <1401055103-28558-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1401055103-28558-1-git-send-email-kerolasa@iki.fi>
References: <1401055103-28558-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Check basic file moves, symlink relinking, and both file moves and
symlinks when operations are have directory in destination path.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh             |  1 +
 tests/expected/rename/basic   |  4 ++++
 tests/expected/rename/subdir  | 20 ++++++++++++++++++++
 tests/expected/rename/symlink |  3 +++
 tests/ts/rename/basic         | 40 ++++++++++++++++++++++++++++++++++++++++
 tests/ts/rename/subdir        | 41 +++++++++++++++++++++++++++++++++++++++++
 tests/ts/rename/symlink       | 40 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 149 insertions(+)
 create mode 100644 tests/expected/rename/basic
 create mode 100644 tests/expected/rename/subdir
 create mode 100644 tests/expected/rename/symlink
 create mode 100755 tests/ts/rename/basic
 create mode 100755 tests/ts/rename/subdir
 create mode 100755 tests/ts/rename/symlink

diff --git a/tests/commands.sh b/tests/commands.sh
index b541af0..23216c3 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -62,6 +62,7 @@ TS_CMD_MKSWAP=${TS_CMD_MKSWAP:-"$top_builddir/mkswap"}
 TS_CMD_MOUNT=${TS_CMD_MOUNT:-"$top_builddir/mount"}
 TS_CMD_NAMEI=${TS_CMD_NAMEI-"$top_builddir/namei"}
 TS_CMD_PARTX=${TS_CMD_PARTX-"$top_builddir/partx"}
+TS_CMD_RENAME=${TS_CMD_RENAME-"$top_builddir/rename"}
 TS_CMD_REV=${TS_CMD_REV:-"$top_builddir/rev"}
 TS_CMD_SCRIPT=${TS_CMD_SCRIPT-"$top_builddir/script"}
 TS_CMD_SETARCH=${TS_CMD_SETARCH-"$top_builddir/setarch"}
diff --git a/tests/expected/rename/basic b/tests/expected/rename/basic
new file mode 100644
index 0000000..8a7a1d8
--- /dev/null
+++ b/tests/expected/rename/basic
@@ -0,0 +1,4 @@
+`rename_basic.1' -> `rename_test.1'
+`rename_basic.2' -> `rename_test.2'
+`rename_basic.3' -> `rename_test.3'
+what is rename_basic.? doing here?
diff --git a/tests/expected/rename/subdir b/tests/expected/rename/subdir
new file mode 100644
index 0000000..a5b3dbe
--- /dev/null
+++ b/tests/expected/rename/subdir
@@ -0,0 +1,20 @@
+== files ==
+`rename_aa/aa' -> `rename_aa/xa'
+`rename_ab/aa' -> `rename_ab/xa'
+rename_aa
+rename_aa/xa
+rename_ab
+rename_ab/xa
+== symlinks ==
+rename_aa/sublink.1: `rename/aa' -> `renxme/aa'
+rename_aa/sublink.2: `rename/aa' -> `renxme/aa'
+rename_aa/sublink.3: `rename/aa' -> `renxme/aa'
+rename_ab/sublink.1: `rename/aa' -> `renxme/aa'
+rename_ab/sublink.2: `rename/aa' -> `renxme/aa'
+rename_ab/sublink.3: `rename/aa' -> `renxme/aa'
+renxme/aa
+renxme/aa
+renxme/aa
+renxme/aa
+renxme/aa
+renxme/aa
diff --git a/tests/expected/rename/symlink b/tests/expected/rename/symlink
new file mode 100644
index 0000000..38e687f
--- /dev/null
+++ b/tests/expected/rename/symlink
@@ -0,0 +1,3 @@
+rename_slink.1: `old' -> `new'
+rename_slink.2: `old' -> `new'
+rename_slink.3: `old' -> `new'
diff --git a/tests/ts/rename/basic b/tests/ts/rename/basic
new file mode 100755
index 0000000..d758952
--- /dev/null
+++ b/tests/ts/rename/basic
@@ -0,0 +1,40 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2014 Sami Kerola <kerolasa@iki.fi>
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
+TS_DESC="basic check"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_RENAME"
+
+touch rename_basic.{1..3}
+$TS_CMD_RENAME -v basic test rename_basic.? >> $TS_OUTPUT 2>&1
+
+for i in rename_basic.?; do
+	echo "what is $i doing here?" >> $TS_OUTPUT
+done
+for i in rename_test.{1..3}; do
+	if [ ! -f $i ]; then
+		echo "file $i is missing" >> $TS_OUTPUT
+	else
+		rm -f $i
+	fi
+done
+
+ts_finalize
diff --git a/tests/ts/rename/subdir b/tests/ts/rename/subdir
new file mode 100755
index 0000000..2225f23
--- /dev/null
+++ b/tests/ts/rename/subdir
@@ -0,0 +1,41 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2014 Sami Kerola <kerolasa@iki.fi>
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
+TS_DESC="subdir check"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_RENAME"
+
+echo "== files ==" >> $TS_OUTPUT
+mkdir rename_a{a,b}
+touch rename_a{a,b}/aa
+$TS_CMD_RENAME -v a x rename_a?/aa >> $TS_OUTPUT 2>&1
+find rename_a{a,b} >> $TS_OUTPUT 2>&1
+
+echo "== symlinks ==" >> $TS_OUTPUT
+for i in rename_a{a,b}/sublink.{1..3}; do
+	ln -s rename/aa $i
+done
+$TS_CMD_RENAME -s -v a x rename_a{a,b}/sublink.? >> $TS_OUTPUT 2>&1
+readlink rename_a{a,b}/sublink.?  >> $TS_OUTPUT 2>&1
+
+rm -rf rename_a{a,b}
+
+ts_finalize
diff --git a/tests/ts/rename/symlink b/tests/ts/rename/symlink
new file mode 100755
index 0000000..28db1bb
--- /dev/null
+++ b/tests/ts/rename/symlink
@@ -0,0 +1,40 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2014 Sami Kerola <kerolasa@iki.fi>
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
+TS_DESC="symlink check"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_RENAME"
+
+for i in rename_slink.{1..3}; do
+	ln -s old $i
+done
+
+$TS_CMD_RENAME -s -v old new rename_slink.? >> $TS_OUTPUT 2>&1
+
+for i in rename_slink.{1..3}; do
+	where="$(readlink $i)"
+	if [ "$where" != "new" ]; then
+		echo "error: $i points to $where" >> $TS_OUTPUT
+	fi
+	rm -f $i
+done
+
+ts_finalize
-- 
1.9.3

