Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:63158 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752141AbbDMMB5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 08:01:57 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0Lomql-1ZI3js2yRn-00grKM for
 <util-linux@vger.kernel.org>; Mon, 13 Apr 2015 14:01:55 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 3/7] tests: logger with socat device
Date: Mon, 13 Apr 2015 14:01:49 +0200
Message-Id: <1428926513-25449-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
References: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/functions.sh      | 29 +++++++++++++++++++++++++++++
 tests/ts/logger/errors  | 10 +++++++++-
 tests/ts/logger/formats | 10 +++++++++-
 tests/ts/logger/options | 16 ++++++++++++++--
 4 files changed, 61 insertions(+), 4 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index 55b9273..44e087c 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -652,3 +652,32 @@ function ts_resolve_host {
 	test -n "$tmp" || return 1
 	echo "$tmp" | sort -R | head -n 1
 }
+
+# listen to unix socket (background socat)
+function ts_init_socket_to_file {
+	local socket=$1
+	local outfile=$2
+	local pid="0"
+
+	ts_check_prog "socat"
+	rm -f "$socket" "$outfile"
+
+	socat -u UNIX-LISTEN:$socket,fork,max-children=1,backlog=128 \
+		STDOUT > "$outfile" &
+	pid=$!
+
+	# check for running background process
+	if [ "$pid" -le "0" ] || ! kill -s 0 "$pid"; then
+		ts_skip "unable to run socat"
+	fi
+	# wait for the socket listener
+	if ! socat -u /dev/null UNIX-CONNECT:$socket,retry=30,interval=0.1; then
+		kill -9 "$pid"
+		ts_skip "timeout waiting for socket"
+	fi
+	# check socket again
+	if ! socat -u /dev/null UNIX-CONNECT:$socket; then
+		kill -9 "$pid"
+		ts_skip "socket stopped listening"
+	fi
+}
diff --git a/tests/ts/logger/errors b/tests/ts/logger/errors
index debce7e..2dfb410 100755
--- a/tests/ts/logger/errors
+++ b/tests/ts/logger/errors
@@ -30,8 +30,13 @@ export LOGGER_TEST_TIMEOFDAY="1234567890.123456"
 export LOGGER_TEST_HOSTNAME="test-hostname"
 export LOGGER_TEST_GETPID="98765"
 
+DEVLOG="${TS_OUTDIR}/${TS_TESTNAME}_devlog"
+SOCKIN="${TS_OUTDIR}/${TS_TESTNAME}_socketin"
+ts_init_socket_to_file $DEVLOG $SOCKIN
+SOCAT_PID="$!"
+
 function logger_fun {
-	$TS_HELPER_LOGGER -s --no-act "$@" >> "$TS_OUTPUT" 2>&1
+	$TS_HELPER_LOGGER -u $DEVLOG -s --no-act "$@" >> "$TS_OUTPUT" 2>&1
 	echo "ret: $?" >> "$TS_OUTPUT"
 }
 
@@ -67,4 +72,7 @@ ts_init_subtest "rfc5424_msgid_with_space"
 logger_fun -t "rfc5424_msgid_with_space" --rfc5424 --msgid="A B" "message"
 ts_finalize_subtest
 
+sleep 1
+kill $SOCAT_PID
+
 ts_finalize
diff --git a/tests/ts/logger/formats b/tests/ts/logger/formats
index d0e9d5c..203c4d6 100755
--- a/tests/ts/logger/formats
+++ b/tests/ts/logger/formats
@@ -30,8 +30,13 @@ export LOGGER_TEST_TIMEOFDAY="1234567890.123456"
 export LOGGER_TEST_HOSTNAME="test-hostname"
 export LOGGER_TEST_GETPID="98765"
 
+DEVLOG="${TS_OUTDIR}/${TS_TESTNAME}_devlog"
+SOCKIN="${TS_OUTDIR}/${TS_TESTNAME}_socketin"
+ts_init_socket_to_file $DEVLOG $SOCKIN
+SOCAT_PID="$!"
+
 function logger_fun {
-	$TS_HELPER_LOGGER -s --no-act "$@" >> "$TS_OUTPUT" 2>&1
+	$TS_HELPER_LOGGER -u $DEVLOG -s --no-act "$@" >> "$TS_OUTPUT" 2>&1
 	echo "ret: $?" >> "$TS_OUTPUT"
 }
 
@@ -63,4 +68,7 @@ for facility in auth authpriv cron daemon ftp lpr mail news syslog user uucp loc
 done
 ts_finalize_subtest
 
+sleep 1
+kill $SOCAT_PID
+
 ts_finalize
diff --git a/tests/ts/logger/options b/tests/ts/logger/options
index 6bd3236..c77c655 100755
--- a/tests/ts/logger/options
+++ b/tests/ts/logger/options
@@ -50,14 +50,26 @@ export LOGGER_TEST_TIMEOFDAY="1234567890.123456"
 export LOGGER_TEST_HOSTNAME="test-hostname"
 export LOGGER_TEST_GETPID="98765"
 
+DEVLOG="${TS_OUTDIR}/${TS_TESTNAME}_devlog"
+SOCKIN="${TS_OUTDIR}/${TS_TESTNAME}_socketin"
+ts_init_socket_to_file $DEVLOG $SOCKIN
+SOCAT_PID="$!"
+
+function logger_fun {
+	$TS_HELPER_LOGGER -u $DEVLOG --stderr --no-act "$@" >> "$TS_OUTPUT" 2>&1
+	echo "ret: $?" >> "$TS_OUTPUT"
+}
+
 for i in "${tests_array[@]}"; do
 	name="${i%%:*}"
 	options="${i##*:}"
 
 	ts_init_subtest "$name"
-	$TS_HELPER_LOGGER --stderr --no-act -t "test_tag" $options > "$TS_OUTPUT" 2>&1
-	echo "ret: $?" >> "$TS_OUTPUT" 
+	logger_fun -t "test_tag" $options
 	ts_finalize_subtest
 done
 
+sleep 1
+kill $SOCAT_PID
+
 ts_finalize
-- 
1.8.4.5

