Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:63643 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754116AbaDOLQC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 15 Apr 2014 07:16:02 -0400
Received: by mail-wi0-f172.google.com with SMTP id hi2so5464772wib.17
        for <util-linux@vger.kernel.org>; Tue, 15 Apr 2014 04:16:01 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 8/9] kill: add --verbose option to display what is killed
Date: Tue, 15 Apr 2014 12:15:34 +0100
Message-Id: <1397560535-14622-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
References: <1397560535-14622-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/kill.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/misc-utils/kill.c b/misc-utils/kill.c
index 9566f14..b30b94f 100644
--- a/misc-utils/kill.c
+++ b/misc-utils/kill.c
@@ -78,7 +78,8 @@ struct kill_control {
 		check_all:1,
 		do_kill:1,
 		do_pid:1,
-		use_sigval:1;
+		use_sigval:1,
+		verbose:1;
 };
 
 struct signv {
@@ -314,6 +315,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -p, --pid              print pids without signaling them\n"), out);
 	fputs(_(" -l, --list [=<signal>] list signal names, or convert one to a name\n"), out);
 	fputs(_(" -L, --table            list signal names and numbers\n"), out);
+	fputs(_("     --verbose          print pids that will be signaled\n"), out);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
@@ -345,7 +347,10 @@ static char **parse_arguments(int argc, char **argv, struct kill_control *ctl)
 		}
 		if (!strcmp(arg, "-h") || !strcmp(arg, "--help"))
 			usage(stdout);
-
+		if (!strcmp(arg, "--verbose")) {
+			ctl->verbose = 1;
+			continue;
+		}
 		if (!strcmp(arg, "-a") || !strcmp(arg, "--all")) {
 			ctl->check_all = 1;
 			continue;
@@ -442,6 +447,8 @@ static int kill_verbose(const struct kill_control *ctl)
 {
 	int rc = 0;
 
+	if (ctl->verbose)
+		printf(_("sending signal %d to pid %d\n"), ctl->numsig, ctl->pid);
 	if (ctl->do_pid) {
 		printf("%ld\n", (long) ctl->pid);
 		return 0;
-- 
1.9.2

