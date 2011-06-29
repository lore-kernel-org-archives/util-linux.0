Return-Path: dave@gnu.org
Subject: [PATCH 2/3] mkfs.minix: add minix v3 support
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 13:28:15 -0400
Message-ID: <1309368495.3162.4.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 29 Jun 2011 12:55:49 -0400

We can now create minix v3 filesystems. Support for this fs was added a few=
 years ago in the Linux kernel. One of the most important benefits is the a=
bility to handle file names up to 60 characters long.
With this change we also introduce the -3 option which naturally indicates =
which version to create. Version 1 is still left as the default one for bac=
kwards compatibility reasons.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/Makefile.am  |    2 +-
 disk-utils/mkfs.minix.c |  142 ++++++++++++++++++++++++++++++++++++-------=
----
 2 files changed, 110 insertions(+), 34 deletions(-)

diff --git a/disk-utils/Makefile.am b/disk-utils/Makefile.am
index cf4a3e8..7d018b5 100644
--- a/disk-utils/Makefile.am
+++ b/disk-utils/Makefile.am
@@ -16,7 +16,7 @@ dist_man_MANS =3D isosize.8 mkfs.8 mkswap.8 \
 sbin_PROGRAMS =3D mkfs mkswap fsck.minix mkfs.minix mkfs.bfs
=20
 fsck_minix_SOURCES =3D fsck.minix.c minix.h $(top_srcdir)/lib/ismounted.c
-mkfs_minix_SOURCES =3D mkfs.minix.c minix.h mkfs.h $(utils_common)
+mkfs_minix_SOURCES =3D mkfs.minix.c minix.h mkfs.h $(utils_common) $(top_s=
rcdir)/lib/strutils.c
 mkfs_bfs_SOURCES =3D mkfs.bfs.c $(utils_common)
=20
 swaplabel_SOURCES =3D swaplabel.c $(utils_common)
diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 24b84db..fe7e53e 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -46,13 +46,18 @@
  * 02.07.96  -  Added small patch from Russell King to make the program a
  *		good deal more portable (janl@math.uio.no)
  *
- * Usage:  mkfs [-c | -l filename ] [-v] [-nXX] [-iXX] device [size-in-blo=
cks]
+ * 06.29.11  -  Overall cleanups for util-linux and v3 support
+ *              Davidlohr Bueso <dave@gnu.org>
+ *
+ * Usage:  mkfs [-c | -l filename ] [-12v3] [-nXX] [-iXX] device [size-in-=
blocks]
  *
  *	-c for readablility checking (SLOW!)
  *      -l for getting a list of bad blocks from a file.
  *	-n for namelength (currently the kernel only uses 14 or 30)
  *	-i for number of inodes
- *	-v for v2 filesystem
+ *      -1 for v1 filesystem
+ *	-2,-v for v2 filesystem
+ *      -3 for v3 filesystem
  *
  * The device may be a block device or a image of one, but this isn't
  * enforced (but it's not much fun on a character device :-).=20
@@ -78,6 +83,7 @@
 #include "pathnames.h"
 #include "bitops.h"
 #include "mkfs.h"
+#include "strutils.h"
=20
 #define MINIX_ROOT_INO 1
 #define MINIX_BAD_INO 2
@@ -93,8 +99,16 @@ static int DEV =3D -1;
 static unsigned long long BLOCKS =3D 0;
 static int check =3D 0;
 static int badblocks =3D 0;
-static int namelen =3D 30;	/* default (changed to 30, per Linus's
-				   suggestion, Sun Nov 21 08:05:07 1993) */
+
+/*=20
+ * default (changed to 30, per Linus's
+ * suggestion, Sun Nov 21 08:05:07 1993)=20
+ * This should be changed in the future to 60,=20
+ * since v3 needs to be the default nowadays (2011)=20
+ */
+static int namelen =3D 30;
+
+static unsigned long long blksz =3D 0;
 static int dirsize =3D 32;
 static int magic =3D MINIX_SUPER_MAGIC2;
 static int version2 =3D 0;
@@ -145,14 +159,27 @@ static void check_mount(void) {
 			device_name);
 }
