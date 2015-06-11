Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:53911 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751526AbbFKJRc (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Thu, 11 Jun 2015 05:17:32 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] chrt: slice up the usage text and normalize its layout
Date: Thu, 11 Jun 2015 11:04:02 +0200
Message-Id: <1434013442-2674-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1434013442-2674-1-git-send-email-bensberg@justemail.net>
References: <1434013442-2674-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 schedutils/chrt.c |   51 +++++++++++++++++++++++++++------------------------
 1 files changed, 27 insertions(+), 24 deletions(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index b6923b2..b1189e0 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -58,34 +58,37 @@ static void __attribute__((__noreturn__)) show_usage(int rc)
 	FILE *out = rc == EXIT_SUCCESS ? stdout : stderr;
 
 	fputs(_("Show or change the real-time scheduling attributes of a process.\n"), out);
-	fprintf(out, _(
-	"\nSet policy:\n"
-	"  chrt [options] <priority> <command> [<arg>...]\n"
-	"  chrt [options] -p <priority> <pid>\n"
-	"\nGet policy:\n"
-	"  chrt [options] -p <pid>\n"));
-
-	fprintf(out, _(
-	"\nScheduling policies:\n"
-	"  -b | --batch         set policy to SCHED_BATCH\n"
-	"  -f | --fifo          set policy to SCHED_FIFO\n"
-	"  -i | --idle          set policy to SCHED_IDLE\n"
-	"  -o | --other         set policy to SCHED_OTHER\n"
-	"  -r | --rr            set policy to SCHED_RR (default)\n"));
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Set policy:\n"
+	" chrt [options] <priority> <command> [<arg>...]\n"
+	" chrt [options] -p <priority> <pid>\n"), out);
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Get policy:\n"
+	" chrt [options] -p <pid>\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Policy options:\n"), out);
+	fputs(_(" -b, --batch          set policy to SCHED_BATCH\n"), out);
+	fputs(_(" -f, --fifo           set policy to SCHED_FIFO\n"), out);
+	fputs(_(" -i, --idle           set policy to SCHED_IDLE\n"), out);
+	fputs(_(" -o, --other          set policy to SCHED_OTHER\n"), out);
+	fputs(_(" -r, --rr             set policy to SCHED_RR (default)\n"), out);
 
 #ifdef SCHED_RESET_ON_FORK
-	fprintf(out, _(
-	"\nScheduling flags:\n"
-	"  -R | --reset-on-fork set SCHED_RESET_ON_FORK for FIFO or RR\n"));
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Scheduling flag:\n"), out);
+	fputs(_(" -R, --reset-on-fork  set SCHED_RESET_ON_FORK for FIFO or RR\n"), out);
 #endif
-	fprintf(out, _(
-	"\nOptions:\n"
-	"  -a | --all-tasks     operate on all the tasks (threads) for a given pid\n"
-	"  -h | --help          display this help\n"
-	"  -m | --max           show min and max valid priorities\n"
-	"  -p | --pid           operate on existing given pid\n"
-	"  -v | --verbose       display status information\n"
-	"  -V | --version       output version information\n\n"));
+	fputs(USAGE_SEPARATOR, out);
+	fputs(_("Other options:\n"), out);
+	fputs(_(" -a, --all-tasks      operate on all the tasks (threads) for a given pid\n"), out);
+	fputs(_(" -m, --max            show min and max valid priorities\n"), out);
+	fputs(_(" -p, --pid            operate on existing given pid\n"), out);
+	fputs(_(" -v, --verbose        display status information\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 
 	fprintf(out, USAGE_MAN_TAIL("chrt(1)"));
 	exit(rc);
-- 
1.7.0.4

