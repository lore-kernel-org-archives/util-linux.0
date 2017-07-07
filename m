Return-Path: util-linux-owner@vger.kernel.org
Received: from prod-mx.aristanetworks.com ([162.210.130.12]:13600 "EHLO
        prod-mx.aristanetworks.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753126AbdGGB1M (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 Jul 2017 21:27:12 -0400
Date: Thu, 6 Jul 2017 18:27:11 -0700
From: Ivan Delalande <colona@arista.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] libmount: make mnt_context_is_fs_mounted work for /proc
Message-ID: <20170707012711.GA1306@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Assume that /proc is not mounted instead of returning an error when we
are unable to open the mounts and mountinfo files in /proc. Also set
cxt->mtab back to NULL so that it gets properly parsed when we check if
the next filesystem is mounted.

The goal is to have mount -a work when /proc is not mounted, typically
with /proc on the first line of fstab.

Signed-off-by: Ivan Delalande <colona@arista.com>
---
 libmount/src/context.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/libmount/src/context.c b/libmount/src/context.c
index 7c34cad95..e7f1ee934 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -33,6 +33,7 @@
 
 #include "mountP.h"
 #include "fileutils.h"
+#include "strutils.h"
 
 #include <sys/wait.h>
 
@@ -2458,14 +2459,23 @@ int mnt_context_helper_setopt(struct libmnt_context *cxt, int c, char *arg)
 int mnt_context_is_fs_mounted(struct libmnt_context *cxt,
 			      struct libmnt_fs *fs, int *mounted)
 {
-	struct libmnt_table *mtab;
+	struct libmnt_table *mtab, *orig;
 	int rc;
 
 	if (!cxt || !fs || !mounted)
 		return -EINVAL;
 
+	orig = cxt->mtab;
 	rc = mnt_context_get_mtab(cxt, &mtab);
-	if (rc)
+	if (rc == -ENOENT && mnt_fs_streq_target(fs, "/proc") &&
+	    (!cxt->mtab_path || startswith(cxt->mtab_path, "/proc/"))) {
+		if (!orig) {
+			mnt_unref_table(cxt->mtab);
+			cxt->mtab = NULL;
+		}
+		*mounted = 0;
+		return 0;	/* /proc not mounted */
+	} else if (rc)
 		return rc;
 
 	*mounted = mnt_table_is_fs_mounted(mtab, fs);
-- 
2.13.2
