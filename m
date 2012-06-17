Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdcbhh.dreamhost.com ([208.97.132.177]:40610 "EHLO
	homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757505Ab2FQQKD (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 17 Jun 2012 12:10:03 -0400
Subject: [PATCH 1/9] fdisk: extend comments for fdisk_new_context()
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jun 2012 18:09:59 +0200
Message-ID: <1339949399.2668.13.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/utils.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/fdisk/utils.c b/fdisk/utils.c
index 352a934..5bb4984 100644
--- a/fdisk/utils.c
+++ b/fdisk/utils.c
@@ -147,6 +147,12 @@ void fdisk_init_debug(int mask)
 
 /**
  * fdisk_new_context:
+ * @filename: path to the device to be handled
+ * @readonly: how to open the device
+ *
+ * If the @readonly flag is set to false, fdisk will attempt to open
+ * the device with read-write mode and will fallback to read-only if
+ * unsuccessful.
  *
  * Returns: newly allocated fdisk context
  */
@@ -155,10 +161,6 @@ struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int rea
 	int fd, errsv = 0;
 	struct fdisk_context *cxt = NULL;
 
-	/*
-	 * Attempt to open the device with r-w permissions
-	 * by default, otherwise try read-only.
-	 */
 	if (readonly == 1 || (fd = open(fname, O_RDWR)) < 0) {
 		if ((fd = open(fname, O_RDONLY)) < 0)
 			return NULL;
-- 
1.7.4.1




