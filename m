Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:51501 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935672Ab3DHTdv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Apr 2013 15:33:51 -0400
Received: by mail-we0-f181.google.com with SMTP id d7so4709343wer.26
        for <util-linux@vger.kernel.org>; Mon, 08 Apr 2013 12:33:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 07/14] libblkid: number of functions should not be declared extern [smatch scan]
Date: Mon,  8 Apr 2013 20:32:52 +0100
Message-Id: <1365449579-13238-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
References: <1365449579-13238-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

These functions are already marked extern in header file.

libblkid/src/dev.c:70:19: warning: function 'blkid_dev_devname' with external linkage has definition
libblkid/src/dev.c:128:26: warning: function 'blkid_dev_iterate_begin' with external linkage has definition
libblkid/src/dev.c:148:12: warning: function 'blkid_dev_set_search' with external linkage has definition
libblkid/src/dev.c:175:12: warning: function 'blkid_dev_next' with external linkage has definition
libblkid/src/dev.c:196:13: warning: function 'blkid_dev_iterate_end' with external linkage has definition
libblkid/src/tag.c:84:12: warning: function 'blkid_dev_has_tag' with external linkage has definition
libblkid/src/tag.c:282:26: warning: function 'blkid_tag_iterate_begin' with external linkage has definition
libblkid/src/tag.c:303:12: warning: function 'blkid_tag_next' with external linkage has definition
libblkid/src/tag.c:322:13: warning: function 'blkid_tag_iterate_end' with external linkage has definition
libblkid/src/tag.c:336:18: warning: function 'blkid_find_dev_with_tag' with external linkage has definition

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/dev.c | 10 +++++-----
 libblkid/src/tag.c | 10 +++++-----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/libblkid/src/dev.c b/libblkid/src/dev.c
index 11d0a02..a4b2aea 100644
--- a/libblkid/src/dev.c
+++ b/libblkid/src/dev.c
@@ -67,7 +67,7 @@ void blkid_free_dev(blkid_dev dev)
 /*
  * Given a blkid device, return its name
  */
-extern const char *blkid_dev_devname(blkid_dev dev)
+const char *blkid_dev_devname(blkid_dev dev)
 {
 	return dev ? dev->bid_name : NULL;
 }
@@ -124,7 +124,7 @@ struct blkid_struct_dev_iterate {
 	struct list_head	*p;
 };
 
-extern blkid_dev_iterate blkid_dev_iterate_begin(blkid_cache cache)
+blkid_dev_iterate blkid_dev_iterate_begin(blkid_cache cache)
 {
 	blkid_dev_iterate iter;
 
@@ -144,7 +144,7 @@ extern blkid_dev_iterate blkid_dev_iterate_begin(blkid_cache cache)
 	return iter;
 }
 
-extern int blkid_dev_set_search(blkid_dev_iterate iter,
+int blkid_dev_set_search(blkid_dev_iterate iter,
 				 char *search_type, char *search_value)
 {
 	char *new_type, *new_value;
@@ -171,7 +171,7 @@ extern int blkid_dev_set_search(blkid_dev_iterate iter,
 /*
  * Return 0 on success, -1 on error
  */
-extern int blkid_dev_next(blkid_dev_iterate iter,
+int blkid_dev_next(blkid_dev_iterate iter,
 			  blkid_dev *ret_dev)
 {
 	blkid_dev		dev;
@@ -192,7 +192,7 @@ extern int blkid_dev_next(blkid_dev_iterate iter,
 	return -1;
 }
 
-extern void blkid_dev_iterate_end(blkid_dev_iterate iter)
+void blkid_dev_iterate_end(blkid_dev_iterate iter)
 {
 	if (!iter || iter->magic != DEV_ITERATE_MAGIC)
 		return;
diff --git a/libblkid/src/tag.c b/libblkid/src/tag.c
index 55df90e..9cfd617 100644
--- a/libblkid/src/tag.c
+++ b/libblkid/src/tag.c
@@ -81,7 +81,7 @@ blkid_tag blkid_find_tag_dev(blkid_dev dev, const char *type)
 	return NULL;
 }
 
-extern int blkid_dev_has_tag(blkid_dev dev, const char *type,
+int blkid_dev_has_tag(blkid_dev dev, const char *type,
 			     const char *value)
 {
 	blkid_tag		tag;
@@ -277,7 +277,7 @@ struct blkid_struct_tag_iterate {
 	struct list_head	*p;
 };
 
-extern blkid_tag_iterate blkid_tag_iterate_begin(blkid_dev dev)
+blkid_tag_iterate blkid_tag_iterate_begin(blkid_dev dev)
 {
 	blkid_tag_iterate	iter;
 
@@ -298,7 +298,7 @@ extern blkid_tag_iterate blkid_tag_iterate_begin(blkid_dev dev)
 /*
  * Return 0 on success, -1 on error
  */
-extern int blkid_tag_next(blkid_tag_iterate iter,
+int blkid_tag_next(blkid_tag_iterate iter,
 			  const char **type, const char **value)
 {
 	blkid_tag tag;
@@ -317,7 +317,7 @@ extern int blkid_tag_next(blkid_tag_iterate iter,
 	return 0;
 }
 
-extern void blkid_tag_iterate_end(blkid_tag_iterate iter)
+void blkid_tag_iterate_end(blkid_tag_iterate iter)
 {
 	if (!iter || iter->magic != TAG_ITERATE_MAGIC)
 		return;
@@ -331,7 +331,7 @@ extern void blkid_tag_iterate_end(blkid_tag_iterate iter)
  * search specification, it returns the one with the highest priority
  * value.  This allows us to give preference to EVMS or LVM devices.
  */
-extern blkid_dev blkid_find_dev_with_tag(blkid_cache cache,
+blkid_dev blkid_find_dev_with_tag(blkid_cache cache,
 					 const char *type,
 					 const char *value)
 {
-- 
1.8.2.1

