Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f177.google.com ([209.85.215.177]:40771 "EHLO
	mail-ea0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3H0SGt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:06:49 -0400
Received: by mail-ea0-f177.google.com with SMTP id f15so2412638eak.22
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:06:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/17] mesg: sync usage() with howto-usage-function.txt
Date: Tue, 27 Aug 2013 19:06:07 +0100
Message-Id: <1377626779-26030-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/mesg.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index 430236f..097fb9c 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -68,16 +68,16 @@
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	/* TRANSLATORS: this program uses for y and n rpmatch(3),
 	 * which means they can be translated.  */
 	fprintf(out,
 	      _(" %s [options] [y | n]\n"), program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -v, --verbose      explain what is being done\n"
-		" -V, --version      output version information and exit\n"
-		" -h, --help         output help screen and exit\n\n"), out);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -v, --verbose  explain what is being done\n"), out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("mesg(1)"));
 
 	exit(out == stderr ? MESG_EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -106,8 +106,7 @@ int main(int argc, char *argv[])
 			verbose = TRUE;
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-			PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
 		case 'h':
 			usage(stdout);
-- 
1.8.4

