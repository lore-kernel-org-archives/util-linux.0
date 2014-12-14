Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:36007 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752172AbaLNRpY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:24 -0500
Received: by mail-wg0-f45.google.com with SMTP id b13so12844023wgh.4
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:23 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/16] chfn: rewrite prompt() to use strutils
Date: Sun, 14 Dec 2014 17:44:05 +0000
Message-Id: <1418579052-29386-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The left and right white space trimming can be done with strutils.h
[lr]trim_whitespace() functions.

As a minor fix when user input exceeds maxium allowed gecos field length
the remaining characters in stdin are purged so that re-prompting works
correctly.

Additionally the prompt() is made to add message to check_gecos_string(),
so that there are less similar strings for translation project to deal.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c | 59 ++++++++++++++++++------------------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 35d00f9..ca6f456 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -54,8 +54,6 @@
 # include "auth.h"
 #endif
 
-static char buf[1024];
-
 struct finfo {
 	struct passwd *pw;
 	char *username;
@@ -90,34 +88,23 @@ static void __attribute__((__noreturn__)) usage(FILE *fp)
  *	check that the given gecos string is legal.  if it's not legal,
  *	output "msg" followed by a description of the problem, and return (-1).
  */
-static int check_gecos_string(char *msg, char *gecos)
+static int check_gecos_string(const char *msg, char *gecos)
 {
 	unsigned int i, c;
+	const size_t len = strlen(gecos);
 
-	if (strlen(gecos) > MAX_FIELD_SIZE) {
-		if (msg)
-			warnx(_("field %s is too long"), msg);
-		else
-			warnx(_("field is too long"));
+	if (MAX_FIELD_SIZE < len) {
+		warnx(_("field %s is too long"), msg);
 		return -1;
 	}
-
-	for (i = 0; i < strlen(gecos); i++) {
+	for (i = 0; i < len; i++) {
 		c = gecos[i];
 		if (c == ',' || c == ':' || c == '=' || c == '"' || c == '\n') {
-			if (msg)
-				warnx(_("%s: '%c' is not allowed"), msg, c);
-			else
-				warnx(_("'%c' is not allowed"), c);
+			warnx(_("%s: '%c' is not allowed"), msg, c);
 			return -1;
 		}
 		if (iscntrl(c)) {
-			if (msg)
-				warnx(_
-				      ("%s: control characters are not allowed"),
-				      msg);
-			else
-				warnx(_("control characters are not allowed"));
+			warnx(_("%s: control characters are not allowed"), msg);
 			return -1;
 		}
 	}
@@ -246,37 +233,31 @@ static void parse_passwd(struct passwd *pw, struct finfo *pinfo)
  *  prompt () --
  *	ask the user for a given field and check that the string is legal.
  */
-static char *prompt(char *question, char *def_val)
+static char *prompt(const char *question, char *def_val)
 {
-	static char *blank = "none";
 	int len;
-	char *ans, *cp;
+	char *ans;
+	char buf[MAX_FIELD_SIZE + 2];
 
+	if (!def_val)
+		def_val = "";
 	while (true) {
-		if (!def_val)
-			def_val = "";
 		printf("%s [%s]: ", question, def_val);
-		*buf = 0;
+		__fpurge(stdin);
 		if (fgets(buf, sizeof(buf), stdin) == NULL)
 			errx(EXIT_FAILURE, _("Aborted."));
-		/* remove the newline at the end of buf. */
 		ans = buf;
-		while (isspace(*ans))
-			ans++;
-		len = strlen(ans);
-		while (len > 0 && isspace(ans[len - 1]))
-			len--;
-		if (len <= 0)
+		/* remove white spaces from string end */
+		ltrim_whitespace((unsigned char *) ans);
+		len = rtrim_whitespace((unsigned char *) ans);
+		if (len == 0)
 			return NULL;
-		ans[len] = 0;
-		if (!strcasecmp(ans, blank))
+		if (!strcasecmp(ans, "none"))
 			return "";
-		if (check_gecos_string(NULL, ans) >= 0)
+		if (check_gecos_string(question, ans) >= 0)
 			break;
 	}
-	cp = (char *)xmalloc(len + 1);
-	strcpy(cp, ans);
-	return cp;
+	return xstrdup(ans);
 }
 
 /*
-- 
2.1.3

