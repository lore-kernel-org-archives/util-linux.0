Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f179.google.com ([209.85.215.179]:61263 "EHLO
	mail-ea0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754119AbaCCVMF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 3 Mar 2014 16:12:05 -0500
Received: by mail-ea0-f179.google.com with SMTP id q10so4795208ead.38
        for <util-linux@vger.kernel.org>; Mon, 03 Mar 2014 13:12:04 -0800 (PST)
From: =?UTF-8?q?Maciej=20Ma=C5=82ecki?= <me@mmalecki.com>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Maciej=20Ma=C5=82ecki?= <me@mmalecki.com>
Subject: [PATCH v2 2/3] libfdisk: remove `O_RDONLY` fallback mode when opening device
Date: Mon,  3 Mar 2014 22:14:06 +0100
Message-Id: <1393881247-17092-2-git-send-email-me@mmalecki.com>
In-Reply-To: <1393881247-17092-1-git-send-email-me@mmalecki.com>
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>
 <1393881247-17092-1-git-send-email-me@mmalecki.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libfdisk/src/context.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index dc9f0f9..795718c 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -241,10 +241,6 @@ static int warn_wipe(struct fdisk_context *cxt)
  * @fname: path to the device to be handled
  * @readonly: how to open the device
  *
- * If the @readonly flag is set to false, fdisk will attempt to open
- * the device with read-write mode and will fallback to read-only if
- * unsuccessful.
- *
  * Returns: 0 on success, < 0 on error.
  */
 int fdisk_context_assign_device(struct fdisk_context *cxt,
@@ -257,10 +253,8 @@ int fdisk_context_assign_device(struct fdisk_context *cxt,
 
 	reset_context(cxt);
 
-	if (readonly == 1 || (fd = open(fname, O_RDWR|O_CLOEXEC)) < 0) {
-		if ((fd = open(fname, O_RDONLY|O_CLOEXEC)) < 0)
-			return -errno;
-		readonly = 1;
+	if ((fd = open(fname, (readonly == 1 ? O_RDONLY : O_RDWR) | O_CLOEXEC)) < 0) {
+		goto fail;
 	}
 
 	cxt->dev_fd = fd;
-- 
1.9.0

