Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42717 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751856AbdLCMv0 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 3 Dec 2017 07:51:26 -0500
Received: by mail-wr0-f196.google.com with SMTP id s66so14413011wrc.9
        for <util-linux@vger.kernel.org>; Sun, 03 Dec 2017 04:51:26 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/4] setarch: minor code clean up
Date: Sun,  3 Dec 2017 12:51:17 +0000
Message-Id: <20171203125117.28159-4-kerolasa@iki.fi>
In-Reply-To: <20171203125117.28159-1-kerolasa@iki.fi>
References: <20171203125117.28159-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Remove global variable, skip unnecessary comparison, and remove version
printing function when a simple printf() can do the job.  In same go fix
compiler warning.

sys-utils/setarch.c:296:4: warning: null argument where non-null required
(argument 2) [-Wnonnull]
    execl("/bin/bash", NULL);

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/setarch.c | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 6673825c8..6f5c8d6b3 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -82,9 +82,8 @@
 # define ADDR_LIMIT_3GB          0x8000000
 #endif
 
-static int archwrapper;
 
-static void __attribute__((__noreturn__)) usage(void)
+static void __attribute__((__noreturn__)) usage(int archwrapper)
 {
 	fputs(USAGE_HEADER, stdout);
 	if (!archwrapper)
@@ -120,13 +119,6 @@ static void __attribute__((__noreturn__)) usage(void)
 	exit(EXIT_SUCCESS);
 }
 
-static void __attribute__((__noreturn__))
-    show_version(void)
-{
-	printf(UTIL_LINUX_VERSION);
-	exit(EXIT_SUCCESS);
-}
-
 static int set_arch(const char *pers, unsigned long options, int list)
 {
 	struct utsname un;
@@ -253,6 +245,7 @@ int main(int argc, char *argv[])
 	const char *arch = NULL;
 	unsigned long options = 0;
 	int verbose = 0;
+	int archwrapper;
 	int c;
 
 	/* Options without equivalent short options */
@@ -294,9 +287,17 @@ int main(int argc, char *argv[])
 		errtryhelp(EXIT_FAILURE);
 	}
 	archwrapper = strcmp(program_invocation_short_name, "setarch") != 0;
-	if (archwrapper)
+	if (archwrapper) {
 		arch = program_invocation_short_name;	/* symlinks to setarch */
-	else {
+#if defined(__sparc64__) || defined(__sparc__)
+		if (strcmp(arch, "sparc32bash") == 0) {
+			if (set_arch(arch, 0L, 0))
+				err(EXIT_FAILURE, _("Failed to set personality to %s"), arch);
+			execl("/bin/bash", "", NULL);
+			err(EXIT_FAILURE, _("failed to execute %s"), "/bin/bash");
+		}
+#endif
+	} else {
 		if (1 < argc && *argv[1] != '-') {
 			arch = argv[1];
 			argv[1] = argv[0];	/* for getopt_long() to get the program name */
@@ -305,23 +306,14 @@ int main(int argc, char *argv[])
 		}
 	}
 
-#if defined(__sparc64__) || defined(__sparc__)
-	if (archwrapper && strcmp(arch, "sparc32bash") == 0) {
-		if (set_arch(arch, 0L, 0))
-			err(EXIT_FAILURE, _("Failed to set personality to %s"), arch);
-		execl("/bin/bash", NULL);
-		err(EXIT_FAILURE, _("failed to execute %s"), "/bin/bash");
-	}
-#endif
-
 	while ((c = getopt_long(argc, argv, "+hVv3BFILRSTXZ", longopts, NULL)) != -1) {
 		switch (c) {
 		case 'h':
-			usage();
+			usage(archwrapper);
 			break;
 		case 'V':
-			show_version();
-			break;
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
 		case 'v':
 			verbose = 1;
 			break;
-- 
2.15.1

