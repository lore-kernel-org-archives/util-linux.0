Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:60764 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752184AbbDMMB5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 08:01:57 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0MHXd2-1YgXfM28Sq-003NZd for
 <util-linux@vger.kernel.org>; Mon, 13 Apr 2015 14:01:56 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 6/7] tests: add subtests for invalid logger devive
Date: Mon, 13 Apr 2015 14:01:52 +0200
Message-Id: <1428926513-25449-7-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
References: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Note --journald should not complain about invalid sockets.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/logger/errors-check_socket   | 2 ++
 tests/expected/logger/errors-invalid_socket | 2 ++
 tests/ts/logger/errors                      | 4 ++++
 tests/ts/logger/journald                    | 2 +-
 4 files changed, 9 insertions(+), 1 deletion(-)
 create mode 100644 tests/expected/logger/errors-invalid_socket

diff --git a/tests/expected/logger/errors-check_socket b/tests/expected/logger/errors-check_socket
index 76a877f..7367dc0 100644
--- a/tests/expected/logger/errors-check_socket
+++ b/tests/expected/logger/errors-check_socket
@@ -17,3 +17,5 @@ socket data, tag_with_space:
 <13>1 2009-02-13T23:31:30.123456+00:00 test-hostname A B - - [timeQuality tzKnown="1" isSynced="0"] tag_with_space_rfc5424
 socket data, rfc5424_msgid_with_space:
 
+socket data, invalid_socket:
+
diff --git a/tests/expected/logger/errors-invalid_socket b/tests/expected/logger/errors-invalid_socket
new file mode 100644
index 0000000..5720afa
--- /dev/null
+++ b/tests/expected/logger/errors-invalid_socket
@@ -0,0 +1,2 @@
+test_logger: socket /bad/boy: No such file or directory
+ret: 1
diff --git a/tests/ts/logger/errors b/tests/ts/logger/errors
index e0a02dc..0b232ec 100755
--- a/tests/ts/logger/errors
+++ b/tests/ts/logger/errors
@@ -75,6 +75,10 @@ ts_init_subtest "rfc5424_msgid_with_space"
 logger_fun -t "rfc5424_msgid_with_space" --rfc5424 --msgid="A B" "message"
 ts_finalize_subtest
 
+ts_init_subtest "invalid_socket"
+logger_fun -u /bad/boy -t "invalid_socket" "message"
+ts_finalize_subtest
+
 ts_init_subtest "check_socket"
 ts_log "Check written socket data of all subtests."
 sleep 1
diff --git a/tests/ts/logger/journald b/tests/ts/logger/journald
index 81296f7..c10824c 100755
--- a/tests/ts/logger/journald
+++ b/tests/ts/logger/journald
@@ -30,6 +30,6 @@ if ! $TS_HELPER_LOGGER --help | grep -q journald; then
 fi
 
 printf "%s\n%s\n%s\n" MESSAGE_ID=b8f74e14bc714bfc8040a5106dc9376a MESSAGE="a b c 1 2 3" |
-$TS_HELPER_LOGGER --no-act --journald --stderr > "$TS_OUTPUT" 2>&1
+$TS_HELPER_LOGGER -u /bad/boy --no-act --journald --stderr > "$TS_OUTPUT" 2>&1
 echo "ret: $?" >> "$TS_OUTPUT"
 ts_finalize
-- 
1.8.4.5

