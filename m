Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58484 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757507Ab2CETjH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:07 -0500
Received: by eaaq12 with SMTP id q12so1565228eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:06 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/17] docs: add deprecation comments
Date: Mon,  5 Mar 2012 20:38:38 +0100
Message-Id: <1330976334-10751-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Markup deprecation to command header to avoid people wasting time in
fixing these utilities.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/elvtune.c |    9 +++++++++
 login-utils/last.c   |    9 +++++++++
 login-utils/newgrp.c |    9 +++++++++
 login-utils/vipw.c   |    9 +++++++++
 sys-utils/arch.c     |    9 +++++++++
 text-utils/line.c    |    9 +++++++++
 6 files changed, 54 insertions(+)

diff --git a/disk-utils/elvtune.c b/disk-utils/elvtune.c
index 7c3caed..7c074ff 100644
--- a/disk-utils/elvtune.c
+++ b/disk-utils/elvtune.c
@@ -18,6 +18,15 @@
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
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
 #include <fcntl.h>
 #include <errno.h>
 #include <stdio.h>
diff --git a/login-utils/last.c b/login-utils/last.c
index 734730b..417314e 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -27,6 +27,15 @@
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
  * last
  */
 #include <sys/param.h>
diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 9839934..707c589 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -6,6 +6,15 @@
  * - added Native Language Support
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
 #include <errno.h>
 #include <getopt.h>
 #include <grp.h>
diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 92b4231..c0ed0b3 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -44,6 +44,15 @@
  * - fixed strerr(errno) in gettext calls
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
 #include <errno.h>
 #include <fcntl.h>
 #include <paths.h>
diff --git a/sys-utils/arch.c b/sys-utils/arch.c
index 0c29c3e..470b12b 100644
--- a/sys-utils/arch.c
+++ b/sys-utils/arch.c
@@ -18,6 +18,15 @@
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
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
 #include <err.h>
 #include <errno.h>
 #include <getopt.h>
diff --git a/text-utils/line.c b/text-utils/line.c
index 826e5a2..636122e 100644
--- a/text-utils/line.c
+++ b/text-utils/line.c
@@ -6,6 +6,15 @@
  * Public Domain.
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
 #include	<stdio.h>
 #include	<unistd.h>
 
-- 
1.7.9.2

