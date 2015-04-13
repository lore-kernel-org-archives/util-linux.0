Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:54922 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751820AbbDMMB6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 08:01:58 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LaXmV-1Z5wmi3h8h-00mN5q for
 <util-linux@vger.kernel.org>; Mon, 13 Apr 2015 14:01:56 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 4/7] tests: logger, validate written socket data
Date: Mon, 13 Apr 2015 14:01:50 +0200
Message-Id: <1428926513-25449-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
References: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Actually there should be no data written to the socket because
we are always using --no-act.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/logger/errors-check_socket  | 1 +
 tests/expected/logger/formats-check_socket | 1 +
 tests/expected/logger/options-check_socket | 1 +
 tests/ts/logger/errors                     | 5 +++++
 tests/ts/logger/formats                    | 5 +++++
 tests/ts/logger/options                    | 5 +++++
 6 files changed, 18 insertions(+)
 create mode 100644 tests/expected/logger/errors-check_socket
 create mode 100644 tests/expected/logger/formats-check_socket
 create mode 100644 tests/expected/logger/options-check_socket

diff --git a/tests/expected/logger/errors-check_socket b/tests/expected/logger/errors-check_socket
new file mode 100644
index 0000000..fa36c4e
--- /dev/null
+++ b/tests/expected/logger/errors-check_socket
@@ -0,0 +1 @@
+Check written socket data of all subtests.
diff --git a/tests/expected/logger/formats-check_socket b/tests/expected/logger/formats-check_socket
new file mode 100644
index 0000000..fa36c4e
--- /dev/null
+++ b/tests/expected/logger/formats-check_socket
@@ -0,0 +1 @@
+Check written socket data of all subtests.
diff --git a/tests/expected/logger/options-check_socket b/tests/expected/logger/options-check_socket
new file mode 100644
index 0000000..fa36c4e
--- /dev/null
+++ b/tests/expected/logger/options-check_socket
@@ -0,0 +1 @@
+Check written socket data of all subtests.
diff --git a/tests/ts/logger/errors b/tests/ts/logger/errors
index 2dfb410..8df97c8 100755
--- a/tests/ts/logger/errors
+++ b/tests/ts/logger/errors
@@ -72,7 +72,12 @@ ts_init_subtest "rfc5424_msgid_with_space"
 logger_fun -t "rfc5424_msgid_with_space" --rfc5424 --msgid="A B" "message"
 ts_finalize_subtest
 
+ts_init_subtest "check_socket"
+ts_log "Check written socket data of all subtests."
 sleep 1
 kill $SOCAT_PID
+wait $SOCAT_PID &>/dev/null
+cat "$SOCKIN" >> "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
 
 ts_finalize
diff --git a/tests/ts/logger/formats b/tests/ts/logger/formats
index 203c4d6..5957fea 100755
--- a/tests/ts/logger/formats
+++ b/tests/ts/logger/formats
@@ -68,7 +68,12 @@ for facility in auth authpriv cron daemon ftp lpr mail news syslog user uucp loc
 done
 ts_finalize_subtest
 
+ts_init_subtest "check_socket"
+ts_log "Check written socket data of all subtests."
 sleep 1
 kill $SOCAT_PID
+wait $SOCAT_PID &>/dev/null
+cat "$SOCKIN" >> "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
 
 ts_finalize
diff --git a/tests/ts/logger/options b/tests/ts/logger/options
index c77c655..afcf5f8 100755
--- a/tests/ts/logger/options
+++ b/tests/ts/logger/options
@@ -69,7 +69,12 @@ for i in "${tests_array[@]}"; do
 	ts_finalize_subtest
 done
 
+ts_init_subtest "check_socket"
+ts_log "Check written socket data of all subtests."
 sleep 1
 kill $SOCAT_PID
+wait $SOCAT_PID &>/dev/null
+cat "$SOCKIN" >> "$TS_OUTPUT" 2>&1
+ts_finalize_subtest
 
 ts_finalize
-- 
1.8.4.5

