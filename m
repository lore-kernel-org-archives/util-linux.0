Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32899 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753074AbdEISK7 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 May 2017 14:10:59 -0400
Received: by mail-wr0-f196.google.com with SMTP id w50so2148991wrc.0
        for <util-linux@vger.kernel.org>; Tue, 09 May 2017 11:10:59 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 3/5] vipw: use getopt_long() to parse options
Date: Tue,  9 May 2017 19:10:50 +0100
Message-Id: <20170509181052.3610-3-kerolasa@iki.fi>
In-Reply-To: <20170509181052.3610-1-kerolasa@iki.fi>
References: <20170509181052.3610-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/vipw.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 4d8592434..7d4a831de 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -61,6 +61,7 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 #include <unistd.h>
+#include <getopt.h>
 
 #include "c.h"
 #include "fileutils.h"
@@ -312,6 +313,13 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 int main(int argc, char *argv[])
 {
+	int c;
+	static const struct option longopts[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
@@ -325,15 +333,16 @@ int main(int argc, char *argv[])
 		xstrncpy(orig_file, PASSWD_FILE, sizeof(orig_file));
 	}
 
-	if (1 < argc) {
-		if (!strcmp(argv[1], "-V") || !strcmp(argv[1], "--version")) {
+	while ((c = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
+		switch (c) {
+		case 'V':
 			printf(UTIL_LINUX_VERSION);
-			exit(EXIT_SUCCESS);
-		}
-		if (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))
+			return EXIT_SUCCESS;
+		case 'h':
 			usage(stdout);
-		usage(stderr);
-	}
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
 
 	edit_file(0);
 
-- 
2.12.2

