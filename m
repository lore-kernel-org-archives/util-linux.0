Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36523 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1163338AbdDWU6t (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 23 Apr 2017 16:58:49 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so10011184wrc.3
        for <util-linux@vger.kernel.org>; Sun, 23 Apr 2017 13:58:48 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/10] findfs: use getopt_long() to parse options
Date: Sun, 23 Apr 2017 21:58:20 +0100
Message-Id: <20170423205821.7444-10-kerolasa@iki.fi>
In-Reply-To: <20170423205821.7444-1-kerolasa@iki.fi>
References: <20170423205821.7444-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change makes the findfs(8) more coherent with other commands in the
project source tree.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/findfs.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/misc-utils/findfs.c b/misc-utils/findfs.c
index e260541a8..cb69323aa 100644
--- a/misc-utils/findfs.c
+++ b/misc-utils/findfs.c
@@ -8,6 +8,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <errno.h>
+#include <getopt.h>
 
 #include <blkid.h>
 
@@ -41,6 +42,12 @@ static void __attribute__((__noreturn__)) usage(int rc)
 int main(int argc, char **argv)
 {
 	char	*dev;
+	int	c;
+	static const struct option longopts[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -52,15 +59,16 @@ int main(int argc, char **argv)
 		 * with version from e2fsprogs */
 		usage(FINDFS_USAGE_ERROR);
 
-	if (strcmp(argv[1], "-V") == 0 ||
-		   strcmp(argv[1], "--version") == 0) {
-		printf(UTIL_LINUX_VERSION);
-		return FINDFS_SUCCESS;
-	} else if (strcmp(argv[1], "-h") == 0 ||
-		   strcmp(argv[1], "--help") == 0) {
-		usage(FINDFS_SUCCESS);
-	} else if (argv[1][0] == '-')
-		usage(FINDFS_USAGE_ERROR);
+	while ((c = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
+		switch (c) {
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(FINDFS_SUCCESS);
+		default:
+			usage(FINDFS_USAGE_ERROR);
+		}
 
 	dev = blkid_evaluate_tag(argv[1], NULL, NULL);
 	if (!dev)
-- 
2.12.2

