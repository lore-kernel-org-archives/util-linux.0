Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:51913 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753009AbaLGKOM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:12 -0500
Received: by mail-wi0-f181.google.com with SMTP id r20so2317094wiv.14
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:11 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 09/11] getopt: prefer switch-case rather than long if statement
Date: Sun,  7 Dec 2014 10:13:53 +0000
Message-Id: <1417947235-24229-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And avoid testing same thing time after time.

CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 64 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 67603b5..8134558 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -122,42 +122,49 @@ static void normalize(const struct getopt_control *ctl, const char *arg)
 	 * quote, and one extra character for '\0'.
 	 */
 	buf = xmalloc(strlen(arg) * 4 + 3);
-
 	bufptr = buf;
-	*bufptr++ = '\'';
 
-	while (*argptr) {
+	for (*bufptr++ = '\''; *argptr; argptr++) {
+		if (ctl->shell == TCSH) {
+			switch (*argptr) {
+			case '\\':
+				/* Backslash: replace it with: '\\' */
+				*bufptr++ = '\\';
+				*bufptr++ = '\\';
+				continue;
+			case '!':
+				/* Exclamation mark: replace it with: \! */
+				*bufptr++ = '\'';
+				*bufptr++ = '\\';
+				*bufptr++ = '!';
+				*bufptr++ = '\'';
+				continue;
+			case '\n':
+				/* Newline: replace it with: \n */
+				*bufptr++ = '\\';
+				*bufptr++ = 'n';
+				continue;
+			}
+			if (isspace(*argptr)) {
+				/* Non-newline whitespace: replace it with \<ws> */
+				*bufptr++ = '\'';
+				*bufptr++ = '\\';
+				*bufptr++ = *argptr;
+				*bufptr++ = '\'';
+				continue;
+			}
+		}
 		if (*argptr == '\'') {
 			/* Quote: replace it with: '\'' */
 			*bufptr++ = '\'';
 			*bufptr++ = '\\';
 			*bufptr++ = '\'';
 			*bufptr++ = '\'';
-		} else if (ctl->shell == TCSH && *argptr == '\\') {
-			/* Backslash: replace it with: '\\' */
-			*bufptr++ = '\\';
-			*bufptr++ = '\\';
-		} else if (ctl->shell == TCSH && *argptr == '!') {
-			/* Exclamation mark: replace it with: \! */
-			*bufptr++ = '\'';
-			*bufptr++ = '\\';
-			*bufptr++ = '!';
-			*bufptr++ = '\'';
-		} else if (ctl->shell == TCSH && *argptr == '\n') {
-			/* Newline: replace it with: \n */
-			*bufptr++ = '\\';
-			*bufptr++ = 'n';
-		} else if (ctl->shell == TCSH && isspace(*argptr)) {
-			/* Non-newline whitespace: replace it with \<ws> */
-			*bufptr++ = '\'';
-			*bufptr++ = '\\';
-			*bufptr++ = *argptr;
-			*bufptr++ = '\'';
 		} else
 			/* Just copy */
 			*bufptr++ = *argptr;
-		argptr++;
 	}
+
 	*bufptr++ = '\'';
 	*bufptr++ = '\0';
 	printf(" %s", buf);
@@ -190,13 +197,16 @@ static int generate_output(const struct getopt_control *ctl, char *argv[], int a
 		if (opt == '?' || opt == ':')
 			exit_code = GETOPT_EXIT_CODE;
 		else if (!ctl->quiet_output) {
-			if (opt == LONG_OPT) {
+			switch (opt) {
+			case LONG_OPT:
 				printf(" --%s", ctl->long_options[longindex].name);
 				if (ctl->long_options[longindex].has_arg)
 					normalize(ctl, optarg ? optarg : "");
-			} else if (opt == NON_OPT)
+				break;
+			case NON_OPT:
 				normalize(ctl, optarg ? optarg : "");
-			else {
+				break;
+			default:
 				printf(" -%c", opt);
 				charptr = strchr(ctl->optstr, opt);
 				if (charptr != NULL && *++charptr == ':')
-- 
2.1.3

