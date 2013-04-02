Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:40870 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762152Ab3DBTnb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:31 -0400
Received: by mail-we0-f182.google.com with SMTP id k14so632077wer.13
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/13] vipw: add usage() function
Date: Tue,  2 Apr 2013 20:42:55 +0100
Message-Id: <1364931777-2645-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/vipw.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 8c47801..6ca5f8c 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -302,6 +302,17 @@ static void edit_file(int is_shadow)
 	ulckpwdf();
 }
 
+static void __attribute__((__noreturn__)) usage(FILE *out)
+{
+	fputs(USAGE_HEADER, out);
+	fprintf(out, " %s\n", program_invocation_short_name);
+	fputs(USAGE_OPTIONS, out);
+	fputs(USAGE_HELP, out);
+	fputs(USAGE_VERSION, out);
+	fprintf(out, USAGE_MAN_TAIL("vipw(8)"));
+	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
+}
+
 int main(int argc, char *argv[])
 {
 	setlocale(LC_ALL, "");
@@ -317,10 +328,14 @@ int main(int argc, char *argv[])
 		xstrncpy(orig_file, PASSWD_FILE, sizeof(orig_file));
 	}
 
-	if ((argc > 1) &&
-	    (!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version"))) {
-		printf(UTIL_LINUX_VERSION);
-		exit(EXIT_SUCCESS);
+	if (1 < argc) {
+		if (!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version")) {
+			printf(UTIL_LINUX_VERSION);
+			exit(EXIT_SUCCESS);
+		}
+		if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
+			usage(stdout);
+		usage(stderr);
 	}
 
 	edit_file(0);
-- 
1.8.2

