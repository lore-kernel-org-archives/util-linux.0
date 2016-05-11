Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34329 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932152AbcEKOy2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 11 May 2016 10:54:28 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so9961619wmn.1
        for <util-linux@vger.kernel.org>; Wed, 11 May 2016 07:54:27 -0700 (PDT)
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: util-linux@vger.kernel.org
Cc: Sassan Panahinejad <sassan@sassan.me.uk>
Subject: [PATCH 3/3] sfdisk: Add support for altering GPT size
Date: Wed, 11 May 2016 15:54:18 +0100
Message-Id: <1462978458-13908-3-git-send-email-sassan@sassan.me.uk>
In-Reply-To: <1462978458-13908-1-git-send-email-sassan@sassan.me.uk>
References: <1462978458-13908-1-git-send-email-sassan@sassan.me.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Adds a header option to alter the GPT table length
---
 libfdisk/src/script.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/libfdisk/src/script.c b/libfdisk/src/script.c
index 096f37c..e6fd0de 100644
--- a/libfdisk/src/script.c
+++ b/libfdisk/src/script.c
@@ -705,7 +705,8 @@ static int parse_line_header(struct fdisk_script *dp, char *s)
 	} else if (strcmp(name, "label-id") == 0
 		   || strcmp(name, "device") == 0
 		   || strcmp(name, "first-lba") == 0
-		   || strcmp(name, "last-lba") == 0) {
+		   || strcmp(name, "last-lba") == 0
+		   || strcmp(name, "table-length") == 0) {
 		;					/* whatever is posssible */
 	} else
 		goto done;				/* unknown header */
@@ -1326,6 +1327,8 @@ struct fdisk_script *fdisk_get_script(struct fdisk_context *cxt)
 int fdisk_apply_script_headers(struct fdisk_context *cxt, struct fdisk_script *dp)
 {
 	const char *name;
+	const char *str;
+	int rc;
 
 	assert(cxt);
 	assert(dp);
@@ -1338,7 +1341,15 @@ int fdisk_apply_script_headers(struct fdisk_context *cxt, struct fdisk_script *d
 	if (!name)
 		return -EINVAL;
 
-	return fdisk_create_disklabel(cxt, name);
+	rc = fdisk_create_disklabel(cxt, name);
+	if (rc)
+		return rc;
+
+	str = fdisk_script_get_header(dp, "table-length");
+	if (str)
+		return fdisk_set_disklabel_length(cxt, strtoul(str, NULL, 0));
+
+	return 0;
 }
 
 /**
-- 
2.1.0

