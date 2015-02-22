Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:33428 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752028AbbBVOmK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:10 -0500
Received: by wevk48 with SMTP id k48so13647348wev.0
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:09 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 13/16] tailf: do not allow minus signed last lines argument
Date: Sun, 22 Feb 2015 14:41:43 +0000
Message-Id: <1424616106-580-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Before mmap() the command behavior was not completely correct, as
demonstrated below, and after the mmap() it tried to print some eighteen
quintillion lines.

$ tailf -n-1 x
tailf: cannot allocate 18446744073709543424 bytes: Cannot allocate memory

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/tailf.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index b5ea4c2..d856203 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -213,16 +213,16 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 }
 
 /* parses -N option */
-static long old_style_option(int *argc, char **argv)
+static long old_style_option(int *argc, char **argv, unsigned long *lines)
 {
-	int i = 1, nargs = *argc;
-	long lines = -1;
+	int i = 1, nargs = *argc, ret = 0;
 
 	while(i < nargs) {
 		if (argv[i][0] == '-' && isdigit(argv[i][1])) {
-			lines = strtol_or_err(argv[i] + 1,
+			*lines = strtoul_or_err(argv[i] + 1,
 					_("failed to parse number of lines"));
 			nargs--;
+			ret = 1;
 			if (nargs - i)
 				memmove(argv + i, argv + i + 1,
 						sizeof(char *) * (nargs - i));
@@ -230,13 +230,13 @@ static long old_style_option(int *argc, char **argv)
 			i++;
 	}
 	*argc = nargs;
-	return lines;
+	return ret;
 }
 
 int main(int argc, char **argv)
 {
 	const char *filename;
-	long lines;
+	unsigned long lines;
 	int ch;
 	struct stat old;
 
@@ -252,16 +252,18 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	lines = old_style_option(&argc, argv);
-	if (lines < 0)
+	if (!old_style_option(&argc, argv, &lines))
 		lines = DEFAULT_LINES;
 
 	while ((ch = getopt_long(argc, argv, "n:N:Vh", longopts, NULL)) != -1)
-		switch((char)ch) {
+		switch ((char)ch) {
 		case 'n':
 		case 'N':
-			lines = strtol_or_err(optarg,
-					_("failed to parse number of lines"));
+			if (optarg[0] == '-')
+				errx(EXIT_FAILURE, "%s: %s",
+				     _("failed to parse number of lines"), optarg);
+			lines =
+			    strtoul_or_err(optarg, _("failed to parse number of lines"));
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
-- 
2.3.0

