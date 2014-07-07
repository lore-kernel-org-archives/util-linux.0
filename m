Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:57534 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752425AbaGGUek (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 7 Jul 2014 16:34:40 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] textual: fix the usage message of kill
Date: Mon,  7 Jul 2014 22:34:28 +0200
Message-Id: <1404765268-6616-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Using angular brackets around each individual argument, indenting a
continuation line, not using a space before =, and the argument of
--queue is a number (an element of data), not a signal.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/kill.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 5d2f27d..f1c734c 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -303,17 +303,17 @@ static int arg_to_signum(char *arg, int maskbit)
 static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
-	fprintf(out, _(" %s [options] <pid|name>...\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] <pid>|<name>...\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --all              do not restrict the name-to-pid conversion to processes\n"
-		"                        with the same uid as the present process\n"), out);
-	fputs(_(" -s, --signal <sig>     send specified signal\n"), out);
+		"                          with the same uid as the present process\n"), out);
+	fputs(_(" -s, --signal <signal>  send this <signal> instead of SIGTERM\n"), out);
 #ifdef HAVE_SIGQUEUE
-	fputs(_(" -q, --queue <sig>      use sigqueue(2) rather than kill(2)\n"), out);
+	fputs(_(" -q, --queue <number>   use sigqueue(2), not kill(2), and pass <number> as data\n"), out);
 #endif
 	fputs(_(" -p, --pid              print pids without signaling them\n"), out);
-	fputs(_(" -l, --list [=<signal>] list signal names, or convert one to a name\n"), out);
+	fputs(_(" -l, --list[=<signal>]  list signal names, or convert one to a name\n"), out);
 	fputs(_(" -L, --table            list signal names and numbers\n"), out);
 	fputs(_("     --verbose          print pids that will be signaled\n"), out);
 
-- 
1.7.0.4

