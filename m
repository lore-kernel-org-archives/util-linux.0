Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f181.google.com ([209.85.212.181]:35301 "EHLO
	mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751207AbbFXIPl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:41 -0400
Received: by wiga1 with SMTP id a1so127959722wig.0
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/12] fsck.minix: add minix v3 support
Date: Wed, 24 Jun 2015 09:15:17 +0100
Message-Id: <1435133719-2971-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Relates-to: a2657ae3ffb56616ac9c921886bcca8ef242499f
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 3c3faf0..57e5be9 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -147,8 +147,6 @@ static char name_list[MAX_DEPTH][MINIX_NAME_MAX + 1];
  * is a waste of 12kB or so.  */
 static char current_name[MAX_DEPTH * (MINIX_NAME_MAX + 1) + 1];
 
-#define MAGIC (Super.s_magic)
-
 static unsigned char *inode_count = NULL;
 static unsigned char *zone_count = NULL;
 
@@ -494,6 +492,9 @@ map_block2(struct minix2_inode *inode, unsigned int blknr) {
 
 static void
 write_super_block(void) {
+	/* v3 super block does not track state */
+	if (fs_version == 3)
+		return;
 	/* Set the state of the filesystem based on whether or not there are
 	 * uncorrected errors.  The filesystem valid flag is unconditionally
 	 * set if we get this far.  */
@@ -534,7 +535,7 @@ get_dirsize(void) {
 	char blk[MINIX_BLOCK_SIZE];
 	size_t size;
 
-	if (fs_version == 2)
+	if (fs_version == 2 || fs_version == 3)
 		block = Inode2[ROOT_INO].i_zone[0];
 	else
 		block = Inode[ROOT_INO].i_zone[0];
@@ -561,22 +562,26 @@ read_superblock(void) {
 
 	if (MINIX_BLOCK_SIZE != read(device_fd, super_block_buffer, MINIX_BLOCK_SIZE))
 		die(_("unable to read super block"));
-	if (MAGIC == MINIX_SUPER_MAGIC) {
+	if (Super.s_magic == MINIX_SUPER_MAGIC) {
 		namelen = 14;
 		dirsize = 16;
 		fs_version = 1;
-	} else if (MAGIC == MINIX_SUPER_MAGIC2) {
+	} else if (Super.s_magic == MINIX_SUPER_MAGIC2) {
 		namelen = 30;
 		dirsize = 32;
 		fs_version = 1;
-	} else if (MAGIC == MINIX2_SUPER_MAGIC) {
+	} else if (Super.s_magic == MINIX2_SUPER_MAGIC) {
 		namelen = 14;
 		dirsize = 16;
 		fs_version = 2;
-	} else if (MAGIC == MINIX2_SUPER_MAGIC2) {
+	} else if (Super.s_magic == MINIX2_SUPER_MAGIC2) {
 		namelen = 30;
 		dirsize = 32;
 		fs_version = 2;
+	} else if (Super3.s_magic == MINIX3_SUPER_MAGIC) {
+		namelen = 60;
+		dirsize = 64;
+		fs_version = 3;
 	} else
 		die(_("bad magic number in super-block"));
 	if (get_zone_size() != 0 || MINIX_BLOCK_SIZE != 1024)
@@ -637,7 +642,8 @@ read_tables(void) {
 		printf(_("Firstdatazone=%jd (%jd)\n"), first_zone, norm_first_zone);
 		printf(_("Zonesize=%d\n"), MINIX_BLOCK_SIZE << get_zone_size());
 		printf(_("Maxsize=%zu\n"), get_max_size());
-		printf(_("Filesystem state=%d\n"), Super.s_state);
+		if (fs_version < 3)
+			printf(_("Filesystem state=%d\n"), Super.s_state);
 		printf(_("namelen=%zd\n\n"), namelen);
 	}
 }
@@ -1013,17 +1019,18 @@ check_file2(struct minix2_inode *dir, unsigned int offset) {
 	ino_t ino;
 	char *name;
 	int block;
+	const int version_offset = fs_version == 3 ? 4 : 2;
 
 	block = map_block2(dir, offset / MINIX_BLOCK_SIZE);
 	read_block(block, blk);
-	name = blk + (offset % MINIX_BLOCK_SIZE) + 2;
-	ino = *(unsigned short *)(name - 2);
+	name = blk + (offset % MINIX_BLOCK_SIZE) + version_offset;
+	ino = *(unsigned short *)(name - version_offset);
 	if (ino > get_ninodes()) {
 		get_current_name();
 		printf(_("The directory '%s' contains a bad inode number "
 			 "for file '%.*s'."), current_name, (int)namelen, name);
 		if (ask(_(" Remove"), 1)) {
-			*(unsigned short *)(name - 2) = 0;
+			*(unsigned short *)(name - version_offset) = 0;
 			write_block(block, blk);
 		}
 		ino = 0;
@@ -1323,7 +1330,7 @@ main(int argc, char **argv) {
 	/* Determine whether or not we should continue with the checking.  This
 	 * is based on the status of the filesystem valid and error flags and
 	 * whether or not the -f switch was specified on the command line.  */
-	if (!(Super.s_state & MINIX_ERROR_FS) &&
+	if (fs_version < 3 && !(Super.s_state & MINIX_ERROR_FS) &&
 	    (Super.s_state & MINIX_VALID_FS) && !force) {
 		if (repair)
 			printf(_("%s is clean, no check.\n"), device_name);
@@ -1350,7 +1357,7 @@ main(int argc, char **argv) {
 		termios_set = 1;
 	}
 
-	if (fs_version == 2) {
+	if (fs_version == 2 || fs_version == 3) {
 		check_root2();
 		check2();
 	} else {
-- 
2.4.4

