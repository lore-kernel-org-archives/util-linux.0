Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f44.google.com ([209.85.220.44]:58268 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3I2KLl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 29 Sep 2013 06:11:41 -0400
Received: by mail-pa0-f44.google.com with SMTP id lf10so4622121pab.3
        for <util-linux@vger.kernel.org>; Sun, 29 Sep 2013 03:11:41 -0700 (PDT)
From: Namhyung Kim <namhyung@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] libmount: Save errno if mkostemp() failed
Date: Sun, 29 Sep 2013 19:11:37 +0900
Message-Id: <1380449497-3298-1-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

After mkostemp() failed, umask() and free() might alter the errno
to another value.  Not sure those calls really changes the errno
or not.  But let's be more conservative.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 libmount/src/utils.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 3cab936..7930e29 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -849,6 +849,8 @@ int mnt_open_uniq_filename(const char *filename, char **name)
 	oldmode = umask(S_IRGRP|S_IWGRP|S_IXGRP|
 			S_IROTH|S_IWOTH|S_IXOTH);
 	fd = mkostemp(n, O_RDWR|O_CREAT|O_EXCL|O_CLOEXEC);
+	if (fd < 0)
+		fd = -errno;
 	umask(oldmode);
 
 	if (fd >= 0 && name)
@@ -856,7 +858,7 @@ int mnt_open_uniq_filename(const char *filename, char **name)
 	else
 		free(n);
 
-	return fd < 0 ? -errno : fd;
+	return fd;
 }
 
 /**
-- 
1.7.9.2

