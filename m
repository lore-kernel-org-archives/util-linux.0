Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qk0-f169.google.com ([209.85.220.169]:35347 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754288AbbDJS6M (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 10 Apr 2015 14:58:12 -0400
Received: by qkhg7 with SMTP id g7so41496042qkh.2
        for <util-linux@vger.kernel.org>; Fri, 10 Apr 2015 11:58:11 -0700 (PDT)
From: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Cristian=20Rodr=C3=ADguez?= <crrodriguez@opensuse.org>
Subject: [PATCH] lib/sysfs.c: use fcntl(..F_DUPFD_CLOEXEC) instead of dup(2)
Date: Fri, 10 Apr 2015 15:57:58 -0300
Message-Id: <1428692278-5226-1-git-send-email-crrodriguez@opensuse.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

"The two descriptors do not share file descriptor flags (the
close-on-exec flag).  The close-on-exec flag  for the duplicate descriptor is off"
---
 lib/sysfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sysfs.c b/lib/sysfs.c
index ac35596..1b20191 100644
--- a/lib/sysfs.c
+++ b/lib/sysfs.c
@@ -246,7 +246,7 @@ DIR *sysfs_opendir(struct sysfs_cxt *cxt, const char *attr)
 		 * -- we cannot use cxt->sysfs_fd directly, because closedir()
 		 * will close this our persistent file descriptor.
 		 */
-		fd = dup(cxt->dir_fd);
+		fd = fcntl(cxt->dir_fd, F_DUPFD_CLOEXEC, STDERR_FILENO + 1);
 
 	if (fd < 0)
 		return NULL;
-- 
2.3.4

