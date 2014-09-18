Return-Path: util-linux-owner@vger.kernel.org
Received: from smtprelay-b32.telenor.se ([213.150.131.21]:37936 "EHLO
	smtprelay-b32.telenor.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751008AbaISAEI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 18 Sep 2014 20:04:08 -0400
Received: from ipb4.telenor.se (ipb4.telenor.se [195.54.127.167])
	by smtprelay-b32.telenor.se (Postfix) with ESMTP id F21F7F1B73
	for <util-linux@vger.kernel.org>; Fri, 19 Sep 2014 01:36:45 +0200 (CEST)
From: Andreas Henriksson <andreas@fatal.se>
To: util-linux@vger.kernel.org
Cc: Andreas Henriksson <andreas@fatal.se>
Subject: [PATCH 1/5] libmount: only invoke loopcxt on linux
Date: Fri, 19 Sep 2014 01:36:33 +0200
Message-Id: <1411083397-8056-1-git-send-email-andreas@fatal.se>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is part of an attempt to make libmount buildable on non-linux.

The support for /dev/loop* is Linux-specific so just disable
it on non-linux for now.

Signed-off-by: Andreas Henriksson <andreas@fatal.se>
---
 libmount/src/cache.c | 2 ++
 libmount/src/tab.c   | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/libmount/src/cache.c b/libmount/src/cache.c
index 8b2e656..fcd84fd 100644
--- a/libmount/src/cache.c
+++ b/libmount/src/cache.c
@@ -633,6 +633,7 @@ char *mnt_pretty_path(const char *path, struct libmnt_cache *cache)
 	if (!pretty)
 		return strdup("none");
 
+#ifdef __linux__
 	/* users assume backing file name rather than /dev/loopN in
 	 * output if the device has been initialized by mount(8).
 	 */
@@ -653,6 +654,7 @@ char *mnt_pretty_path(const char *path, struct libmnt_cache *cache)
 		loopcxt_deinit(&lc);
 
 	}
+#endif
 
 done:
 	/* don't return pointer to the cache, allocate a new string */
diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 4094fb8..011ba54 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -1439,8 +1439,10 @@ int mnt_table_is_fs_mounted(struct libmnt_table *tb, struct libmnt_fs *fstab_fs)
 			} else
 				flags = LOOPDEV_FL_OFFSET;
 
+#if __linux__
 			if (loopdev_is_used(mnt_fs_get_srcpath(fs), src, offset, flags))
 				break;
+#endif
 		}
 
 		if (root) {
-- 
2.1.0.rc1

