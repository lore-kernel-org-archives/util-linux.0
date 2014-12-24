Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:49978 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751688AbaLXQ4e (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Dec 2014 11:56:34 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/10] look: slice up the usage text for ease of translation
Date: Wed, 24 Dec 2014 17:56:08 +0100
Message-Id: <1419440170-10850-8-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
References: <1419440170-10850-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also use the standard macros, and correct the synopsis: use angular
brackets and show that look accepts multiple files.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/look.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/misc-utils/look.c b/misc-utils/look.c
index 51938f2..d6a8e26 100644
--- a/misc-utils/look.c
+++ b/misc-utils/look.c
@@ -364,16 +364,18 @@ compare(char *s2, char *s2end) {
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
-	fprintf(out,
-	      _(" %s [options] string [file]\n"), program_invocation_short_name);
-	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -a, --alternative      use alternative dictionary\n"
-		" -d, --alphanum         compare only alphanumeric characters\n"
-		" -f, --ignore-case      ignore case differences when comparing\n"
-		" -t, --terminate <char> define string termination character\n"
-		" -V, --version          output version information and exit\n"
-		" -h, --help             display this help and exit\n\n"), out);
+	fprintf(out, _(" %s [options] <string> [<file>...]\n"), program_invocation_short_name);
 
+	fputs(USAGE_OPTIONS, out);
+	fputs(_(" -a, --alternative        use the alternative dictionary\n"), out);
+	fputs(_(" -d, --alphanum           compare only alphanumeric characters\n"), out);
+	fputs(_(" -f, --ignore-case        ignore case differences when comparing\n"), out);
+	fputs(_(" -t, --terminate <char>   define the string-termination character\n"), out);
+
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("look(1)"));
+
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.7.0.4