=20
+static int *super_set_state_ptr(void)
+{
+	switch (fs_version) {
+	case 3:
+		Super3.s_state |=3D MINIX_VALID_FS;
+		Super3.s_state &=3D ~MINIX_ERROR_FS;
+		break;
+	default:
+		Super.s_state |=3D MINIX_VALID_FS;
+		Super.s_state &=3D ~MINIX_ERROR_FS;
+		break;
+	}
+}
+
 static void write_tables(void) {
 	unsigned long imaps =3D get_nimaps();
 	unsigned long zmaps =3D get_nzmaps();
 	unsigned long buffsz =3D get_inode_buffer_size();
=20
 	/* Mark the super block valid. */
-	Super.s_state |=3D MINIX_VALID_FS;
-	Super.s_state &=3D ~MINIX_ERROR_FS;
+	int *state =3D super_set_state_ptr();
=20
 	if (lseek(DEV, 0, SEEK_SET))
 		err(MKFS_ERROR, _("%s: seek to boot block failed "
@@ -217,7 +244,8 @@ static inline int next(int zone) {
 	return 0;
 }
=20
-static void make_bad_inode_v1(void) {
+static void make_bad_inode_v1(void)
+{
 	struct minix_inode * inode =3D &Inode[MINIX_BAD_INO];
 	int i,j,zone;
 	int ind=3D0,dind=3D0;
@@ -266,7 +294,8 @@ end_bad:
 		write_block(dind, (char *) dind_block);
 }
=20
-static void make_bad_inode_v2 (void) {
+static void make_bad_inode_v2_v3 (void)
+{
 	struct minix2_inode *inode =3D &Inode2[MINIX_BAD_INO];
 	int i, j, zone;
 	int ind =3D 0, dind =3D 0;
@@ -318,7 +347,7 @@ static void make_bad_inode(void)
 {
 	if (fs_version < 2)
 		return make_bad_inode_v1();
-	return make_bad_inode_v2();
+	return make_bad_inode_v2_v3();
 }
=20
 static void make_root_inode_v1(void) {
@@ -342,20 +371,22 @@ static void make_root_inode_v1(void) {
 	write_block(inode->i_zone[0],root_block);
 }
=20
-static void make_root_inode_v2 (void) {
+static void make_root_inode_v2_v3 (void) {
 	struct minix2_inode *inode =3D &Inode2[MINIX_ROOT_INO];
=20
 	mark_inode (MINIX_ROOT_INO);
 	inode->i_zone[0] =3D get_free_block ();
 	inode->i_nlinks =3D 2;
 	inode->i_atime =3D inode->i_mtime =3D inode->i_ctime =3D time (NULL);
+
 	if (badblocks)
 		inode->i_size =3D 3 * dirsize;
 	else {
 		root_block[2 * dirsize] =3D '\0';
-		root_block[2 * dirsize + 1] =3D '\0';
-		inode->i_size =3D 2 * dirsize;
+		if (fs_version =3D=3D 2)
+			inode->i_size =3D 2 * dirsize;
 	}
+
 	inode->i_mode =3D S_IFDIR + 0755;
 	inode->i_uid =3D getuid();
 	if (inode->i_uid)
@@ -367,12 +398,13 @@ static void make_root_inode(void)
 {
 	if (fs_version < 2)
 		return make_root_inode_v1();
-	return make_root_inode_v2();
+	return make_root_inode_v2_v3();
 }
=20
 static void super_set_nzones(void)
 {
 	switch (fs_version) {
+	case 3:
 	case 2:
 		Super.s_zones =3D BLOCKS;
 		break;
@@ -385,14 +417,48 @@ static void super_set_nzones(void)
 static void super_init_maxsize(void)
 {
 	switch (fs_version) {
+	case 3:
+		Super3.s_max_size =3D 2147483647L;
+		break;
 	case 2:
 		Super.s_max_size =3D  0x7fffffff;
+		break;
 	default: /* v1 */
 		Super.s_max_size =3D (7+512+512*512)*1024;
 		break;
 	}
 }
=20
+static void super_set_map_blocks(unsigned long inodes)
+{
+	switch (fs_version) {
+	case 3:
+		Super3.s_imap_blocks =3D UPPER(inodes + 1, BITS_PER_BLOCK);
+		Super3.s_zmap_blocks =3D UPPER(BLOCKS - (1+get_nimaps()+inode_blocks()),
+					     BITS_PER_BLOCK+1);
+		Super3.s_firstdatazone =3D first_zone_data();
+		break;
+	default:
+		Super.s_imap_blocks =3D UPPER(inodes + 1, BITS_PER_BLOCK);
+		Super.s_zmap_blocks =3D UPPER(BLOCKS - (1+get_nimaps()+inode_blocks()),
+					     BITS_PER_BLOCK+1);
+		Super.s_firstdatazone =3D first_zone_data();
+		break;
+	}
+}
+
+static void super_set_magic(void)
+{
+	switch (fs_version) {
+	case 3:
+		Super3.s_magic =3D magic;
+		break;
+	default:
+		Super.s_magic =3D magic;
+		break;
+	}
+}
+
 static void setup_tables(void) {
 	int i;
 	unsigned long inodes, zmaps, imaps, zones;
@@ -403,39 +469,42 @@ static void setup_tables(void) {
 				device_name);
=20
 	memset(boot_block_buffer,0,512);
-	Super.s_magic =3D magic;
-	Super.s_log_zone_size =3D 0;
+	super_set_magic();
+=09
+	if (fs_version =3D=3D 3) {
+		Super3.s_log_zone_size =3D 0;
+		Super3.s_blocksize =3D BLOCKS;
+	}
+	else {
+		Super.s_log_zone_size =3D 0;
+	}
=20
 	super_init_maxsize();
 	super_set_nzones();
 	zones =3D get_nzones();
=20
-/* some magic nrs: 1 inode / 3 blocks */
+	/* some magic nrs: 1 inode / 3 blocks */
 	if ( req_nr_inodes =3D=3D 0 )=20
 		inodes =3D BLOCKS/3;
 	else
 		inodes =3D req_nr_inodes;
 	/* Round up inode count to fill block size */
-	if (fs_version =3D=3D 2)
+	if (fs_version =3D=3D 2 || fs_version =3D=3D 3)
 		inodes =3D ((inodes + MINIX2_INODES_PER_BLOCK - 1) &
 			  ~(MINIX2_INODES_PER_BLOCK - 1));
 	else
 		inodes =3D ((inodes + MINIX_INODES_PER_BLOCK - 1) &
 			  ~(MINIX_INODES_PER_BLOCK - 1));
-	if (inodes > 65535)
-		inodes =3D 65535;
-	Super.s_ninodes =3D inodes;
-
-	/* The old code here
-	 * ZMAPS =3D 0;
-	 * while (ZMAPS !=3D UPPER(BLOCKS - NORM_FIRSTZONE + 1,BITS_PER_BLOCK))
-	 *	  ZMAPS =3D UPPER(BLOCKS - NORM_FIRSTZONE + 1,BITS_PER_BLOCK);
-	 * was no good, since it may loop. - aeb
-	 */
-	imaps =3D Super.s_imap_blocks =3D UPPER(inodes + 1, BITS_PER_BLOCK);
-	zmaps =3D Super.s_zmap_blocks =3D UPPER(BLOCKS - (1+get_nimaps()+inode_bl=
ocks()),
-				    BITS_PER_BLOCK+1);
-	Super.s_firstdatazone =3D first_zone_data();
+	if (inodes > MAX_INODES)
+		inodes =3D MAX_INODES;
+	if (fs_version =3D=3D 3)
+		Super3.s_ninodes =3D inodes;
+	else
+		Super.s_ninodes =3D inodes;
+
+	super_set_map_blocks(inodes);
+	imaps =3D get_nimaps();
+	zmaps =3D get_nzmaps();
=20
 	inode_map =3D malloc(imaps * BLOCK_SIZE);
 	zone_map =3D malloc(zmaps * BLOCK_SIZE);
@@ -586,7 +655,7 @@ int main(int argc, char ** argv) {
 		errx(MKFS_ERROR, _("%s: bad inode size"), device_name);
=20
 	opterr =3D 0;
-	while ((i =3D getopt(argc, argv, "ci:l:n:v12")) !=3D -1)
+	while ((i =3D getopt(argc, argv, "ci:l:n:v123")) !=3D -1)
 		switch (i) {
 		case 'c':
 			check=3D1; break;
@@ -616,6 +685,9 @@ int main(int argc, char ** argv) {
 			fs_version =3D 2;
 			version2 =3D 1;
 			break;
+		case '3':
+			fs_version =3D 3;
+			break;
 		default:
 			usage();
 		}
@@ -659,7 +731,7 @@ int main(int argc, char ** argv) {
 	if (S_ISBLK(statbuf.st_mode)) {
 		int sectorsize;
=20
-		if (blkdev_get_sector_size(DEV, &sectorsize) =3D=3D -1)
+	if (blkdev_get_sector_size(DEV, &sectorsize) =3D=3D -1)
 			sectorsize =3D DEFAULT_SECTOR_SIZE;		/* kernel < 2.3.3 */
=20
 		if (blkdev_is_misaligned(DEV))
@@ -682,6 +754,10 @@ int main(int argc, char ** argv) {
 		errx(MKFS_ERROR, _("will not try to make filesystem on '%s'"), device_na=
me);
 	if (BLOCKS < 10)
 		errx(MKFS_ERROR, _("%s: number of blocks too small"), device_name);
+
+	if (fs_version =3D=3D 3)
+		magic =3D MINIX3_SUPER_MAGIC;
+=09
 	if (fs_version =3D=3D 2) {
 		if (namelen =3D=3D 14)
 			magic =3D MINIX2_SUPER_MAGIC;
--=20
1.7.4.1
