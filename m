Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f179.google.com ([209.85.212.179]:36699 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751911AbbCVXFk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Mar 2015 19:05:40 -0400
Received: by wibg7 with SMTP id g7so33037229wib.1
        for <util-linux@vger.kernel.org>; Sun, 22 Mar 2015 16:05:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/5] tests: check timestamp formats
Date: Sun, 22 Mar 2015 23:05:29 +0000
Message-Id: <1427065530-10695-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
References: <1427065530-10695-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/dmesg/indentation | 15 +++++++++++++++
 tests/ts/dmesg/indentation       |  6 ++++++
 2 files changed, 21 insertions(+)

diff --git a/tests/expected/dmesg/indentation b/tests/expected/dmesg/indentation
index e32d87f..0d0b6e4 100644
--- a/tests/expected/dmesg/indentation
+++ b/tests/expected/dmesg/indentation
@@ -18,3 +18,18 @@ line
 two
 new
 lines
+[Feb13 23:31] new
+              line
+[  +1.000000] two
+              new
+              lines
+[Fri Feb 13 23:31:31 2009] new
+                           line
+[Fri Feb 13 23:31:32 2009] two
+                           new
+                           lines
+2009-02-13T23:31:31,000000+0000 new
+                                line
+2009-02-13T23:31:32,000000+0000 two
+                                new
+                                lines
diff --git a/tests/ts/dmesg/indentation b/tests/ts/dmesg/indentation
index 624dd9b..11a9e56 100755
--- a/tests/ts/dmesg/indentation
+++ b/tests/ts/dmesg/indentation
@@ -28,4 +28,10 @@ $TS_HELPER_DMESG --time-format=delta --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
 
 $TS_HELPER_DMESG --time-format=notime --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
 
+$TS_HELPER_DMESG --time-format=reltime --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
+
+$TS_HELPER_DMESG --time-format=ctime --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
+
+$TS_HELPER_DMESG --time-format=iso --file $TS_SELF/newlines >> $TS_OUTPUT 2>&1
+
 ts_finalize
-- 
2.3.3

