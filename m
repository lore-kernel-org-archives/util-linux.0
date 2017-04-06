Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:64103 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756787AbdDFH4R (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 03:56:17 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 5/5] tests: fincore/count, skip unsupported FS
Date: Thu,  6 Apr 2017 09:56:05 +0200
Message-Id: <1491465365-7515-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
References: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/fincore/count | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tests/ts/fincore/count b/tests/ts/fincore/count
index fd50ff8..ac58850 100755
--- a/tests/ts/fincore/count
+++ b/tests/ts/fincore/count
@@ -31,6 +31,21 @@ function _dd
 	return $ret
 }
 
+function check_dd_fs_feat
+{
+	local testf="$TS_OUTDIR/ddtest"
+	rm -f "$testf"
+	touch "$testf"
+
+	# NFS seems to fail for direct AND append
+	_dd if=/dev/zero of="$testf" bs=1K count=2 oflag=direct,append &>/dev/null \
+		|| ts_skip "unsupported: dd oflag=direct,append"
+
+	# TODO: Should we check for sparse file support?
+
+	rm -f "$testf"
+}
+
 function run_dd_test
 {
     header=$1
@@ -94,6 +109,8 @@ fi
 ts_check_test_command "$TS_CMD_FINCORE"
 ts_cd "$TS_OUTDIR"
 
+check_dd_fs_feat
+
 INPUT=
 input=
 
-- 
1.8.5.6

