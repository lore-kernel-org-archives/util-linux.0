Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:65408 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754171AbaIVUVR (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:21:17 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/10] textual: using angular brackets around individual arguments
Date: Mon, 22 Sep 2014 22:15:37 +0200
Message-Id: <1411416940-3249-7-git-send-email-bensberg@justemail.net>
In-Reply-To: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

And separate short and long options with the standard comma.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/flock.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/sys-utils/flock.c b/sys-utils/flock.c
index f160eac..dabacb8 100644
--- a/sys-utils/flock.c
+++ b/sys-utils/flock.c
@@ -49,19 +49,19 @@ static void __attribute__((__noreturn__)) usage(int ex)
 {
 	fprintf(stderr, USAGE_HEADER);
 	fprintf(stderr,
-		_(" %1$s [options] <file|directory> <command> [<arguments>...]\n"
-		  " %1$s [options] <file|directory> -c <command>\n"
+		_(" %1$s [options] <file>|<directory> <command> [<argument>...]\n"
+		  " %1$s [options] <file>|<directory> -c <command>\n"
 		  " %1$s [options] <file descriptor number>\n"),
 		program_invocation_short_name);
 	fputs(USAGE_OPTIONS, stderr);
-	fputs(_(  " -s  --shared             get a shared lock\n"), stderr);
-	fputs(_(  " -x  --exclusive          get an exclusive lock (default)\n"), stderr);
-	fputs(_(  " -u  --unlock             remove a lock\n"), stderr);
-	fputs(_(  " -n  --nonblock           fail rather than wait\n"), stderr);
-	fputs(_(  " -w  --timeout <secs>     wait for a limited amount of time\n"), stderr);
-	fputs(_(  " -E  --conflict-exit-code <number>  exit code after conflict or timeout\n"), stderr);
-	fputs(_(  " -o  --close              close file descriptor before running command\n"), stderr);
-	fputs(_(  " -c  --command <command>  run a single command string through the shell\n"), stderr);
+	fputs(_(  " -s, --shared             get a shared lock\n"), stderr);
+	fputs(_(  " -x, --exclusive          get an exclusive lock (default)\n"), stderr);
+	fputs(_(  " -u, --unlock             remove a lock\n"), stderr);
+	fputs(_(  " -n, --nonblock           fail rather than wait\n"), stderr);
+	fputs(_(  " -w, --timeout <secs>     wait for a limited amount of time\n"), stderr);
+	fputs(_(  " -E, --conflict-exit-code <number>  exit code after conflict or timeout\n"), stderr);
+	fputs(_(  " -o, --close              close file descriptor before running command\n"), stderr);
+	fputs(_(  " -c, --command <command>  run a single command string through the shell\n"), stderr);
 	fprintf(stderr, USAGE_SEPARATOR);
 	fprintf(stderr, USAGE_HELP);
 	fprintf(stderr, USAGE_VERSION);
-- 
1.7.0.4

