Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34867 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751177AbdLCMvX (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 3 Dec 2017 07:51:23 -0500
Received: by mail-wm0-f67.google.com with SMTP id f9so9993259wmh.0
        for <util-linux@vger.kernel.org>; Sun, 03 Dec 2017 04:51:23 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/4] rename: use access(3) to check if a file exists
Date: Sun,  3 Dec 2017 12:51:15 +0000
Message-Id: <20171203125117.28159-2-kerolasa@iki.fi>
In-Reply-To: <20171203125117.28159-1-kerolasa@iki.fi>
References: <20171203125117.28159-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is more lightweight than calling stat(3).  In same go add a regression
test to ensure changes like this will not break --no-overwrite option.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/rename.c             |  3 +--
 tests/expected/rename/overwrite |  1 +
 tests/ts/rename/overwrite       | 31 +++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 2 deletions(-)
 create mode 100644 tests/expected/rename/overwrite
 create mode 100755 tests/ts/rename/overwrite

diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index 7c3cdf67d..cbda638e1 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -105,7 +105,6 @@ static int do_file(char *from, char *to, char *s, int verbose, int noact, int no
 {
 	char *newname = NULL, *file=NULL;
 	int ret = 1;
-	struct stat sb;
 
 	if (strchr(from, '/') == NULL && strchr(to, '/') == NULL)
 		file = strrchr(s, '/');
@@ -113,7 +112,7 @@ static int do_file(char *from, char *to, char *s, int verbose, int noact, int no
 		file = s;
 	if (string_replace(from, to, file, s, &newname))
 		return 0;
-	if (nooverwrite && stat(newname, &sb) == 0) {
+	if (nooverwrite && access(newname, F_OK) == 0) {
 		printf(_("Skipping existing file: `%s'\n"), newname);
 		ret = 0;
 	}
diff --git a/tests/expected/rename/overwrite b/tests/expected/rename/overwrite
new file mode 100644
index 000000000..b16f799c3
--- /dev/null
+++ b/tests/expected/rename/overwrite
@@ -0,0 +1 @@
+Skipping existing file: `rename_to'
diff --git a/tests/ts/rename/overwrite b/tests/ts/rename/overwrite
new file mode 100755
index 000000000..be5b24d03
--- /dev/null
+++ b/tests/ts/rename/overwrite
@@ -0,0 +1,31 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2017 Sami Kerola <kerolasa@iki.fi>
+#
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
+#
+TS_TOPDIR="${0%/*}/../.."
+TS_DESC="overwrite"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_RENAME"
+ts_cd "$TS_OUTDIR"
+
+touch rename_from rename_to
+$TS_CMD_RENAME -v --no-overwrite from to rename_from > $TS_OUTPUT 2>&1
+rm rename_from rename_to >> $TS_OUTPUT 2>&1
+
+ts_finalize
-- 
2.15.1

