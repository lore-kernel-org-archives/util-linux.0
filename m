Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews05.kpnxchange.com ([213.75.39.8]:54872 "EHLO
	cpsmtpb-ews05.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751627AbaLXQ4c (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Dec 2014 11:56:32 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 07/10] colcrt: slice up the usage text for ease of translation
Date: Wed, 24 Dec 2014 17:56:07 +0100
Message-Id: <1419440170-10850-7-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
References: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also use the standard macros for outputting it.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 text-utils/colcrt.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/text-utils/colcrt.c b/text-utils/colcrt.c
index c39c8b6..21013ea 100644
--- a/text-utils/colcrt.c
+++ b/text-utils/colcrt.c
@@ -309,16 +309,17 @@ void move(int l, int m)
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
-	fprintf(out,
-		_("\nUsage:\n"
-		  " %s [options] [file ...]\n"), program_invocation_short_name);
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [options] [<file>...]\n"), program_invocation_short_name);
 
-	fprintf(out,
-		_(" -,  --no-underlining  suppress all underlining\n"
-		  " -2, --half-lines      print all half-lines\n"
-		  " -V, --version         output version information and exit\n"
-		  " -h, --help            display this help and exit\n\n"));
+	fputs(USAGE_OPTIONS, out);
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

