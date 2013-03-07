Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:45839 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758218Ab3CGX1f (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Mar 2013 18:27:35 -0500
Received: by mail-we0-f169.google.com with SMTP id t11so329769wey.28
        for <util-linux@vger.kernel.org>; Thu, 07 Mar 2013 15:27:34 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/7] kill: align with howto-usage-function.txt
Date: Thu,  7 Mar 2013 23:27:19 +0000
Message-Id: <1362698844-21292-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
References: <1362698844-21292-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index e43f23a..2b6256c 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -405,14 +405,25 @@ static void printsignals (FILE *fp)
     fputc ('\n', fp);
 }
 
-static int usage (int status)
+static int usage(int status)
 {
-    FILE *fp;
-
-    fp = (status == 0 ? stdout : stderr);
-    fprintf (fp, _("usage: %s [ -s signal | -p ] [ -a ] pid ...\n"), progname);
-    fprintf (fp, _("       %s -l [ signal ]\n"), progname);
-    return status;
+	FILE *out;
+	out = (status == 0 ? stdout : stderr);
+
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] <pid | commandname> [...]\n"), program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -a, --all           all commands including not same uid as parent process\n"), out);
+	fputs(_(" -s, --signal <sig>  send specified signal\n"), out);
+	fputs(_(" -q, --queue <sig>   use sigqueue(2) rather than kill(2)\n"), out);
+	fputs(_(" -p, --pid           print pids without signaling them\n"), out);
+	fputs(_(" -l, --list <name>   list signal names\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("kill(1)"));
+
+	return status;
 }
 
 static int kill_verbose (char *procname, int pid, int sig)
-- 
1.8.1.5

