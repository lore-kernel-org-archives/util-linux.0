Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:57943 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbaLVLrg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:36 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so6440926wgh.32
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:35 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/14] chsh: fail get_shell_list() check when /etc/shells cannot be opened
Date: Mon, 22 Dec 2014 11:47:12 +0000
Message-Id: <1419248837-4619-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And get rid of stdbool.h true/false usage.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chsh.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 3c51783..a84e3ff 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -26,7 +26,6 @@
 #include <errno.h>
 #include <getopt.h>
 #include <pwd.h>
-#include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
@@ -87,16 +86,15 @@ static void __attribute__((__noreturn__)) usage (FILE *fp)
 static int get_shell_list(const char *shell_name)
 {
 	FILE *fp;
-	int found;
+	int found = 0;
 	char *buf = NULL;
 	size_t sz = 0, len;
 
-	found = false;
 	fp = fopen(_PATH_SHELLS, "r");
 	if (!fp) {
 		if (!shell_name)
 			warnx(_("No known shells."));
-		return true;
+		return 0;
 	}
 	while (getline(&buf, &sz, fp) != -1) {
 		len = strlen(buf);
@@ -112,7 +110,7 @@ static int get_shell_list(const char *shell_name)
 		/* check or output the shell */
 		if (shell_name) {
 			if (!strcmp(shell_name, buf)) {
-				found = true;
+				found = 1;
 				break;
 			}
 		} else
-- 
2.2.1

