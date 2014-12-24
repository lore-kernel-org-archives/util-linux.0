Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews10.kpnxchange.com ([213.75.39.15]:64920 "EHLO
	cpsmtpb-ews10.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751587AbaLXQ4W (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Dec 2014 11:56:22 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 03/10] ipcrm: gettextize the command synopsis of the usage text
Date: Wed, 24 Dec 2014 17:56:03 +0100
Message-Id: <1419440170-10850-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
References: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/ipcrm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/ipcrm.c b/sys-utils/ipcrm.c
index 6443f48..b17590a 100644
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
 	fprintf(out, USAGE_OPTIONS);
 	fputs(_(" -m, --shmem-id <id>        remove shared memory segment by id\n"), out);
 	fputs(_(" -M, --shmem-key <key>      remove shared memory segment by key\n"), out);
-- 
1.7.0.4

