Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:36631 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab3CGX1m (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Mar 2013 18:27:42 -0500
Received: by mail-we0-f169.google.com with SMTP id t11so321082wey.14
        for <util-linux@vger.kernel.org>; Thu, 07 Mar 2013 15:27:41 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 5/7] kill, procs: move function declarations to kill.h
Date: Thu,  7 Mar 2013 23:27:22 +0000
Message-Id: <1362698844-21292-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
References: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c  | 2 --
 misc-utils/kill.h  | 8 +++++++-
 misc-utils/procs.c | 1 -
 3 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 5e349c8..b0145cd 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -139,8 +139,6 @@ struct signv {
 #endif
 };
 
-extern char *mybasename(char *);
-
 static int arg_to_signum(char *arg, int mask);
 static void nosig(char *name);
 static void printsig(int sig);
diff --git a/misc-utils/kill.h b/misc-utils/kill.h
index 27a12a8..43c6ed7 100644
--- a/misc-utils/kill.h
+++ b/misc-utils/kill.h
@@ -1 +1,7 @@
-extern int *get_pids (char *process_name, int get_all);
+#ifndef UTIL_LINUX_KILL
+#define UTIL_LINUX_KILL
+
+extern int *get_pids(char *process_name, int get_all);
+extern char *mybasename(char *);
+
+#endif
diff --git a/misc-utils/procs.c b/misc-utils/procs.c
index 071a63a..544966e 100644
--- a/misc-utils/procs.c
+++ b/misc-utils/procs.c
@@ -23,7 +23,6 @@
 #include "kill.h"
 #include "xalloc.h"
 
-extern char *mybasename(char *);
 static char *parse_parens(char *buf);
 
 int *get_pids(char *process_name, int get_all)
-- 
1.8.1.5

