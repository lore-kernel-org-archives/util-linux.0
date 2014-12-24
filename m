Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:64653 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751302AbaLXQ4U (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Dec 2014 11:56:20 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 02/10] ipcs: in usage show resource option as nonoptional when used with -i
Date: Wed, 24 Dec 2014 17:56:02 +0100
Message-Id: <1419440170-10850-2-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
References: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
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
index 9ce5366..440a39e 100644
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
 	fprintf(out, USAGE_OPTIONS);
 	fputs(_(" -i, --id <id>  print details on resource identified by <id>\n"), out);
 	fprintf(out, USAGE_HELP);
@@ -63,7 +63,7 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
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

