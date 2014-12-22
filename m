Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:39609 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754447AbaLVLrf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:35 -0500
Received: by mail-wi0-f177.google.com with SMTP id l15so7691603wiw.4
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:34 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/14] chsh: rewrite function interacting with user to get path to new shell
Date: Mon, 22 Dec 2014 11:47:10 +0000
Message-Id: <1419248837-4619-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Rename prompt() to ask_new_shell().  Remove fixed size buffer and
allocate path to new shell, that should make Hurd people happy.  Use
strutils.h for white space trimming.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chsh.c | 43 +++++++++++++++++++------------------------
 1 file changed, 19 insertions(+), 24 deletions(-)

diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 5339e55..bcd0995 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -40,6 +40,7 @@
 #include "nls.h"
 #include "pathnames.h"
 #include "setpwnam.h"
+#include "strutils.h"
 #include "xalloc.h"
 
 #include "ch-common.h"
@@ -166,34 +167,28 @@ static void parse_argv(int argc, char **argv, struct sinfo *pinfo)
 }
 
 /*
- *  prompt () --
- *	ask the user for a given field and return it.
+ *  ask_new_shell () --
+ *	ask the user for a shell and return it.
  */
-static char *prompt(char *question, char *def_val)
+static char *ask_new_shell(char *question, char *oldshell)
 {
 	int len;
-	char *ans, *cp;
-	char buf[BUFSIZ];
+	char *ans = NULL;
+	size_t dummy = 0;
+	ssize_t sz;
 
-	if (!def_val)
-		def_val = "";
-	printf("%s [%s]: ", question, def_val);
-	*buf = 0;
-	if (fgets(buf, sizeof(buf), stdin) == NULL)
-		errx(EXIT_FAILURE, _("Aborted."));
-	/* remove the newline at the end of buf. */
-	ans = buf;
-	while (isspace(*ans))
-		ans++;
-	len = strlen(ans);
-	while (len > 0 && isspace(ans[len - 1]))
-		len--;
-	if (len <= 0)
+	if (!oldshell)
+		oldshell = "";
+	printf("%s [%s]: ", question, oldshell);
+	sz = getline(&ans, &dummy, stdin);
+	if (sz == -1)
 		return NULL;
-	ans[len] = 0;
-	cp = (char *)xmalloc(len + 1);
-	strcpy(cp, ans);
-	return cp;
+	/* remove the newline at the end of ans. */
+	ltrim_whitespace((unsigned char *) ans);
+	len = rtrim_whitespace((unsigned char *) ans);
+	if (len == 0)
+		return NULL;
+	return ans;
 }
 
 /*
@@ -329,7 +324,7 @@ int main(int argc, char **argv)
 	}
 #endif
 	if (!info.shell) {
-		info.shell = prompt(_("New shell"), oldshell);
+		info.shell = ask_new_shell(_("New shell"), oldshell);
 		if (!info.shell)
 			return EXIT_SUCCESS;
 	}
-- 
2.2.1

