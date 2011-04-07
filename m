Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yx0-f174.google.com ([209.85.213.174]:45615 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756565Ab1DGTnR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 7 Apr 2011 15:43:17 -0400
Received: by yxs7 with SMTP id 7so1166846yxs.19
        for <util-linux@vger.kernel.org>; Thu, 07 Apr 2011 12:43:17 -0700 (PDT)
Subject: [PATCH] mkfs.minix: add -{1,2,3} options
From: Davidlohr Bueso <dave.bueso@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 07 Apr 2011 16:43:07 -0300
Message-ID: <1302205387.19659.4.camel@offworld>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To be applied on top of the die removal patch.

From: Davidlohr Bueso <dave@gnu.org>
Date: Thu, 7 Apr 2011 16:39:37 -0300	
Subject: [PATCH] mkfs.minix: add -{1,2,3} options

Specify by intuitive arguments which fs version to create. For v3 an exit message is shown that the feature is not yet available.
This patch also gets rid of the version2 variable, replaced by 'fs_version'.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/mkfs.minix.c |   26 ++++++++++++++++----------
 1 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 53b5900..ff50d4d 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -88,7 +88,7 @@
 #define INODE_SIZE (sizeof(struct minix_inode))
 
 #define INODE_SIZE2 (sizeof(struct minix2_inode))
-#define INODE_BLOCKS UPPER(INODES, (version2 ? MINIX2_INODES_PER_BLOCK \
+#define INODE_BLOCKS UPPER(INODES, (fs_version == 2 ? MINIX2_INODES_PER_BLOCK \
 				    : MINIX_INODES_PER_BLOCK))
 #define INODE_BUFFER_SIZE (INODE_BLOCKS * BLOCK_SIZE)
 
@@ -106,7 +106,7 @@ static int namelen = 30;	/* default (changed to 30, per Linus's
 				   suggestion, Sun Nov 21 08:05:07 1993) */
 static int dirsize = 32;
 static int magic = MINIX_SUPER_MAGIC2;
-static int version2 = 0;
+static int fs_version = 1; /* v1 by default */
 
 static char root_block[BLOCK_SIZE] = "\0";
 
@@ -118,7 +118,7 @@ static char *super_block_buffer;
 static char boot_block_buffer[512];
 #define Super (*(struct minix_super_block *)super_block_buffer)
 #define INODES ((unsigned long)Super.s_ninodes)
-#define ZONES ((unsigned long)(version2 ? Super.s_zones : Super.s_nzones))
+#define ZONES ((unsigned long)(fs_version == 2 ? Super.s_zones : Super.s_nzones))
 #define IMAPS ((unsigned long)Super.s_imap_blocks)
 #define ZMAPS ((unsigned long)Super.s_zmap_blocks)
 #define FIRSTZONE ((unsigned long)Super.s_firstdatazone)
@@ -392,8 +392,8 @@ setup_tables(void) {
 	memset(boot_block_buffer,0,512);
 	Super.s_magic = magic;
 	Super.s_log_zone_size = 0;
-	Super.s_max_size = version2 ? 0x7fffffff : (7+512+512*512)*1024;
-	if (version2)
+	Super.s_max_size = fs_version == 2 ? 0x7fffffff : (7+512+512*512)*1024;
+	if (fs_version == 2)
 		Super.s_zones = BLOCKS;
 	else
 		Super.s_nzones = BLOCKS;
@@ -404,7 +404,7 @@ setup_tables(void) {
 	else
 		inodes = req_nr_inodes;
 	/* Round up inode count to fill block size */
-	if (version2)
+	if (fs_version == 2)
 		inodes = ((inodes + MINIX2_INODES_PER_BLOCK - 1) &
 			  ~(MINIX2_INODES_PER_BLOCK - 1));
 	else
@@ -570,7 +570,7 @@ main(int argc, char ** argv) {
 		errx(8, _("bad inode size"), device_name);
 
 	opterr = 0;
-	while ((i = getopt(argc, argv, "ci:l:n:v")) != -1)
+	while ((i = getopt(argc, argv, "ci:l:n:v123")) != -1)
 		switch (i) {
 		case 'c':
 			check=1; break;
@@ -592,9 +592,15 @@ main(int argc, char ** argv) {
 			namelen = i;
 			dirsize = i+2;
 			break;
+		case '1':
+			fs_version = 1;
+			break;
+		case '2':
 		case 'v':
-			version2 = 1;
+			fs_version = 2;
 			break;
+		case '3':
+			errx(8, _("cannot create mkfs v3 - unsupported feature"));
 		default:
 			usage();
 		}
@@ -654,7 +660,7 @@ main(int argc, char ** argv) {
 		errx(8, _("will not try to make filesystem on '%s'"), device_name);
 	if (BLOCKS < 10)
 		errx(8, _("number of blocks too small"), device_name);
-	if (version2) {
+	if (fs_version == 2) {
 		if (namelen == 14)
 			magic = MINIX2_SUPER_MAGIC;
 		else
@@ -667,7 +673,7 @@ main(int argc, char ** argv) {
 		check_blocks();
 	else if (listfile)
 		get_list_blocks(listfile);
-	if (version2) {
+	if (fs_version == 2) {
 		make_root_inode2 ();
 		make_bad_inode2 ();
 	} else {
-- 
1.7.1



