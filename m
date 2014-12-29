Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:55770 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751665AbaL2KRr (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Mon, 29 Dec 2014 05:17:47 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 09/11] look: slice up the usage text for ease of translation
Date: Mon, 29 Dec 2014 11:17:04 +0100
Message-Id: <1419848226-2533-8-git-send-email-bensberg@justemail.net>
In-Reply-To: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
References: <1419848226-2533-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also use the standard macros, and correct the synopsis: use angular
brackets and show that look accepts multiple files.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 misc-utils/look.c |   17 +++++++++--------
 1 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/misc-utils/look.c b/misc-utils/look.c
index 50bc4f4..dc6a8d0 100644
--- a/misc-utils/look.c
+++ b/misc-utils/look.c
@@ -364,20 +364,21 @@ compare(char *s2, char *s2end) {
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
-	fprintf(out,
-	      _(" %s [options] string [file]\n"), program_invocation_short_name);
+	fprintf(out, _(" %s [options] <string> [<file>...]\n"), program_invocation_short_name);
 
 	fputs(USAGE_SEPARATOR, out);
 	fputs(_("Display lines beginning with a specified string.\n"), out);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -a, --alternative      use alternative dictionary\n"
-		" -d, --alphanum         compare only alphanumeric characters\n"
-		" -f, --ignore-case      ignore case differences when comparing\n"
-		" -t, --terminate <char> define string termination character\n"
-		" -V, --version          output version information and exit\n"
-		" -h, --help             display this help and exit\n\n"), out);
+	fputs(_(" -a, --alternative        use the alternative dictionary\n"), out);
+	fputs(_(" -d, --alphanum           compare only alphanumeric characters\n"), out);
+	fputs(_(" -f, --ignore-case        ignore case differences when comparing\n"), out);
+	fputs(_(" -t, --terminate <char>   define the string-termination character\n"), out);
 
+	fputs(USAGE_SEPARATOR, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
 	fprintf(out, USAGE_MAN_TAIL("look(1)"));
+
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.7.0.4

