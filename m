Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:49930 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753154AbaLGKOK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Dec 2014 05:14:10 -0500
Received: by mail-wi0-f172.google.com with SMTP id n3so2287646wiv.17
        for <util-linux@vger.kernel.org>; Sun, 07 Dec 2014 02:14:08 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>,
        Frodo Looijaard <frodo@frodo.looijaard.name>
Subject: [PATCH 07/11] getopt: make normalize() print strings
Date: Sun,  7 Dec 2014 10:13:51 +0000
Message-Id: <1417947235-24229-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
References: <1417947235-24229-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

A change towards less indirection, and a change to free allocated memory.

CC: Frodo Looijaard <frodo@frodo.looijaard.name>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/getopt.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/misc-utils/getopt.c b/misc-utils/getopt.c
index 4c92e30..696e87a 100644
--- a/misc-utils/getopt.c
+++ b/misc-utils/getopt.c
@@ -104,18 +104,15 @@ int (*getopt_long_fp) (int argc, char *const *argv, const char *optstr,
  * exclamation marks within single quotes, and nukes whitespace. This
  * function returns a pointer to a buffer that is overwritten by each call.
  */
-static const char *normalize(const struct getopt_control *ctl, const char *arg)
+static void normalize(const struct getopt_control *ctl, const char *arg)
 {
-	static char *BUFFER = NULL;
+	char *buf;
 	const char *argptr = arg;
 	char *bufptr;
 
-	free(BUFFER);
-
 	if (!ctl->quote) {
-		/* Just copy arg */
-		BUFFER = xstrdup(arg);
-		return BUFFER;
+		printf(" %s", arg);
+		return;
 	}
 
 	/*
@@ -124,9 +121,9 @@ static const char *normalize(const struct getopt_control *ctl, const char *arg)
 	 * and an opening quote! We need also the global opening and closing
 	 * quote, and one extra character for '\0'.
 	 */
-	BUFFER = xmalloc(strlen(arg) * 4 + 3);
+	buf = xmalloc(strlen(arg) * 4 + 3);
 
-	bufptr = BUFFER;
+	bufptr = buf;
 	*bufptr++ = '\'';
 
 	while (*argptr) {
@@ -163,7 +160,8 @@ static const char *normalize(const struct getopt_control *ctl, const char *arg)
 	}
 	*bufptr++ = '\'';
 	*bufptr++ = '\0';
-	return BUFFER;
+	printf(" %s", buf);
+	free(buf);
 }
 
 /*
@@ -195,21 +193,21 @@ static int generate_output(const struct getopt_control *ctl, char *argv[], int a
 			if (opt == LONG_OPT) {
 				printf(" --%s", ctl->long_options[longindex].name);
 				if (ctl->long_options[longindex].has_arg)
-					printf(" %s", normalize(ctl, optarg ? optarg : ""));
+					normalize(ctl, optarg ? optarg : "");
 			} else if (opt == NON_OPT)
-				printf(" %s", normalize(ctl, optarg ? optarg : ""));
+				normalize(ctl, optarg ? optarg : "");
 			else {
 				printf(" -%c", opt);
 				charptr = strchr(ctl->optstr, opt);
 				if (charptr != NULL && *++charptr == ':')
-					printf(" %s", normalize(ctl, optarg ? optarg : ""));
+					normalize(ctl, optarg ? optarg : "");
 			}
 		}
 
 	if (!ctl->quiet_output) {
 		printf(" --");
 		while (optind < argc)
-			printf(" %s", normalize(ctl, argv[optind++]));
+			normalize(ctl, argv[optind++]);
 		printf("\n");
 	}
 	return exit_code;
-- 
2.1.3

