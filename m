Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:35629 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751437AbbJYQFL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 25 Oct 2015 12:05:11 -0400
Received: by wicll6 with SMTP id ll6so84838825wic.0
        for <util-linux@vger.kernel.org>; Sun, 25 Oct 2015 09:05:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/4] tests: add uuid parser check
Date: Sun, 25 Oct 2015 16:04:57 +0000
Message-Id: <1445789100-1781-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1445789100-1781-1-git-send-email-kerolasa@iki.fi>
References: <1445789100-1781-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The check is based on code by Theodore Ts'o to test libuuid, from which
unstable output is commented out.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libuuid/src/Makemodule.am       |  8 ++++----
 libuuid/src/test_uuid.c         |  8 +++++++-
 tests/commands.sh               |  1 +
 tests/expected/uuid/uuid_parser | 15 +++++++++++++++
 tests/ts/uuid/uuid_parser       | 26 ++++++++++++++++++++++++++
 5 files changed, 53 insertions(+), 5 deletions(-)
 create mode 100644 tests/expected/uuid/uuid_parser
 create mode 100755 tests/ts/uuid/uuid_parser

diff --git a/libuuid/src/Makemodule.am b/libuuid/src/Makemodule.am
index 061aff2..180ac01 100644
--- a/libuuid/src/Makemodule.am
+++ b/libuuid/src/Makemodule.am
@@ -1,8 +1,8 @@
 
-check_PROGRAMS += test_uuid
-test_uuid_SOURCES = libuuid/src/test_uuid.c
-test_uuid_LDADD = libuuid.la $(SOCKET_LIBS)
-test_uuid_CFLAGS = -I$(ul_libuuid_incdir)
+check_PROGRAMS += test_uuid_parser
+test_uuid_parser_SOURCES = libuuid/src/test_uuid.c
+test_uuid_parser_LDADD = libuuid.la $(SOCKET_LIBS)
+test_uuid_parser_CFLAGS = -I$(ul_libuuid_incdir)
 
 # includes
 uuidincdir = $(includedir)/uuid
diff --git a/libuuid/src/test_uuid.c b/libuuid/src/test_uuid.c
index e03138f..e8f0703 100644
--- a/libuuid/src/test_uuid.c
+++ b/libuuid/src/test_uuid.c
@@ -69,13 +69,15 @@ static int test_uuid(const char * uuid, int isValid)
 int
 main(int argc ATTR((unused)) , char **argv ATTR((unused)))
 {
+	int failed = 0;
+/* Code commented out will print random uuid's that are unsuitable output
+ * for test suite.
 	uuid_t		buf, tst;
 	char		str[100];
 	struct timeval	tv;
 	time_t		time_reg;
 	unsigned char	*cp;
 	int i;
-	int failed = 0;
 	int type, variant;
 
 	uuid_generate(buf);
@@ -160,6 +162,7 @@ main(int argc ATTR((unused)) , char **argv ATTR((unused)))
 		printf("UUID copy and compare failed!\n");
 		failed++;
 	}
+*/
 	failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981b", 1);
 	failed += test_uuid("84949CC5-4701-4A84-895B-354C584A981B", 1);
 	failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981bc", 0);
@@ -171,6 +174,9 @@ main(int argc ATTR((unused)) , char **argv ATTR((unused)))
 	failed += test_uuid("84949cc5-4701-4a84-895b0354c584a981b", 0);
 	failed += test_uuid("g4949cc5-4701-4a84-895b-354c584a981b", 0);
 	failed += test_uuid("84949cc5-4701-4a84-895b-354c584a981g", 0);
+	failed += test_uuid("00000000-0000-0000-0000-000000000000", 1);
+	failed += test_uuid("01234567-89ab-cdef-0134-567890abcedf", 1);
+	failed += test_uuid("ffffffff-ffff-ffff-ffff-ffffffffffff", 1);
 
 	if (failed) {
 		printf("%d failures.\n", failed);
diff --git a/tests/commands.sh b/tests/commands.sh
index 737918f..84bf661 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -30,6 +30,7 @@ TS_HELPER_SCRIPT="$top_builddir/test_script"
 TS_HELPER_SIGRECEIVE="$top_builddir/test_sigreceive"
 TS_HELPER_STRUTILS="$top_builddir/test_strutils"
 TS_HELPER_SYSINFO="$top_builddir/test_sysinfo"
+TS_HELPER_UUID_PARSER="$top_builddir/test_uuid_parser"
 
 # paths to commands
 TS_CMD_ADDPART=${TS_CMD_ADDPART:-"$top_builddir/addpart"}
diff --git a/tests/expected/uuid/uuid_parser b/tests/expected/uuid/uuid_parser
new file mode 100644
index 0000000..a9eb672
--- /dev/null
+++ b/tests/expected/uuid/uuid_parser
@@ -0,0 +1,15 @@
+84949cc5-4701-4a84-895b-354c584a981b is valid, OK
+84949CC5-4701-4A84-895B-354C584A981B is valid, OK
+84949cc5-4701-4a84-895b-354c584a981bc is invalid, OK
+84949cc5-4701-4a84-895b-354c584a981 is invalid, OK
+84949cc5x4701-4a84-895b-354c584a981b is invalid, OK
+84949cc504701-4a84-895b-354c584a981b is invalid, OK
+84949cc5-470104a84-895b-354c584a981b is invalid, OK
+84949cc5-4701-4a840895b-354c584a981b is invalid, OK
+84949cc5-4701-4a84-895b0354c584a981b is invalid, OK
+g4949cc5-4701-4a84-895b-354c584a981b is invalid, OK
+84949cc5-4701-4a84-895b-354c584a981g is invalid, OK
+00000000-0000-0000-0000-000000000000 is valid, OK
+01234567-89ab-cdef-0134-567890abcedf is valid, OK
+ffffffff-ffff-ffff-ffff-ffffffffffff is valid, OK
+return value: 0
diff --git a/tests/ts/uuid/uuid_parser b/tests/ts/uuid/uuid_parser
new file mode 100755
index 0000000..d80d269
--- /dev/null
+++ b/tests/ts/uuid/uuid_parser
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+# This file is part of util-linux.
+#
+# This file is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This file is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="uuid_parser"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_UUID_PARSER"
+
+$TS_HELPER_UUID_PARSER > $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+
+ts_finalize
-- 
2.6.2

