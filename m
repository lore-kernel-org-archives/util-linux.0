Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51926 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751708AbbDMMB5 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 08:01:57 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LaoMe-1Z5fGm1NDk-00kS5B for
 <util-linux@vger.kernel.org>; Mon, 13 Apr 2015 14:01:56 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 5/7] tests: logger/errors does not use --no-act
Date: Mon, 13 Apr 2015 14:01:51 +0200
Message-Id: <1428926513-25449-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
References: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/logger/errors-check_socket | 18 ++++++++++++++++++
 tests/ts/logger/errors                    |  5 ++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/tests/expected/logger/errors-check_socket b/tests/expected/logger/errors-check_socket
index fa36c4e..76a877f 100644
--- a/tests/expected/logger/errors-check_socket
+++ b/tests/expected/logger/errors-check_socket
@@ -1 +1,19 @@
 Check written socket data of all subtests.
+socket data, kern_priority:
+<8>Feb 13 23:31:30 prio: message
+socket data, kern_priority_numeric:
+<8>Feb 13 23:31:30 prio: message
+socket data, invalid_prio:
+
+socket data, rfc5424_exceed_size:
+<13>1 2009-02-13T23:31:30.123456+00:00 test-hostname rfc5424_exceed_size - - [timeQuality tzKnown="1" isSynced="0"] abc
+socket data, id_with_space:
+
+socket data, id_with_space:
+
+socket data, tag_with_space:
+<13>Feb 13 23:31:30 A B: tag_with_space
+socket data, tag_with_space:
+<13>1 2009-02-13T23:31:30.123456+00:00 test-hostname A B - - [timeQuality tzKnown="1" isSynced="0"] tag_with_space_rfc5424
+socket data, rfc5424_msgid_with_space:
+
diff --git a/tests/ts/logger/errors b/tests/ts/logger/errors
index 8df97c8..e0a02dc 100755
--- a/tests/ts/logger/errors
+++ b/tests/ts/logger/errors
@@ -36,8 +36,11 @@ ts_init_socket_to_file $DEVLOG $SOCKIN
 SOCAT_PID="$!"
 
 function logger_fun {
-	$TS_HELPER_LOGGER -u $DEVLOG -s --no-act "$@" >> "$TS_OUTPUT" 2>&1
+	# logger without --no-act to write all data to the socket
+	echo "socket data, ${TS_SUBNAME}:" |socat -u - UNIX-CONNECT:$DEVLOG
+	$TS_HELPER_LOGGER -u $DEVLOG --stderr "$@" >> "$TS_OUTPUT" 2>&1
 	echo "ret: $?" >> "$TS_OUTPUT"
+	echo |socat -u - UNIX-CONNECT:$DEVLOG
 }
 
 ts_init_subtest "kern_priority"
-- 
1.8.4.5

