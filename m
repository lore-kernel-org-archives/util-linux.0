Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36492 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753671AbdEISLB (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 9 May 2017 14:11:01 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so2127955wrc.3
        for <util-linux@vger.kernel.org>; Tue, 09 May 2017 11:11:00 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/5] switch_root: use getopt_long() to parse options
Date: Tue,  9 May 2017 19:10:51 +0100
Message-Id: <20170509181052.3610-4-kerolasa@iki.fi>
In-Reply-To: <20170509181052.3610-1-kerolasa@iki.fi>
References: <20170509181052.3610-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/switch_root.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index 2b42ddf85..7bd07783e 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -33,6 +33,7 @@
 #include <errno.h>
 #include <ctype.h>
 #include <dirent.h>
+#include <getopt.h>
 
 #include "c.h"
 #include "nls.h"
@@ -217,14 +218,25 @@ static void __attribute__((__noreturn__)) usage(FILE *output)
 int main(int argc, char *argv[])
 {
 	char *newroot, *init, **initargs;
+	int c;
+	static const struct option longopts[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
+
 	atexit(close_stdout);
 
-	if (argv[1] && (!strcmp(argv[1], "--help") || !strcmp(argv[1], "-h")))
-		usage(stdout);
-	if (argv[1] && (!strcmp(argv[1], "--version") || !strcmp(argv[1], "-V"))) {
-		printf(UTIL_LINUX_VERSION);
-		return EXIT_SUCCESS;
-	}
+	while ((c = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
+		switch (c) {
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
+		default:
+			errtryhelp(EXIT_FAILURE);
+		}
 	if (argc < 3)
 		usage(stderr);
 
-- 
2.12.2

