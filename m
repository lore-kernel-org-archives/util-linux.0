Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:61558 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752887AbaG3Voi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Jul 2014 17:44:38 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so1811975wes.28
        for <util-linux@vger.kernel.org>; Wed, 30 Jul 2014 14:44:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/2] tests: fix rename subdir check that was failing in travis
Date: Wed, 30 Jul 2014 22:44:31 +0100
Message-Id: <1406756671-26805-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406756671-26805-1-git-send-email-kerolasa@iki.fi>
References: <1406756671-26805-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Apparently some or all travis build servers has a bit older coreutils
version.  The coreutils v8.13 added a feature to readlink that allows
user to specify multiple arguments.  Earlier versions gave exactly the
type of error travis_script log has.

+readlink: extra operand `rename_aa/sublink.2'
+Try `readlink --help' for more information.

The commit 0f85e0535bd4e6d19fadca182e4d57660b6bb57b introduced the travis
realpath issue to happen.

Reference: https://travis-ci.org/karelzak/util-linux/builds/30538376
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/ts/rename/subdir | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tests/ts/rename/subdir b/tests/ts/rename/subdir
index f83b2bf..4ae7005 100755
--- a/tests/ts/rename/subdir
+++ b/tests/ts/rename/subdir
@@ -35,7 +35,9 @@ for i in rename_a{a,b}/sublink.{1..3}; do
 	ln -s rename/aa $i
 done
 $TS_CMD_RENAME -s -v a x rename_a{a,b}/sublink.? >> $TS_OUTPUT 2>&1
-readlink rename_a{a,b}/sublink.?  >> $TS_OUTPUT 2>&1
+for i in rename_a{a,b}/sublink.?; do
+	readlink $i >> $TS_OUTPUT 2>&1
+done
 
 rm -rf rename_a{a,b}
 
-- 
2.0.3

