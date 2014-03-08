Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-oa0-f42.google.com ([209.85.219.42]:62813 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751096AbaCHVng (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 8 Mar 2014 16:43:36 -0500
Received: by mail-oa0-f42.google.com with SMTP id i4so5653216oah.29
        for <util-linux@vger.kernel.org>; Sat, 08 Mar 2014 13:43:36 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/5] mcookie: use same variable type consistently
Date: Sat,  8 Mar 2014 15:43:28 -0600
Message-Id: <1394315010-22481-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
References: <1394315010-22481-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/mcookie.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/misc-utils/mcookie.c b/misc-utils/mcookie.c
index 41f5a0c..9167440 100644
--- a/misc-utils/mcookie.c
+++ b/misc-utils/mcookie.c
@@ -39,9 +39,9 @@ enum {
 };
 
 /* The basic function to hash a file */
-static off_t hash_file(struct MD5Context *ctx, int fd)
+static size_t hash_file(struct MD5Context *ctx, int fd)
 {
-	off_t count = 0;
+	size_t count = 0;
 	ssize_t r;
 	unsigned char buf[BUFFERSIZE];
 
@@ -74,7 +74,7 @@ static void randomness_from_files(char **files, int nfiles,
 				  struct MD5Context *ctx, int verbose)
 {
 	int fd, i;
-	int count = 0;
+	size_t count = 0;
 
 	for (i = 0; i < nfiles; i++) {
 		if (files[i][0] == '-' && !files[i][1])
@@ -88,8 +88,8 @@ static void randomness_from_files(char **files, int nfiles,
 			count = hash_file(ctx, fd);
 			if (verbose)
 				fprintf(stderr,
-					P_("Got %d byte from %s\n",
-					   "Got %d bytes from %s\n", count),
+					P_("Got %zu byte from %s\n",
+					   "Got %zu bytes from %s\n", count),
 					count, files[i]);
 
 			if (fd != STDIN_FILENO)
-- 
1.9.0

