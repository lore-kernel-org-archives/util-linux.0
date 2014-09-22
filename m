Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:63009 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754452AbaIVUVM (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 22 Sep 2014 16:21:12 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 05/10] textual: not using angular brackets around literal arguments
Date: Mon, 22 Sep 2014 22:15:35 +0200
Message-Id: <1411416940-3249-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
References: <1411416940-3249-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 sys-utils/ctrlaltdel.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sys-utils/ctrlaltdel.c b/sys-utils/ctrlaltdel.c
index df13d08..863632f 100644
--- a/sys-utils/ctrlaltdel.c
+++ b/sys-utils/ctrlaltdel.c
@@ -18,7 +18,7 @@
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fprintf(out, USAGE_HEADER);
-	fprintf(out, _(" %s <hard|soft>\n"), program_invocation_short_name);
+	fprintf(out, _(" %s hard|soft\n"), program_invocation_short_name);
 	fprintf(out, USAGE_OPTIONS);
 	fprintf(out, USAGE_HELP);
 	fprintf(out, USAGE_VERSION);
-- 
1.7.0.4

