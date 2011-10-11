Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:41758 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755544Ab1JKS1b (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 11 Oct 2011 14:27:31 -0400
Received: by vws1 with SMTP id 1so5844993vws.19
        for <util-linux@vger.kernel.org>; Tue, 11 Oct 2011 11:27:30 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] include/loopdev.h: add missing function prototype
Date: Tue, 11 Oct 2011 14:27:47 -0400
Message-Id: <1318357667-30286-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
This is only used internally by lib/loopdev.c, but based on the name/purpose,
it seems like this function was meant to be exposed in the header rather than
declared static.

 include/loopdev.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/loopdev.h b/include/loopdev.h
index e25aa96..2c8db17 100644
--- a/include/loopdev.h
+++ b/include/loopdev.h
@@ -132,6 +132,7 @@ extern int loopcxt_set_device(struct loopdev_cxt *lc, const char *device);
 extern char *loopcxt_strdup_device(struct loopdev_cxt *lc);
 extern const char *loopcxt_get_device(struct loopdev_cxt *lc);
 extern struct sysfs_cxt *loopcxt_get_sysfs(struct loopdev_cxt *lc);
+extern struct loop_info64 *loopcxt_get_info(struct loopdev_cxt *lc);
 
 extern int loopcxt_get_fd(struct loopdev_cxt *lc);
 extern int loopcxt_set_fd(struct loopdev_cxt *lc, int fd, int mode);
-- 
1.7.7

