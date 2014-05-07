Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:40441 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751884AbaEGRBP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 7 May 2014 13:01:15 -0400
Received: by mail-we0-f180.google.com with SMTP id t61so1314057wes.11
        for <util-linux@vger.kernel.org>; Wed, 07 May 2014 10:01:13 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] tests: make kill to go-around when /proc is not available
Date: Wed,  7 May 2014 18:01:08 +0100
Message-Id: <1399482068-6460-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And change messaging to be easier to debug, if the outcome of the
opportunistic sleep is unsuccessful test.  In such case one could assume
the test_sigreceive was not successful when setting handler.  Maybe
because of load on test server, or some other reason.

Reference: https://travis-ci.org/rudimeier/util-linux/jobs/24561058
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/ts/kill/kill_functions.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tests/ts/kill/kill_functions.sh b/tests/ts/kill/kill_functions.sh
index 043b4cb..56ad98b 100644
--- a/tests/ts/kill/kill_functions.sh
+++ b/tests/ts/kill/kill_functions.sh
@@ -5,6 +5,16 @@ function check_test_sigreceive {
 	local pid=$1
 
 	for i in 0.01 0.1 1 1 1 1; do
+		if [ ! -f /proc/$pid/status ]; then
+			# This message is visible in tests/run.sh output.
+			# Do not direct to $TS_OUTPUT it would make test
+			# fail, while with a bit of luck this might be
+			# recoverable (after a sleep).
+			echo "kill_functions.sh: /proc/$pid/status: No such file or directory" &&
+			rc=1 &&
+			sleep 2 &&
+			break
+		fi
 		awk 'BEGIN { retval=1 }
 		/^SigCgt/ {
 			lbyte = strtonum("0x" substr($2, 16, 16))
-- 
1.9.2

