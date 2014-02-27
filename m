Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f49.google.com ([74.125.83.49]:49623 "EHLO
	mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752868AbaB0DY5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 26 Feb 2014 22:24:57 -0500
Received: by mail-ee0-f49.google.com with SMTP id b57so1026370eek.8
        for <util-linux@vger.kernel.org>; Wed, 26 Feb 2014 19:24:55 -0800 (PST)
From: =?UTF-8?q?Maciej=20Ma=C5=82ecki?= <me@mmalecki.com>
To: util-linux@vger.kernel.org
Cc: =?UTF-8?q?Maciej=20Ma=C5=82ecki?= <me@mmalecki.com>
Subject: [PATCH 2/2] fdisk: do not allow writing to a read-only device
Date: Thu, 27 Feb 2014 04:26:40 +0100
Message-Id: <1393471600-17777-2-git-send-email-me@mmalecki.com>
In-Reply-To: <1393471600-17777-1-git-send-email-me@mmalecki.com>
References: <1393471600-17777-1-git-send-email-me@mmalecki.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Print a warning instead. This fixes the aforementioned "Bad file
descriptor" issue when writing to read-only completely.

Signed-off-by: Maciej Małecki <me@mmalecki.com>
---
 fdisks/fdisk-menu.c    | 4 ++++
 libfdisk/src/context.c | 3 +++
 libfdisk/src/fdiskP.h  | 1 +
 3 files changed, 8 insertions(+)

diff --git a/fdisks/fdisk-menu.c b/fdisks/fdisk-menu.c
index ced819a..f965e3f 100644
--- a/fdisks/fdisk-menu.c
+++ b/fdisks/fdisk-menu.c
@@ -448,6 +448,10 @@ static int generic_menu_cb(struct fdisk_context **cxt0,
 		rc = fdisk_list_disklabel(cxt);
 		break;
 	case 'w':
+		if (cxt->readonly) {
+			fdisk_warnx(cxt, _("Device open in read-only mode"));
+			break;
+		}
 		rc = fdisk_write_disklabel(cxt);
 		if (rc)
 			err(EXIT_FAILURE, _("failed to write disklabel"));
diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index 40f9080..05833df 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -45,6 +45,7 @@ struct fdisk_context *fdisk_new_nested_context(struct fdisk_context *parent,
 	DBG(LABEL, dbgprint("new context %p allocated", cxt));
 	cxt->dev_fd = parent->dev_fd;
 	cxt->parent = parent;
+	cxt->readonly = parent->readonly;
 
 	cxt->io_size =          parent->io_size;
 	cxt->optimal_io_size =  parent->optimal_io_size;
@@ -173,6 +174,7 @@ static void reset_context(struct fdisk_context *cxt)
 
 	/* initialize */
 	cxt->dev_fd = -1;
+	cxt->readonly = -1;
 	cxt->dev_path = NULL;
 	cxt->firstsector = NULL;
 
@@ -271,6 +273,7 @@ retry:
 	}
 
 	cxt->dev_fd = fd;
+	cxt->readonly = readonly;
 	cxt->dev_path = strdup(fname);
 	if (!cxt->dev_path)
 		goto fail;
diff --git a/libfdisk/src/fdiskP.h b/libfdisk/src/fdiskP.h
index feaab3d..da56c13 100644
--- a/libfdisk/src/fdiskP.h
+++ b/libfdisk/src/fdiskP.h
@@ -264,6 +264,7 @@ struct fdisk_ask {
 
 struct fdisk_context {
 	int dev_fd;         /* device descriptor */
+	int readonly;       /* is the device read-only? */
 	char *dev_path;     /* device path */
 	unsigned char *firstsector; /* buffer with master boot record */
 
-- 
1.9.0

