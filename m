Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:59434 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753701Ab3DMTzv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:51 -0400
Received: by mail-wi0-f173.google.com with SMTP id m6so510166wiv.0
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:49 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/33] libmount: check writing to a file was successful
Date: Sat, 13 Apr 2013 20:54:43 +0100
Message-Id: <1365882901-11429-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/lock.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/libmount/src/lock.c b/libmount/src/lock.c
index e73edf5..f381e42 100644
--- a/libmount/src/lock.c
+++ b/libmount/src/lock.c
@@ -21,6 +21,7 @@
 #include <limits.h>
 #include <sys/file.h>
 
+#include "closestream.h"
 #include "pathnames.h"
 #include "mountP.h"
 
@@ -573,7 +574,9 @@ void increment_data(const char *filename, int verbose, int loopno)
 		err(EXIT_FAILURE, "%d: failed to open: %s", getpid(), filename);
 
 	fprintf(f, "%ld", num);
-	fclose(f);
+
+	if (close_stream(f) != 0)
+		err(EXIT_FAILURE, "write failed: %s", filename);
 
 	if (verbose)
 		fprintf(stderr, "%d: %s: %ld --> %ld (loop=%d)\n", getpid(),
-- 
1.8.2.1

