Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:54496 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751123Ab2GYTPt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:49 -0400
Received: by wgbdr13 with SMTP id dr13so1068839wgb.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/3] tests: partx changed default output format
Date: Wed, 25 Jul 2012 21:15:19 +0200
Message-Id: <1343243745-1172-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: commit 7cfd1b26437acd45f1e2e75c9648afabb8f5b2da
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/partx/partx-bsd     |  5 +++--
 tests/expected/partx/partx-dos+bsd |  9 +++++----
 tests/expected/partx/partx-gpt     | 11 ++++++-----
 tests/expected/partx/partx-sgi     |  5 +++--
 tests/expected/partx/partx-sun     |  5 +++--
 5 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/tests/expected/partx/partx-bsd b/tests/expected/partx/partx-bsd
index d4be5c5..15568c4 100644
--- a/tests/expected/partx/partx-bsd
+++ b/tests/expected/partx/partx-bsd
@@ -1,2 +1,3 @@
-# 1:      7936-    12799 (     4864 sectors,      2 MB)
-# 2:     12544-    16127 (     3584 sectors,      1 MB)
+NR START   END SECTORS SIZE NAME UUID
+ 1  7936 12799    4864 2.4M      
+ 2 12544 16127    3584 1.8M      
diff --git a/tests/expected/partx/partx-dos+bsd b/tests/expected/partx/partx-dos+bsd
index 3242a6c..75cdfe8 100644
--- a/tests/expected/partx/partx-dos+bsd
+++ b/tests/expected/partx/partx-dos+bsd
@@ -1,4 +1,5 @@
-# 1:        32-     7679 (     7648 sectors,      3 MB)
-# 2:      7680-    16383 (     8704 sectors,      4 MB)
-# 5:      7936-    12799 (     4864 sectors,      2 MB)
-# 6:     12544-    16127 (     3584 sectors,      1 MB)
+NR START   END SECTORS SIZE NAME UUID
+ 1    32  7679    7648 3.8M      
+ 2  7680 16383    8704 4.3M      
+ 5  7936 12799    4864 2.4M      
+ 6 12544 16127    3584 1.8M      
diff --git a/tests/expected/partx/partx-gpt b/tests/expected/partx/partx-gpt
index 0a1d491..c941f36 100644
--- a/tests/expected/partx/partx-gpt
+++ b/tests/expected/partx/partx-gpt
@@ -1,5 +1,6 @@
-# 1:        34-     2047 (     2014 sectors,      1 MB)
-# 2:      2048-     4095 (     2048 sectors,      1 MB)
-# 3:      4096-     6143 (     2048 sectors,      1 MB)
-# 4:      6144-     8191 (     2048 sectors,      1 MB)
-# 5:      8192-    10239 (     2048 sectors,      1 MB)
+NR START   END SECTORS  SIZE NAME            UUID
+ 1    34  2047    2014 1007K ThisIsName      1dcf10bc-637e-4c52-8203-087ae10a820b
+ 2  2048  4095    2048    1M ThisIsOtherName a1d03a96-7238-46c6-bbb3-789cbe173ec7
+ 3  4096  6143    2048    1M primary         a7101b6c-468c-47df-aff6-cd444d12af61
+ 4  6144  8191    2048    1M primary         afc4950a-f0f1-4add-802c-5957133486d1
+ 5  8192 10239    2048    1M primary         0db0a787-c16b-4886-af3a-fbb97299677c
diff --git a/tests/expected/partx/partx-sgi b/tests/expected/partx/partx-sgi
index 469d442..ba357e0 100644
--- a/tests/expected/partx/partx-sgi
+++ b/tests/expected/partx/partx-sgi
@@ -1,2 +1,3 @@
-# 1:        63-  1606499 (  1606437 sectors,    822 MB)
-# 2:   1606500- 32129999 ( 30523500 sectors,  15628 MB)
+NR   START      END  SECTORS   SIZE NAME UUID
+ 1      63  1606499  1606437 784.4M      
+ 2 1606500 32129999 30523500  14.6G      
diff --git a/tests/expected/partx/partx-sun b/tests/expected/partx/partx-sun
index d957f58..e69fdb1 100644
--- a/tests/expected/partx/partx-sun
+++ b/tests/expected/partx/partx-sun
@@ -1,2 +1,3 @@
-# 1:         0-    87379 (    87380 sectors,     44 MB)
-# 2:     87380-   131069 (    43690 sectors,     22 MB)
+NR START    END SECTORS  SIZE NAME UUID
+ 1     0  87379   87380 42.7M      
+ 2 87380 131069   43690 21.3M      
-- 
1.7.11.3

