Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:44176 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932079Ab3LWAB3 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Dec 2013 19:01:29 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 78F4333EAF3
	for <util-linux@vger.kernel.org>; Mon, 23 Dec 2013 00:01:29 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] tests: libmount: skip tabfiles-py when pylibmount is disabled
Date: Sun, 22 Dec 2013 19:01:32 -0500
Message-Id: <1387756892-25074-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The default configure disables python support, so this test fails by
default.  Add a simple check for module availability.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 tests/ts/libmount/tabfiles-py | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/ts/libmount/tabfiles-py b/tests/ts/libmount/tabfiles-py
index 64e8911..b89fb5b 100755
--- a/tests/ts/libmount/tabfiles-py
+++ b/tests/ts/libmount/tabfiles-py
@@ -12,6 +12,8 @@ ts_init_py libmount
 PYDBG="$PYTHON -m pdb"
 TESTPROG="$TS_HELPER_PYLIBMOUNT_TAB"
 
+$PYTHON -c 'import libmount' 2>/dev/null || ts_skip "pylibmount not compiled"
+
 ts_init_subtest "parse-fstab"
 $PYTHON $TESTPROG --parse "$TS_SELF/files/fstab" &> $TS_OUTPUT
 sed -i -e 's/fs: 0x.*/fs:/g' $TS_OUTPUT
-- 
1.8.4.3

