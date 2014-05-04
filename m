Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:46460 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751071AbaEDPjp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 4 May 2014 11:39:45 -0400
Received: by mail-we0-f182.google.com with SMTP id t60so788053wes.41
        for <util-linux@vger.kernel.org>; Sun, 04 May 2014 08:39:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] column: inform user when multibyte conversion error occurs
Date: Sun,  4 May 2014 16:39:38 +0100
Message-Id: <1399217978-20252-1-git-send-email-kerolasa@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The column(1) read input until conversion error, and used incomplete
input when outputing, that made at least me to wonder where the rest
disappeared without explanation.  IMHO it is better to fail immediately
rather than do only half of the task.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tests/expected/column/invalid-multibyte |  1 +
 tests/ts/column/invalid-multibyte       | 30 ++++++++++++++++++++++++++++++
 text-utils/column.c                     |  8 +++++++-
 3 files changed, 38 insertions(+), 1 deletion(-)
 create mode 100644 tests/expected/column/invalid-multibyte
 create mode 100755 tests/ts/column/invalid-multibyte

diff --git a/tests/expected/column/invalid-multibyte b/tests/expected/column/invalid-multibyte
new file mode 100644
index 0000000..7a89472
--- /dev/null
+++ b/tests/expected/column/invalid-multibyte
@@ -0,0 +1 @@
+column: read failed: Invalid or incomplete multibyte or wide character
diff --git a/tests/ts/column/invalid-multibyte b/tests/ts/column/invalid-multibyte
new file mode 100755
index 0000000..9935a38
--- /dev/null
+++ b/tests/ts/column/invalid-multibyte
@@ -0,0 +1,30 @@
+#!/bin/bash
+
+#
+# Copyright (C) 2014 Sami Kerola <kerolasa@iki.fi>
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
+TS_DESC="invalid multibyte"
+
+. $TS_TOPDIR/functions.sh
+ts_init "$*"
+
+ts_check_test_command "$TS_CMD_COLUMN"
+
+cd $TS_OUTDIR
+
+printf "£\n" | LC_ALL=C $TS_CMD_COLUMN >> $TS_OUTPUT 2>&1
+
+ts_finalize
diff --git a/text-utils/column.c b/text-utils/column.c
index e34184e..0ee5a9e 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -376,7 +376,13 @@ static int input(FILE *fp, int *maxlength, wchar_t ***list, int *entries)
 	if (!local_list)
 		local_list = xcalloc(maxentry, sizeof(wchar_t *));
 
-	while (fgetws(buf, MAXLINELEN, fp)) {
+	while (1) {
+		if (fgetws(buf, MAXLINELEN, fp) == NULL) {
+			if (feof(fp))
+				break;
+			else
+				err(EXIT_FAILURE, _("read failed"));
+		}
 		for (p = buf; *p && iswspace(*p); ++p)
 			;
 		if (!*p)
-- 
1.9.2

