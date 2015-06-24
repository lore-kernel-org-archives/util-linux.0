Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33389 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751488AbbFXIPf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:35 -0400
Received: by wiwl6 with SMTP id l6so87779016wiw.0
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/12] mkfs.minix: add fs_control structure, and remove most global variables
Date: Wed, 24 Jun 2015 09:15:12 +0100
Message-Id: <1435133719-2971-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This allows better code structure in future.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.c | 380 ++++++++++++++++++++++++------------------------
 1 file changed, 190 insertions(+), 190 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index d3b46b2..fcf7f37 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -98,30 +98,23 @@ static char *inode_buffer = NULL;
 #define Inode (((struct minix_inode *) inode_buffer) - 1)
 #define Inode2 (((struct minix2_inode *) inode_buffer) - 1)
 
-static char *device_name;
-static int DEV = -1;
-static unsigned long long BLOCKS;
-static int check;
-static int badblocks;
-
-/*
- * default (changed to 30, per Linus's
- * suggestion, Sun Nov 21 08:05:07 1993)
- * This should be changed in the future to 60,
- * since v3 needs to be the default nowadays (2011)
- */
-static size_t namelen = 30;
-static size_t dirsize = 32;
-static int magic = MINIX_SUPER_MAGIC2;
+struct fs_control {
+	char *device_name;		/* device on a Minix file system is created */
+	int device_fd;			/* open file descriptor of the device */
+	unsigned long long fs_blocks;	/* device block count for the file system */
+	int fs_used_blocks;		/* used blocks on a device */
+	int fs_bad_blocks;		/* number of bad blocks found from device */
+	size_t fs_namelen;		/* maximum length of filenames */
+	size_t fs_dirsize;		/* maximum size of directory */
+	unsigned long fs_inodes;	/* number of inodes */
+	int fs_magic;			/* file system magic number */
+	unsigned int
+	 check_blocks:1;		/* check for bad blocks */
+};
 
 static char root_block[MINIX_BLOCK_SIZE];
-
 static char boot_block_buffer[512];
-
 static unsigned short good_blocks_table[MAX_GOOD_BLOCKS];
-static int used_good_blocks;
-static unsigned long req_nr_inodes;
-
 
 static char *inode_map;
 static char *zone_map;
@@ -166,7 +159,7 @@ static void super_set_state(void)
 	}
 }
 
-static void write_tables(void) {
+static void write_tables(const struct fs_control *ctl) {
 	unsigned long imaps = get_nimaps();
 	unsigned long zmaps = get_nzmaps();
 	size_t buffsz = get_inode_buffer_size();
@@ -174,59 +167,59 @@ static void write_tables(void) {
 	/* Mark the super block valid. */
 	super_set_state();
 
-	if (lseek(DEV, 0, SEEK_SET))
+	if (lseek(ctl->device_fd, 0, SEEK_SET))
 		err(MKFS_EX_ERROR, _("%s: seek to boot block failed "
-				   " in write_tables"), device_name);
-	if (write_all(DEV, boot_block_buffer, 512))
-		err(MKFS_EX_ERROR, _("%s: unable to clear boot sector"), device_name);
-	if (MINIX_BLOCK_SIZE != lseek(DEV, MINIX_BLOCK_SIZE, SEEK_SET))
-		err(MKFS_EX_ERROR, _("%s: seek failed in write_tables"), device_name);
+				   " in write_tables"), ctl->device_name);
+	if (write_all(ctl->device_fd, boot_block_buffer, 512))
+		err(MKFS_EX_ERROR, _("%s: unable to clear boot sector"), ctl->device_name);
+	if (MINIX_BLOCK_SIZE != lseek(ctl->device_fd, MINIX_BLOCK_SIZE, SEEK_SET))
+		err(MKFS_EX_ERROR, _("%s: seek failed in write_tables"), ctl->device_name);
 
-	if (write_all(DEV, super_block_buffer, MINIX_BLOCK_SIZE))
-		err(MKFS_EX_ERROR, _("%s: unable to write super-block"), device_name);
+	if (write_all(ctl->device_fd, super_block_buffer, MINIX_BLOCK_SIZE))
+		err(MKFS_EX_ERROR, _("%s: unable to write super-block"), ctl->device_name);
 
-	if (write_all(DEV, inode_map, imaps * MINIX_BLOCK_SIZE))
-		err(MKFS_EX_ERROR, _("%s: unable to write inode map"), device_name);
+	if (write_all(ctl->device_fd, inode_map, imaps * MINIX_BLOCK_SIZE))
+		err(MKFS_EX_ERROR, _("%s: unable to write inode map"), ctl->device_name);
 
-	if (write_all(DEV, zone_map, zmaps * MINIX_BLOCK_SIZE))
-		err(MKFS_EX_ERROR, _("%s: unable to write zone map"), device_name);
+	if (write_all(ctl->device_fd, zone_map, zmaps * MINIX_BLOCK_SIZE))
+		err(MKFS_EX_ERROR, _("%s: unable to write zone map"), ctl->device_name);
 
-	if (write_all(DEV, inode_buffer, buffsz))
-		err(MKFS_EX_ERROR, _("%s: unable to write inodes"), device_name);
+	if (write_all(ctl->device_fd, inode_buffer, buffsz))
+		err(MKFS_EX_ERROR, _("%s: unable to write inodes"), ctl->device_name);
 }
 
