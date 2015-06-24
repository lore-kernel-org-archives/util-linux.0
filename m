Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:38436 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751490AbbFXIPg (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:36 -0400
Received: by wibdq8 with SMTP id dq8so38723093wib.1
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 06/12] mkfs.minix: check user input carefully
Date: Wed, 24 Jun 2015 09:15:13 +0100
Message-Id: <1435133719-2971-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

File name lenght and version input needs to be checked against each
other, which will determine what version of file system is in question.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.8 |  9 +++---
 disk-utils/mkfs.minix.c | 79 +++++++++++++++++++++++++++++++++----------------
 2 files changed, 57 insertions(+), 31 deletions(-)

diff --git a/disk-utils/mkfs.minix.8 b/disk-utils/mkfs.minix.8
index e46a768..fcf0e7c 100644
--- a/disk-utils/mkfs.minix.8
+++ b/disk-utils/mkfs.minix.8
@@ -42,10 +42,9 @@ Check the device for bad blocks before creating the filesystem.  If any
 are found, the count is printed.
 .TP
 \fB\-n\fR, \fB\-\-namelength\fR \fIlength\fR
-Specify the maximum length of filenames.
-Currently, the only allowable values are 14 and 30.
-The default is 30.  Note that kernels older than 0.99p7
-only accept namelength 14.
+Specify the maximum length of filenames.  Currently, the only allowable
+values are 14 and 30 for file system versions 1 and 2.  Version 3 allows
+only value 60.  The default is 30.
 .TP
 \fB\-i\fR, \fB\-\-inodes\fR \fInumber\fR
 Specify the number of inodes for the filesystem.
@@ -57,7 +56,7 @@ The file has one bad-block number per line.  The count of bad blocks read
 is printed.
 .TP
 .B \-1
-Make a Minix version 1 filesystem.
+Make a Minix version 1 filesystem.  This is the default.
 .TP
 .BR \-2 , " \-v"
 Make a Minix version 2 filesystem.
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index fcf7f37..59e1674 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -87,10 +87,12 @@
 
 #define MINIX_MAX_INODES 65535
 
+#define DEFAULT_FS_VERSION 1
+
 /*
  * Global variables used in minix_programs.h inline fuctions
  */
-int fs_version = 1;
+int fs_version = DEFAULT_FS_VERSION;
 char *super_block_buffer;
 
 static char *inode_buffer = NULL;
@@ -104,7 +106,7 @@ struct fs_control {
 	unsigned long long fs_blocks;	/* device block count for the file system */
 	int fs_used_blocks;		/* used blocks on a device */
 	int fs_bad_blocks;		/* number of bad blocks found from device */
-	size_t fs_namelen;		/* maximum length of filenames */
+	uint16_t fs_namelen;		/* maximum length of filenames */
 	size_t fs_dirsize;		/* maximum size of directory */
 	unsigned long fs_inodes;	/* number of inodes */
 	int fs_magic;			/* file system magic number */
@@ -632,12 +634,54 @@ static void get_list_blocks(struct fs_control *ctl, char *filename) {
 		printf(P_("%d bad block\n", "%d bad blocks\n", ctl->fs_bad_blocks), ctl->fs_bad_blocks);
 }
 
+static int find_super_magic(const struct fs_control *ctl)
+{
+	switch (fs_version) {
+	case 1:
+		if (ctl->fs_namelen == 14)
+			return MINIX_SUPER_MAGIC;
+		else
+			return MINIX_SUPER_MAGIC2;
+		break;
+	case 2:
+		if (ctl->fs_namelen == 14)
+			return MINIX2_SUPER_MAGIC;
+		else
+			return MINIX2_SUPER_MAGIC2;
+		break;
+	case 3:
+		return MINIX3_SUPER_MAGIC;
+	default:
+		abort();
+	}
+}
+
+static void check_user_instructions(struct fs_control *ctl)
+{
+	switch (fs_version) {
+	case 1:
+	case 2:
+		if (ctl->fs_namelen == 14 || ctl->fs_namelen == 30)
+			ctl->fs_dirsize = ctl->fs_namelen + 2;
+		else
+			errx(MKFS_EX_ERROR, _("unsupported name length: %d"), ctl->fs_namelen);
+		break;
+	case 3:
+		if (ctl->fs_namelen == 60)
+			ctl->fs_dirsize = ctl->fs_namelen + 4;
+		else
+			errx(MKFS_EX_ERROR, _("unsupported name length: %d"), ctl->fs_namelen);
+		break;
+	default:
+		errx(MKFS_EX_ERROR, _("unsupported minix file system version: %d"), fs_version);
+	}
+	ctl->fs_magic = find_super_magic(ctl);
+}
+
 int main(int argc, char ** argv)
 {
 	struct fs_control ctl = {
-		.fs_namelen = 30,
-		.fs_dirsize = 32,
-		.fs_magic = MINIX_SUPER_MAGIC2,		/* version 1, long names */
+		.fs_namelen = 30,	/* keep in sync with DEFAULT_FS_VERSION */
 		0
 	};
 	int i;
@@ -672,19 +716,10 @@ int main(int argc, char ** argv)
 		case '3':
 			fs_version = 3;
 			ctl.fs_namelen = 60;
-			ctl.fs_dirsize = 64;
 			break;
 		case 'n':
-			i = strtoul_or_err(optarg,
+			ctl.fs_namelen = strtou16_or_err(optarg,
 					_("failed to parse maximum length of filenames"));
-			if (i == 14)
-				ctl.fs_magic = MINIX_SUPER_MAGIC;
-			else if (i == 30)
-				ctl.fs_magic = MINIX_SUPER_MAGIC2;
-			else
-				usage(stderr);
-			ctl.fs_namelen = i;
-			ctl.fs_dirsize = i + 2;
 			break;
 		case 'i':
 			ctl.fs_inodes = strtoul_or_err(optarg,
@@ -717,6 +752,7 @@ int main(int argc, char ** argv)
 	if (!ctl.device_name) {
 		usage(stderr);
 	}
+	check_user_instructions(&ctl);
 	if (is_mounted(ctl.device_name))
 		errx(MKFS_EX_ERROR, _("%s is mounted; will not make a filesystem here!"),
 			ctl.device_name);
@@ -774,17 +810,8 @@ int main(int argc, char ** argv)
 	}
 	if (ctl.fs_blocks < 10)
 		errx(MKFS_EX_ERROR, _("%s: number of blocks too small"), ctl.device_name);
-
-	if (fs_version == 3)
-		ctl.fs_magic = MINIX3_SUPER_MAGIC;
-	else if (fs_version == 2) {
-		if (ctl.fs_namelen == 14)
-			ctl.fs_magic = MINIX2_SUPER_MAGIC;
-		else
-			ctl.fs_magic = MINIX2_SUPER_MAGIC2;
-	} else /* fs_version == 1 */
-		if (ctl.fs_blocks > MINIX_MAX_INODES)
-			ctl.fs_blocks = MINIX_MAX_INODES;
+	if (fs_version == 1 && ctl.fs_blocks > MINIX_MAX_INODES)
+		ctl.fs_blocks = MINIX_MAX_INODES;
 	if (ctl.fs_blocks > MINIX_MAX_INODES * BITS_PER_BLOCK)
 		ctl.fs_blocks = MINIX_MAX_INODES * BITS_PER_BLOCK;	/* Utter maximum: Clip. */
 	setup_tables(&ctl);
-- 
2.4.4

