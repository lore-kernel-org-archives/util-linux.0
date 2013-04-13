Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f42.google.com ([74.125.82.42]:57199 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMT40 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:26 -0400
Received: by mail-wg0-f42.google.com with SMTP id k13so516546wgh.1
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 28/33] mkswap: unify write check to a file descriptor
Date: Sat, 13 Apr 2013 20:54:56 +0100
Message-Id: <1365882901-11429-29-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkswap.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index ec6fc5f..71503f4 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -625,15 +625,6 @@ main(int argc, char **argv) {
 			_("%s: unable to write signature page"),
 			device_name);
 
-	/*
-	 * A subsequent swapon() will fail if the signature
-	 * is not actually on disk. (This is a kernel bug.)
-	 */
-#ifdef HAVE_FSYNC
-	if (fsync(DEV))
-		errx(EXIT_FAILURE, _("fsync failed"));
-#endif
-
 #ifdef HAVE_LIBSELINUX
 	if (S_ISREG(statbuf.st_mode) && is_selinux_enabled() > 0) {
 		security_context_t context_string;
@@ -664,5 +655,12 @@ main(int argc, char **argv) {
 		freecon(oldcontext);
 	}
 #endif
+	/*
+	 * A subsequent swapon() will fail if the signature
+	 * is not actually on disk. (This is a kernel bug.)
+	 * The fsync() in close_fd() will take care of writing.
+	 */
+	if (close_fd(DEV) != 0)
+		err(EXIT_FAILURE, _("write failed"));
 	return EXIT_SUCCESS;
 }
-- 
1.8.2.1

