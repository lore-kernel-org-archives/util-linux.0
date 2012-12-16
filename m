Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f174.google.com ([209.85.212.174]:58849 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752614Ab2LPKoc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Dec 2012 05:44:32 -0500
Received: by mail-wi0-f174.google.com with SMTP id hm9so1394217wib.1
        for <util-linux@vger.kernel.org>; Sun, 16 Dec 2012 02:44:31 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/14] minix: use off_t, size_t, etc appropriate types
Date: Sun, 16 Dec 2012 10:43:58 +0000
Message-Id: <1355654642-22106-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
References: <1355654642-22106-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.c | 12 ++++++------
 disk-utils/mkfs.minix.c |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index f24a9f2..6189b0b 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -584,9 +584,9 @@ read_superblock(void) {
 static void
 read_tables(void) {
 	unsigned long inodes = get_ninodes();
-	unsigned long buffsz = get_inode_buffer_size();
-	unsigned long norm_first_zone = first_zone_data();
-	unsigned long first_zone = get_first_zone();
+	size_t buffsz = get_inode_buffer_size();
+	off_t norm_first_zone = first_zone_data();
+	off_t first_zone = get_first_zone();
 	unsigned long zones = get_nzones();
 	unsigned long imaps = get_nimaps();
 	unsigned long zmaps = get_nzmaps();
@@ -999,7 +999,7 @@ static void
 check_file2(struct minix2_inode *dir, unsigned int offset) {
 	static char blk[MINIX_BLOCK_SIZE];
 	struct minix2_inode *inode;
-	unsigned long ino;
+	ino_t ino;
 	char *name;
 	int block;
 
@@ -1064,7 +1064,7 @@ check_file2(struct minix2_inode *dir, unsigned int offset) {
 static void
 recursive_check(unsigned int ino) {
 	struct minix_inode *dir;
-	unsigned int offset;
+	off_t offset;
 
 	dir = Inode + ino;
 	if (!S_ISDIR(dir->i_mode))
@@ -1081,7 +1081,7 @@ recursive_check(unsigned int ino) {
 static void
 recursive_check2(unsigned int ino) {
 	struct minix2_inode *dir;
-	unsigned int offset;
+	off_t offset;
 
 	dir = Inode2 + ino;
 	if (!S_ISDIR(dir->i_mode))
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 343ec68..b445c0c 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -188,7 +188,7 @@ static void super_set_state(void)
 static void write_tables(void) {
 	unsigned long imaps = get_nimaps();
 	unsigned long zmaps = get_nzmaps();
-	unsigned long buffsz = get_inode_buffer_size();
+	size_t buffsz = get_inode_buffer_size();
 
 	/* Mark the super block valid. */
 	super_set_state();
@@ -552,8 +552,8 @@ static void setup_tables(void) {
  * Perform a test of a block; return the number of
  * blocks readable/writeable.
  */
-static long do_check(char * buffer, int try, unsigned int current_block) {
-	long got;
+static size_t do_check(char * buffer, int try, unsigned int current_block) {
+	ssize_t got;
 	
 	/* Seek to the correct loc. */
 	if (lseek(DEV, current_block * MINIX_BLOCK_SIZE, SEEK_SET) !=
@@ -587,7 +587,7 @@ static void alarm_intr(int alnum __attribute__ ((__unused__))) {
 }
 
 static void check_blocks(void) {
-	int try,got;
+	size_t try, got;
 	static char buffer[MINIX_BLOCK_SIZE * TEST_BUFFER_BLOCKS];
 	unsigned long zones = get_nzones();
 	unsigned long first_zone = get_first_zone();
-- 
1.8.0.2

