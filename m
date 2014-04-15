Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:41131 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752068AbaDOLPx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 07:15:53 -0400
Received: by mail-wi0-f180.google.com with SMTP id q5so5468962wiv.13
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 04:15:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH 5/9] tests: check various ways to specify kill signal
Date: Tue, 15 Apr 2014 12:15:31 +0100
Message-Id: <1397560535-14622-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

CC: Bernhard Voelker <mail@bernhard-voelker.de>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/kill/options |  1 +
 tests/ts/kill/options       | 66 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)
 create mode 100644 tests/expected/kill/options
 create mode 100755 tests/ts/kill/options

diff --git a/tests/expected/kill/options b/tests/expected/kill/options
new file mode 100644
index 0000000..d48ce72
--- /dev/null
+++ b/tests/expected/kill/options
@@ -0,0 +1 @@
+all ok
diff --git a/tests/ts/kill/options b/tests/ts/kill/options
new file mode 100755
index 0000000..70ae7da
--- /dev/null
+++ b/tests/ts/kill/options
@@ -0,0 +1,66 @@
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
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="options"
+
+. "$TS_TOPDIR/functions.sh"
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_KILL"
+all_ok=true
+
+TS_CWD="${0%/*}"
+HELPER_SYMLINK="$TS_CWD/$(mktemp -u XXXXXXXXXXXXXXX)"
+ln -s "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
+trap "rm -f $HELPER_SYMLINK" 0
+
+try_option()
+{
+	"$HELPER_SYMLINK" "$TS_CWD" >> "$TS_OUTPUT" 2>&1 &
+	TEST_PID=$!
+	# test_sigreceive needs time to start up
+	up=0
+	for i in 0.01 0.1 1 1 1 1; do
+		test -f "$TS_CWD/$TEST_PID" && { up=1; break; }
+		sleep $i
+	done
+	test $up = 1 || echo "$@ sigreceive helper did not start" >> "$TS_OUTPUT"
+	"$TS_CMD_KILL" "$@" $TEST_PID >> "$TS_OUTPUT" 2>&1
+	if [ $? -ne 0 ]; then
+		echo "kill $@ did not work" >> "$TS_OUTPUT"
+		all_ok=false
+	fi
+	wait $TEST_PID
+	if [ $? -ne 1 ]; then
+		echo "wait $TEST_PID for $@ did not work" >> "$TS_OUTPUT"
+		all_ok=false
+	fi
+}
+
+try_option -s 1
+try_option --signal 1
+try_option --signal HUP
+try_option --signal SIGHUP
+try_option -q HUP
+try_option --queue HUP
+try_option -1
+try_option -HUP
+try_option -SIGHUP
+
+if $all_ok; then
+	echo 'all ok' >> "$TS_OUTPUT"
+fi
+
+ts_finalize
-- 
1.9.2

