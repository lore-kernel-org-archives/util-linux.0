Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f171.google.com ([209.85.217.171]:36292 "EHLO
	mail-lb0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbbJFRwY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 6 Oct 2015 13:52:24 -0400
Received: by lbcao8 with SMTP id ao8so81017282lbc.3
        for <util-linux@vger.kernel.org>; Tue, 06 Oct 2015 10:52:22 -0700 (PDT)
From: Alexander Kuleshov <kuleshovmail@gmail.com>
To: util-linux@vger.kernel.org
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] partx: introduce INIT_BLGPG macro
Date: Tue,  6 Oct 2015 23:50:56 +0600
Message-Id: <1444153856-14210-1-git-send-email-kuleshovmail@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The disk-utils/partx.h provides three functions:
partx_{del,add,resize}_partition() that contain almost the same code
- initialization of the blkpg_partition and blkpg_ioctl_arg structs.

Let's provide INIT_PKG macro that will do all work to prevent code
duplication.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 disk-utils/partx.h | 55 ++++++++++++++++++++++--------------------------------
 1 file changed, 22 insertions(+), 33 deletions(-)

diff --git a/disk-utils/partx.h b/disk-utils/partx.h
index 254cd85..28165b3 100644
--- a/disk-utils/partx.h
+++ b/disk-utils/partx.h
@@ -16,21 +16,26 @@
 # define BLKPG_RESIZE_PARTITION	3		/* since Linux 3.6 */
 #endif
 
+#define INIT_BLKPG(ioctl_arg, action, partno, start, size) do {	\
+	struct blkpg_partition p;		\
+	p.pno = partno;				\
+	p.start = start;			\
+	p.length = size;			\
+	p.devname[0] = 0;			\
+	p.volname[0] = 0;			\
+	ioctl_arg.op = action;			\
+	ioctl_arg.flags = 0;			\
+	ioctl_arg.datalen = sizeof(p);		\
+	ioctl_arg.data = &p;			\
+} while (0)
+
 static inline int partx_del_partition(int fd, unsigned int partno)
 {
 	struct blkpg_ioctl_arg a;
-	struct blkpg_partition p;
-
-	p.pno = partno;
-	p.start = 0;
-	p.length = 0;
-	p.devname[0] = 0;
-	p.volname[0] = 0;
-	a.op = BLKPG_DEL_PARTITION;
-	a.flags = 0;
-	a.datalen = sizeof(p);
-	a.data = &p;
+	uint64_t start = 0;
+	uint64_t size = 0;
 
+	INIT_BLKPG(a, BLKPG_DEL_PARTITION, partno, start, size);
 	return ioctl(fd, BLKPG, &a);
 }
 
@@ -38,18 +43,10 @@ static inline int partx_add_partition(int fd, int partno,
 			uint64_t start, uint64_t size)
 {
 	struct blkpg_ioctl_arg a;
-	struct blkpg_partition p;
-
-	p.pno = partno;
-	p.start = start << 9;
-	p.length = size << 9;
-	p.devname[0] = 0;
-	p.volname[0] = 0;
-	a.op = BLKPG_ADD_PARTITION;
-	a.flags = 0;
-	a.datalen = sizeof(p);
-	a.data = &p;
 
+	start = start << 9;
+	size = size << 9;
+	INIT_BLKPG(a, BLKPG_ADD_PARTITION, partno, start, size);
 	return ioctl(fd, BLKPG, &a);
 }
 
@@ -57,18 +54,10 @@ static inline int partx_resize_partition(int fd, int partno,
 			uint64_t start, uint64_t size)
 {
 	struct blkpg_ioctl_arg a;
-	struct blkpg_partition p;
-
-	p.pno = partno;
-	p.start = start << 9;
-	p.length = size << 9;
-	p.devname[0] = 0;
-	p.volname[0] = 0;
-	a.op = BLKPG_RESIZE_PARTITION;
-	a.flags = 0;
-	a.datalen = sizeof(p);
-	a.data = &p;
 
+	start = start << 9;
+	size = size << 9;
+	INIT_BLKPG(a, BLKPG_RESIZE_PARTITION, partno, start, size);
 	return ioctl(fd, BLKPG, &a);
 }
 
-- 
2.6.0

