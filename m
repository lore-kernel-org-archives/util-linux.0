Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.19]:59043 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754177AbcDFKaW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 6 Apr 2016 06:30:22 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx002)
 with ESMTPSA (Nemesis) id 0MHX4u-1aorBf1LJc-003IoV for
 <util-linux@vger.kernel.org>; Wed, 06 Apr 2016 12:30:19 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] tests: test_md5 prints md5sum only
Date: Wed,  6 Apr 2016 12:30:17 +0200
Message-Id: <1459938618-20153-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We want to to use it for other tests without depending on
gnu md5sum and without cut or awk.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/md5/md5   | 14 +++++++-------
 tests/helpers/test_md5.c |  2 +-
 tests/ts/md5/md5         |  2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/tests/expected/md5/md5 b/tests/expected/md5/md5
index 6ca300b..d6559a7 100644
--- a/tests/expected/md5/md5
+++ b/tests/expected/md5/md5
@@ -1,7 +1,7 @@
-d41d8cd98f00b204e9800998ecf8427e  -
-900150983cd24fb0d6963f7d28e17f72  -
-5eb6d580e5f68fde65c3778afb8826ff  -
-bd1e13bdaab82581d4dc299eb9a3da0f  -
-d81ee4f567972a18f9326540b5d8aeaf  -
-9561bd208c0041c673080ed744919b85  -
-d98d58d5562ca4dd47f0f0fe86b2d48f  -
+d41d8cd98f00b204e9800998ecf8427e
+900150983cd24fb0d6963f7d28e17f72
+5eb6d580e5f68fde65c3778afb8826ff
+bd1e13bdaab82581d4dc299eb9a3da0f
+d81ee4f567972a18f9326540b5d8aeaf
+9561bd208c0041c673080ed744919b85
+d98d58d5562ca4dd47f0f0fe86b2d48f
diff --git a/tests/helpers/test_md5.c b/tests/helpers/test_md5.c
index 44f6a93..471580e 100644
--- a/tests/helpers/test_md5.c
+++ b/tests/helpers/test_md5.c
@@ -24,6 +24,6 @@ int main(void)
 
 	for (i = 0; i < MD5LENGTH; i++)
 		printf( "%02x", digest[i] );
-	printf("  -\n");
+	printf("\n");
 	return 0;
 }
diff --git a/tests/ts/md5/md5 b/tests/ts/md5/md5
index 6fe3f14..57c4d52 100755
--- a/tests/ts/md5/md5
+++ b/tests/ts/md5/md5
@@ -20,7 +20,7 @@ TS_TOPDIR="${0%/*}/../.."
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
 
-> $TS_OUTPUT
+ts_check_test_command "$TS_HELPER_MD5"
 
 cat $TS_SELF/data | while read data
 do
-- 
1.8.4.5

