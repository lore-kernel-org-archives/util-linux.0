Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:46021 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751165AbaGPUzV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 16 Jul 2014 16:55:21 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so1522438wgg.16
        for <util-linux@vger.kernel.org>; Wed, 16 Jul 2014 13:55:19 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/3] fallocate: avoid unnecessary computation
Date: Wed, 16 Jul 2014 21:54:57 +0100
Message-Id: <1405544098-1740-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405544098-1740-1-git-send-email-kerolasa@iki.fi>
References: <1405544098-1740-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Where POSIX_FADV_SEQUENTIAL and HAVE_POSIX_FADVISE are not available it
is waste of resources to have variables that are meaningful only for
posix_fadvise().  Also initialize the variables immediately to correct
values, and since cachesz is never changed mark it read only.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/fallocate.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index 93fd3b4..c619f64 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -174,17 +174,12 @@ static void dig_holes(int fd, off_t off, off_t len)
 {
 	off_t end = len ? off + len : 0;
 	off_t hole_start = 0, hole_sz = 0;
-	off_t cache_start = 0;
 	uintmax_t ct = 0;
-	size_t bufsz, cachesz;
+	size_t  bufsz;
 	char *buf;
 	struct stat st;
-
-	if (fstat(fd, &st) != 0)
-		err(EXIT_FAILURE, _("stat failed %s"), filename);
-
-	bufsz = st.st_blksize;
-
+#if defined(POSIX_FADV_SEQUENTIAL) && defined(HAVE_POSIX_FADVISE)
+	off_t cache_start = off;
 	/*
 	 * We don't want to call POSIX_FADV_DONTNEED to discard cached
 	 * data in PAGE_SIZE steps. IMHO it's overkill (too many syscalls).
@@ -193,15 +188,19 @@ static void dig_holes(int fd, off_t off, off_t len)
 	 * a good compromise.
 	 *					    -- kzak Feb-2014
 	 */
-	cachesz = getpagesize() * 256;
+	const size_t cachesz = getpagesize() * 256;
+#endif
+
+	if (fstat(fd, &st) != 0)
+		err(EXIT_FAILURE, _("stat failed %s"), filename);
+
+	bufsz = st.st_blksize;
 
 	if (lseek(fd, off, SEEK_SET) < 0)
 		err(EXIT_FAILURE, _("seek on %s failed"), filename);
 
 	/* buffer + extra space for is_nul() sentinel */
 	buf = xmalloc(bufsz + sizeof(uintptr_t));
-	cache_start = off;
-
 #if defined(POSIX_FADV_SEQUENTIAL) && defined(HAVE_POSIX_FADVISE)
 	posix_fadvise(fd, off, 0, POSIX_FADV_SEQUENTIAL);
 #endif
-- 
2.0.1