-static void write_block(int blk, char * buffer) {
-	if (blk*MINIX_BLOCK_SIZE != lseek(DEV, blk*MINIX_BLOCK_SIZE, SEEK_SET))
-		errx(MKFS_EX_ERROR, _("%s: seek failed in write_block"), device_name);
+static void write_block(const struct fs_control *ctl, int blk, char * buffer) {
+	if (blk * MINIX_BLOCK_SIZE != lseek(ctl->device_fd, blk * MINIX_BLOCK_SIZE, SEEK_SET))
+		errx(MKFS_EX_ERROR, _("%s: seek failed in write_block"), ctl->device_name);
 
-	if (write_all(DEV, buffer, MINIX_BLOCK_SIZE))
-		errx(MKFS_EX_ERROR, _("%s: write failed in write_block"), device_name);
+	if (write_all(ctl->device_fd, buffer, MINIX_BLOCK_SIZE))
+		errx(MKFS_EX_ERROR, _("%s: write failed in write_block"), ctl->device_name);
 }
 
-static int get_free_block(void) {
+static int get_free_block(struct fs_control *ctl) {
 	unsigned int blk;
 	unsigned int zones = get_nzones();
 	unsigned int first_zone = get_first_zone();
 
-	if (used_good_blocks+1 >= MAX_GOOD_BLOCKS)
-		errx(MKFS_EX_ERROR, _("%s: too many bad blocks"), device_name);
-	if (used_good_blocks)
-		blk = good_blocks_table[used_good_blocks-1]+1;
+	if (ctl->fs_used_blocks + 1 >= MAX_GOOD_BLOCKS)
+		errx(MKFS_EX_ERROR, _("%s: too many bad blocks"), ctl->device_name);
+	if (ctl->fs_used_blocks)
+		blk = good_blocks_table[ctl->fs_used_blocks - 1] + 1;
 	else
 		blk = first_zone;
 	while (blk < zones && zone_in_use(blk))
 		blk++;
 	if (blk >= zones)
-		errx(MKFS_EX_ERROR, _("%s: not enough good blocks"), device_name);
-	good_blocks_table[used_good_blocks] = blk;
-	used_good_blocks++;
+		errx(MKFS_EX_ERROR, _("%s: not enough good blocks"), ctl->device_name);
+	good_blocks_table[ctl->fs_used_blocks] = blk;
+	ctl->fs_used_blocks++;
 	return blk;
 }
 
-static void mark_good_blocks(void) {
+static void mark_good_blocks(const struct fs_control *ctl) {
 	int blk;
 
-	for (blk=0 ; blk < used_good_blocks ; blk++)
+	for (blk=0 ; blk < ctl->fs_used_blocks ; blk++)
 		mark_zone(good_blocks_table[blk]);
 }
 
@@ -242,7 +235,7 @@ static inline int next(unsigned long zone) {
 	return 0;
 }
 
-static void make_bad_inode_v1(void)
+static void make_bad_inode_v1(struct fs_control *ctl)
 {
 	struct minix_inode * inode = &Inode[MINIX_BAD_INO];
 	int i,j,zone;
@@ -252,31 +245,31 @@ static void make_bad_inode_v1(void)
 
 #define NEXT_BAD (zone = next(zone))
 
-	if (!badblocks)
+	if (!ctl->fs_bad_blocks)
 		return;
 	mark_inode(MINIX_BAD_INO);
 	inode->i_nlinks = 1;
 	inode->i_time = time(NULL);
 	inode->i_mode = S_IFREG + 0000;
-	inode->i_size = badblocks*MINIX_BLOCK_SIZE;
+	inode->i_size = ctl->fs_bad_blocks * MINIX_BLOCK_SIZE;
 	zone = next(0);
 	for (i=0 ; i<7 ; i++) {
 		inode->i_zone[i] = zone;
 		if (!NEXT_BAD)
 			goto end_bad;
 	}
-	inode->i_zone[7] = ind = get_free_block();
+	inode->i_zone[7] = ind = get_free_block(ctl);
 	memset(ind_block,0,MINIX_BLOCK_SIZE);
 	for (i=0 ; i<512 ; i++) {
 		ind_block[i] = zone;
 		if (!NEXT_BAD)
 			goto end_bad;
 	}
-	inode->i_zone[8] = dind = get_free_block();
+	inode->i_zone[8] = dind = get_free_block(ctl);
 	memset(dind_block,0,MINIX_BLOCK_SIZE);
 	for (i=0 ; i<512 ; i++) {
-		write_block(ind,(char *) ind_block);
-		dind_block[i] = ind = get_free_block();
+		write_block(ctl, ind,(char *) ind_block);
+		dind_block[i] = ind = get_free_block(ctl);
 		memset(ind_block,0,MINIX_BLOCK_SIZE);
 		for (j=0 ; j<512 ; j++) {
 			ind_block[j] = zone;
@@ -284,15 +277,15 @@ static void make_bad_inode_v1(void)
 				goto end_bad;
 		}
 	}
-	errx(MKFS_EX_ERROR, _("%s: too many bad blocks"), device_name);
+	errx(MKFS_EX_ERROR, _("%s: too many bad blocks"), ctl->device_name);
 end_bad:
 	if (ind)
-		write_block(ind, (char *) ind_block);
+		write_block(ctl, ind, (char *) ind_block);
 	if (dind)
-		write_block(dind, (char *) dind_block);
+		write_block(ctl, dind, (char *) dind_block);
 }
 
-static void make_bad_inode_v2_v3 (void)
+static void make_bad_inode_v2_v3 (struct fs_control *ctl)
 {
 	struct minix2_inode *inode = &Inode2[MINIX_BAD_INO];
 	int i, j, zone;
@@ -300,31 +293,31 @@ static void make_bad_inode_v2_v3 (void)
 	unsigned long ind_block[MINIX_BLOCK_SIZE >> 2];
 	unsigned long dind_block[MINIX_BLOCK_SIZE >> 2];
 
-	if (!badblocks)
+	if (!ctl->fs_bad_blocks)
 		return;
 	mark_inode (MINIX_BAD_INO);
 	inode->i_nlinks = 1;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = time (NULL);
 	inode->i_mode = S_IFREG + 0000;
-	inode->i_size = badblocks * MINIX_BLOCK_SIZE;
+	inode->i_size = ctl->fs_bad_blocks * MINIX_BLOCK_SIZE;
 	zone = next (0);
 	for (i = 0; i < 7; i++) {
 		inode->i_zone[i] = zone;
 		if (!NEXT_BAD)
 			goto end_bad;
 	}
-	inode->i_zone[7] = ind = get_free_block ();
+	inode->i_zone[7] = ind = get_free_block (ctl);
 	memset (ind_block, 0, MINIX_BLOCK_SIZE);
 	for (i = 0; i < 256; i++) {
 		ind_block[i] = zone;
 		if (!NEXT_BAD)
 			goto end_bad;
 	}
-	inode->i_zone[8] = dind = get_free_block ();
+	inode->i_zone[8] = dind = get_free_block (ctl);
 	memset (dind_block, 0, MINIX_BLOCK_SIZE);
 	for (i = 0; i < 256; i++) {
-		write_block (ind, (char *) ind_block);
-		dind_block[i] = ind = get_free_block ();
+		write_block (ctl, ind, (char *) ind_block);
+		dind_block[i] = ind = get_free_block (ctl);
 		memset (ind_block, 0, MINIX_BLOCK_SIZE);
 		for (j = 0; j < 256; j++) {
 			ind_block[j] = zone;
@@ -333,86 +326,86 @@ static void make_bad_inode_v2_v3 (void)
 		}
 	}
 	/* Could make triple indirect block here */
-	errx(MKFS_EX_ERROR, _("%s: too many bad blocks"), device_name);
+	errx(MKFS_EX_ERROR, _("%s: too many bad blocks"), ctl->device_name);
  end_bad:
 	if (ind)
-		write_block (ind, (char *) ind_block);
+		write_block (ctl, ind, (char *) ind_block);
 	if (dind)
-		write_block (dind, (char *) dind_block);
+		write_block (ctl, dind, (char *) dind_block);
 }
 
-static void make_bad_inode(void)
+static void make_bad_inode(struct fs_control *ctl)
 {
 	if (fs_version < 2) {
-		make_bad_inode_v1();
+		make_bad_inode_v1(ctl);
 		return;
 	}
-	make_bad_inode_v2_v3();
+	make_bad_inode_v2_v3(ctl);
 }
 
-static void make_root_inode_v1(void) {
+static void make_root_inode_v1(struct fs_control *ctl) {
 	struct minix_inode * inode = &Inode[MINIX_ROOT_INO];
 
 	mark_inode(MINIX_ROOT_INO);
-	inode->i_zone[0] = get_free_block();
+	inode->i_zone[0] = get_free_block(ctl);
 	inode->i_nlinks = 2;
 	inode->i_time = time(NULL);
-	if (badblocks)
-		inode->i_size = 3*dirsize;
+	if (ctl->fs_bad_blocks)
+		inode->i_size = 3 * ctl->fs_dirsize;
 	else {
-		root_block[2*dirsize] = '\0';
-		root_block[2*dirsize+1] = '\0';
-		inode->i_size = 2*dirsize;
+		root_block[2 * ctl->fs_dirsize] = '\0';
+		root_block[2 * ctl->fs_dirsize + 1] = '\0';
+		inode->i_size = 2 * ctl->fs_dirsize;
 	}
 	inode->i_mode = S_IFDIR + 0755;
 	inode->i_uid = getuid();
 	if (inode->i_uid)
 		inode->i_gid = getgid();
-	write_block(inode->i_zone[0],root_block);
+	write_block(ctl, inode->i_zone[0],root_block);
 }
 
-static void make_root_inode_v2_v3 (void) {
+static void make_root_inode_v2_v3 (struct fs_control *ctl) {
 	struct minix2_inode *inode = &Inode2[MINIX_ROOT_INO];
 
 	mark_inode (MINIX_ROOT_INO);
-	inode->i_zone[0] = get_free_block ();
+	inode->i_zone[0] = get_free_block (ctl);
 	inode->i_nlinks = 2;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = time (NULL);
 
-	if (badblocks)
-		inode->i_size = 3 * dirsize;
+	if (ctl->fs_bad_blocks)
+		inode->i_size = 3 * ctl->fs_dirsize;
 	else {
-		root_block[2 * dirsize] = '\0';
-		inode->i_size = 2 * dirsize;
+		root_block[2 * ctl->fs_dirsize] = '\0';
+		inode->i_size = 2 * ctl->fs_dirsize;
 	}
 
 	inode->i_mode = S_IFDIR + 0755;
 	inode->i_uid = getuid();
 	if (inode->i_uid)
 		inode->i_gid = getgid();
-	write_block (inode->i_zone[0], root_block);
+	write_block (ctl, inode->i_zone[0], root_block);
 }
 
-static void make_root_inode(void)
+static void make_root_inode(struct fs_control *ctl)
 {
 	if (fs_version < 2) {
-		make_root_inode_v1();
+		make_root_inode_v1(ctl);
 		return;
 	}
-	make_root_inode_v2_v3();
+	make_root_inode_v2_v3(ctl);
 }
 
-static void super_set_nzones(void)
+static void super_set_nzones(const struct fs_control *ctl)
 {
 	switch (fs_version) {
 	case 3:
-		Super3.s_zones = BLOCKS;
+		Super3.s_zones = ctl->fs_blocks;
 		break;
 	case 2:
-		Super.s_zones = BLOCKS;
+		Super.s_zones = ctl->fs_blocks;
 		break;
 	default: /* v1 */
-		Super.s_nzones = BLOCKS;
+		Super.s_nzones = ctl->fs_blocks;
 		break;
 	}
 }
@@ -432,46 +425,46 @@ static void super_init_maxsize(void)
 	}
 }
 
-static void super_set_map_blocks(unsigned long inodes)
+static void super_set_map_blocks(const struct fs_control *ctl, unsigned long inodes)
 {
 	switch (fs_version) {
 	case 3:
 		Super3.s_imap_blocks = UPPER(inodes + 1, BITS_PER_BLOCK);
-		Super3.s_zmap_blocks = UPPER(BLOCKS - (1+get_nimaps()+inode_blocks()),
-					     BITS_PER_BLOCK+1);
+		Super3.s_zmap_blocks = UPPER(ctl->fs_blocks - (1 + get_nimaps() + inode_blocks()),
+					     BITS_PER_BLOCK + 1);
 		Super3.s_firstdatazone = first_zone_data();
 		break;
 	default:
 		Super.s_imap_blocks = UPPER(inodes + 1, BITS_PER_BLOCK);
-		Super.s_zmap_blocks = UPPER(BLOCKS - (1+get_nimaps()+inode_blocks()),
-					     BITS_PER_BLOCK+1);
+		Super.s_zmap_blocks = UPPER(ctl->fs_blocks - (1 + get_nimaps() + inode_blocks()),
+					     BITS_PER_BLOCK + 1);
 		Super.s_firstdatazone = first_zone_data();
 		break;
 	}
 }
 
-static void super_set_magic(void)
+static void super_set_magic(const struct fs_control *ctl)
 {
 	switch (fs_version) {
 	case 3:
-		Super3.s_magic = magic;
+		Super3.s_magic = ctl->fs_magic;
 		break;
 	default:
-		Super.s_magic = magic;
+		Super.s_magic = ctl->fs_magic;
 		break;
 	}
 }
 
-static void setup_tables(void) {
+static void setup_tables(const struct fs_control *ctl) {
 	unsigned long inodes, zmaps, imaps, zones, i;
 
 	super_block_buffer = calloc(1, MINIX_BLOCK_SIZE);
 	if (!super_block_buffer)
 		err(MKFS_EX_ERROR, _("%s: unable to allocate buffer for superblock"),
-				device_name);
+				ctl->device_name);
 
 	memset(boot_block_buffer,0,512);
-	super_set_magic();
+	super_set_magic(ctl);
 
 	if (fs_version == 3) {
 		Super3.s_log_zone_size = 0;
@@ -482,21 +475,21 @@ static void setup_tables(void) {
 	}
 
 	super_init_maxsize();
-	super_set_nzones();
+	super_set_nzones(ctl);
 	zones = get_nzones();
 
 	/* some magic nrs: 1 inode / 3 blocks for smaller filesystems,
 	 * for one inode / 16 blocks for large ones. mkfs will eventually
 	 * crab about too far when getting close to the maximum size. */
-	if (req_nr_inodes == 0)
-		if (2048 * 1024 < BLOCKS)	/* 2GB */
-			inodes = BLOCKS / 16;
-		else if (512 * 1024 < BLOCKS)	/* 0.5GB */
-			inodes = BLOCKS / 8;
+	if (ctl->fs_inodes == 0)
+		if (2048 * 1024 < ctl->fs_blocks)	/* 2GB */
+			inodes = ctl->fs_blocks / 16;
+		else if (512 * 1024 < ctl->fs_blocks)	/* 0.5GB */
+			inodes = ctl->fs_blocks / 8;
 		else
-			inodes = BLOCKS / 3;
+			inodes = ctl->fs_blocks / 3;
 	else
-		inodes = req_nr_inodes;
+		inodes = ctl->fs_inodes;
 	/* Round up inode count to fill block size */
 	if (fs_version == 2 || fs_version == 3)
 		inodes = ((inodes + MINIX2_INODES_PER_BLOCK - 1) &
@@ -512,7 +505,7 @@ static void setup_tables(void) {
 		if (inodes > MINIX_MAX_INODES)
 			inodes = MINIX_MAX_INODES;
 	}
-	super_set_map_blocks(inodes);
+	super_set_map_blocks(ctl, inodes);
 	if (MINIX_MAX_INODES < first_zone_data())
 		errx(MKFS_EX_ERROR,
 		     _("First data block at %jd, which is too far (max %d).\n"
@@ -526,7 +519,7 @@ static void setup_tables(void) {
 	zone_map = malloc(zmaps * MINIX_BLOCK_SIZE);
 	if (!inode_map || !zone_map)
 		err(MKFS_EX_ERROR, _("%s: unable to allocate buffers for maps"),
-				device_name);
+				ctl->device_name);
 	memset(inode_map,0xff,imaps * MINIX_BLOCK_SIZE);
 	memset(zone_map,0xff,zmaps * MINIX_BLOCK_SIZE);
 	for (i = get_first_zone() ; i<zones ; i++)
@@ -536,7 +529,7 @@ static void setup_tables(void) {
 	inode_buffer = malloc(get_inode_buffer_size());
 	if (!inode_buffer)
 		err(MKFS_EX_ERROR, _("%s: unable to allocate buffer for inodes"),
-				device_name);
+				ctl->device_name);
 	memset(inode_buffer,0, get_inode_buffer_size());
 	printf(P_("%lu inode\n", "%lu inodes\n", inodes), inodes);
 	printf(P_("%lu block\n", "%lu blocks\n", zones), zones);
@@ -549,17 +542,17 @@ static void setup_tables(void) {
  * Perform a test of a block; return the number of
  * blocks readable/writeable.
  */
-static size_t do_check(char * buffer, int try, unsigned int current_block) {
+static size_t do_check(const struct fs_control *ctl, char * buffer, int try, unsigned int current_block) {
 	ssize_t got;
 	
 	/* Seek to the correct loc. */
-	if (lseek(DEV, current_block * MINIX_BLOCK_SIZE, SEEK_SET) !=
+	if (lseek(ctl->device_fd, current_block * MINIX_BLOCK_SIZE, SEEK_SET) !=
 		       current_block * MINIX_BLOCK_SIZE )
 		err(MKFS_EX_ERROR, _("%s: seek failed during testing of blocks"),
-				device_name);
+				ctl->device_name);
 
 	/* Try the read */
-	got = read(DEV, buffer, try * MINIX_BLOCK_SIZE);
+	got = read(ctl->device_fd, buffer, try * MINIX_BLOCK_SIZE);
 	if (got < 0) got = 0;	
 	if (got & (MINIX_BLOCK_SIZE - 1 )) {
 		printf(_("Weird values in do_check: probably bugs\n"));
@@ -583,7 +576,7 @@ static void alarm_intr(int alnum __attribute__ ((__unused__))) {
 	fflush(stdout);
 }
 
-static void check_blocks(void) {
+static void check_blocks(struct fs_control *ctl) {
 	size_t try, got;
 	static char buffer[MINIX_BLOCK_SIZE * TEST_BUFFER_BLOCKS];
 	unsigned long zones = get_nzones();
@@ -593,53 +586,60 @@ static void check_blocks(void) {
 	signal(SIGALRM,alarm_intr);
 	alarm(5);
 	while (currently_testing < zones) {
-		if (lseek(DEV,currently_testing*MINIX_BLOCK_SIZE,SEEK_SET) !=
+		if (lseek(ctl->device_fd, currently_testing * MINIX_BLOCK_SIZE,SEEK_SET) !=
 		    currently_testing*MINIX_BLOCK_SIZE)
 			errx(MKFS_EX_ERROR, _("%s: seek failed in check_blocks"),
-					device_name);
+					ctl->device_name);
 		try = TEST_BUFFER_BLOCKS;
 		if (currently_testing + try > zones)
 			try = zones-currently_testing;
-		got = do_check(buffer, try, currently_testing);
+		got = do_check(ctl, buffer, try, currently_testing);
 		currently_testing += got;
 		if (got == try)
 			continue;
 		if (currently_testing < first_zone)
 			errx(MKFS_EX_ERROR, _("%s: bad blocks before data-area: "
-					"cannot make fs"), device_name);
+					"cannot make fs"), ctl->device_name);
 		mark_zone(currently_testing);
-		badblocks++;
+		ctl->fs_bad_blocks++;
 		currently_testing++;
 	}
-	if (badblocks > 0)
-		printf(P_("%d bad block\n", "%d bad blocks\n", badblocks), badblocks);
+	if (ctl->fs_bad_blocks > 0)
+		printf(P_("%d bad block\n", "%d bad blocks\n", ctl->fs_bad_blocks), ctl->fs_bad_blocks);
 }
 
-static void get_list_blocks(char *filename) {
+static void get_list_blocks(struct fs_control *ctl, char *filename) {
 	FILE *listfile;
 	unsigned long blockno;
 
 	listfile = fopen(filename,"r");
 	if (listfile == NULL)
 		err(MKFS_EX_ERROR, _("%s: can't open file of bad blocks"),
-				device_name);
+				ctl->device_name);
 
 	while (!feof(listfile)) {
 		if (fscanf(listfile,"%lu\n", &blockno) != 1) {
-			printf(_("badblock number input error on line %d\n"), badblocks + 1);
+			printf(_("badblock number input error on line %d\n"), ctl->fs_bad_blocks + 1);
 			errx(MKFS_EX_ERROR, _("%s: cannot read badblocks file"),
-					device_name);
+					ctl->device_name);
 		}
 		mark_zone(blockno);
-		badblocks++;
+		ctl->fs_bad_blocks++;
 	}
 	fclose(listfile);
 
-	if (badblocks > 0)
-		printf(P_("%d bad block\n", "%d bad blocks\n", badblocks), badblocks);
+	if (ctl->fs_bad_blocks > 0)
+		printf(P_("%d bad block\n", "%d bad blocks\n", ctl->fs_bad_blocks), ctl->fs_bad_blocks);
 }
 
-int main(int argc, char ** argv) {
+int main(int argc, char ** argv)
+{
+	struct fs_control ctl = {
+		.fs_namelen = 30,
+		.fs_dirsize = 32,
+		.fs_magic = MINIX_SUPER_MAGIC2,		/* version 1, long names */
+		0
+	};
 	int i;
 	char * tmp;
 	struct stat statbuf;
@@ -671,27 +671,27 @@ int main(int argc, char ** argv) {
 			break;
 		case '3':
 			fs_version = 3;
-			namelen = 60;
-			dirsize = 64;
+			ctl.fs_namelen = 60;
+			ctl.fs_dirsize = 64;
 			break;
 		case 'n':
 			i = strtoul_or_err(optarg,
 					_("failed to parse maximum length of filenames"));
 			if (i == 14)
-				magic = MINIX_SUPER_MAGIC;
+				ctl.fs_magic = MINIX_SUPER_MAGIC;
 			else if (i == 30)
-				magic = MINIX_SUPER_MAGIC2;
+				ctl.fs_magic = MINIX_SUPER_MAGIC2;
 			else
 				usage(stderr);
-			namelen = i;
-			dirsize = i+2;
+			ctl.fs_namelen = i;
+			ctl.fs_dirsize = i + 2;
 			break;
 		case 'i':
-			req_nr_inodes = strtoul_or_err(optarg,
+			ctl.fs_inodes = strtoul_or_err(optarg,
 					_("failed to parse number of inodes"));
 			break;
 		case 'c':
-			check=1;
+			ctl.check_blocks = 1;
 			break;
 		case 'l':
 			listfile = optarg;
@@ -706,99 +706,99 @@ int main(int argc, char ** argv) {
 		}
 	argc -= optind;
 	argv += optind;
-	if (argc > 0 && !device_name) {
-		device_name = argv[0];
+	if (argc > 0) {
+		ctl.device_name = argv[0];
 		argc--;
 		argv++;
 	}
 	if (argc > 0)
-		BLOCKS = strtoul_or_err(argv[0], _("failed to parse number of blocks"));
+		ctl.fs_blocks = strtoul_or_err(argv[0], _("failed to parse number of blocks"));
 
-	if (!device_name) {
+	if (!ctl.device_name) {
 		usage(stderr);
 	}
-	if (is_mounted(device_name))
+	if (is_mounted(ctl.device_name))
 		errx(MKFS_EX_ERROR, _("%s is mounted; will not make a filesystem here!"),
-			device_name);
+			ctl.device_name);
 	tmp = root_block;
 	if (fs_version == 3) {
 		*(uint32_t *)tmp = 1;
 		strcpy(tmp+4,".");
-		tmp += dirsize;
+		tmp += ctl.fs_dirsize;
 		*(uint32_t *)tmp = 1;
 		strcpy(tmp+4,"..");
-		tmp += dirsize;
+		tmp += ctl.fs_dirsize;
 		*(uint32_t *)tmp = 2;
 		strcpy(tmp+4, ".badblocks");
 	} else {
 		*(uint16_t *)tmp = 1;
 		strcpy(tmp+2,".");
-		tmp += dirsize;
+		tmp += ctl.fs_dirsize;
 		*(uint16_t *)tmp = 1;
 		strcpy(tmp+2,"..");
-		tmp += dirsize;
+		tmp += ctl.fs_dirsize;
 		*(uint16_t *)tmp = 2;
 		strcpy(tmp+2, ".badblocks");
 	}
-	if (stat(device_name, &statbuf) < 0)
-		err(MKFS_EX_ERROR, _("stat of %s failed"), device_name);
+	if (stat(ctl.device_name, &statbuf) < 0)
+		err(MKFS_EX_ERROR, _("stat of %s failed"), ctl.device_name);
 	if (S_ISBLK(statbuf.st_mode))
-		DEV = open(device_name,O_RDWR | O_EXCL);
+		ctl.device_fd = open(ctl.device_name, O_RDWR | O_EXCL);
 	else
-		DEV = open(device_name,O_RDWR);
+		ctl.device_fd = open(ctl.device_name, O_RDWR);
 
-	if (DEV<0)
-		err(MKFS_EX_ERROR, _("cannot open %s"), device_name);
+	if (ctl.device_fd < 0)
+		err(MKFS_EX_ERROR, _("cannot open %s"), ctl.device_name);
 
 	if (S_ISBLK(statbuf.st_mode)) {
 		int sectorsize;
 
-		if (blkdev_get_sector_size(DEV, &sectorsize) == -1)
+		if (blkdev_get_sector_size(ctl.device_fd, &sectorsize) == -1)
 			sectorsize = DEFAULT_SECTOR_SIZE;		/* kernel < 2.3.3 */
 
-		if (blkdev_is_misaligned(DEV))
-			warnx(_("%s: device is misaligned"), device_name);
+		if (blkdev_is_misaligned(ctl.device_fd))
+			warnx(_("%s: device is misaligned"), ctl.device_name);
 
 		if (MINIX_BLOCK_SIZE < sectorsize)
 			errx(MKFS_EX_ERROR, _("block size smaller than physical "
-					"sector size of %s"), device_name);
-		if (!BLOCKS) {
-			if (blkdev_get_size(DEV, &BLOCKS) == -1)
+					"sector size of %s"), ctl.device_name);
+		if (!ctl.fs_blocks) {
+			if (blkdev_get_size(ctl.device_fd, &ctl.fs_blocks) == -1)
 				errx(MKFS_EX_ERROR, _("cannot determine size of %s"),
-					device_name);
-			BLOCKS /= MINIX_BLOCK_SIZE;
+					ctl.device_name);
+			ctl.fs_blocks /= MINIX_BLOCK_SIZE;
 		}
 	} else if (!S_ISBLK(statbuf.st_mode)) {
-		if (!BLOCKS)
-			BLOCKS = statbuf.st_size / MINIX_BLOCK_SIZE;
+		if (!ctl.fs_blocks)
+			ctl.fs_blocks = statbuf.st_size / MINIX_BLOCK_SIZE;
 	}
-	if (BLOCKS < 10)
-		errx(MKFS_EX_ERROR, _("%s: number of blocks too small"), device_name);
+	if (ctl.fs_blocks < 10)
+		errx(MKFS_EX_ERROR, _("%s: number of blocks too small"), ctl.device_name);
 
 	if (fs_version == 3)
-		magic = MINIX3_SUPER_MAGIC;
+		ctl.fs_magic = MINIX3_SUPER_MAGIC;
 	else if (fs_version == 2) {
-		if (namelen == 14)
-			magic = MINIX2_SUPER_MAGIC;
+		if (ctl.fs_namelen == 14)
+			ctl.fs_magic = MINIX2_SUPER_MAGIC;
 		else
-			magic = MINIX2_SUPER_MAGIC2;
+			ctl.fs_magic = MINIX2_SUPER_MAGIC2;
 	} else /* fs_version == 1 */
-		if (BLOCKS > MINIX_MAX_INODES)
-			BLOCKS = MINIX_MAX_INODES;
-	if (BLOCKS > MINIX_MAX_INODES * BITS_PER_BLOCK)
-		BLOCKS = MINIX_MAX_INODES * BITS_PER_BLOCK;	/* Utter maximum: Clip. */
-	setup_tables();
-	if (check)
-		check_blocks();
+		if (ctl.fs_blocks > MINIX_MAX_INODES)
+			ctl.fs_blocks = MINIX_MAX_INODES;
+	if (ctl.fs_blocks > MINIX_MAX_INODES * BITS_PER_BLOCK)
+		ctl.fs_blocks = MINIX_MAX_INODES * BITS_PER_BLOCK;	/* Utter maximum: Clip. */
+	setup_tables(&ctl);
+	if (ctl.check_blocks)
+		check_blocks(&ctl);
 	else if (listfile)
-		get_list_blocks(listfile);
+		get_list_blocks(&ctl, listfile);
 
-	make_root_inode();
-	make_bad_inode();
+	make_root_inode(&ctl);
+	make_bad_inode(&ctl);
 
-	mark_good_blocks();
-	write_tables();
-	if (close_fd(DEV) != 0)
+	mark_good_blocks(&ctl);
+	write_tables(&ctl);
+	if (close_fd(ctl.device_fd) != 0)
 		err(MKFS_EX_ERROR, _("write failed"));
 
 	return MKFS_EX_OK;
-- 
2.4.4

