Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:36161 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752551AbbF1Tni (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Jun 2015 15:43:38 -0400
Received: by wguu7 with SMTP id u7so125255648wgu.3
        for <util-linux@vger.kernel.org>; Sun, 28 Jun 2015 12:43:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 7/7] reset: deprecate the script, and remove reset.033c
Date: Sun, 28 Jun 2015 20:43:25 +0100
Message-Id: <1435520605-4296-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
References: <1435520605-4296-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Most distributions probably ship reset from ncurses, which means
util-linux reset(1) is unlikely to be in use anywhere.  Assuming the
previous being true it is almost unimaginable anyone one would be using
the alternative script, so remove it and mark the script deprecated.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/deprecated.txt |  5 +++++
 term-utils/Makemodule.am     |  1 -
 term-utils/reset             |  6 ++++++
 term-utils/reset.033c        | 11 -----------
 4 files changed, 11 insertions(+), 12 deletions(-)
 delete mode 100755 term-utils/reset.033c

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index a32833f..e63675a 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -93,6 +93,11 @@ Why:	parallel port printers are probably almost extinct devices
 
 ----------------------------
 
+What:	reset
+Why:	ncurses has better reset(1)
+
+----------------------------
+
 The Single UNIX(TM) Specification, Version 2
 Copyright (C) 1997 The Open Group
 
diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index 75cc922..e8c26d3 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -55,7 +55,6 @@ if BUILD_RESET
 dist_usrbin_exec_SCRIPTS += term-utils/reset
 dist_man_MANS += term-utils/reset.1
 endif
-EXTRA_DIST += term-utils/reset.033c
 
 
 if BUILD_MESG
diff --git a/term-utils/reset b/term-utils/reset
index 68de82e..43f83cb 100755
--- a/term-utils/reset
+++ b/term-utils/reset
@@ -1,4 +1,10 @@
 #!/bin/sh
+# This command is deprecated.  The utility is in maintenance mode,
+# meaning we keep them in source tree for backward compatibility
+# only.  Do not waste time making this command better, unless the
+# fix is about security or other very critical issue.
+#
+# See Documentation/deprecated.txt for more information.
 stty sane
 tput clear
 tput rmacs
diff --git a/term-utils/reset.033c b/term-utils/reset.033c
deleted file mode 100755
index fc7fad6..0000000
--- a/term-utils/reset.033c
+++ /dev/null
@@ -1,11 +0,0 @@
-#!/bin/sh
-stty sane
-tput clear
-tput rmacs
-tput rmm
-tput rmso
-tput rmul
-tput rs1
-tput rs2
-tput rs3
-printf "\\033c\n"
-- 
2.4.4

