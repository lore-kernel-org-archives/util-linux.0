Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:37291 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932150AbbJML32 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Oct 2015 07:29:28 -0400
Received: by wijq8 with SMTP id q8so27289969wij.0
        for <util-linux@vger.kernel.org>; Tue, 13 Oct 2015 04:29:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 5/8] tests: add uuidd check
Date: Tue, 13 Oct 2015 12:29:11 +0100
Message-Id: <1444735754-18976-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
References: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This check will try functionality of uuidd, leaving out the validation
uuid's are truly unique.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/Makemodule.am  |  5 +++++
 misc-utils/uuidd.c        | 16 ++++++++++++++++
 tests/commands.sh         |  1 +
 tests/expected/uuid/uuidd |  7 +++++++
 tests/ts/uuid/uuidd       | 33 +++++++++++++++++++++++++++++++++
 5 files changed, 62 insertions(+)
 create mode 100644 tests/expected/uuid/uuidd
 create mode 100755 tests/ts/uuid/uuidd

diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index 2fbaa01..b8e04fc 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -106,6 +106,11 @@ systemdsystemunit_DATA += \
 	misc-utils/uuidd.service \
 	misc-utils/uuidd.socket
 endif
+
+check_PROGRAMS += test_uuidd2
+test_uuidd2_SOURCES = $(uuidd_SOURCES)
+test_uuidd2_LDADD = $(uuidd_LDADD)
+test_uuidd2_CFLAGS = -DTEST_UUIDD $(uuidd_CFLAGS)
 endif # BUILD_UUIDD
 
 PATHFILES += \
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 4b5bf00..03d94d7 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -331,6 +331,12 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 				POLLFD_SIGNAL = 0,
 				POLLFD_SOCKET
 	};
+#ifdef TEST_UUIDD
+	const char		*test_file = getenv("UUIDD_RANDOM_SOURCE");
+
+	if (!test_file)
+		errx(EXIT_FAILURE, "UUIDD_RANDOM_SOURCE: not set");
+#endif
 
 #ifdef HAVE_LIBSYSTEMD
 	if (!uuidd_cxt->no_sock)	/* no_sock implies no_fork and no_pid */
@@ -468,7 +474,12 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			break;
 		case UUIDD_OP_TIME_UUID:
 			num = 1;
+#ifdef TEST_UUIDD
+			if (uuid_generate_file(uu, test_file))
+				err(EXIT_FAILURE, "%s", test_file);
+#else
 			__uuid_generate_time(uu, &num);
+#endif
 			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
 				fprintf(stderr, _("Generated time UUID: %s\n"), str);
@@ -478,7 +489,12 @@ static void server_loop(const char *socket_path, const char *pidfile_path,
 			break;
 		case UUIDD_OP_RANDOM_UUID:
 			num = 1;
+#ifdef TEST_UUIDD
+			if (uuid_generate_file(uu, test_file))
+				err(EXIT_FAILURE, "%s", test_file);
+#else
 			__uuid_generate_random(uu, &num);
+#endif
 			if (uuidd_cxt->debug) {
 				uuid_unparse(uu, str);
 				fprintf(stderr, _("Generated random UUID: %s\n"), str);
diff --git a/tests/commands.sh b/tests/commands.sh
index 6878650..ba1f738 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -30,6 +30,7 @@ TS_HELPER_SCRIPT="$top_builddir/test_script"
 TS_HELPER_SIGRECEIVE="$top_builddir/test_sigreceive"
 TS_HELPER_STRUTILS="$top_builddir/test_strutils"
 TS_HELPER_SYSINFO="$top_builddir/test_sysinfo"
+TS_HELPER_UUIDD2="$top_builddir/test_uuidd2"
 TS_HELPER_UUIDGEN="$top_builddir/test_uuidgen"
 
 # paths to commands
diff --git a/tests/expected/uuid/uuidd b/tests/expected/uuid/uuidd
new file mode 100644
index 0000000..81ee6e4
--- /dev/null
+++ b/tests/expected/uuid/uuidd
@@ -0,0 +1,7 @@
+return value: 0
+deadface-cafe-babe-feed-baadbeeff00d
+return value: 0
+deadface-cafe-babe-feed-baadbeeff00d
+return value: 0
+Killed uuidd running at pid <num>.
+return value: 0
diff --git a/tests/ts/uuid/uuidd b/tests/ts/uuid/uuidd
new file mode 100755
index 0000000..d3f7d50
--- /dev/null
+++ b/tests/ts/uuid/uuidd
@@ -0,0 +1,33 @@
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
+TS_DESC="uuidd"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_UUIDD2"
+
+UUIDD_RANDOM_SOURCE=$TS_SELF/0xdeadbeef $TS_HELPER_UUIDD2 --pid $TS_OUTDIR/pid --socket $TS_OUTDIR/socket > $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+$TS_HELPER_UUIDD2 --debug --random --socket $TS_OUTDIR/socket >> $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+$TS_HELPER_UUIDD2 --debug --time --socket $TS_OUTDIR/socket >> $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+$TS_HELPER_UUIDD2 --debug --kill --socket $TS_OUTDIR/socket |
+	sed 's/pid [0-9]*.$/pid <num>./' >> $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+
+ts_finalize
-- 
2.6.1

