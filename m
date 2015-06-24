Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:34469 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbFXIPk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:40 -0400
Received: by wicnd19 with SMTP id nd19so127222393wic.1
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 09/12] fsck.minix: rename device file descriptor variable
Date: Wed, 24 Jun 2015 09:15:16 +0100
Message-Id: <1435133719-2971-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.minix.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index 52b001b..3c3faf0 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -127,7 +127,7 @@ static char *inode_buffer;
 #define Inode2 (((struct minix2_inode *) inode_buffer) - 1)
 
 static char *device_name;
-static int IN;
+static int device_fd;
 static int repair, automatic, verbose, list, show, warn_mode, force;
 static int directory, regular, blockdev, chardev, links, symlinks, total;
 
@@ -363,13 +363,13 @@ read_block(unsigned int nr, char *addr) {
 		memset(addr, 0, MINIX_BLOCK_SIZE);
 		return;
 	}
-	if (MINIX_BLOCK_SIZE * nr != lseek(IN, MINIX_BLOCK_SIZE * nr, SEEK_SET)) {
+	if (MINIX_BLOCK_SIZE * nr != lseek(device_fd, MINIX_BLOCK_SIZE * nr, SEEK_SET)) {
 		get_current_name();
 		printf(_("Read error: unable to seek to block in file '%s'\n"),
 		       current_name);
 		memset(addr, 0, MINIX_BLOCK_SIZE);
 		errors_uncorrected = 1;
-	} else if (MINIX_BLOCK_SIZE != read(IN, addr, MINIX_BLOCK_SIZE)) {
+	} else if (MINIX_BLOCK_SIZE != read(device_fd, addr, MINIX_BLOCK_SIZE)) {
 		get_current_name();
 		printf(_("Read error: bad block in file '%s'\n"), current_name);
 		memset(addr, 0, MINIX_BLOCK_SIZE);
@@ -388,9 +388,9 @@ write_block(unsigned int nr, char *addr) {
 		errors_uncorrected = 1;
 		return;
 	}
-	if (MINIX_BLOCK_SIZE * nr != lseek(IN, MINIX_BLOCK_SIZE * nr, SEEK_SET))
+	if (MINIX_BLOCK_SIZE * nr != lseek(device_fd, MINIX_BLOCK_SIZE * nr, SEEK_SET))
 		die(_("seek failed in write_block"));
-	if (MINIX_BLOCK_SIZE != write(IN, addr, MINIX_BLOCK_SIZE)) {
+	if (MINIX_BLOCK_SIZE != write(device_fd, addr, MINIX_BLOCK_SIZE)) {
 		get_current_name();
 		printf(_("Write error: bad block in file '%s'\n"),
 		       current_name);
@@ -503,9 +503,9 @@ write_super_block(void) {
 	else
 		Super.s_state &= ~MINIX_ERROR_FS;
 
-	if (MINIX_BLOCK_SIZE != lseek(IN, MINIX_BLOCK_SIZE, SEEK_SET))
+	if (MINIX_BLOCK_SIZE != lseek(device_fd, MINIX_BLOCK_SIZE, SEEK_SET))
 		die(_("seek failed in write_super_block"));
-	if (MINIX_BLOCK_SIZE != write(IN, super_block_buffer, MINIX_BLOCK_SIZE))
+	if (MINIX_BLOCK_SIZE != write(device_fd, super_block_buffer, MINIX_BLOCK_SIZE))
 		die(_("unable to write super-block"));
 	return;
 }
@@ -518,13 +518,13 @@ write_tables(void) {
 
 	write_super_block();
 
-	if (write_all(IN, inode_map, imaps * MINIX_BLOCK_SIZE))
+	if (write_all(device_fd, inode_map, imaps * MINIX_BLOCK_SIZE))
 		die(_("Unable to write inode map"));
 
-	if (write_all(IN, zone_map, zmaps * MINIX_BLOCK_SIZE))
+	if (write_all(device_fd, zone_map, zmaps * MINIX_BLOCK_SIZE))
 		die(_("Unable to write zone map"));
 
-	if (write_all(IN, inode_buffer, buffsz))
+	if (write_all(device_fd, inode_buffer, buffsz))
 		die(_("Unable to write inodes"));
 }
 
@@ -552,14 +552,14 @@ get_dirsize(void) {
 
 static void
 read_superblock(void) {
-	if (MINIX_BLOCK_SIZE != lseek(IN, MINIX_BLOCK_SIZE, SEEK_SET))
+	if (MINIX_BLOCK_SIZE != lseek(device_fd, MINIX_BLOCK_SIZE, SEEK_SET))
 		die(_("seek failed"));
 
 	super_block_buffer = calloc(1, MINIX_BLOCK_SIZE);
 	if (!super_block_buffer)
 		die(_("unable to alloc buffer for superblock"));
 
-	if (MINIX_BLOCK_SIZE != read(IN, super_block_buffer, MINIX_BLOCK_SIZE))
+	if (MINIX_BLOCK_SIZE != read(device_fd, super_block_buffer, MINIX_BLOCK_SIZE))
 		die(_("unable to read super block"));
 	if (MAGIC == MINIX_SUPER_MAGIC) {
 		namelen = 14;
@@ -615,15 +615,15 @@ read_tables(void) {
 	if (!zone_count)
 		die(_("Unable to allocate buffer for zone count"));
 
-	rc = read(IN, inode_map, imaps * MINIX_BLOCK_SIZE);
+	rc = read(device_fd, inode_map, imaps * MINIX_BLOCK_SIZE);
 	if (rc < 0 || imaps * MINIX_BLOCK_SIZE != (size_t) rc)
 		die(_("Unable to read inode map"));
 
-	rc = read(IN, zone_map, zmaps * MINIX_BLOCK_SIZE);
+	rc = read(device_fd, zone_map, zmaps * MINIX_BLOCK_SIZE);
 	if (rc < 0 || zmaps * MINIX_BLOCK_SIZE != (size_t) rc)
 		die(_("Unable to read zone map"));
 
-	rc = read(IN, inode_buffer, buffsz);
+	rc = read(device_fd, inode_buffer, buffsz);
 	if (rc < 0 || buffsz != (size_t) rc)
 		die(_("Unable to read inodes"));
 	if (norm_first_zone != first_zone) {
@@ -1112,9 +1112,9 @@ static int
 bad_zone(int i) {
 	char buffer[1024];
 
-	if (MINIX_BLOCK_SIZE * i != lseek(IN, MINIX_BLOCK_SIZE * i, SEEK_SET))
+	if (MINIX_BLOCK_SIZE * i != lseek(device_fd, MINIX_BLOCK_SIZE * i, SEEK_SET))
 		die(_("seek failed in bad_zone"));
-	return (MINIX_BLOCK_SIZE != read(IN, buffer, MINIX_BLOCK_SIZE));
+	return (MINIX_BLOCK_SIZE != read(device_fd, buffer, MINIX_BLOCK_SIZE));
 }
 
 static void
@@ -1313,8 +1313,8 @@ main(int argc, char **argv) {
 		if (!isatty(STDIN_FILENO) || !isatty(STDOUT_FILENO))
 			die(_("need terminal for interactive repairs"));
 	}
-	IN = open(device_name, repair ? O_RDWR : O_RDONLY);
-	if (IN < 0)
+	device_fd = open(device_name, repair ? O_RDWR : O_RDONLY);
+	if (device_fd < 0)
 		die(_("cannot open %s: %s"), device_name, strerror(errno));
 	for (count = 0; count < 3; count++)
 		sync();
@@ -1396,7 +1396,7 @@ main(int argc, char **argv) {
 	if (repair && !automatic)
 		tcsetattr(STDIN_FILENO, TCSANOW, &termios);
 
-	if (close_fd(IN) != 0)
+	if (close_fd(device_fd) != 0)
 		err(FSCK_EX_ERROR, _("write failed"));
 	if (changed)
 		retcode += 3;
-- 
2.4.4

