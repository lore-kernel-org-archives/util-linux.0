Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f172.google.com ([209.85.215.172]:53092 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbaB0DYr (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Feb 2014 22:24:47 -0500
Received: by mail-ea0-f172.google.com with SMTP id l9so1421757eaj.17
        for <util-linux@vger.kernel.org>; Wed, 26 Feb 2014 19:24:45 -0800 (PST)
From: =?UTF-8?q?Maciej=20Ma=C5=82ecki?= <me@mmalecki.com>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Maciej=20Ma=C5=82ecki?= <me@mmalecki.com>
Subject: [PATCH 1/2] fdisk: warn if opening a device in write mode failed
Date: Thu, 27 Feb 2014 04:26:39 +0100
Message-Id: <1393471600-17777-1-git-send-email-me@mmalecki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Otherwise, `fdisk` fails silently with "Bad file descriptor" when
writing the partition table.

Signed-off-by: Maciej Małecki <me@mmalecki.com>
---
 libfdisk/src/context.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index c405403..40f9080 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -248,17 +248,26 @@ static int warn_wipe(struct fdisk_context *cxt)
 int fdisk_context_assign_device(struct fdisk_context *cxt,
 				const char *fname, int readonly)
 {
-	int fd;
+	int fd, mode;
 
 	DBG(CONTEXT, dbgprint("assigning device %s", fname));
 	assert(cxt);
 
 	reset_context(cxt);
 
-	if (readonly == 1 || (fd = open(fname, O_RDWR|O_CLOEXEC)) < 0) {
-		if ((fd = open(fname, O_RDONLY|O_CLOEXEC)) < 0)
+retry:
+	mode = (readonly ? O_RDONLY : O_RDWR) | O_CLOEXEC;
+	fd = open(fname, mode);
+	if (fd < 0) {
+		if (readonly)
 			return -errno;
-		readonly = 1;
+		else {
+			fdisk_warn(cxt,
+			    _("%s: opening device in read write mode failed"),
+			    fname);
+			readonly = 1;
+			goto retry;
+		}
 	}
 
 	cxt->dev_fd = fd;
-- 
1.9.0

