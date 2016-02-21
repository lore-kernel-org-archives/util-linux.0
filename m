Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:57877 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751651AbcBURzS (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 21 Feb 2016 12:55:18 -0500
Received: from assos.lan ([84.185.150.84]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0MTTKZ-1aQ1jf2Xzj-00SQzg for
 <util-linux@vger.kernel.org>; Sun, 21 Feb 2016 18:55:16 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] tests: add logger tests "id _numbers_ with spaces"
Date: Sun, 21 Feb 2016 18:55:14 +0100
Message-Id: <1456077314-17910-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456077314-17910-1-git-send-email-sweet_f_a@gmx.de>
References: <1456077314-17910-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Leading spaces are allowed.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/logger/errors-check_socket  | 7 +++++++
 tests/expected/logger/errors-id_with_space | 6 ++++++
 tests/ts/logger/errors                     | 4 ++++
 3 files changed, 17 insertions(+)

diff --git a/tests/expected/logger/errors-check_socket b/tests/expected/logger/errors-check_socket
index 79a47f4..bf02837 100644
--- a/tests/expected/logger/errors-check_socket
+++ b/tests/expected/logger/errors-check_socket
@@ -14,6 +14,13 @@ socket data, id_with_space:
 
 socket data, id_with_space:
 
+socket data, id_with_space:
+
+socket data, id_with_space:
+<13>Feb 13 23:31:30 id_with_leading space[123]: message
+
+socket data, id_with_space:
+
 socket data, tag_with_space:
 <13>Feb 13 23:31:30 A B: tag_with_space
 
diff --git a/tests/expected/logger/errors-id_with_space b/tests/expected/logger/errors-id_with_space
index 79bd050..0f3bc45 100644
--- a/tests/expected/logger/errors-id_with_space
+++ b/tests/expected/logger/errors-id_with_space
@@ -2,3 +2,9 @@ test_logger: failed to parse id: 'A B'
 ret: 1
 test_logger: failed to parse id: 'A B'
 ret: 1
+test_logger: failed to parse id: '1 23'
+ret: 1
+<13>Feb 13 23:31:30 id_with_leading space[123]: message
+ret: 0
+test_logger: failed to parse id: '123 '
+ret: 1
diff --git a/tests/ts/logger/errors b/tests/ts/logger/errors
index c0fab94..33c1057 100755
--- a/tests/ts/logger/errors
+++ b/tests/ts/logger/errors
@@ -74,6 +74,10 @@ ts_finalize_subtest
 ts_init_subtest "id_with_space"
 logger_fun -t "id_with_space" --id="A B" "message"
 logger_fun -t "rfc5424_id_with_space" --rfc5424 --id="A B" "message"
+logger_fun -t "id_with_space" --id="1 23" "message"
+logger_fun -t "id_with_leading space" --id=" 123" "message"
+logger_fun -t "id_with_trailing space" --id="123 " "message"
+
 ts_finalize_subtest
 
 # should not fail
-- 
1.9.1

