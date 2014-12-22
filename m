Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:62005 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754558AbaLVLra (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:30 -0500
Received: by mail-wi0-f180.google.com with SMTP id n3so7683215wiv.7
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:29 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/14] chsh: use getline() to support arbitrarily long lines
Date: Mon, 22 Dec 2014 11:47:06 +0000
Message-Id: <1419248837-4619-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use of fgets() can make a single long line to be understood as two
entries, and someone could play tricks with the remainder part of the
buffer.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chsh.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 2245f41..9ed4d06 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -87,8 +87,8 @@ static int get_shell_list(char *shell_name)
 {
 	FILE *fp;
 	int found;
-	int len;
-	char buf[PATH_MAX];
+	char *buf = NULL;
+	size_t sz = 0, len;
 
 	found = false;
 	fp = fopen(_PATH_SHELLS, "r");
@@ -97,17 +97,17 @@ static int get_shell_list(char *shell_name)
 			warnx(_("No known shells."));
 		return true;
 	}
-	while (fgets(buf, sizeof(buf), fp) != NULL) {
+	while (getline(&buf, &sz, fp) != -1) {
+		len = strlen(buf);
 		/* ignore comments */
 		if (*buf == '#')
 			continue;
-		len = strlen(buf);
+		/* skip blank lines*/
+		if (len < 2)
+			continue;
 		/* strip the ending newline */
 		if (buf[len - 1] == '\n')
 			buf[len - 1] = 0;
-		/* ignore lines that are too damn long */
-		else
-			continue;
 		/* check or output the shell */
 		if (shell_name) {
 			if (!strcmp(shell_name, buf)) {
@@ -118,6 +118,7 @@ static int get_shell_list(char *shell_name)
 			printf("%s\n", buf);
 	}
 	fclose(fp);
+	free(buf);
 	return found;
 }
 
-- 
2.2.1

