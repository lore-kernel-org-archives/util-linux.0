Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:62044 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751665AbaL2KRp (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Dec 2014 05:17:45 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/11] colcrt: slice up the usage text for ease of translation
Date: Mon, 29 Dec 2014 11:17:03 +0100
Message-Id: <1419848226-2533-7-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
References: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also use the standard macros for outputting it.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 text-utils/colcrt.c |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index 31ce52a..da2250b 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -317,12 +317,13 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	fputs(_("Filter nroff output for CRT previewing.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fprintf(out,
-		_(" -,  --no-underlining  suppress all underlining\n"
-		  " -2, --half-lines      print all half-lines\n"
-		  " -V, --version         output version information and exit\n"
-		  " -h, --help            display this help and exit\n\n"));
+	fputs(_(" -,  --no-underlining    suppress all underlining\n"), out);
+	fputs(_(" -2, --half-lines        print all half-lines\n"), out);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("colcrt(1)"));
+
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.7.0.4

