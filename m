Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:62392 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750989AbbHAIXu (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 1 Aug 2015 04:23:50 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/7] lslocks: slice up the recently modified usage text
Date: Sat,  1 Aug 2015 10:23:08 +0200
Message-Id: <1438417391-2269-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1438417391-2269-1-git-send-email-bensberg@justemail.net>
References: <1438417391-2269-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

For ease of translation when it changes.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/lslocks.c |   18 ++++++++++--------
 1 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index 01469ce..35ca5c7 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -518,14 +518,16 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_("List local system locks.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -J, --json             use JSON output format\n"
-		" -p, --pid <pid>        process id\n"
-		" -o, --output <list>    define which output columns to use\n"
-		" -n, --noheadings       don't print headings\n"
-		" -r, --raw              use the raw output format\n"
-		" -u, --notruncate       don't truncate text in columns\n"
-		" -h, --help             display this help and exit\n"
-		" -V, --version          output version information and exit\n"), out);
+	fputs(_(" -J, --json             use JSON output format\n"), out);
+	fputs(_(" -n, --noheadings       don't print headings\n"), out);
+	fputs(_(" -o, --output <list>    define which output columns to use\n"), out);
+	fputs(_(" -p, --pid <pid>        display only locks held by this process\n"), out);
+	fputs(_(" -r, --raw              use the raw output format\n"), out);
+	fputs(_(" -u, --notruncate       don't truncate text in columns\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 
 	fputs(_("\nAvailable columns (for --output):\n"), out);
 
-- 
1.7.0.4

