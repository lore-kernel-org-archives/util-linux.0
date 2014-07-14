Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:58408 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756709AbaGNRhW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 14 Jul 2014 13:37:22 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so2027029wiw.0
        for <util-linux@vger.kernel.org>; Mon, 14 Jul 2014 10:37:21 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] tests: add kill --queue check
Date: Mon, 14 Jul 2014 18:37:17 +0100
Message-Id: <1405359437-6288-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/kill/queue       |  1 +
 tests/helpers/test_sigreceive.c | 17 +++++++++----
 tests/ts/kill/options           |  2 --
 tests/ts/kill/queue             | 53 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 7 deletions(-)
 create mode 100644 tests/expected/kill/queue
 create mode 100755 tests/ts/kill/queue

diff --git a/tests/expected/kill/queue b/tests/expected/kill/queue
new file mode 100644
index 0000000..d48ce72
--- /dev/null
+++ b/tests/expected/kill/queue
@@ -0,0 +1 @@
+all ok
diff --git a/tests/helpers/test_sigreceive.c b/tests/helpers/test_sigreceive.c
index 3f76f06..daa290e 100644
--- a/tests/helpers/test_sigreceive.c
+++ b/tests/helpers/test_sigreceive.c
@@ -38,9 +38,16 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 }
 
 static __attribute__((__noreturn__))
-void exiter(int sig)
+void exiter(int signo __attribute__((__unused__)),
+	    siginfo_t *info,
+	    void *context __attribute__((__unused__)))
 {
-	_exit(sig);
+	int ret = info->si_signo;
+
+	if (info)
+		if (info->si_code == SI_QUEUE && info->si_value.sival_int != 0)
+			ret = info->si_value.sival_int;
+	_exit(ret);
 }
 
 int main(int argc, char **argv)
@@ -81,8 +88,8 @@ int main(int argc, char **argv)
 	}
 
 	sigemptyset(&sigact.sa_mask);
-	sigact.sa_flags = 0;
-	sigact.sa_handler = exiter;
+	sigact.sa_flags = SA_SIGINFO;
+	sigact.sa_sigaction = exiter;
 	timeout.tv_sec = 5;
 	timeout.tv_usec = 0;
 
@@ -171,5 +178,5 @@ int main(int argc, char **argv)
 	FD_SET(STDIN_FILENO, &rfds);
 	select(0, &rfds, NULL, NULL, &timeout);
 
-	exiter(TEST_SIGRECEIVE_FAILURE);
+	exiter(TEST_SIGRECEIVE_FAILURE, NULL, NULL);
 }
diff --git a/tests/ts/kill/options b/tests/ts/kill/options
index 5af78d9..2c82bbc 100755
--- a/tests/ts/kill/options
+++ b/tests/ts/kill/options
@@ -51,8 +51,6 @@ try_option -s 1
 try_option --signal 1
 try_option --signal HUP
 try_option --signal SIGHUP
-try_option -s 1 -q 42
-try_option -s 1 --queue 42
 try_option -1
 try_option -HUP
 try_option -SIGHUP
diff --git a/tests/ts/kill/queue b/tests/ts/kill/queue
new file mode 100755
index 0000000..992acf7
--- /dev/null
+++ b/tests/ts/kill/queue
@@ -0,0 +1,53 @@
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
+TS_DESC="queue"
+
+. "$TS_TOPDIR/functions.sh"
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_KILL"
+ts_check_test_command "$TS_HELPER_SIGRECEIVE"
+
+. "$TS_SELF/kill_functions.sh"
+
+all_ok=true
+
+HELPER_SYMLINK="$(mktemp "${TS_OUTDIR}/quXXXXXXXXXXXXX")"
+ln -sf "$TS_HELPER_SIGRECEIVE" "$HELPER_SYMLINK"
+
+"$HELPER_SYMLINK" >> "$TS_OUTPUT" 2>&1 &
+TEST_PID=$!
+check_test_sigreceive $TEST_PID
+[ $? -eq 1 ] || echo "${HELPER_SYMLINK##*/} helper did not start" >> "$TS_OUTPUT"
+
+"$TS_CMD_KILL" -1 --queue 42 $TEST_PID >> "$TS_OUTPUT" 2>&1
+if [ $? -ne 0 ]; then
+	echo "kill --queue 42 failed" >> "$TS_OUTPUT"
+	all_ok=false
+fi
+wait $TEST_PID
+if [ $? -ne 42 ]; then
+	echo "wait $TEST_PID returned $? instead of 42" >> "$TS_OUTPUT"
+	all_ok=false
+fi
+
+if $all_ok; then
+	echo 'all ok' >> "$TS_OUTPUT"
+fi
+
+rm -f "$HELPER_SYMLINK"
+
+ts_finalize
-- 
2.0.1

