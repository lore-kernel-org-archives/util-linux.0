Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:41814 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX13 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:29 -0500
Received: by mail-wi0-f170.google.com with SMTP id hq7so3881941wib.3
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:27 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/14] su-common: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:03 +0000
Message-Id: <1358897233-6676-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/su-common.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 9daae72..47e05ff 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -646,18 +646,16 @@ usage (int status)
     fputs(USAGE_OPTIONS, stdout);
   }
 
-  fputs (_(
-    " -m, -p, --preserve-environment  do not reset environment variables\n"
-    " -g, --group <group>             specify the primary group\n"
-    " -G, --supp-group <group>        specify a supplemental group\n\n"), stdout);
-
-  fputs (_(
-    " -, -l, --login                  make the shell a login shell\n"
-    " -c, --command <command>         pass a single command to the shell with -c\n"
-    " --session-command <command>     pass a single command to the shell with -c\n"
-    "                                 and do not create a new session\n"
-    " -f, --fast                      pass -f to the shell (for csh or tcsh)\n"
-    " -s, --shell <shell>             run shell if /etc/shells allows it\n"), stdout);
+  fputs (_(" -m, -p, --preserve-environment  do not reset environment variables\n"), stdout);
+  fputs (_(" -g, --group <group>             specify the primary group\n"), stdout);
+  fputs (_(" -G, --supp-group <group>        specify a supplemental group\n\n"), stdout);
+
+  fputs (_(" -, -l, --login                  make the shell a login shell\n"), stdout);
+  fputs (_(" -c, --command <command>         pass a single command to the shell with -c\n"), stdout);
+  fputs (_(" --session-command <command>     pass a single command to the shell with -c\n"), stdout);
+  fputs (_("                                 and do not create a new session\n"), stdout);
+  fputs (_(" -f, --fast                      pass -f to the shell (for csh or tcsh)\n"), stdout);
+  fputs (_(" -s, --shell <shell>             run shell if /etc/shells allows it\n"), stdout);
 
   fputs(USAGE_SEPARATOR, stdout);
   fputs(USAGE_HELP, stdout);
-- 
1.8.1.1

