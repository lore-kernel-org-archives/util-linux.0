Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f42.google.com ([74.125.83.42]:60929 "EHLO
	mail-ee0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab3H0SGp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 27 Aug 2013 14:06:45 -0400
Received: by mail-ee0-f42.google.com with SMTP id b45so2442065eek.29
        for <util-linux@vger.kernel.org>; Tue, 27 Aug 2013 11:06:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/17] wall: sync usage() with howto-usage-function.txt
Date: Tue, 27 Aug 2013 19:06:06 +0100
Message-Id: <1377626779-26030-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
References: <1377626779-26030-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/wall.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/term-utils/wall.c b/term-utils/wall.c
index 98dc5c7..451b5d3 100644
--- a/term-utils/wall.c
+++ b/term-utils/wall.c
@@ -77,16 +77,16 @@ static char *makemsg(char *fname, char **mvec, int mvecsz,
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
-		_(" %s [options] [<file> | <message>]\n"),
-		program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -n, --nobanner          do not print banner, works only for root\n"
-		" -t, --timeout <timeout> write timeout in seconds\n"
-		" -V, --version           output version information and exit\n"
-		" -h, --help              display this help and exit\n\n"), out);
+	      _(" %s [options] [<file> | <message>]\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -n, --nobanner          do not print banner, works only for root\n"), out);
+	fputs(_(" -t, --timeout <timeout> write timeout in seconds\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("wall(1)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
@@ -132,8 +132,7 @@ int main(int argc, char **argv)
 				errx(EXIT_FAILURE, _("invalid timeout argument: %s"), optarg);
 			break;
 		case 'V':
-			printf(_("%s from %s\n"), program_invocation_short_name,
-						  PACKAGE_STRING);
+			printf(UTIL_LINUX_VERSION);
 			exit(EXIT_SUCCESS);
 		case 'h':
 			usage(stdout);
-- 
1.8.4

