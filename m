Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:49379 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbBVOmM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:12 -0500
Received: by mail-wi0-f170.google.com with SMTP id hi2so14685188wib.1
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:11 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 15/16] logger: move /dev/log to pathnames.h
Date: Sun, 22 Feb 2015 14:41:45 +0000
Message-Id: <1424616106-580-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/pathnames.h | 3 +++
 misc-utils/logger.c | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index cbc93b7..cc01589 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -193,5 +193,8 @@
 /* kernel command line */
 #define _PATH_PROC_CMDLINE	"/proc/cmdline"
 
+/* logger paths */
+#define _PATH_DEVLOG		"/dev/log"
+
 #endif /* PATHNAMES_H */
 
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index a3af7f1..db6fd44 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -56,6 +56,7 @@
 #include "c.h"
 #include "closestream.h"
 #include "nls.h"
+#include "pathnames.h"
 #include "strutils.h"
 #include "xalloc.h"
 
@@ -481,7 +482,7 @@ static void logger_open(struct logger_ctl *ctl)
 			ctl->syslogfp = syslog_rfc5424;
 		return;
 	}
-	ctl->fd = unix_socket(ctl, "/dev/log", ctl->socket_type);
+	ctl->fd = unix_socket(ctl, _PATH_DEVLOG, ctl->socket_type);
 	ctl->syslogfp = syslog_local;
 }
 
-- 
2.3.0

