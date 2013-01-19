Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:45009 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754454Ab3ASAJ1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 18 Jan 2013 19:09:27 -0500
Received: by mail-wg0-f44.google.com with SMTP id dr12so2460806wgb.23
        for <util-linux@vger.kernel.org>; Fri, 18 Jan 2013 16:09:25 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/22] tests: add getopt(1) check
Date: Sat, 19 Jan 2013 00:08:53 +0000
Message-Id: <1358554151-25985-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
References: <1358554151-25985-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/commands.sh          |  1 +
 tests/expected/misc/getopt |  9 +++++++++
 tests/ts/misc/getopt       | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 56 insertions(+)
 create mode 100644 tests/expected/misc/getopt
 create mode 100755 tests/ts/misc/getopt

diff --git a/tests/commands.sh b/tests/commands.sh
index 73725c9..cb2f444 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -66,3 +66,4 @@ TS_CMD_FDISK=${TS_CMD_FDISK-"$top_builddir/fdisk"}
 TS_CMD_HEXDUMP=${TS_CMD_HEXDUMP-"$top_builddir/hexdump"}
 
 TS_CMD_UTMPDUMP=${TS_CMD_UTMPDUMP-"$top_builddir/utmpdump"}
+TS_CMD_GETOPT=${TS_CMD_GETOPT-"$top_builddir/getopt"}
diff --git a/tests/expected/misc/getopt b/tests/expected/misc/getopt
new file mode 100644
index 0000000..c2c90ae
--- /dev/null
+++ b/tests/expected/misc/getopt
@@ -0,0 +1,9 @@
+Option a
+Option b, argument `1'
+Option c, argument `2'
+Option a
+Option b, argument `3'
+Option c, no argument
+Remaining arguments:
+--> `foo'
+--> `bar'
diff --git a/tests/ts/misc/getopt b/tests/ts/misc/getopt
new file mode 100755
index 0000000..a6b91cb
--- /dev/null
+++ b/tests/ts/misc/getopt
@@ -0,0 +1,46 @@
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
+# This test script is modified version of 'getopt-parse.bash' example
+# file in misc/ directory.
+
+TS_TOPDIR="$(dirname $0)/../.."
+TS_DESC="getopt"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+TEMP=$($TS_CMD_GETOPT -o ab:c:: --long a-long,b-long:,c-long:: -n 'example.bash' -- -a -b 1 -c2  --a-long --b-long 3 --c-long foo bar)
+
+if [ $? != 0 ] ; then echo "Terminating..." >&2 ; exit 1 ; fi
+
+eval set -- "$TEMP"
+
+while true ; do
+	case "$1" in
+		-a|--a-long) echo "Option a" >> $TS_OUTPUT 2>&1; shift ;;
+		-b|--b-long) echo "Option b, argument \`$2'" >> $TS_OUTPUT 2>&1; shift 2 ;;
+		-c|--c-long)
+			case "$2" in
+				"") echo "Option c, no argument" >> $TS_OUTPUT 2>&1; shift 2 ;;
+				*)  echo "Option c, argument \`$2'" >> $TS_OUTPUT 2>&1; shift 2 ;;
+			esac ;;
+		--) shift ; break ;;
+		*) echo "Internal error!" >> $TS_OUTPUT 2>&1; exit 1 ;;
+	esac
+done
+echo "Remaining arguments:" >> $TS_OUTPUT 2>&1
+for arg do echo '--> '"\`$arg'" >> $TS_OUTPUT 2>&1; done
+
+ts_finalize
-- 
1.8.1.1

