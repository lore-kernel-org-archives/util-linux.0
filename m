Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:53919 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753680Ab1GLPv4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 12 Jul 2011 11:51:56 -0400
Received: by ewy4 with SMTP id 4so1779571ewy.19
        for <util-linux@vger.kernel.org>; Tue, 12 Jul 2011 08:51:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] minix: v3 super-block does not have s_state field
Date: Tue, 12 Jul 2011 17:50:46 +0200
Message-Id: <1310485846-3685-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Originally attempt was to use minix definitions and file system
structures from linux/minix_fs.h, but that failed at first try.

mkfs.minix.c:164:10: error: no member named 's_state' in 'struct
      minix3_super_block'
                Super3.s_state |= MINIX_VALID_FS;
                ~~~~~~ ^
mkfs.minix.c:165:10: error: no member named 's_state' in 'struct
      minix3_super_block'
                Super3.s_state &= ~MINIX_ERROR_FS;

Primary reason seems to be that the minix3 super-block does not
have s_state field. And it looks to me that it has never had it.
Further details about s_state can be found from minix v3 file
system support kernel patch.

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=939b00df0306bc4b5cd25c3c3c78e89b91e72fc8

Former minix disk s_state is now in kernel memory super-block
info structure as a s_mount_state field, if someone wonders what
happen to it.

Issue appeared commit a2657ae3ffb56616ac9c921886bcca8ef242499f
(13 days ago), and hopefully not too many users where affected as
I am not sure how bad it is to have mismatch in super-block
structure.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/minix.h      |   68 +----------------------------------------------
 disk-utils/mkfs.minix.c |    2 -
 2 files changed, 1 insertions(+), 69 deletions(-)

diff --git a/disk-utils/minix.h b/disk-utils/minix.h
index fc1d1c0..de79366 100644
--- a/disk-utils/minix.h
+++ b/disk-utils/minix.h
@@ -1,90 +1,24 @@
 #ifndef __MINIX_H__
 #define __MINIX_H__
 
-#ifdef KERNEL_INCLUDES_ARE_CLEAN
-
+#include <linux/types.h>
 #include <linux/fs.h>
 #include <linux/minix_fs.h>
 
-#else
-
-typedef unsigned char u8;
-typedef unsigned short u16;
-typedef unsigned int u32;
-
-struct minix_inode {
-        u16 i_mode;
-        u16 i_uid;
-        u32 i_size;
-        u32 i_time;
-        u8  i_gid;
-        u8  i_nlinks;
-        u16 i_zone[9];
-};
-
-struct minix2_inode {
-        u16 i_mode;
-        u16 i_nlinks;
-        u16 i_uid;
-        u16 i_gid;
-        u32 i_size;
-        u32 i_atime;
-        u32 i_mtime;
-        u32 i_ctime;
-        u32 i_zone[10];
-};
-
-struct minix_super_block {
-        u16 s_ninodes;
-        u16 s_nzones;
-        u16 s_imap_blocks;
-        u16 s_zmap_blocks;
-        u16 s_firstdatazone;
-        u16 s_log_zone_size;
-        u32 s_max_size;
-        u16 s_magic;
-        u16 s_state;
-        u32 s_zones;
-};
-
-/* V3 minix super-block data on disk */
-struct minix3_super_block {
-	u32 s_ninodes;
-	u16 s_pad0;
-	u16 s_imap_blocks;
-	u16 s_zmap_blocks;
-	u16 s_firstdatazone;
-	u16 s_log_zone_size;
-	u16 s_pad1;
-	u32 s_max_size;
-	u32 s_zones;
-	u16 s_magic;
-	u16 s_pad2;
-	u16 s_blocksize;
-	u8  s_disk_version;
-        u16 s_state;
-};
-
 #define BLOCK_SIZE_BITS 10
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
 
 #define NAME_MAX   255   /* # chars in a file name */
 #define MAX_INODES 65535
 
-#define MINIX_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix_inode)))
 #define MINIX2_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix2_inode)))
 
-#define MINIX_VALID_FS               0x0001          /* Clean fs. */
-#define MINIX_ERROR_FS               0x0002          /* fs has errors. */
-
 #define MINIX_SUPER_MAGIC    0x137F          /* original minix fs */
 #define MINIX_SUPER_MAGIC2   0x138F          /* minix fs, 30 char names */
 #define MINIX2_SUPER_MAGIC   0x2468	     /* minix V2 fs */
 #define MINIX2_SUPER_MAGIC2  0x2478	     /* minix V2 fs, 30 char names */
 #define MINIX3_SUPER_MAGIC   0x4d5a          /* minix V3 fs (60 char names) */
 
-#endif /* KERNEL_INCLUDES_ARE_CLEAN */
-
 #define Inode (((struct minix_inode *) inode_buffer)-1)
 #define Inode2 (((struct minix2_inode *) inode_buffer)-1)
 
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 916dd17..322c023 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -161,8 +161,6 @@ static void super_set_state(void)
 {
 	switch (fs_version) {
 	case 3:
-		Super3.s_state |= MINIX_VALID_FS;
-		Super3.s_state &= ~MINIX_ERROR_FS;
 		break;
 	default:
 		Super.s_state |= MINIX_VALID_FS;
-- 
1.7.6

