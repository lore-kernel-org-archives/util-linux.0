Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:38058 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSQb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:16:31 -0400
Received: by mail-wi0-f169.google.com with SMTP id f14so2555760wiw.4
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:16:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/16] last: check expected numeric user input is number
Date: Sat, 17 Aug 2013 19:15:13 +0100
Message-Id: <1376763321-22782-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This commit also changes the line count to use unsigned integers, as
negative numbers in this context does not make sense.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/Makemodule.am | 2 +-
 login-utils/last.c        | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index e4361ed..8d65cc5 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -4,7 +4,7 @@ usrbin_exec_PROGRAMS += last
 dist_man_MANS += \
 	login-utils/last.1 \
 	login-utils/lastb.1
-last_SOURCES = login-utils/last.c
+last_SOURCES = login-utils/last.c lib/strutils.c
 
 install-exec-hook-last:
 	cd $(DESTDIR)$(usrsbin_execdir) && ln -sf last lastb
diff --git a/login-utils/last.c b/login-utils/last.c
index f08632b..f188092 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -46,6 +46,7 @@
 #include "xalloc.h"
 #include "closestream.h"
 #include "carefulputc.h"
+#include "strutils.h"
 
 #ifndef SHUTDOWN_TIME
 # define SHUTDOWN_TIME 254
@@ -72,8 +73,8 @@ struct utmplist *utmplist = NULL;
 #define R_TIMECHANGE	7 /* NEW_TIME or OLD_TIME */
 
 /* Global variables */
-static int maxrecs = 0;		/* Maximum number of records to list. */
-static int recsdone = 0;	/* Number of records listed */
+static unsigned int maxrecs = 0; /* Maximum number of records to list. */
+static unsigned int recsdone = 0; /* Number of records listed */
 static int showhost = 1;	/* Show hostname too? */
 static int altlist = 0;		/* Show hostname at the end. */
 static int usedns = 0;		/* Use DNS to lookup the hostname. */
@@ -540,7 +541,7 @@ int main(int argc, char **argv)
 			extended = 1;
 			break;
 		case 'n':
-			maxrecs = atoi(optarg);
+			maxrecs = strtos32_or_err(optarg, _("failed to parse number"));
 			break;
 		case 'f':
 			altufile = xstrdup(optarg);
-- 
1.8.3.4

