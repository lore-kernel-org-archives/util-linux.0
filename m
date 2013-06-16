Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:60648 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755360Ab3FPSyn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:43 -0400
Received: by mail-wg0-f43.google.com with SMTP id z11so1750912wgg.34
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/15] dmesg: regroup time related options close to each other
Date: Sun, 16 Jun 2013 19:53:53 +0100
Message-Id: <1371408836-16663-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index be08f6c..480c897 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -238,8 +238,6 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -C, --clear                 clear the kernel ring buffer\n"), out);
 	fputs(_(" -c, --read-clear            read and clear all messages\n"), out);
 	fputs(_(" -D, --console-off           disable printing messages to console\n"), out);
-	fputs(_(" -d, --show-delta            show time delta between printed messages\n"), out);
-	fputs(_(" -e, --reltime               show local time and time delta in readable format\n"), out);
 	fputs(_(" -E, --console-on            enable printing messages to console\n"), out);
 	fputs(_(" -F, --file <file>           use the file instead of the kernel log buffer\n"), out);
 	fputs(_(" -f, --facility <list>       restrict output to defined facilities\n"), out);
@@ -252,14 +250,16 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -r, --raw                   print the raw message buffer\n"), out);
 	fputs(_(" -S, --syslog                force to use syslog(2) rather than /dev/kmsg\n"), out);
 	fputs(_(" -s, --buffer-size <size>    buffer size to query the kernel ring buffer\n"), out);
-	fputs(_(" -T, --ctime                 show human readable timestamp (could be \n"
-		"                               inaccurate if you have used SUSPEND/RESUME)\n"), out);
-	fputs(_(" -t, --notime                don't print messages timestamp\n"), out);
 	fputs(_(" -u, --userspace             display userspace messages\n"), out);
 	fputs(_(" -w, --follow                wait for new messages\n"), out);
 	fputs(_(" -x, --decode                decode facility and level to readable string\n"), out);
+	fputs(_(" -d, --show-delta            show time delta between printed messages\n"), out);
+	fputs(_(" -e, --reltime               show local time and time delta in readable format\n"), out);
+	fputs(_(" -T, --ctime                 show human readable timestamp\n"), out);
+	fputs(_(" -t, --notime                don't print messages timestamp\n"), out);
 	fputs(_("     --time-format <format>  show time stamp using format:\n"
-		"                               [delta|reltime|ctime|notime|iso]\n"), out);
+		"                               [delta|reltime|ctime|notime|iso]\n"
+		"Suspending/resume will make ctime and iso timestamps inaccurate.\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
-- 
1.8.3.1

