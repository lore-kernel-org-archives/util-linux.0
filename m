Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33904 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbcGQNA0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:26 -0400
Received: by mail-wm0-f66.google.com with SMTP id q128so8790864wma.1
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:25 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/13] switch_root: simplify code and reduce indentation [oclint]
Date: Sun, 17 Jul 2016 14:00:04 +0100
Message-Id: <20160717130015.31760-3-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The if statement in line 162 already ensures value of cfd to be 0 or
greater, so the later if is not needed.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/switch_root.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index dc55a6d..6f5468f 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -176,22 +176,21 @@ static int switchroot(const char *newroot)
 		return -1;
 	}
 
-	if (cfd >= 0) {
-		pid = fork();
-		if (pid <= 0) {
-			struct statfs stfs;
-			if (fstatfs(cfd, &stfs) == 0 &&
-			    (F_TYPE_EQUAL(stfs.f_type, STATFS_RAMFS_MAGIC) ||
-			     F_TYPE_EQUAL(stfs.f_type, STATFS_TMPFS_MAGIC)))
-				recursiveRemove(cfd);
-			else
-				warn(_("old root filesystem is not an initramfs"));
-
-			if (pid == 0)
-				exit(EXIT_SUCCESS);
-		}
-		close(cfd);
+	pid = fork();
+	if (pid <= 0) {
+		struct statfs stfs;
+
+		if (fstatfs(cfd, &stfs) == 0 &&
+		    (F_TYPE_EQUAL(stfs.f_type, STATFS_RAMFS_MAGIC) ||
+		     F_TYPE_EQUAL(stfs.f_type, STATFS_TMPFS_MAGIC)))
+			recursiveRemove(cfd);
+		else
+			warn(_("old root filesystem is not an initramfs"));
+		if (pid == 0)
+			exit(EXIT_SUCCESS);
 	}
+
+	close(cfd);
 	return 0;
 }
 
-- 
2.9.0

