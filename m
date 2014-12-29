Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:54273 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751686AbaL2KRe (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Dec 2014 05:17:34 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/11] ipcs: in usage show resource option as nonoptional when used with -i
Date: Mon, 29 Dec 2014 11:16:58 +0100
Message-Id: <1419848226-2533-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
References: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also, the resource option -a is not valid with -i, so show the valid
ones explicitly.  Also gettextize the synopsis as a single string, as
the two lines are tightly related and other synopses do this too.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/ipcs.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/sys-utils/ipcs.c b/sys-utils/ipcs.c
index 3bfba0a..6029451 100644
--- a/sys-utils/ipcs.c
+++ b/sys-utils/ipcs.c
@@ -50,8 +50,8 @@ static void print_msg (int id, int unit);
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
-	fprintf(out, " %s [resource ...] [output-format]\n", program_invocation_short_name);
-	fprintf(out, " %s [resource] -i <id>\n", program_invocation_short_name);
+	fprintf(out, _(" %1$s [resource-option...] [output-option]\n"
+		       " %1$s -m|-q|-s -i <id>\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Show information on IPC facilities.\n"), out);
@@ -67,7 +67,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_(" -s, --semaphores  semaphores\n"), out);
 	fputs(_(" -a, --all         all (default)\n"), out);
 	fprintf(out, USAGE_SEPARATOR);
-	fputs(_("Output format:\n"), out);
+	fputs(_("Output options:\n"), out);
 	fputs(_(" -t, --time        show attach, detach and change times\n"), out);
 	fputs(_(" -p, --pid         show PIDs of creator and last operator\n"), out);
 	fputs(_(" -c, --creator     show creator and owner\n"), out);
-- 
1.7.0.4

