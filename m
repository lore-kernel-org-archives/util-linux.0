Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:51969 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbaI1TwM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:12 -0400
Received: by mail-we0-f172.google.com with SMTP id q58so3024863wes.17
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/23] textual: fix couple typos in comments
Date: Sun, 28 Sep 2014 20:51:37 +0100
Message-Id: <1411933916-30576-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libfdisk/src/context.c         | 2 +-
 libfdisk/src/script.c          | 2 +-
 libsmartcols/src/table_print.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index 4931145..e44cc14 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -644,7 +644,7 @@ int fdisk_use_cylinders(struct fdisk_context *cxt)
  * fdisk_get_units_per_sector:
  * @cxt: context
  *
- * This is neccessary only for brain dead situations when we use "cylinders";
+ * This is necessary only for brain dead situations when we use "cylinders";
  *
  * Returns: number of "units" per sector, default is 1 if display unit is sector.
  */
diff --git a/libfdisk/src/script.c b/libfdisk/src/script.c
index bc92c82..d91cef9 100644
--- a/libfdisk/src/script.c
+++ b/libfdisk/src/script.c
@@ -344,7 +344,7 @@ int fdisk_script_read_context(struct fdisk_script *dp, struct fdisk_context *cxt
  *
  * Writes script @dp to the ile @f.
  *
- * Returns: 0 on sucess, <0 on error.
+ * Returns: 0 on success, <0 on error.
  */
 int fdisk_script_write_file(struct fdisk_script *dp, FILE *f)
 {
diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index c9f3d8f..4191515 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -100,7 +100,7 @@ static int buffer_set_data(struct libscols_buffer *buf, const char *str)
 	return rc ? rc : buffer_append_data(buf, str);
 }
 
-/* save the current buffer possition to art_idx */
+/* save the current buffer position to art_idx */
 static void buffer_set_art_index(struct libscols_buffer *buf)
 {
 	if (buf) {
-- 
2.1.1

