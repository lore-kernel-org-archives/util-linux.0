Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f46.google.com ([209.85.219.46]:59195 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbaCHVnf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Mar 2014 16:43:35 -0500
Received: by mail-oa0-f46.google.com with SMTP id i7so5676990oag.33
        for <util-linux@vger.kernel.org>; Sat, 08 Mar 2014 13:43:35 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/5] mcookie: allow --file option be defined multiple times
Date: Sat,  8 Mar 2014 15:43:27 -0600
Message-Id: <1394315010-22481-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
References: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Earlier only the last option argument took effect.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/mcookie.c | 73 +++++++++++++++++++++++++++++++---------------------
 1 file changed, 44 insertions(+), 29 deletions(-)

diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index 63eeb5b..41f5a0c 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -23,6 +23,7 @@
 #include "nls.h"
 #include "closestream.h"
 #include "randutils.h"
+#include "xalloc.h"
 
 #include <fcntl.h>
 #include <getopt.h>
@@ -69,15 +70,45 @@ static void __attribute__((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
+static void randomness_from_files(char **files, int nfiles,
+				  struct MD5Context *ctx, int verbose)
+{
+	int fd, i;
+	int count = 0;
+
+	for (i = 0; i < nfiles; i++) {
+		if (files[i][0] == '-' && !files[i][1])
+			fd = STDIN_FILENO;
+		else
+			fd = open(files[i], O_RDONLY);
+
+		if (fd < 0) {
+			warn(_("cannot open %s"), files[i]);
+		} else {
+			count = hash_file(ctx, fd);
+			if (verbose)
+				fprintf(stderr,
+					P_("Got %d byte from %s\n",
+					   "Got %d bytes from %s\n", count),
+					count, files[i]);
+
+			if (fd != STDIN_FILENO)
+				if (close(fd))
+					err(EXIT_FAILURE,
+					    _("closing %s failed"), files[i]);
+		}
+	}
+}
+
 int main(int argc, char **argv)
 {
 	size_t i;
 	struct MD5Context ctx;
 	unsigned char digest[MD5LENGTH];
 	unsigned char buf[RAND_BYTES];
-	int fd;
+	char **files = NULL;
+	int nfiles;
 	int c;
-	char *file = NULL;
 	int verbose = 0;
 
 	static const struct option longopts[] = {
@@ -93,6 +124,13 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	MD5Init(&ctx);
+
+	if (2 < argc) {
+		files = xmalloc(sizeof(char *) * argc);
+		nfiles = 0;
+	}
+
 	while ((c =
 		getopt_long(argc, argv, "f:vVh", longopts, NULL)) != -1)
 		switch (c) {
@@ -100,7 +138,8 @@ int main(int argc, char **argv)
 			verbose = 1;
 			break;
 		case 'f':
-			file = optarg;
+			files[nfiles] = optarg;
+			nfiles++;
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -111,32 +150,8 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 
-	MD5Init(&ctx);
-
-	if (file) {
-		int count = 0;
-
-		if (file[0] == '-' && !file[1])
-			fd = STDIN_FILENO;
-		else
-			fd = open(file, O_RDONLY);
-
-		if (fd < 0) {
-			warn(_("cannot open %s"), file);
-		} else {
-			count = hash_file(&ctx, fd);
-			if (verbose)
-				fprintf(stderr,
-					P_("Got %d byte from %s\n",
-					   "Got %d bytes from %s\n", count),
-					count, file);
-
-			if (fd != STDIN_FILENO)
-				if (close(fd))
-					err(EXIT_FAILURE,
-					    _("closing %s failed"), file);
-		}
-	}
+	randomness_from_files(files, nfiles, &ctx, verbose);
+	free(files);
 
 	random_get_bytes(&buf, RAND_BYTES);
 	MD5Update(&ctx, buf, RAND_BYTES);
-- 
1.9.0

