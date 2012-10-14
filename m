Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:64919 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754383Ab2JNUVn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:43 -0400
Received: by mail-wi0-f172.google.com with SMTP id hq12so1296035wib.1
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 19/19] fsck.cramfs: replace utime() with utimensat()
Date: Sun, 14 Oct 2012 21:21:10 +0100
Message-Id: <1350246070-10544-20-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The utime() function is marked obsolescent.

References: http://pubs.opengroup.org/onlinepubs/9699919799/functions/utime.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.cramfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index b39d231..3e2c8bb 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -45,7 +45,6 @@
 #include <errno.h>
 #include <string.h>
 #include <getopt.h>
-#include <utime.h>
 #include <fcntl.h>
 #include <zlib.h>
 
@@ -405,7 +404,7 @@ static void do_uncompress(char *path, int fd, unsigned long offset,
 
 static void change_file_status(char *path, struct cramfs_inode *i)
 {
-	struct utimbuf epoch = { 0, 0 };
+	struct timespec epoch = { 0, 0 };
 
 	if (euid == 0) {
 		if (lchown(path, i->uid, i->gid) < 0)
@@ -417,8 +416,8 @@ static void change_file_status(char *path, struct cramfs_inode *i)
 	}
 	if (S_ISLNK(i->mode))
 		return;
-	if (utime(path, &epoch) < 0)
-		err(FSCK_EX_ERROR, _("utime failed: %s"), path);
+	if (utimensat(path, &epoch, 0) < 0)
+		err(FSCK_EX_ERROR, _("utimensat failed: %s"), path);
 }
 
 static void do_directory(char *path, struct cramfs_inode *i)
-- 
1.7.12.2

