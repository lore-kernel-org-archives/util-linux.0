Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:52099 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751982AbbBVOmC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:02 -0500
Received: by mail-wi0-f182.google.com with SMTP id l15so11674745wiw.3
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:01 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/16] tunelp: remove get_val() in favour of strtol_or_err()
Date: Sun, 22 Feb 2015 14:41:35 +0000
Message-Id: <1424616106-580-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/Makemodule.am |  1 +
 sys-utils/tunelp.c      | 22 ++++++++--------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 14d0773..c8f1c42 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -50,6 +50,7 @@ if BUILD_TUNELP
 usrsbin_exec_PROGRAMS += tunelp
 dist_man_MANS += sys-utils/tunelp.8
 tunelp_SOURCES = sys-utils/tunelp.c sys-utils/lp.h
+tunelp_LDADD = $(LDADD) libcommon.la
 endif
 
 if BUILD_FSTRIM
diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index b132d7a..197b093 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -74,8 +74,10 @@
 #include "xalloc.h"
 #include "closestream.h"
 
-#define EXIT_BAD_VALUE	3
-#define EXIT_LP_IO_ERR	4
+#define STRTOXX_EXIT_CODE	3
+#define EXIT_LP_IO_ERR		4
+
+#include "strutils.h"
 
 struct command {
 	long op;
@@ -114,14 +116,6 @@ static void __attribute__((__noreturn__)) print_usage(FILE *out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-static long get_val(char *val)
-{
-	long ret;
-	if (!(sscanf(val, "%ld", &ret) == 1))
-		errx(EXIT_BAD_VALUE, _("bad value"));
-	return ret;
-}
-
 static long get_onoff(char *val)
 {
 	if (!strncasecmp("on", val, 2))
@@ -171,28 +165,28 @@ int main(int argc, char **argv)
 			break;
 		case 'i':
 			cmds->op = LPSETIRQ;
-			cmds->val = get_val(optarg);
+			cmds->val = strtol_or_err(optarg, _("argument error"));
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = 0;
 			break;
 		case 't':
 			cmds->op = LPTIME;
-			cmds->val = get_val(optarg);
+			cmds->val = strtol_or_err(optarg, _("argument error"));
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = 0;
 			break;
 		case 'c':
 			cmds->op = LPCHAR;
-			cmds->val = get_val(optarg);
+			cmds->val = strtol_or_err(optarg, _("argument error"));
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = 0;
 			break;
 		case 'w':
 			cmds->op = LPWAIT;
-			cmds->val = get_val(optarg);
+			cmds->val = strtol_or_err(optarg, _("argument error"));
 			cmds->next = xmalloc(sizeof(struct command));
 			cmds = cmds->next;
 			cmds->next = 0;
-- 
2.3.0

