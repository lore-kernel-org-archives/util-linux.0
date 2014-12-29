Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:53381 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751686AbaL2KRh (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Dec 2014 05:17:37 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/11] ipcrm: gettextize the command synopsis of the usage text
Date: Mon, 29 Dec 2014 11:16:59 +0100
Message-Id: <1419848226-2533-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
References: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/ipcrm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 6702631..a877f0c 100644
--- a/sys-utils/ipcrm.c
+++ b/sys-utils/ipcrm.c
@@ -47,8 +47,8 @@ static int verbose = 0;
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
-	fprintf(out, " %s [options]\n", program_invocation_short_name);
-	fprintf(out, " %s shm|msg|sem <id>...\n", program_invocation_short_name);
+	fprintf(out, _(" %s [options]\n"
+		       " %s shm|msg|sem <id>...\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Remove certain IPC resources.\n"), out);
-- 
1.7.0.4

