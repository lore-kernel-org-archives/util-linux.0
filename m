Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcaid.dreamhost.com ([208.97.132.83]:60603 "EHLO
	homiemail-a5.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757163Ab2ADXCK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 4 Jan 2012 18:02:10 -0500
Subject: [PATCH 1/2] blkdev: add is_blkdev function
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 Jan 2012 00:02:06 +0100
Message-ID: <1325718126.7056.5.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

We should have the most basic of checks in this library to see whether or not a block device is being used.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 include/blkdev.h |    3 +++
 lib/blkdev.c     |    6 ++++++
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/include/blkdev.h b/include/blkdev.h
index 1a9119d..6b18879 100644
--- a/include/blkdev.h
+++ b/include/blkdev.h
@@ -86,6 +86,9 @@ struct hd_geometry {
 };
 #endif
 
+/* are we working with block device? */
+int is_blkdev(int fd);
+
 /* Determine size in bytes */
 off_t blkdev_find_size (int fd);
 
diff --git a/lib/blkdev.c b/lib/blkdev.c
index 9138b0d..c59386d 100644
--- a/lib/blkdev.c
+++ b/lib/blkdev.c
@@ -35,6 +35,12 @@ blkdev_valid_offset (int fd, off_t offset) {
 	return 1;
 }
 
+int is_blkdev(int fd)
+{
+	struct stat st;
+	return (fstat(fd, &st) == 0 && S_ISBLK(st.st_mode));
+}
+
 off_t
 blkdev_find_size (int fd) {
 	uintmax_t high, low = 0;
-- 
1.7.4.1




