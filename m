Return-Path: util-linux-owner@vger.kernel.org
Received: from hapkido.dreamhost.com ([66.33.216.122]:58098 "EHLO
	hapkido.dreamhost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758027Ab1CaPAd (ORCPT
	<rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 31 Mar 2011 11:00:33 -0400
Received: from homiemail-a60.g.dreamhost.com (mailbigip.dreamhost.com [208.97.132.5])
	by hapkido.dreamhost.com (Postfix) with ESMTP id A2F9217A5C6
	for <util-linux-ng@vger.kernel.org>; Thu, 31 Mar 2011 08:00:32 -0700 (PDT)
Subject: [PATCH 3/3] mkfs.minix: add support for minix3 fs
From: Davidlohr Bueso <dave@gnu.org>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux-ng <util-linux-ng@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 31 Mar 2011 11:59:38 -0300
Message-ID: <1301583579.2159.17.camel@offworld>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add Minix filesystem v3 support. This version allows up to 60 character name files, instead of 30 for older versions.
We can also specify the block size to be used (with the new -B option). Additionally, three new options were added to
specify the fs version to be created (-1, -2, -3).

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/Makefile.am  |    2 +-
 disk-utils/mkfs.minix.c |  351 ++++++++++++++++++++++++++++++-----------------
 2 files changed, 223 insertions(+), 130 deletions(-)

diff --git a/disk-utils/Makefile.am b/disk-utils/Makefile.am
index 5df8064..cd07169 100644
--- a/disk-utils/Makefile.am
+++ b/disk-utils/Makefile.am
@@ -1,6 +1,6 @@
 include $(top_srcdir)/config/include-Makefile.am
 
-utils_common = $(top_srcdir)/lib/blkdev.c
+utils_common = $(top_srcdir)/lib/blkdev.c $(top_srcdir)/lib/strutils.c
 if LINUX
 utils_common += $(top_srcdir)/lib/linux_version.c
 endif
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 807a571..c5f1ac6 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -46,13 +46,19 @@
  * 02.07.96  -  Added small patch from Russell King to make the program a
  *		good deal more portable (janl@math.uio.no)
  *
- * Usage:  mkfs [-c | -l filename ] [-v] [-nXX] [-iXX] device [size-in-blocks]
+ * 22.03.11  -  Added support for v3 filesystem, -1,-2,-3,-B options 
+ *              and overall general cleanups.
+ *		(Davidlohr Bueso, dave@gnu.org)
+ *
+ * Usage:  mkfs [-c | -l filename ] [-v] [-1 | -2 | -3] [-nXX] [-iXX] device [size-in-blocks]
  *
  *	-c for readablility checking (SLOW!)
  *      -l for getting a list of bad blocks from a file.
  *	-n for namelength (currently the kernel only uses 14 or 30)
  *	-i for number of inodes
  *	-v for v2 filesystem
+ *      -B specify block size (v3)
+ *      -1,-2,-3 indicating the filesystem version to be created
  *
  * The device may be a block device or a image of one, but this isn't
  * enforced (but it's not much fun on a character device :-). 
@@ -70,13 +76,14 @@
 #include <sys/stat.h>
 #include <mntent.h>
 #include <getopt.h>
-#include <err.h>
 
 #include "blkdev.h"
 #include "minix.h"
 #include "nls.h"
 #include "pathnames.h"
 #include "bitops.h"
+#include "strutils.h"
+#include "xalloc.h"
 
 #define MINIX_ROOT_INO 1
 #define MINIX_BAD_INO 2
@@ -88,13 +95,11 @@
 #define INODE_SIZE (sizeof(struct minix_inode))
 
 #define INODE_SIZE2 (sizeof(struct minix2_inode))
-#define INODE_BLOCKS UPPER(INODES, (version2 ? MINIX2_INODES_PER_BLOCK \
-				    : MINIX_INODES_PER_BLOCK))
-#define INODE_BUFFER_SIZE (INODE_BLOCKS * BLOCK_SIZE)
+#define INODE_BLOCKS UPPER(INODES, inodes_per_block)
 
-#define BITS_PER_BLOCK (BLOCK_SIZE<<3)
+#define INODE_BUFFER_SIZE (INODE_BLOCKS * BLOCK_SIZE)
 
-#define MAX_INODES 65535
+#define BITS_PER_BLOCK (blksz<<3)
 
 static char * program_name = "mkfs";
 static char * device_name = NULL;
@@ -102,11 +107,17 @@ static int DEV = -1;
 static unsigned long long BLOCKS = 0;
 static int check = 0;
 static int badblocks = 0;
-static int namelen = 30;	/* default (changed to 30, per Linus's
-				   suggestion, Sun Nov 21 08:05:07 1993) */
+static unsigned long long blksz = 0;
+
+/* 
+ * default (changed to 30, per Linus's
+ * suggestion, Sun Nov 21 08:05:07 1993) 
+ * This should be changed in the future to 60, 
+ * since v3 needs to be the default nowadays (2011) 
+ */
+static int namelen = 30;	
 static int dirsize = 32;
 static int magic = MINIX_SUPER_MAGIC2;
-static int version2 = 0;
 
 static char root_block[BLOCK_SIZE] = "\0";
 
@@ -114,16 +125,21 @@ static char * inode_buffer = NULL;
 #define Inode (((struct minix_inode *) inode_buffer)-1)
 #define Inode2 (((struct minix2_inode *) inode_buffer)-1)
 
+static int inodes_per_block = 0;
+static int fs_version = 1; /* v1 enabled by default */
+
 static char *super_block_buffer;
 static char boot_block_buffer[512];
+
 #define Super (*(struct minix_super_block *)super_block_buffer)
-#define INODES ((unsigned long)Super.s_ninodes)
-#define ZONES ((unsigned long)(version2 ? Super.s_zones : Super.s_nzones))
-#define IMAPS ((unsigned long)Super.s_imap_blocks)
-#define ZMAPS ((unsigned long)Super.s_zmap_blocks)
-#define FIRSTZONE ((unsigned long)Super.s_firstdatazone)
-#define ZONESIZE ((unsigned long)Super.s_log_zone_size)
-#define MAXSIZE ((unsigned long)Super.s_max_size)
+#define Super3 (*(struct minix3_super_block *)super_block_buffer)
+#define INODES ((unsigned long)(fs_version == 3 ? Super3.s_ninodes : Super.s_ninodes))
+#define ZONES ((unsigned long)(fs_version == 3 ? Super3.s_zones : (fs_version == 2 ? Super.s_zones : Super.s_nzones)))
+#define IMAPS ((unsigned long)(fs_version == 3 ? Super3.s_imap_blocks : Super.s_imap_blocks))
+#define ZMAPS ((unsigned long)(fs_version == 3 ? Super3.s_zmap_blocks : Super.s_zmap_blocks))
+#define FIRSTZONE ((unsigned long) (fs_version == 3 ? Super3.s_firstdatazone : Super.s_firstdatazone))
+#define ZONESIZE ((unsigned long)(fs_version == 3 ? Super3.s_log_zone_size : Super.s_log_zone_size))
+#define MAXSIZE ((unsigned long)(fs_version == 3 ? Super3.s_max_size : Super.s_max_size))
 #define NORM_FIRSTZONE (2+IMAPS+ZMAPS+INODE_BLOCKS)
 
 static char *inode_map;
@@ -141,6 +157,8 @@ static unsigned long req_nr_inodes = 0;
 #define mark_zone(x) (setbit(zone_map,(x)-FIRSTZONE+1))
 #define unmark_zone(x) (clrbit(zone_map,(x)-FIRSTZONE+1))
 
+#define INODE_MAX       65535
+
 static void
 die(char *str) {
 	fprintf(stderr, "%s: ", program_name);
@@ -149,10 +167,13 @@ die(char *str) {
 	exit(8);
 }
 
-static void __attribute__((__noreturn__))
+static void
 usage(void) {
-	errx(16, _("Usage: %s [-c | -l filename] [-nXX] [-iXX] /dev/name [blocks]"),
-	     program_name);
+	fprintf(stderr, _("%s (%s)\n"), program_name, PACKAGE_STRING);
+	fprintf(stderr,
+		_("Usage: %s [-c | -l filename] [-nXX] [-iXX] /dev/name [blocks]\n"),
+		program_name);
+	exit(16);
 }
 
 /*
@@ -177,23 +198,28 @@ check_mount(void) {
 	die(_("%s is mounted; will not make a filesystem here!"));
 }
 
-static void
+static void 
 write_tables(void) {
 	/* Mark the super block valid. */
-	Super.s_state |= MINIX_VALID_FS;
-	Super.s_state &= ~MINIX_ERROR_FS;
-
+	if (fs_version == 3) {
+		Super3.s_state |= MINIX_VALID_FS;
+		Super3.s_state &= ~MINIX_ERROR_FS;
+	} else {
+		Super.s_state |= MINIX_VALID_FS;
+		Super.s_state &= ~MINIX_ERROR_FS;
+	}
+	
 	if (lseek(DEV, 0, SEEK_SET))
 		die(_("seek to boot block failed in write_tables"));
 	if (512 != write(DEV, boot_block_buffer, 512))
 		die(_("unable to clear boot sector"));
-	if (BLOCK_SIZE != lseek(DEV, BLOCK_SIZE, SEEK_SET))
+	if (blksz != lseek(DEV, blksz, SEEK_SET))
 		die(_("seek failed in write_tables"));
-	if (BLOCK_SIZE != write(DEV, super_block_buffer, BLOCK_SIZE))
+	if (blksz != write(DEV, super_block_buffer, blksz))
 		die(_("unable to write super-block"));
-	if (IMAPS*BLOCK_SIZE != write(DEV,inode_map,IMAPS*BLOCK_SIZE))
+	if (IMAPS*blksz != write(DEV,inode_map,IMAPS*blksz))
 		die(_("unable to write inode map"));
-	if (ZMAPS*BLOCK_SIZE != write(DEV,zone_map,ZMAPS*BLOCK_SIZE))
+	if (ZMAPS*blksz != write(DEV,zone_map,ZMAPS*blksz))
 		die(_("unable to write zone map"));
 	if (INODE_BUFFER_SIZE != write(DEV,inode_buffer,INODE_BUFFER_SIZE))
 		die(_("unable to write inodes"));
@@ -202,9 +228,9 @@ write_tables(void) {
 
 static void
 write_block(int blk, char * buffer) {
-	if (blk*BLOCK_SIZE != lseek(DEV, blk*BLOCK_SIZE, SEEK_SET))
+	if (blk*blksz != lseek(DEV, blk*blksz, SEEK_SET))
 		die(_("seek failed in write_block"));
-	if (BLOCK_SIZE != write(DEV, buffer, BLOCK_SIZE))
+	if (blksz != write(DEV, buffer, blksz))
 		die(_("write failed in write_block"));
 }
 
@@ -250,8 +276,8 @@ make_bad_inode(void) {
 	struct minix_inode * inode = &Inode[MINIX_BAD_INO];
 	int i,j,zone;
 	int ind=0,dind=0;
-	unsigned short ind_block[BLOCK_SIZE>>1];
-	unsigned short dind_block[BLOCK_SIZE>>1];
+	unsigned short ind_block[blksz>>1];
+	unsigned short dind_block[blksz>>1];
 
 #define NEXT_BAD (zone = next(zone))
 
@@ -261,7 +287,7 @@ make_bad_inode(void) {
 	inode->i_nlinks = 1;
 	inode->i_time = time(NULL);
 	inode->i_mode = S_IFREG + 0000;
-	inode->i_size = badblocks*BLOCK_SIZE;
+	inode->i_size = badblocks*blksz;
 	zone = next(0);
 	for (i=0 ; i<7 ; i++) {
 		inode->i_zone[i] = zone;
@@ -269,18 +295,18 @@ make_bad_inode(void) {
 			goto end_bad;
 	}
 	inode->i_zone[7] = ind = get_free_block();
-	memset(ind_block,0,BLOCK_SIZE);
+	memset(ind_block,0,blksz);
 	for (i=0 ; i<512 ; i++) {
 		ind_block[i] = zone;
 		if (!NEXT_BAD)
 			goto end_bad;
 	}
 	inode->i_zone[8] = dind = get_free_block();
-	memset(dind_block,0,BLOCK_SIZE);
+	memset(dind_block,0,blksz);
 	for (i=0 ; i<512 ; i++) {
 		write_block(ind,(char *) ind_block);
 		dind_block[i] = ind = get_free_block();
-		memset(ind_block,0,BLOCK_SIZE);
+		memset(ind_block,0,blksz);
 		for (j=0 ; j<512 ; j++) {
 			ind_block[j] = zone;
 			if (!NEXT_BAD)
@@ -296,12 +322,13 @@ end_bad:
 }
 
 static void
-make_bad_inode2 (void) {
+make_bad_inode2 (void)
+{
 	struct minix2_inode *inode = &Inode2[MINIX_BAD_INO];
 	int i, j, zone;
 	int ind = 0, dind = 0;
-	unsigned long ind_block[BLOCK_SIZE >> 2];
-	unsigned long dind_block[BLOCK_SIZE >> 2];
+	unsigned long ind_block[blksz >> 2];
+	unsigned long dind_block[blksz >> 2];
 
 	if (!badblocks)
 		return;
@@ -309,7 +336,7 @@ make_bad_inode2 (void) {
 	inode->i_nlinks = 1;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = time (NULL);
 	inode->i_mode = S_IFREG + 0000;
-	inode->i_size = badblocks * BLOCK_SIZE;
+	inode->i_size = badblocks * blksz;
 	zone = next (0);
 	for (i = 0; i < 7; i++) {
 		inode->i_zone[i] = zone;
@@ -317,18 +344,18 @@ make_bad_inode2 (void) {
 			goto end_bad;
 	}
 	inode->i_zone[7] = ind = get_free_block ();
-	memset (ind_block, 0, BLOCK_SIZE);
+	memset (ind_block, 0, blksz);
 	for (i = 0; i < 256; i++) {
 		ind_block[i] = zone;
 		if (!NEXT_BAD)
 			goto end_bad;
 	}
 	inode->i_zone[8] = dind = get_free_block ();
-	memset (dind_block, 0, BLOCK_SIZE);
+	memset (dind_block, 0, blksz);
 	for (i = 0; i < 256; i++) {
 		write_block (ind, (char *) ind_block);
 		dind_block[i] = ind = get_free_block ();
-		memset (ind_block, 0, BLOCK_SIZE);
+		memset (ind_block, 0, blksz);
 		for (j = 0; j < 256; j++) {
 			ind_block[j] = zone;
 			if (!NEXT_BAD)
@@ -337,7 +364,7 @@ make_bad_inode2 (void) {
 	}
 	/* Could make triple indirect block here */
 	die (_("too many bad blocks"));
- end_bad:
+end_bad:
 	if (ind)
 		write_block (ind, (char *) ind_block);
 	if (dind)
@@ -345,9 +372,13 @@ make_bad_inode2 (void) {
 }
 
 static void
-make_root_inode(void) {
+make_root_inode(void) 
+{
 	struct minix_inode * inode = &Inode[MINIX_ROOT_INO];
 
+
+	
+
 	mark_inode(MINIX_ROOT_INO);
 	inode->i_zone[0] = get_free_block();
 	inode->i_nlinks = 2;
@@ -363,126 +394,154 @@ make_root_inode(void) {
 	inode->i_uid = getuid();
 	if (inode->i_uid)
 		inode->i_gid = getgid();
-	write_block(inode->i_zone[0],root_block);
+	write_block(inode->i_zone[0], root_block);
 }
 
-static void
-make_root_inode2 (void) {
+static void 
+make_root_inode2 (void)
+{
 	struct minix2_inode *inode = &Inode2[MINIX_ROOT_INO];
 
 	mark_inode (MINIX_ROOT_INO);
 	inode->i_zone[0] = get_free_block ();
 	inode->i_nlinks = 2;
 	inode->i_atime = inode->i_mtime = inode->i_ctime = time (NULL);
+	
 	if (badblocks)
 		inode->i_size = 3 * dirsize;
 	else {
 		root_block[2 * dirsize] = '\0';
-		root_block[2 * dirsize + 1] = '\0';
-		inode->i_size = 2 * dirsize;
+		root_block[2 * dirsize] = '\0';
+		if (fs_version == 2)
+			inode->i_size = 2 * dirsize;
 	}
 	inode->i_mode = S_IFDIR + 0755;
 	inode->i_uid = getuid();
 	if (inode->i_uid)
 		inode->i_gid = getgid();
+
 	write_block (inode->i_zone[0], root_block);
 }
 
-static void
-setup_tables(void) {
+/* sets up the boot sector, superblock and inode tables */
+static void 
+setup_tables(void) 
+{
 	int i;
 	unsigned long inodes;
 
-	super_block_buffer = calloc(1, BLOCK_SIZE);
-	if (!super_block_buffer)
-		die(_("unable to alloc buffer for superblock"));
-
+	super_block_buffer = xcalloc(1, blksz);
 	memset(boot_block_buffer,0,512);
-	Super.s_magic = magic;
-	Super.s_log_zone_size = 0;
-	Super.s_max_size = version2 ? 0x7fffffff : (7+512+512*512)*1024;
-	if (version2)
+	
+	if (fs_version == 3) {
+		Super3.s_magic = magic;
+		Super3.s_log_zone_size = 0;
+		Super3.s_blocksize = blksz;
+	}
+
+	else {
+		Super.s_magic = magic;
+		Super.s_log_zone_size = 0;
+	}
+
+	if (fs_version == 3)
+		Super3.s_max_size = 2147483647L;
+	else 
+		Super.s_max_size = fs_version == 2 ? 0x7fffffff : (7+512+512*512)*1024;
+	
+	if (fs_version == 3) 
+		Super3.s_zones = BLOCKS;
+	else if (fs_version == 2)
 		Super.s_zones = BLOCKS;
 	else
 		Super.s_nzones = BLOCKS;
 
-/* some magic nrs: 1 inode / 3 blocks */
+	/* some magic nrs: 1 inode / 3 blocks */
 	if ( req_nr_inodes == 0 ) 
 		inodes = BLOCKS/3;
 	else
 		inodes = req_nr_inodes;
 	/* Round up inode count to fill block size */
-	if (version2)
+	if (fs_version == 2 || fs_version == 3)
 		inodes = ((inodes + MINIX2_INODES_PER_BLOCK - 1) &
 			  ~(MINIX2_INODES_PER_BLOCK - 1));
 	else
 		inodes = ((inodes + MINIX_INODES_PER_BLOCK - 1) &
 			  ~(MINIX_INODES_PER_BLOCK - 1));
-	if (inodes > 65535)
-		inodes = 65535;
-	Super.s_ninodes = inodes;
-
-	/* The old code here
-	 * ZMAPS = 0;
-	 * while (ZMAPS != UPPER(BLOCKS - NORM_FIRSTZONE + 1,BITS_PER_BLOCK))
-	 *	  ZMAPS = UPPER(BLOCKS - NORM_FIRSTZONE + 1,BITS_PER_BLOCK);
-	 * was no good, since it may loop. - aeb
-	 */
-	Super.s_imap_blocks = UPPER(INODES + 1, BITS_PER_BLOCK);
-	Super.s_zmap_blocks = UPPER(BLOCKS - (1+IMAPS+INODE_BLOCKS),
-				    BITS_PER_BLOCK+1);
-	Super.s_firstdatazone = NORM_FIRSTZONE;
-
-	inode_map = malloc(IMAPS * BLOCK_SIZE);
-	zone_map = malloc(ZMAPS * BLOCK_SIZE);
-	if (!inode_map || !zone_map)
-		die(_("unable to allocate buffers for maps"));
-	memset(inode_map,0xff,IMAPS * BLOCK_SIZE);
-	memset(zone_map,0xff,ZMAPS * BLOCK_SIZE);
+
+	if (fs_version == 3)
+		Super3.s_ninodes = inodes;
+	else  {
+		if (inodes > INODE_MAX)
+			inodes = INODE_MAX;
+		Super.s_ninodes = inodes;
+	}
+
+	if (fs_version == 3) 
+		Super3.s_imap_blocks = UPPER(INODES + 1, BITS_PER_BLOCK);
+	else 
+		Super.s_imap_blocks = UPPER(INODES + 1, BITS_PER_BLOCK);
+
+	if (fs_version == 3)
+		Super3.s_zmap_blocks = UPPER(BLOCKS - (1+IMAPS+INODE_BLOCKS),
+					     BITS_PER_BLOCK+1);
+	else 
+		Super.s_zmap_blocks = UPPER(BLOCKS - (1+IMAPS+INODE_BLOCKS),
+					    BITS_PER_BLOCK+1);
+
+	if (fs_version == 3) 
+		Super3.s_firstdatazone = NORM_FIRSTZONE;
+	else 
+		Super.s_firstdatazone = NORM_FIRSTZONE;
+
+	inode_map = xmalloc(IMAPS * blksz);
+	zone_map = xmalloc(ZMAPS * blksz);
+	memset(inode_map,0xff,IMAPS * blksz);
+	memset(zone_map,0xff,ZMAPS * blksz);
 	for (i = FIRSTZONE ; i<ZONES ; i++)
 		unmark_zone(i);
 	for (i = MINIX_ROOT_INO ; i<=INODES ; i++)
 		unmark_inode(i);
-	inode_buffer = malloc(INODE_BUFFER_SIZE);
-	if (!inode_buffer)
-		die(_("unable to allocate buffer for inodes"));
+
+	inode_buffer = xmalloc(INODE_BUFFER_SIZE);
 	memset(inode_buffer,0,INODE_BUFFER_SIZE);
-	printf(_("%ld inodes\n"),INODES);
-	printf(_("%ld blocks\n"),ZONES);
-	printf(_("Firstdatazone=%ld (%ld)\n"),FIRSTZONE,NORM_FIRSTZONE);
-	printf(_("Zonesize=%d\n"),BLOCK_SIZE<<ZONESIZE);
-	printf(_("Maxsize=%ld\n\n"),MAXSIZE);
+
+	printf(_("%lu inodes\n"), INODES);
+	printf(_("%ld blocks\n"), ZONES);
+	printf(_("Firstdatazone=%ld (%ld)\n"), FIRSTZONE, NORM_FIRSTZONE);
+	printf(_("Zonesize=%llu\n"), blksz<<ZONESIZE);
+	printf(_("Maxsize=%ld\n\n"), MAXSIZE);
 }
 
 /*
  * Perform a test of a block; return the number of
  * blocks readable/writeable.
  */
-static long
-do_check(char * buffer, int try, unsigned int current_block) {
+static long do_check(char * buffer, int try, unsigned int current_block)
+{
 	long got;
 	
 	/* Seek to the correct loc. */
-	if (lseek(DEV, current_block * BLOCK_SIZE, SEEK_SET) !=
-		       current_block * BLOCK_SIZE ) {
-		 die(_("seek failed during testing of blocks"));
+	if (lseek(DEV, current_block * blksz, SEEK_SET) !=
+	    current_block * blksz ) {
+		die(_("seek failed during testing of blocks"));
 	}
 

 	/* Try the read */
-	got = read(DEV, buffer, try * BLOCK_SIZE);
+	got = read(DEV, buffer, try * blksz);
 	if (got < 0) got = 0;	
-	if (got & (BLOCK_SIZE - 1 )) {
+	if (got & (blksz - 1 )) {
 		printf(_("Weird values in do_check: probably bugs\n"));
 	}
-	got /= BLOCK_SIZE;
+	got /= blksz;
 	return got;
 }
 
 static unsigned int currently_testing = 0;
 
-static void
-alarm_intr(int alnum) {
+static void alarm_intr(int alnum)
+{
 	if (currently_testing >= ZONES)
 		return;
 	signal(SIGALRM,alarm_intr);
@@ -493,8 +552,8 @@ alarm_intr(int alnum) {
 	fflush(stdout);
 }
 
-static void
-check_blocks(void) {
+static void check_blocks(void) 
+{
 	int try,got;
 	static char buffer[BLOCK_SIZE * TEST_BUFFER_BLOCKS];
 
@@ -502,8 +561,8 @@ check_blocks(void) {
 	signal(SIGALRM,alarm_intr);
 	alarm(5);
 	while (currently_testing < ZONES) {
-		if (lseek(DEV,currently_testing*BLOCK_SIZE,SEEK_SET) !=
-		currently_testing*BLOCK_SIZE)
+		if (lseek(DEV,currently_testing*blksz,SEEK_SET) !=
+		    currently_testing*blksz)
 			die(_("seek failed in check_blocks"));
 		try = TEST_BUFFER_BLOCKS;
 		if (currently_testing + try > ZONES)
@@ -549,13 +608,10 @@ get_list_blocks(char *filename) {
 		printf(_("one bad block\n"));
 }
 
-int
-main(int argc, char ** argv) {
-	int i;
-	char * tmp;
+int main(int argc, char ** argv) {
 	struct stat statbuf;
-	char * listfile = NULL;
-	char * p;
+	char *tmp, *p, *listfile = NULL;
+	int i, sectorsize; /* physical sector size in bytes */
 
 	if (argc && *argv)
 		program_name = *argv;
@@ -572,13 +628,8 @@ main(int argc, char ** argv) {
 		exit(0);
 	}
 
-	if (INODE_SIZE * MINIX_INODES_PER_BLOCK != BLOCK_SIZE)
-		die(_("bad inode size"));
-	if (INODE_SIZE2 * MINIX2_INODES_PER_BLOCK != BLOCK_SIZE)
-		die(_("bad inode size"));
-
 	opterr = 0;
-	while ((i = getopt(argc, argv, "ci:l:n:v")) != -1)
+	while ((i = getopt(argc, argv, "ci:l:n:v123B:")) != -1)
 		switch (i) {
 		case 'c':
 			check=1; break;
@@ -596,12 +647,22 @@ main(int argc, char ** argv) {
 			else if (i == 30)
 				magic = MINIX_SUPER_MAGIC2;
 			else
-				usage();
+				die(_("length must be either 14 or 30"));
 			namelen = i;
 			dirsize = i+2;
 			break;
-		case 'v':
-			version2 = 1;
+		case '2':
+		case 'v': /* kept for backwards compatiblitly */
+			fs_version = 2;
+			break;
+		case '1':
+			fs_version = 1; 
+			break;
+		case '3':
+			fs_version = 3;
+			break;
+		case 'B':
+			blksz = strtol_or_err(optarg, "failed to parse the block size");
 			break;
 		default:
 			usage();
@@ -621,9 +682,9 @@ main(int argc, char ** argv) {
 		}
 	}
 
-	if (!device_name) {
+	if (!device_name)
 		usage();
-	}
+	
 	check_mount();		/* is it already mounted? */
 	tmp = root_block;
 	*(short *)tmp = 1;
@@ -633,6 +694,7 @@ main(int argc, char ** argv) {
 	strcpy(tmp+2,"..");
 	tmp += dirsize;
 	*(short *)tmp = 2;
+	
 	strcpy(tmp+2,".badblocks");
 	if (stat(device_name, &statbuf) < 0)
 		die(_("unable to stat %s"));
@@ -643,8 +705,6 @@ main(int argc, char ** argv) {
 	if (DEV<0)
 		die(_("unable to open %s"));
 	if (S_ISBLK(statbuf.st_mode)) {
-		int sectorsize;
-
 		if (blkdev_get_sector_size(DEV, &sectorsize) == -1)
 			die(_("cannot determine sector size for %s"));
 		if (BLOCK_SIZE < sectorsize)
@@ -660,29 +720,62 @@ main(int argc, char ** argv) {
 		check=0;
 	} else if (statbuf.st_rdev == 0x0300 || statbuf.st_rdev == 0x0340)
 		die(_("will not try to make filesystem on '%s'"));
+
+	/* determine what block size to use, based on fs version and user input */
+	if (blksz && fs_version == 3) {
+		if (blksz%sectorsize || blksz < BLOCK_SIZE) {
+			fprintf(stderr, "block size must be multiple of sector (%d) "
+				"and at least %d bytes\n", sectorsize, BLOCK_SIZE);
+			die(_("specified block size illegal"));
+		}
+		if(blksz%INODE_SIZE2) {
+			fprintf(stderr, "block size must be a multiple of inode size (%lu bytes)\n",
+				INODE_SIZE2);
+			die(_("specified block size illegal"));
+		}
+	}
+	else /* use the default block size */
+		blksz = BLOCK_SIZE;
+
+	if (fs_version == 2 || fs_version == 3) {
+		inodes_per_block = ((blksz)/(sizeof(struct minix2_inode)));
+		if (INODE_SIZE2 * inodes_per_block != blksz)
+			die(_("bad inode size"));
+	}
+	else {
+		inodes_per_block = ((blksz)/(sizeof(struct minix_inode)));
+		if (INODE_SIZE * inodes_per_block != blksz)
+			die(_("bad inode size"));
+
+	}
+
 	if (BLOCKS < 10)
 		die(_("number of blocks too small"));
-	if (version2) {
+
+	if (fs_version == 3)
+		magic = MINIX3_SUPER_MAGIC;
+	else if (fs_version == 2) {
 		if (namelen == 14)
 			magic = MINIX2_SUPER_MAGIC;
 		else
 			magic = MINIX2_SUPER_MAGIC2;
 	} else
-		if (BLOCKS > MAX_INODES)
-			BLOCKS = MAX_INODES;
+		if (BLOCKS > 65535)
+			BLOCKS = 65535;
 	setup_tables();
 	if (check)
 		check_blocks();
 	else if (listfile)
 		get_list_blocks(listfile);
-	if (version2) {
+
+	if (fs_version == 2 || fs_version == 3) {
 		make_root_inode2 ();
 		make_bad_inode2 ();
 	} else {
 		make_root_inode();
 		make_bad_inode();
 	}
-
+	
 	mark_good_blocks();
 	write_tables();
 	close(DEV);
-- 
1.7.1






