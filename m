Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:36792 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbbJMOUc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Oct 2015 10:20:32 -0400
Received: by wicgb1 with SMTP id gb1so191046060wic.1
        for <util-linux@vger.kernel.org>; Tue, 13 Oct 2015 07:20:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 9/9] tests: add uuid parser check
Date: Tue, 13 Oct 2015 15:20:22 +0100
Message-Id: <1444746022-15664-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The check is based on code by Theodore Ts'o to test libuuid, from which
unstable output is commented out.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libuuid/src/Makemodule.am       |  8 ++++----
 libuuid/src/test_uuid.c         |  5 ++++-
 tests/commands.sh               |  1 +
 tests/expected/uuid/uuid_parser | 12 ++++++++++++
 tests/ts/uuid/uuid_parser       | 26 ++++++++++++++++++++++++++
 5 files changed, 47 insertions(+), 5 deletions(-)
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
index e03138f..6e00ac9 100644
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
diff --git a/tests/commands.sh b/tests/commands.sh
index ba1f738..9df04a4 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -32,6 +32,7 @@ TS_HELPER_STRUTILS="$top_builddir/test_strutils"
 TS_HELPER_SYSINFO="$top_builddir/test_sysinfo"
 TS_HELPER_UUIDD2="$top_builddir/test_uuidd2"
 TS_HELPER_UUIDGEN="$top_builddir/test_uuidgen"
+TS_HELPER_UUID_PARSER="$top_builddir/test_uuid_parser"
 
 # paths to commands
 TS_CMD_ADDPART=${TS_CMD_ADDPART:-"$top_builddir/addpart"}
diff --git a/tests/expected/uuid/uuid_parser b/tests/expected/uuid/uuid_parser
new file mode 100644
index 0000000..18b4c5b
--- /dev/null
+++ b/tests/expected/uuid/uuid_parser
@@ -0,0 +1,12 @@
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
2.6.1

