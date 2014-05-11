Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:60512 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934080AbaEKT0y (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 11 May 2014 15:26:54 -0400
Received: by mail-wi0-f182.google.com with SMTP id r20so3502084wiv.15
        for <util-linux@vger.kernel.org>; Sun, 11 May 2014 12:26:53 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Ruediger Meier <sweet_f_a@gmx.de>
Subject: [PATCH 01/12] tests: check /proc availability, and go-around if it is incomplete
Date: Sun, 11 May 2014 20:26:38 +0100
Message-Id: <1399836409-7769-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Unavailability of /proc is fatal for kill, and continuing with the test
in that case does not make sense as it will only mean false positive
errors.

Where /proc/<pid>/status file(s) does not exist the check will perform
opportunistic sleep with assumption the test_sigreceive will be ready to
be killed if it has some time to init.

CC: Ruediger Meier <sweet_f_a@gmx.de>
Reference: https://travis-ci.org/rudimeier/util-linux/jobs/24561058
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/ts/kill/kill_functions.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/tests/ts/kill/kill_functions.sh b/tests/ts/kill/kill_functions.sh
index 73fff05..a2a2483 100644
--- a/tests/ts/kill/kill_functions.sh
+++ b/tests/ts/kill/kill_functions.sh
@@ -1,3 +1,5 @@
+# kill tests, or command, will not when /proc is missing.
+test /proc || ts_skip "/proc not available"
 
 # unfortunately we are using gawk features
 type gawk >/dev/null 2>&1 || ts_skip "cannot find gawk"
@@ -8,6 +10,17 @@ function check_test_sigreceive {
 	local pid=$1
 
 	for i in 0.01 0.1 1 1 1 1; do
+		if [ ! -f /proc/$pid/status ]; then
+			# The /proc exists, but not status file. Because
+			# the process already started it is unlikely the
+			# file would appear after any amount of waiting.
+			# Try to sleep for moment and hopefully
+			# test_sigreceive is ready to be killed.
+			echo "kill_functions.sh: /proc/$pid/status: No such file or directory"
+			sleep 2
+			rc=1
+			break
+		fi
 		gawk 'BEGIN { retval=1 }
 		/^SigCgt/ {
 			lbyte = strtonum("0x" substr($2, 16, 16))
-- 
1.9.2

