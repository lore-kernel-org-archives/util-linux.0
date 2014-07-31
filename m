Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:62667 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbaGaWFa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 31 Jul 2014 18:05:30 -0400
Received: by mail-wg0-f44.google.com with SMTP id m15so3301714wgh.15
        for <util-linux@vger.kernel.org>; Thu, 31 Jul 2014 15:05:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] tests: kill output message change
Date: Thu, 31 Jul 2014 23:05:25 +0100
Message-Id: <1406844325-1611-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 09af3db48e01e5744f15fd8a2395e0fed36526ea changed how a missing
process is reported, which caused kill test to fail when the test suite
is ran as root.

Reference: https://travis-ci.org/karelzak/util-linux/jobs/31312170
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/kill/all_processes | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/expected/kill/all_processes b/tests/expected/kill/all_processes
index c428372..f14549f 100644
--- a/tests/expected/kill/all_processes
+++ b/tests/expected/kill/all_processes
@@ -1,5 +1,5 @@
 test 1
-kill: cannot find process "test_sigreceive".
+kill: cannot find process "test_sigreceive"
 test 2
 test 3
-kill: cannot find process "test_sigreceive".
+kill: cannot find process "test_sigreceive"
-- 
2.0.3

