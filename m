Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:38839 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118AbaIFLZD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 6 Sep 2014 07:25:03 -0400
Received: by mail-wg0-f47.google.com with SMTP id z12so12569513wgg.18
        for <util-linux@vger.kernel.org>; Sat, 06 Sep 2014 04:25:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/6] rename: use usage and version print out macros
Date: Sat,  6 Sep 2014 12:24:49 +0100
Message-Id: <1410002693-16540-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
References: <1410002693-16540-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/renice.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/sys-utils/renice.c b/sys-utils/renice.c
index 5d643fb..0605680 100644
--- a/sys-utils/renice.c
+++ b/sys-utils/renice.c
@@ -50,23 +50,20 @@
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
-	fputs(_("\nUsage:\n"), out);
+	fputs(USAGE_HEADER, out);
 	fprintf(out,
 	      _(" %1$s [-n] <priority> [-p|--pid] <pid>...\n"
 		" %1$s [-n] <priority>  -g|--pgrp <pgid>...\n"
 		" %1$s [-n] <priority>  -u|--user <user>...\n"),
 		program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
+	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -g, --pgrp <id>        interpret argument as process group ID\n"
 		" -n, --priority <num>   specify the nice increment value\n"
 		" -p, --pid <id>         interpret argument as process ID (default)\n"
 		" -u, --user <name|id>   interpret argument as username or user ID\n"
 		" -h, --help             display help text and exit\n"
 		" -V, --version          display version information and exit\n"), out);
-
-	fputs(_("\nFor more information see renice(1).\n"), out);
-
+	fprintf(out, USAGE_MAN_TAIL("renice(1)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
@@ -129,9 +126,8 @@ main(int argc, char **argv)
 		if (strcmp(*argv, "-v") == 0 ||
 		    strcmp(*argv, "-V") == 0 ||
 		    strcmp(*argv, "--version") == 0) {
-			printf(_("%s from %s\n"),
-			       program_invocation_short_name, PACKAGE_STRING);
-			exit(EXIT_SUCCESS);
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
 		}
 	}
 
-- 
2.1.0

