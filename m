Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews06.kpnxchange.com ([213.75.39.9]:57164 "EHLO
	cpsmtpb-ews06.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751643AbaLXQ4h (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Dec 2014 11:56:37 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/10] tailf: slice up the usage text for ease of translation
Date: Wed, 24 Dec 2014 17:56:09 +0100
Message-Id: <1419440170-10850-9-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
References: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 text-utils/tailf.c |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/text-utils/tailf.c b/text-utils/tailf.c
index bd38da2..7dea599 100644
--- a/text-utils/tailf.c
+++ b/text-utils/tailf.c
@@ -193,19 +193,18 @@ watch_file_inotify(const char *filename, off_t *size)
 
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
 {
-	fprintf(out,
-		_("\nUsage:\n"
-		  " %s [option] file\n"),
-		program_invocation_short_name);
-
-	fprintf(out, _(
-		"\nOptions:\n"
-		" -n, --lines NUMBER  output the last NUMBER lines\n"
-		" -NUMBER             same as `-n NUMBER'\n"
-		" -V, --version       output version information and exit\n"
-		" -h, --help          display this help and exit\n\n"));
+	fputs(USAGE_HEADER, out);
+	fprintf(out, _(" %s [option] <file>\n"), program_invocation_short_name);
 
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -n, --lines <number>   output the last <number> lines\n"), out);
+	fputs(_(" -<number>              same as '-n <number>'\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("tailf(1)"));
+
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-- 
1.7.0.4

