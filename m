Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36113 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163346AbdDWU6u (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:50 -0400
Received: by mail-wm0-f68.google.com with SMTP id u65so13751181wmu.3
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/10] chfn, chsh: use readline(3) to receive user input
Date: Sun, 23 Apr 2017 21:58:21 +0100
Message-Id: <20170423205821.7444-11-kerolasa@iki.fi>
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
References: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The readline offers editing capabilities while the user is entering the
line, unlike fgets(3) and getline(3) that were used earlier.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/Makemodule.am |  2 +-
 login-utils/chfn.c        | 22 ++++++++++++----------
 login-utils/chsh.c        |  8 +++-----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index be07ace43..f3397b9f4 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -82,7 +82,7 @@ chfn_chsh_sources = \
 	login-utils/ch-common.c
 chfn_chsh_cflags = $(SUID_CFLAGS) $(AM_CFLAGS)
 chfn_chsh_ldflags = $(SUID_LDFLAGS) $(AM_LDFLAGS)
-chfn_chsh_ldadd = libcommon.la
+chfn_chsh_ldadd = libcommon.la $(READLINE_LIBS)
 
 if CHFN_CHSH_PASSWORD
 chfn_chsh_ldadd += -lpam
diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index faddd89a7..6fd2a3d79 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -31,6 +31,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <readline/readline.h>
 
 #include "c.h"
 #include "env.h"
@@ -221,31 +222,32 @@ static char *ask_new_field(struct chfn_control *ctl, const char *question,
 			   char *def_val)
 {
 	int len;
-	char *ans;
-	char buf[MAX_FIELD_SIZE + 2];
+	char *buf;
 
 	if (!def_val)
 		def_val = "";
 	while (true) {
 		printf("%s [%s]: ", question, def_val);
 		__fpurge(stdin);
-		if (fgets(buf, sizeof(buf), stdin) == NULL)
+		if ((buf = readline(NULL)) == NULL)
 			errx(EXIT_FAILURE, _("Aborted."));
-		ans = buf;
 		/* remove white spaces from string end */
-		ltrim_whitespace((unsigned char *) ans);
-		len = rtrim_whitespace((unsigned char *) ans);
-		if (len == 0)
+		ltrim_whitespace((unsigned char *) buf);
+		len = rtrim_whitespace((unsigned char *) buf);
+		if (len == 0) {
+			free(buf);
 			return xstrdup(def_val);
-		if (!strcasecmp(ans, "none")) {
+		}
+		if (!strcasecmp(buf, "none")) {
+			free(buf);
 			ctl->changed = 1;
 			return xstrdup("");
 		}
-		if (check_gecos_string(question, ans) >= 0)
+		if (check_gecos_string(question, buf) >= 0)
 			break;
 	}
 	ctl->changed = 1;
-	return xstrdup(ans);
+	return buf;
 }
 
 /*
diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 979a287fe..69f6cf53c 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -31,6 +31,7 @@
 #include <string.h>
 #include <sys/types.h>
 #include <unistd.h>
+#include <readline/readline.h>
 
 #include "c.h"
 #include "env.h"
@@ -172,15 +173,12 @@ static void parse_argv(int argc, char **argv, struct sinfo *pinfo)
 static char *ask_new_shell(char *question, char *oldshell)
 {
 	int len;
-	char *ans = NULL;
-	size_t dummy = 0;
-	ssize_t sz;
+	char *ans;
 
 	if (!oldshell)
 		oldshell = "";
 	printf("%s [%s]: ", question, oldshell);
-	sz = getline(&ans, &dummy, stdin);
-	if (sz == -1)
+	if ((ans = readline(NULL)) == NULL)
 		return NULL;
 	/* remove the newline at the end of ans. */
 	ltrim_whitespace((unsigned char *) ans);
-- 
2.12.2

