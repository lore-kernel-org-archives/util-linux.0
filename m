Return-Path: util-linux-owner@vger.kernel.org
Received: from c-83-233-174-181.cust.bredband2.com ([83.233.174.181]:48224
	"EHLO pi.fatal.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751493AbbFVRWq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Jun 2015 13:22:46 -0400
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>, Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH] tests: add fullpath tests to rename/subdir
Date: Mon, 22 Jun 2015 19:22:34 +0200
Message-Id: <1434993754-20646-1-git-send-email-andreas@fatal.se>
In-Reply-To: <CAG27Bk353ASGr0hyDe4oQvAZ3Swf_HbgonENtkOPFE_qcjE7MQ@mail.gmail.com>
References: <CAG27Bk353ASGr0hyDe4oQvAZ3Swf_HbgonENtkOPFE_qcjE7MQ@mail.gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 tests/expected/rename/subdir |  9 +++++++++
 tests/ts/rename/subdir       | 24 ++++++++++++++++++++++++
 2 files changed, 33 insertions(+)

diff --git a/tests/expected/rename/subdir b/tests/expected/rename/subdir
index a5b3dbe..f429602 100644
--- a/tests/expected/rename/subdir
+++ b/tests/expected/rename/subdir
@@ -18,3 +18,12 @@ renxme/aa
 renxme/aa
 renxme/aa
 renxme/aa
+== fullpath ==
+`./rename_path1' -> `./rename_path2'
+./rename_path2
+`rename_path_test1' -> `rename_path_a/test1'
+./rename_path_a/test1
+`rename_path_a/test2' -> `rename_path_b/test2'
+rename_path_a
+rename_path_b
+rename_path_b/test2
diff --git a/tests/ts/rename/subdir b/tests/ts/rename/subdir
index 4ae7005..01472fa 100755
--- a/tests/ts/rename/subdir
+++ b/tests/ts/rename/subdir
@@ -41,4 +41,28 @@ done
 
 rm -rf rename_a{a,b}
 
+echo "== fullpath ==" >> $TS_OUTPUT
+touch rename_path1
+$TS_CMD_RENAME -v ./rename_path1 ./rename_path2 ./rename_path1 >> $TS_OUTPUT 2>&1
+
+find . -name 'rename_path*' >> $TS_OUTPUT 2>&1
+rm -f ./rename_path*
+
+mkdir rename_path_a
+touch rename_path_test1
+
+$TS_CMD_RENAME -v rename_path_test1 rename_path_a/test1 rename_path_test1 >> $TS_OUTPUT 2>&1
+
+find . -name '*test1*' >> $TS_OUTPUT 2>&1
+rm -f rename_path_test1 rename_path_a/test1
+
+mkdir rename_path_b
+touch rename_path_a/test2
+$TS_CMD_RENAME -v rename_path_a/test2 rename_path_b/test2 rename_path_a/test2 >> $TS_OUTPUT 2>&1
+
+find rename_path_a rename_path_b >> $TS_OUTPUT 2>&1
+rm -f rename_path_a/test2 rename_path_b/test2
+
+rmdir rename_path_a rename_path_b
+
 ts_finalize
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
