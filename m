Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57181 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab1LTNgM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 20 Dec 2011 08:36:12 -0500
Received: by mail-qw0-f46.google.com with SMTP id c12so2981786qad.19
        for <util-linux@vger.kernel.org>; Tue, 20 Dec 2011 05:36:11 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 3/3] tools/checkxalloc.sh: add new code checking script
Date: Tue, 20 Dec 2011 08:36:04 -0500
Message-Id: <1324388164-2112-3-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1324388164-2112-1-git-send-email-dreisner@archlinux.org>
References: <1324388164-2112-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Finds usage of strdup, malloc, calloc, and realloc when xalloc.h is
included.

http://marc.info/?l=util-linux-ng&m=132438338929925&w=2

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
Ask and you shall receive ;)

 tools/checkxalloc.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)
 create mode 100755 tools/checkxalloc.sh

diff --git a/tools/checkxalloc.sh b/tools/checkxalloc.sh
new file mode 100755
index 0000000..f8f8c8c
--- /dev/null
+++ b/tools/checkxalloc.sh
@@ -0,0 +1,14 @@
+#!/bin/sh
+#
+# Find files which include the xalloc.h header, but which still call
+# the unwrapped calloc and malloc.
+#
+
+cd "$(git rev-parse --show-toplevel)" || {
+  echo "error: failed to chdir to git root"
+  exit 1
+}
+
+git grep -zl '#include "xalloc.h"' |
+  xargs -0 grep -nwE '[^x](([cm]|re)alloc|strdup)\('
+
-- 
1.7.8

