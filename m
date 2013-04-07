Return-Path: util-linux-owner@vger.kernel.org
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:58380 "EHLO
	filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932930Ab3DGIML (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Apr 2013 04:12:11 -0400
Received: from localhost (localhost [127.0.0.1])
	by filtteri6.pp.htv.fi (Postfix) with ESMTP id 597E456F031
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:12:09 +0300 (EEST)
Received: from smtp4.welho.com ([213.243.153.38])
	by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
	with ESMTP id x6TDMqKZfhJG for <util-linux@vger.kernel.org>;
	Sun,  7 Apr 2013 11:12:09 +0300 (EEST)
Received: from viper.bobcat.mine.nu.bobcat.mine.nu (cs78200229.pp.htv.fi [62.78.200.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp4.welho.com (Postfix) with ESMTPS id 045EE5BC017
	for <util-linux@vger.kernel.org>; Sun,  7 Apr 2013 11:12:09 +0300 (EEST)
From: =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/5] Spelling fixes.
Date: Sun,  7 Apr 2013 11:12:07 +0300
Message-Id: <1365322328-1607-4-git-send-email-ville.skytta@iki.fi>
In-Reply-To: <1365322328-1607-1-git-send-email-ville.skytta@iki.fi>
References: <1365322328-1607-1-git-send-email-ville.skytta@iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 Documentation/TODO           | 2 +-
 libfdisk/src/context.c       | 4 ++--
 libmount/src/context_mount.c | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/TODO b/Documentation/TODO
index 9596cce..fe67f12 100644
--- a/Documentation/TODO
+++ b/Documentation/TODO
@@ -11,7 +11,7 @@ hwlock
 bash completion
 ---------------
 - Optional argument handling requires user to press backspace to get
-  argument completetion.
+  argument completion.
 - Comma separated value, e.g., --output 'value1,value2', are not
   completed for users.
 
diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index c961392..7569e5b 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -146,7 +146,7 @@ static void reset_context(struct fdisk_context *cxt)
  * the device with read-write mode and will fallback to read-only if
  * unsuccessful.
  *
- * Returns: 0 on sucess, < 0 on error.
+ * Returns: 0 on success, < 0 on error.
  */
 int fdisk_context_assign_device(struct fdisk_context *cxt,
 				const char *fname, int readonly)
@@ -224,7 +224,7 @@ void fdisk_free_context(struct fdisk_context *cxt)
  * @ask_cb: callback
  * @data: callback data
  *
- * Returns: 0 on sucess, < 0 on error.
+ * Returns: 0 on success, < 0 on error.
  */
 int fdisk_context_set_ask(struct fdisk_context *cxt,
 		int (*ask_cb)(struct fdisk_context *, struct fdisk_ask *, void *),
diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 3b280ab..d287361 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -24,7 +24,7 @@
 
 /*
  * Kernel supports only one MS_PROPAGATION flag change by one mount(2) syscall,
- * to bypass this restriction we call mount(2) per flag. It's realy not a perfect
+ * to bypass this restriction we call mount(2) per flag. It's really not a perfect
  * solution, but it's the same like to execute multiple mount(8) commands.
  *
  * We use cxt->addmounts (additional mounts) list to keep order of the requested
@@ -865,7 +865,7 @@ int mnt_context_do_mount(struct libmnt_context *cxt)
 	type = mnt_fs_get_fstype(cxt->fs);
 	if (type) {
 		if (strchr(type, ','))
-			/* this only happen if fstab countains list of filesystems */
+			/* this only happens if fstab contains list of filesystems */
 			res = do_mount_by_pattern(cxt, type);
 		else
 			res = do_mount(cxt, NULL);
-- 
1.7.11.7

