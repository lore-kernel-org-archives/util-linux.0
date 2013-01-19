Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:55439 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755248Ab3ASAJl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:41 -0500
Received: by mail-wg0-f52.google.com with SMTP id 12so154177wgh.7
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:40 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/22] tests: add more(1) check
Date: Sat, 19 Jan 2013 00:08:59 +0000
Message-Id: <1358554151-25985-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh           |  1 +
 tests/expected/more/regexp  |  4 ++++
 tests/expected/more/squeeze |  3 +++
 tests/ts/more/regexp        | 24 ++++++++++++++++++++++++
 tests/ts/more/squeeze       | 24 ++++++++++++++++++++++++
 5 files changed, 56 insertions(+)
 create mode 100644 tests/expected/more/regexp
 create mode 100644 tests/expected/more/squeeze
 create mode 100755 tests/ts/more/regexp
 create mode 100755 tests/ts/more/squeeze

diff --git a/tests/commands.sh b/tests/commands.sh
index c5f7140..dad7010 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -71,3 +71,4 @@ TS_CMD_MCOOKIE=${TS_CMD_MCOOKIE-"$top_builddir/mcookie"}
 TS_CMD_TAILF=${TS_CMD_TAILF-"$top_builddir/tailf"}
 TS_CMD_UL=${TS_CMD_UL-"$top_builddir/ul"}
 TS_CMD_IONICE=${TS_CMD_IONICE-"$top_builddir/ionice"}
+TS_CMD_MORE=${TS_CMD_MORE-"$top_builddir/more"}
diff --git a/tests/expected/more/regexp b/tests/expected/more/regexp
new file mode 100644
index 0000000..e88c99b
--- /dev/null
+++ b/tests/expected/more/regexp
@@ -0,0 +1,4 @@
+
+...skipping
+foo
+xyzzy
diff --git a/tests/expected/more/squeeze b/tests/expected/more/squeeze
new file mode 100644
index 0000000..a1a53b5
--- /dev/null
+++ b/tests/expected/more/squeeze
@@ -0,0 +1,3 @@
+a
+
+b
diff --git a/tests/ts/more/regexp b/tests/ts/more/regexp
new file mode 100755
index 0000000..af2ccc7
--- /dev/null
+++ b/tests/ts/more/regexp
@@ -0,0 +1,24 @@
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
+TS_DESC="regexp"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+printf "abba\nbar\nfoo\nxyzzy\n" |
+	MORE='-n' $TS_CMD_MORE +/foo > $TS_OUTPUT 2>&1
+
+ts_finalize
diff --git a/tests/ts/more/squeeze b/tests/ts/more/squeeze
new file mode 100755
index 0000000..2aeb053
--- /dev/null
+++ b/tests/ts/more/squeeze
@@ -0,0 +1,24 @@
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
+TS_DESC="squeeze"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+printf "a\n\n\nb\n" |
+	MORE='-n' $TS_CMD_MORE -s > $TS_OUTPUT 2>&1
+
+ts_finalize
-- 
1.8.1.1

