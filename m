Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:49988 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750837AbaI1TwJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:09 -0400
Received: by mail-wg0-f48.google.com with SMTP id x13so9009096wgg.7
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/23] docs: update deprecation banners
Date: Sun, 28 Sep 2014 20:51:35 +0100
Message-Id: <1411933916-30576-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.c    | 9 +++++++++
 login-utils/newgrp.c | 9 ---------
 login-utils/vipw.c   | 9 ---------
 sys-utils/tunelp.c   | 9 +++++++++
 text-utils/col.c     | 9 +++++++++
 text-utils/pg.c      | 9 +++++++++
 6 files changed, 36 insertions(+), 18 deletions(-)

diff --git a/disk-utils/mkfs.c b/disk-utils/mkfs.c
index cb34951..5bdb931 100644
--- a/disk-utils/mkfs.c
+++ b/disk-utils/mkfs.c
@@ -13,6 +13,15 @@
  *	
  */
 
+/*
+ * This command is deprecated.  The utility is in maintenance mode,
+ * meaning we keep them in source tree for backward compatibility
+ * only.  Do not waste time making this command better, unless the
+ * fix is about security or other very critical issue.
+ *
+ * See Documentation/deprecated.txt for more information.
+ */
+
 #include <getopt.h>
 #include <limits.h>
 #include <stdio.h>
diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 9c0f8f5..a5b1ef2 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -6,15 +6,6 @@
  * - added Native Language Support
  */
 
-/*
- * This command is deprecated.  The utility is in maintenance mode,
- * meaning we keep them in source tree for backward compatibility
- * only.  Do not waste time making this command better, unless the
- * fix is about security or other very critical issue.
- *
- * See Documentation/deprecated.txt for more information.
- */
-
 #include <errno.h>
 #include <getopt.h>
 #include <grp.h>
diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 6ca5f8c..ca90f65 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -44,15 +44,6 @@
  * - fixed strerr(errno) in gettext calls
  */
 
-/*
- * This command is deprecated.  The utility is in maintenance mode,
- * meaning we keep them in source tree for backward compatibility
- * only.  Do not waste time making this command better, unless the
- * fix is about security or other very critical issue.
- *
- * See Documentation/deprecated.txt for more information.
- */
-
 #include <errno.h>
 #include <fcntl.h>
 #include <paths.h>
diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index f9c362c..7beb8a7 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -7,6 +7,15 @@
  */
 
 /*
+ * This command is deprecated.  The utility is in maintenance mode,
+ * meaning we keep them in source tree for backward compatibility
+ * only.  Do not waste time making this command better, unless the
+ * fix is about security or other very critical issue.
+ *
+ * See Documentation/deprecated.txt for more information.
+ */
+
+/*
  * $Log: tunelp.c,v $
  * Revision 1.9  1998/06/08 19:37:11  janl
  * Thus compiles tunelp with 2.1.103 kernels
diff --git a/text-utils/col.c b/text-utils/col.c
index 9aa6a41..997f87b 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -44,6 +44,15 @@
  *
  */
 
+/*
+ * This command is deprecated.  The utility is in maintenance mode,
+ * meaning we keep them in source tree for backward compatibility
+ * only.  Do not waste time making this command better, unless the
+ * fix is about security or other very critical issue.
+ *
+ * See Documentation/deprecated.txt for more information.
+ */
+
 #include <stdlib.h>
 #include <errno.h>
 #include <ctype.h>
diff --git a/text-utils/pg.c b/text-utils/pg.c
index e9156c3..9ada00c 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -31,6 +31,15 @@
 
 /* Sccsid @(#)pg.c 1.44 (gritter) 2/8/02 - modified for util-linux */
 
+/*
+ * This command is deprecated.  The utility is in maintenance mode,
+ * meaning we keep them in source tree for backward compatibility
+ * only.  Do not waste time making this command better, unless the
+ * fix is about security or other very critical issue.
+ *
+ * See Documentation/deprecated.txt for more information.
+ */
+
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <sys/stat.h>
-- 
2.1.1

