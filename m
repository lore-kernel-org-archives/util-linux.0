Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:37260 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932136AbbJML31 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 13 Oct 2015 07:29:27 -0400
Received: by wijq8 with SMTP id q8so27289193wij.0
        for <util-linux@vger.kernel.org>; Tue, 13 Oct 2015 04:29:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/8] tests: add uuidgen check
Date: Tue, 13 Oct 2015 12:29:10 +0100
Message-Id: <1444735754-18976-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
References: <1444735754-18976-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=yes
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This check will try functionality of uuidgen, leaving out the validation
uuid's are truly unique.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/Makemodule.am    |   5 +++++
 misc-utils/uuidgen.c        |  24 ++++++++++++++++++++++++
 tests/commands.sh           |   1 +
 tests/expected/uuid/uuidgen |   6 ++++++
 tests/ts/uuid/0x00000000    | Bin 0 -> 16 bytes
 tests/ts/uuid/0xdeadbeef    |   1 +
 tests/ts/uuid/0xffffffff    |   1 +
 tests/ts/uuid/uuidgen       |  30 ++++++++++++++++++++++++++++++
 8 files changed, 68 insertions(+)
 create mode 100644 tests/expected/uuid/uuidgen
 create mode 100644 tests/ts/uuid/0x00000000
 create mode 100644 tests/ts/uuid/0xdeadbeef
 create mode 100644 tests/ts/uuid/0xffffffff
 create mode 100755 tests/ts/uuid/uuidgen

diff --git a/misc-utils/Makemodule.am b/misc-utils/Makemodule.am
index e7949d0..2fbaa01 100644
--- a/misc-utils/Makemodule.am
+++ b/misc-utils/Makemodule.am
@@ -85,6 +85,11 @@ dist_man_MANS += misc-utils/uuidgen.1
 uuidgen_SOURCES = misc-utils/uuidgen.c
 uuidgen_LDADD = $(LDADD) libuuid.la
 uuidgen_CFLAGS = $(AM_CFLAGS) -I$(ul_libuuid_incdir)
+
+check_PROGRAMS += test_uuidgen
+test_uuidgen_SOURCES = $(uuidgen_SOURCES)
+test_uuidgen_LDADD = $(uuidgen_LDADD)
+test_uuidgen_CFLAGS = -DTEST_UUIDGEN $(uuidgen_CFLAGS)
 endif
 
 if BUILD_UUIDD
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 40b00ff..912b4a9 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -28,6 +28,9 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_("Create a new UUID value.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
+#ifdef TEST_UUIDGEN
+	fputs(  "     --file <file>  generate <file> based uuid", out);
+#endif
 	fputs(_(" -r, --random     generate random-based uuid\n"
 		" -t, --time       generate time-based uuid\n"
 		" -V, --version    output version information and exit\n"
@@ -44,8 +47,17 @@ main (int argc, char *argv[])
 	int    do_type = 0;
 	char   str[37];
 	uuid_t uu;
+#ifdef TEST_UUIDGEN
+	char   *file;
 
+	enum {
+		OPT_FILE = CHAR_MAX + 1
+	};
+#endif
 	static const struct option longopts[] = {
+#ifdef TEST_UUIDGEN
+		{"file", required_argument, NULL, OPT_FILE},
+#endif
 		{"random", no_argument, NULL, 'r'},
 		{"time", no_argument, NULL, 't'},
 		{"version", no_argument, NULL, 'V'},
@@ -60,6 +72,12 @@ main (int argc, char *argv[])
 
 	while ((c = getopt_long(argc, argv, "rtVh", longopts, NULL)) != -1)
 		switch (c) {
+#ifdef TEST_UUIDGEN
+		case OPT_FILE:
+			do_type = UUID_TYPE_DCE_FILE;
+			file = optarg;
+			break;
+#endif
 		case 't':
 			do_type = UUID_TYPE_DCE_TIME;
 			break;
@@ -76,6 +94,12 @@ main (int argc, char *argv[])
 		}
 
 	switch (do_type) {
+#ifdef TEST_UUIDGEN
+	case UUID_TYPE_DCE_FILE:
+		if (uuid_generate_file(uu, file))
+			err(EXIT_FAILURE, "%s", file);
+		break;
+#endif
 	case UUID_TYPE_DCE_TIME:
 		uuid_generate_time(uu);
 		break;
diff --git a/tests/commands.sh b/tests/commands.sh
index 737918f..6878650 100644
--- a/tests/commands.sh
+++ b/tests/commands.sh
@@ -30,6 +30,7 @@ TS_HELPER_SCRIPT="$top_builddir/test_script"
 TS_HELPER_SIGRECEIVE="$top_builddir/test_sigreceive"
 TS_HELPER_STRUTILS="$top_builddir/test_strutils"
 TS_HELPER_SYSINFO="$top_builddir/test_sysinfo"
+TS_HELPER_UUIDGEN="$top_builddir/test_uuidgen"
 
 # paths to commands
 TS_CMD_ADDPART=${TS_CMD_ADDPART:-"$top_builddir/addpart"}
diff --git a/tests/expected/uuid/uuidgen b/tests/expected/uuid/uuidgen
new file mode 100644
index 0000000..257e4df
--- /dev/null
+++ b/tests/expected/uuid/uuidgen
@@ -0,0 +1,6 @@
+00000000-0000-0000-0000-000000000000
+return value: 0
+deadface-cafe-babe-feed-baadbeeff00d
+return value: 0
+ffffffff-ffff-ffff-ffff-ffffffffffff
+return value: 0
diff --git a/tests/ts/uuid/0x00000000 b/tests/ts/uuid/0x00000000
new file mode 100644
index 0000000000000000000000000000000000000000..01d633b27e8ea9b17084fc911d0c8cc43a4170a9
GIT binary patch
literal 16
KcmZQzKm`B*5C8!H

literal 0
HcmV?d00001

diff --git a/tests/ts/uuid/0xdeadbeef b/tests/ts/uuid/0xdeadbeef
new file mode 100644
index 0000000..11c64c5
--- /dev/null
+++ b/tests/ts/uuid/0xdeadbeef
@@ -0,0 +1 @@
+Þ­úÎÊþº¾þíº­¾ïð
*••*
\ No newline at end of file
diff --git a/tests/ts/uuid/0xffffffff b/tests/ts/uuid/0xffffffff
new file mode 100644
index 0000000..13ff23b
--- /dev/null
+++ b/tests/ts/uuid/0xffffffff
@@ -0,0 +1 @@
+ÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿÿ
\ No newline at end of file
diff --git a/tests/ts/uuid/uuidgen b/tests/ts/uuid/uuidgen
new file mode 100755
index 0000000..ec1fcaf
--- /dev/null
+++ b/tests/ts/uuid/uuidgen
@@ -0,0 +1,30 @@
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
+TS_DESC="uuidgen"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_HELPER_UUIDGEN"
+
+$TS_HELPER_UUIDGEN --file $TS_SELF/0x00000000 > $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+$TS_HELPER_UUIDGEN --file $TS_SELF/0xdeadbeef >> $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+$TS_HELPER_UUIDGEN --file $TS_SELF/0xffffffff >> $TS_OUTPUT 2>&1
+echo "return value: $?" >> $TS_OUTPUT
+
+ts_finalize
-- 
2.6.1

