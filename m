Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:36010 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751173AbdKTUJv (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 20 Nov 2017 15:09:51 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 530C15F15C
        for <util-linux@vger.kernel.org>; Mon, 20 Nov 2017 20:09:51 +0000 (UTC)
From: Andy Grover <agrover@redhat.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Mark char* params to blkid_dev_set_search as const
Date: Mon, 20 Nov 2017 12:09:50 -0800
Message-Id: <20171120200950.11377-1-agrover@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

They are not changed by the function.

Signed-off-by: Andy Grover <agrover@redhat.com>
---
 libblkid/src/blkid.h.in | 2 +-
 libblkid/src/dev.c      | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/blkid.h.in b/libblkid/src/blkid.h.in
index ffd791ad1..a35b71388 100644
--- a/libblkid/src/blkid.h.in
+++ b/libblkid/src/blkid.h.in
@@ -149,7 +149,7 @@ extern const char *blkid_dev_devname(blkid_dev dev)
 
 extern blkid_dev_iterate blkid_dev_iterate_begin(blkid_cache cache);
 extern int blkid_dev_set_search(blkid_dev_iterate iter,
-				char *search_type, char *search_value);
+				const char *search_type, const char *search_value);
 extern int blkid_dev_next(blkid_dev_iterate iterate, blkid_dev *dev);
 extern void blkid_dev_iterate_end(blkid_dev_iterate iterate);
 
diff --git a/libblkid/src/dev.c b/libblkid/src/dev.c
index 046cdce1b..056df2b86 100644
--- a/libblkid/src/dev.c
+++ b/libblkid/src/dev.c
@@ -148,7 +148,7 @@ blkid_dev_iterate blkid_dev_iterate_begin(blkid_cache cache)
 }
 
 int blkid_dev_set_search(blkid_dev_iterate iter,
-				 char *search_type, char *search_value)
+				 const char *search_type, const char *search_value)
 {
 	char *new_type, *new_value;
 
-- 
2.13.6

