Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:63729 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752909Ab3AVX1j (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jan 2013 18:27:39 -0500
Received: by mail-wi0-f181.google.com with SMTP id hq4so191576wib.14
        for <util-linux@vger.kernel.org>; Tue, 22 Jan 2013 15:27:38 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/14] dmesg: make usage() translator friendly
Date: Tue, 22 Jan 2013 23:27:07 +0000
Message-Id: <1358897233-6676-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
References: <1358897233-6676-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 75 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index f95db40..14c3e18 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -198,51 +198,46 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	size_t i;
 
-	fputs(_("\nUsage:\n"), out);
-	fprintf(out,
-	      _(" %s [options]\n"), program_invocation_short_name);
-
-	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -C, --clear                 clear the kernel ring buffer\n"
-		" -c, --read-clear            read and clear all messages\n"
-		" -D, --console-off           disable printing messages to console\n"
-		" -d, --show-delta            show time delta between printed messages\n"
-		" -e, --reltime               show local time and time delta in readable format\n"
-		" -E, --console-on            enable printing messages to console\n"
-		" -F, --file <file>           use the file instead of the kernel log buffer\n"
-		" -f, --facility <list>       restrict output to defined facilities\n"
-		" -h, --help                  display this help and exit\n"
-		" -k, --kernel                display kernel messages\n"
-		" -L, --color                 colorize messages\n"
-		" -l, --level <list>          restrict output to defined levels\n"
-		" -n, --console-level <level> set level of messages printed to console\n"
-		" -r, --raw                   print the raw message buffer\n"
-		" -S, --syslog                force to use syslog(2) rather than /dev/kmsg\n"
-		" -s, --buffer-size <size>    buffer size to query the kernel ring buffer\n"
-		" -T, --ctime                 show human readable timestamp (could be \n"
-		"                             inaccurate if you have used SUSPEND/RESUME)\n"
-		" -t, --notime                don't print messages timestamp\n"
-		" -u, --userspace             display userspace messages\n"
-		" -V, --version               output version information and exit\n"
-		" -w, --follow                wait for new messages\n"
-		" -x, --decode                decode facility and level to readable string\n"), out);
-
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options]\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -C, --clear                 clear the kernel ring buffer\n"), out);
+	fputs(_(" -c, --read-clear            read and clear all messages\n"), out);
+	fputs(_(" -D, --console-off           disable printing messages to console\n"), out);
+	fputs(_(" -d, --show-delta            show time delta between printed messages\n"), out);
+	fputs(_(" -e, --reltime               show local time and time delta in readable format\n"), out);
+	fputs(_(" -E, --console-on            enable printing messages to console\n"), out);
+	fputs(_(" -F, --file <file>           use the file instead of the kernel log buffer\n"), out);
+	fputs(_(" -f, --facility <list>       restrict output to defined facilities\n"), out);
+	fputs(_(" -k, --kernel                display kernel messages\n"), out);
+	fputs(_(" -L, --color                 colorize messages\n"), out);
+	fputs(_(" -l, --level <list>          restrict output to defined levels\n"), out);
+	fputs(_(" -n, --console-level <level> set level of messages printed to console\n"), out);
+	fputs(_(" -r, --raw                   print the raw message buffer\n"), out);
+	fputs(_(" -S, --syslog                force to use syslog(2) rather than /dev/kmsg\n"), out);
+	fputs(_(" -s, --buffer-size <size>    buffer size to query the kernel ring buffer\n"), out);
+	fputs(_(" -T, --ctime                 show human readable timestamp (could be \n"
+		"                               inaccurate if you have used SUSPEND/RESUME)\n"), out);
+	fputs(_(" -t, --notime                don't print messages timestamp\n"), out);
+	fputs(_(" -u, --userspace             display userspace messages\n"), out);
+	fputs(_(" -w, --follow                wait for new messages\n"), out);
+	fputs(_(" -x, --decode                decode facility and level to readable string\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fputs(_("\nSupported log facilities:\n"), out);
-	for (i = 0; i < ARRAY_SIZE(level_names); i++) {
+	for (i = 0; i < ARRAY_SIZE(level_names); i++)
 		fprintf(stderr, " %7s - %s\n",
-				facility_names[i].name,
-				_(facility_names[i].help));
-	}
+			facility_names[i].name,
+			_(facility_names[i].help));
 
 	fputs(_("\nSupported log levels (priorities):\n"), out);
-	for (i = 0; i < ARRAY_SIZE(level_names); i++) {
+	for (i = 0; i < ARRAY_SIZE(level_names); i++)
 		fprintf(stderr, " %7s - %s\n",
-				level_names[i].name,
-				_(level_names[i].help));
-	}
-
-	fputc('\n', out);
-
+			level_names[i].name,
+			_(level_names[i].help));
+	fputc(USAGE_SEPARATOR, out);
+	fprintf(out, USAGE_MAN_TAIL("dmesg(q)"));
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-- 
1.8.1.1

