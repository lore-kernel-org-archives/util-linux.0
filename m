Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52925 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbbCMPJl (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Fri, 13 Mar 2015 11:09:41 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0Lip2P-1Z93h009pF-00cz2o for
 <util-linux@vger.kernel.org>; Fri, 13 Mar 2015 16:09:39 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] tests: disarm tailf test
Date: Fri, 13 Mar 2015 16:09:37 +0100
Message-Id: <1426259377-15288-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1426259377-15288-1-git-send-email-sweet_f_a@gmx.de>
References: <1426259377-15288-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/tailf/simple | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/ts/tailf/simple b/tests/ts/tailf/simple
index d0a1c5c..35d10f3 100755
--- a/tests/ts/tailf/simple
+++ b/tests/ts/tailf/simple
@@ -20,6 +20,10 @@ ts_init "$*"
 
 ts_check_test_command "$TS_CMD_TAILF"
 
+# This test is unsafe for some filesystems and for case non-inotify. We don't
+# fix it since tailf is deprecated. Just keep this test for the test log.
+TS_KNOWN_FAIL="yes"
+
 INPUT=$TS_OUTDIR/$TS_TESTNAME.input
 
 rm -f $INPUT
-- 
1.8.4.5

