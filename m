Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:36803 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751587AbbFXIPj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:39 -0400
Received: by wicnd19 with SMTP id nd19so127676874wic.1
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:37 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/12] mkfs.minix: refactor root block content creation
Date: Wed, 24 Jun 2015 09:15:15 +0100
Message-Id: <1435133719-2971-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This does not belong to main() function.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index c2ab664..16305b2 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -390,6 +390,27 @@ static void make_root_inode_v2_v3 (struct fs_control *ctl) {
 
 static void make_root_inode(struct fs_control *ctl)
 {
+	char *tmp = root_block;
+
+	if (fs_version == 3) {
+		*(uint32_t *) tmp = 1;
+		strcpy(tmp + 4, ".");
+		tmp += ctl->fs_dirsize;
+		*(uint32_t *) tmp = 1;
+		strcpy(tmp + 4, "..");
+		tmp += ctl->fs_dirsize;
+		*(uint32_t *) tmp = 2;
+		strcpy(tmp + 4, ".badblocks");
+	} else {
+		*(uint16_t *) tmp = 1;
+		strcpy(tmp + 2, ".");
+		tmp += ctl->fs_dirsize;
+		*(uint16_t *) tmp = 1;
+		strcpy(tmp + 2, "..");
+		tmp += ctl->fs_dirsize;
+		*(uint16_t *) tmp = 2;
+		strcpy(tmp + 2, ".badblocks");
+	}
 	if (fs_version < 2) {
 		make_root_inode_v1(ctl);
 		return;
@@ -718,7 +739,6 @@ int main(int argc, char ** argv)
 		0
 	};
 	int i;
-	char * tmp;
 	struct stat statbuf;
 	char * listfile = NULL;
 	static const struct option longopts[] = {
@@ -789,26 +809,6 @@ int main(int argc, char ** argv)
 	if (is_mounted(ctl.device_name))
 		errx(MKFS_EX_ERROR, _("%s is mounted; will not make a filesystem here!"),
 			ctl.device_name);
-	tmp = root_block;
-	if (fs_version == 3) {
-		*(uint32_t *)tmp = 1;
-		strcpy(tmp+4,".");
-		tmp += ctl.fs_dirsize;
-		*(uint32_t *)tmp = 1;
-		strcpy(tmp+4,"..");
-		tmp += ctl.fs_dirsize;
-		*(uint32_t *)tmp = 2;
-		strcpy(tmp+4, ".badblocks");
-	} else {
-		*(uint16_t *)tmp = 1;
-		strcpy(tmp+2,".");
-		tmp += ctl.fs_dirsize;
-		*(uint16_t *)tmp = 1;
-		strcpy(tmp+2,"..");
-		tmp += ctl.fs_dirsize;
-		*(uint16_t *)tmp = 2;
-		strcpy(tmp+2, ".badblocks");
-	}
 	if (stat(ctl.device_name, &statbuf) < 0)
 		err(MKFS_EX_ERROR, _("stat of %s failed"), ctl.device_name);
 	if (S_ISBLK(statbuf.st_mode))
-- 
2.4.4

