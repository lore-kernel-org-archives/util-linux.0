Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50837 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751917AbbDMMB5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 08:01:57 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LikyX-1ZFKSE2ExR-00czRM for
 <util-linux@vger.kernel.org>; Mon, 13 Apr 2015 14:01:55 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 2/7] tests: simplify common logger options
Date: Mon, 13 Apr 2015 14:01:48 +0200
Message-Id: <1428926513-25449-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
References: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/logger/errors  | 32 ++++++++++++++------------------
 tests/ts/logger/formats | 26 ++++++++++++++------------
 2 files changed, 28 insertions(+), 30 deletions(-)

diff --git a/tests/ts/logger/errors b/tests/ts/logger/errors
index c50b3e5..debce7e 100755
--- a/tests/ts/logger/errors
+++ b/tests/ts/logger/errors
@@ -30,45 +30,41 @@ export LOGGER_TEST_TIMEOFDAY="1234567890.123456"
 export LOGGER_TEST_HOSTNAME="test-hostname"
 export LOGGER_TEST_GETPID="98765"
 
+function logger_fun {
+	$TS_HELPER_LOGGER -s --no-act "$@" >> "$TS_OUTPUT" 2>&1
+	echo "ret: $?" >> "$TS_OUTPUT"
+}
+
 ts_init_subtest "kern_priority"
-$TS_HELPER_LOGGER --no-act -s -t "prio" -p kern.emerg "message" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "prio" -p kern.emerg "message"
 ts_finalize_subtest
 
 ts_init_subtest "kern_priority_numeric"
-$TS_HELPER_LOGGER --no-act -s -t "prio" -p 0 "message" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "prio" -p 0 "message"
 ts_finalize_subtest
 
 ts_init_subtest "invalid_prio"
-$TS_HELPER_LOGGER --no-act -s -t "prio" -p 8 "message" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "prio" -p 8 "message"
 ts_finalize_subtest
 
 # should truncate
 ts_init_subtest "rfc5424_exceed_size"
-$TS_HELPER_LOGGER --no-act -s -t "rfc5424_exceed_size" --rfc5424 --size 3 "abcd" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "rfc5424_exceed_size" --rfc5424 --size 3 "abcd"
 ts_finalize_subtest
 
 ts_init_subtest "id_with_space"
-$TS_HELPER_LOGGER --no-act -s -t "id_with_space" --id="A B" "message" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
-$TS_HELPER_LOGGER --no-act -s -t "rfc5424_id_with_space" --rfc5424 --id="A B" "message" >> "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "id_with_space" --id="A B" "message"
+logger_fun -t "rfc5424_id_with_space" --rfc5424 --id="A B" "message"
 ts_finalize_subtest
 
 # should not fail
 ts_init_subtest "tag_with_space"
-$TS_HELPER_LOGGER --no-act -s -t "A B" "tag_with_space" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
-$TS_HELPER_LOGGER --no-act -s -t "A B" --rfc5424 "tag_with_space_rfc5424" >> "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "A B" "tag_with_space"
+logger_fun -t "A B" --rfc5424 "tag_with_space_rfc5424"
 ts_finalize_subtest
 
 ts_init_subtest "rfc5424_msgid_with_space"
-$TS_HELPER_LOGGER --no-act -s -t "rfc5424_msgid_with_space" --rfc5424 --msgid="A B" "message" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "rfc5424_msgid_with_space" --rfc5424 --msgid="A B" "message"
 ts_finalize_subtest
 
 ts_finalize
diff --git a/tests/ts/logger/formats b/tests/ts/logger/formats
index a647b81..d0e9d5c 100755
--- a/tests/ts/logger/formats
+++ b/tests/ts/logger/formats
@@ -30,33 +30,35 @@ export LOGGER_TEST_TIMEOFDAY="1234567890.123456"
 export LOGGER_TEST_HOSTNAME="test-hostname"
 export LOGGER_TEST_GETPID="98765"
 
+function logger_fun {
+	$TS_HELPER_LOGGER -s --no-act "$@" >> "$TS_OUTPUT" 2>&1
+	echo "ret: $?" >> "$TS_OUTPUT"
+}
+
 ts_init_subtest "rfc3164"
-$TS_HELPER_LOGGER -s --no-act -t "rfc3164" --rfc3164 "message" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "rfc3164" --rfc3164 "message"
 ts_finalize_subtest
 
 ts_init_subtest "rfc5424_simple"
-$TS_HELPER_LOGGER -s --no-act -t "rfc5424" --rfc5424 "message" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "rfc5424" --rfc5424 "message"
 ts_finalize_subtest
+
 ts_init_subtest "rfc5424_notime"
-$TS_HELPER_LOGGER -s --no-act -t "rfc5424" --rfc5424=notime "message" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "rfc5424" --rfc5424=notime "message"
 ts_finalize_subtest
+
 ts_init_subtest "rfc5424_nohost"
-$TS_HELPER_LOGGER -s --no-act -t "rfc5424" --rfc5424=nohost "message" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "rfc5424" --rfc5424=nohost "message"
 ts_finalize_subtest
+
 ts_init_subtest "rfc5424_msgid"
-$TS_HELPER_LOGGER -s --no-act -t "rfc5424" --rfc5424 --msgid "MSGID" "message" > "$TS_OUTPUT" 2>&1
-echo "ret: $?" >> "$TS_OUTPUT"
+logger_fun -t "rfc5424" --rfc5424 --msgid "MSGID" "message"
 ts_finalize_subtest
 
 ts_init_subtest "priorities"
 for facility in auth authpriv cron daemon ftp lpr mail news syslog user uucp local{0..7}; do
 	for level in emerg alert crit err warning notice info debug; do
-		$TS_HELPER_LOGGER -s --no-act -t "prio" -p "$facility.$level" "$facility.$level" >> "$TS_OUTPUT" 2>&1
-		echo "ret: $?" >> "$TS_OUTPUT"
+		logger_fun -t "prio" -p "$facility.$level" "$facility.$level"
 	done
 done
 ts_finalize_subtest
-- 
1.8.4.5

