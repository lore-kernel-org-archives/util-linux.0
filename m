Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:57928 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136Ab3IJTvU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 10 Sep 2013 15:51:20 -0400
Received: by mail-wg0-f52.google.com with SMTP id m14so7132175wgh.7
        for <util-linux@vger.kernel.org>; Tue, 10 Sep 2013 12:51:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/2] tests: lscpu: add CPU max MHz to test results
Date: Tue, 10 Sep 2013 20:51:13 +0100
Message-Id: <1378842674-456-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Commit 44320710bdb98a3036e8297d0e0af043fb72d702 changed default output.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/lscpu/lscpu-armv7             | 1 +
 tests/expected/lscpu/lscpu-x86_64-64cpu      | 1 +
 tests/expected/lscpu/lscpu-x86_64-dell_e4310 | 1 +
 3 files changed, 3 insertions(+)

diff --git a/tests/expected/lscpu/lscpu-armv7 b/tests/expected/lscpu/lscpu-armv7
index a1b691c..373e115 100644
--- a/tests/expected/lscpu/lscpu-armv7
+++ b/tests/expected/lscpu/lscpu-armv7
@@ -3,6 +3,7 @@ On-line CPU(s) list:   0,1
 Thread(s) per core:    1
 Core(s) per socket:    2
 Socket(s):             1
+CPU max MHz:           1700.0000
 
 # The following is the parsable format, which can be fed to other
 # programs. Each different item in every column has an unique ID
diff --git a/tests/expected/lscpu/lscpu-x86_64-64cpu b/tests/expected/lscpu/lscpu-x86_64-64cpu
index 45890b5..db625cf 100644
--- a/tests/expected/lscpu/lscpu-x86_64-64cpu
+++ b/tests/expected/lscpu/lscpu-x86_64-64cpu
@@ -11,6 +11,7 @@ Model:                 46
 Model name:            Intel(R) Xeon(R) CPU           X7550  @ 2.00GHz
 Stepping:              6
 CPU MHz:               1064.000
+CPU max MHz:           1996.0000
 BogoMIPS:              3989.44
 Virtualization:        VT-x
 L1d cache:             32K
diff --git a/tests/expected/lscpu/lscpu-x86_64-dell_e4310 b/tests/expected/lscpu/lscpu-x86_64-dell_e4310
index a81878d..2506c9b 100644
--- a/tests/expected/lscpu/lscpu-x86_64-dell_e4310
+++ b/tests/expected/lscpu/lscpu-x86_64-dell_e4310
@@ -11,6 +11,7 @@ Model:                 37
 Model name:            Intel(R) Core(TM) i5 CPU       M 560  @ 2.67GHz
 Stepping:              5
 CPU MHz:               1199.000
+CPU max MHz:           2667.0000
 BogoMIPS:              5319.97
 Virtualization:        VT-x
 L1d cache:             32K
-- 
1.8.4

