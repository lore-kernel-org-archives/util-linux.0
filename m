Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35726 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbJaTVi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:38 -0400
Received: by wmll128 with SMTP id l128so33768577wml.0
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/12] lib/fileutils: add is_same_inode() check
Date: Sat, 31 Oct 2015 19:21:18 +0000
Message-Id: <1446319284-24778-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Check if a file path and descriptor are indeed the same file.  This function
is needed for TACTOU avoidance.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/fileutils.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/include/fileutils.h b/include/fileutils.h
index be6d1f7..55df1a7 100644
--- a/include/fileutils.h
+++ b/include/fileutils.h
@@ -4,6 +4,7 @@
 #include <stdio.h>
 #include <fcntl.h>
 #include <unistd.h>
+#include <sys/stat.h>
 
 #include "c.h"
 
@@ -25,6 +26,19 @@ static inline FILE *xfmkstemp(char **tmpname, const char *dir, const char *prefi
 	return ret;
 }
 
+static inline int is_same_inode(const int fd, const char *path)
+{
+	struct stat f, p;
+
+	if (fstat(fd, &f) < 0)
+		return 0;
+	if (stat(path, &p) < 0)
+		return 0;
+	if (f.st_dev != p.st_dev || f.st_ino != p.st_ino)
+		return 0;
+	return 1;
+}
+
 extern int dup_fd_cloexec(int oldfd, int lowfd);
 extern int get_fd_tabsize(void);
 
-- 
2.6.2

