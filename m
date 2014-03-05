Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.10]:59565 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753306AbaCEKzg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 5 Mar 2014 05:55:36 -0500
Message-ID: <531702A6.2070903@bernhard-voelker.de>
Date: Wed, 05 Mar 2014 11:55:34 +0100
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: Util-Linux <util-linux@vger.kernel.org>
Subject: [PATCH] libmount: define BTRFS_TEST_MAGIC if missing
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The patch below avoid the following compile error:

   libmount/src/utils.c: In function 'mnt_statfs_get_fstype':
   libmount/src/utils.c:397:7: error: 'BTRFS_TEST_MAGIC' undeclared (first use in this function)
     case BTRFS_TEST_MAGIC:  return "btrfs";
          ^
   libmount/src/utils.c:397:7: note: each undeclared identifier is reported only once for each function it appears in

Have a nice day,
Berny


 From 2a5ed00775aa558a71be462c05ded86ad3e632d9 Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Wed, 5 Mar 2014 11:52:13 +0100
Subject: [PATCH] libmount: define BTRFS_TEST_MAGIC if missing

* libmount/src/utils.c (BTRFS_TEST_MAGIC): Conditionally add define
which is used since commit v2.24-243-g6a52473.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
  libmount/src/utils.c | 3 +++
  1 file changed, 3 insertions(+)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index d402b7e..2541a22 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -333,6 +333,9 @@ int mnt_fstype_is_netfs(const char *type)
  #ifndef CONFIGFS_SUPER_MAGIC
  # define CONFIGFS_SUPER_MAGIC	0x62656570
  #endif
+#ifndef BTRFS_TEST_MAGIC
+# define BTRFS_TEST_MAGIC	0x73727279
+#endif

  const char *mnt_statfs_get_fstype(struct statfs *vfs)
  {
-- 
1.8.4.2

