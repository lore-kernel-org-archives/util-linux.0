Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:47973 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751118Ab2KPESK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 15 Nov 2012 23:18:10 -0500
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] umount(recursive): add a cache to the table
Date: Thu, 15 Nov 2012 23:18:07 -0500
Message-Id: <1353039487-9525-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Without this table libmount will not resolve paths, meaning that
umounting by relative path will fail.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
Alternatively, one could call mnt_resolve_path(spec, NULL) and avoid attaching
the cache for the single lookup.

 sys-utils/umount.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index b21e396..87812ac 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -364,6 +364,7 @@ done:
 static int umount_recursive(struct libmnt_context *cxt, const char *spec)
 {
 	struct libmnt_table *tb;
+	struct libmnt_cache *cache;
 	int rc;
 
 	/* it's always real mountpoint, don't assume that the target maybe a device */
@@ -374,6 +375,11 @@ static int umount_recursive(struct libmnt_context *cxt, const char *spec)
 		err(MOUNT_EX_SYSERR, _("libmount table allocation failed"));
 	mnt_table_set_parser_errcb(tb, table_parser_errcb);
 
+	cache = mnt_new_cache();
+	if (!cache)
+		err(MOUNT_EX_SYSERR, _("libmount cache allocation failed"));
+	mnt_table_set_cache(tb, cache);
+
 	/*
 	 * Don't use mtab here. The recursive umount depends on child-parent
 	 * relationship defined by mountinfo file.
@@ -395,6 +401,7 @@ static int umount_recursive(struct libmnt_context *cxt, const char *spec)
 		}
 	}
 
+	mnt_free_cache(cache);
 	mnt_free_table(tb);
 	return rc;
 }
-- 
1.8.0

