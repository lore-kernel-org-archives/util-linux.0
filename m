Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:37084 "EHLO
	homiemail-a3.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753992Ab2FCSPi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jun 2012 14:15:38 -0400
Subject: [PATCH 5/5] fdisk: add fdisk_dev_sectsz_is_default helper
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 03 Jun 2012 20:15:34 +0200
Message-ID: <1338747334.2864.14.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Instead of printing this warning from the API, add a helper and call it from fdisk logic.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.c |    4 ++++
 fdisk/fdisk.h |    1 +
 fdisk/utils.c |   14 +++++++++++---
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/fdisk/fdisk.c b/fdisk/fdisk.c
index baa5bad..df0d29b 100644
--- a/fdisk/fdisk.c
+++ b/fdisk/fdisk.c
@@ -2152,6 +2152,10 @@ int main(int argc, char **argv)
 
 	print_welcome();
 
+	if (!fdisk_dev_sectsz_is_default(cxt))
+		printf(_("Note: sector size is %ld (not %d)\n"),
+		       cxt->sector_size, DEFAULT_SECTOR_SIZE);
+
 	gpt_warning(cxt->dev_path);
 	get_boot(cxt, 0);
 
diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index a74f25e..6aacc05 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -119,6 +119,7 @@ struct fdisk_context {
 
 extern struct fdisk_context *fdisk_new_context_from_filename(const char *fname, int readonly);
 extern int fdisk_dev_has_topology(struct fdisk_context *cxt);
+extern int fdisk_dev_sectsz_is_default(struct fdisk_context *cxt);
 extern void fdisk_free_context(struct fdisk_context *cxt);
 
 /* prototypes for fdisk.c */
diff --git a/fdisk/utils.c b/fdisk/utils.c
index 6fabd82..d57abe9 100644
--- a/fdisk/utils.c
+++ b/fdisk/utils.c
@@ -80,14 +80,22 @@ static int __discover_topology(struct fdisk_context *cxt)
 	cxt->sector_size = __get_sector_size(cxt->dev_fd);
 	if (!cxt->phy_sector_size) /* could not discover physical size */
 		cxt->phy_sector_size = cxt->sector_size;
-	if (cxt->sector_size != DEFAULT_SECTOR_SIZE)
-		printf(_("Note: sector size is %ld (not %d)\n"),
-		       cxt->sector_size, DEFAULT_SECTOR_SIZE);
 
 	return 0;
 }
 
 /**
+ * fdisk_dev_sectsz_is_default:
+ * @cxt: fdisk context
+ *
+ * Returns 1 if the device's sector size is the default value, otherwise 0.
+ */
+int fdisk_dev_sectsz_is_default(struct fdisk_context *cxt)
+{
+	return cxt->sector_size == DEFAULT_SECTOR_SIZE;
+}
+
+/**
  * fdisk_dev_has_topology:
  * @cxt: fdisk context
  *
-- 
1.7.4.1




