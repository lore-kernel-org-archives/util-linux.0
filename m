Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:62119 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751522AbbBQUpu (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Tue, 17 Feb 2015 15:45:50 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] tests: improve some wordings of the output
Date: Tue, 17 Feb 2015 21:45:46 +0100
Message-Id: <1424205946-2714-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For one, replace the puzzlingly stern imperative "IGNORE" with
the simple and light-hearted and descriptive "SKIPPED".

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 tests/functions.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index 852a6a3..02f81dd 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -73,11 +73,11 @@ function ts_check_losetup {
 	if test -b "$tmp"; then
 		return 0
 	fi
-	ts_skip "no loop device support"
+	ts_skip "no loop-device support"
 }
 
 function ts_skip_subtest {
-	ts_report " IGNORE ($1)"
+	ts_report " SKIPPED ($1)"
 }
 
 function ts_skip {
@@ -90,7 +90,7 @@ function ts_skip {
 
 function ts_skip_nonroot {
 	if [ $UID -ne 0 ]; then
-		ts_skip "not root permissions"
+		ts_skip "no root permissions"
 	fi
 }
 
-- 
1.7.0.4

