Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:42783 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755940Ab3LVXU1 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 22 Dec 2013 18:20:27 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 6D61F33D977
	for <util-linux@vger.kernel.org>; Sun, 22 Dec 2013 23:20:26 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] tests: last: skip when last is not enabled
Date: Sun, 22 Dec 2013 18:20:29 -0500
Message-Id: <1387754429-19777-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

References: https://bugs.gentoo.org/489794
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 tests/ts/last/ipv6 | 2 ++
 tests/ts/last/last | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tests/ts/last/ipv6 b/tests/ts/last/ipv6
index 8e2b01e..60b72bd 100755
--- a/tests/ts/last/ipv6
+++ b/tests/ts/last/ipv6
@@ -18,6 +18,8 @@ TS_DESC="last ipv6"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+[ -x $TS_CMD_LAST ] || ts_skip "last not enabled"
+
 export LANG=C
 export TZ=GMT
 
diff --git a/tests/ts/last/last b/tests/ts/last/last
index 4ad38cb..83b7f8d 100755
--- a/tests/ts/last/last
+++ b/tests/ts/last/last
@@ -18,6 +18,8 @@ TS_DESC="last"
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
+[ -x $TS_CMD_LAST ] || ts_skip "last not enabled"
+
 export LANG=C
 export TZ=GMT
 
-- 
1.8.4.3

