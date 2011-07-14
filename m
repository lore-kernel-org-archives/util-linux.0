Return-Path: kerolasa@gmail.com
MIME-Version: 1.0
Reply-To: kerolasa@gmail.com
Sender: kerolasa@gmail.com
In-Reply-To: <20110714091829.GE3486@nb.net.home>
References: <1310485846-3685-1-git-send-email-kerolasa@iki.fi>
	<1310529931.4444.7.camel@offbook>
	<CAG27Bk0vW2LZySAf8B38OBbVaXpSDP81C+wVuA1vSW1rwhgwgg@mail.gmail.com>
	<20110713121232.GC3486@nb.net.home>
	<CAG27Bk2m+d=N9yVTSbByzhfkMUmP-d7heQXS643uWE3n+05+Mw@mail.gmail.com>
	<20110713173430.GD3486@nb.net.home>
	<1310609005.3482.0.camel@offbook>
	<20110714091829.GE3486@nb.net.home>
Date: Thu, 14 Jul 2011 17:47:39 +0200
Message-ID: <CAG27Bk0DYx+jCD-iqQvt1n=VdHszceTEAQQRvCKLvPXqpagTXA@mail.gmail.com>
Subject: Re: [PATCH] minix: v3 super-block does not have s_state field
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
Cc: Davidlohr Bueso <dave@gnu.org>, util-linux@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <util-linux.vger.kernel.org>

On Thu, Jul 14, 2011 at 11:18, Karel Zak <kzak@redhat.com> wrote:
> =A0Applied. It would be nice to clean up the superblocks definitions
> =A0(use POSIX int types), move it to include/minix.h and use it for
> =A0libblkid too.

By any change would the following be the 'nice to have' you referred to?

The following changes since commit 872a1575e81f5ed1e871d4ed9558f43effe96423=
:

  dmesg: fix typo in usage() (2011-07-14 13:46:13 +0200)

are available in the git repository at:
  https://github.com/kerolasa/lelux-utiliteetit minix

Sami Kerola (7):
      include: minix.h: use data types from stdint.h
      include: remove kernel headers from minix.h
      include: move minix.h to include directory
      libblkid: use superblock structure from minix.h
      libblkid: use BLOCK_SIZE from minix.h
      include: minix.h use static variables
      libblkid: move MINIX_MAXPARTITIONS to minix.h

 disk-utils/Makefile.am           |    4 +-
 include/Makefile.am              |    1 +
 {disk-utils =3D> include}/minix.h  |  100 ++++++++++++++++++--------------=
------
 libblkid/src/partitions/minix.c  |    6 +--
 libblkid/src/superblocks/minix.c |   37 +-------------
 5 files changed, 54 insertions(+), 94 deletions(-)
 rename {disk-utils =3D> include}/minix.h (74%)

diff --git a/disk-utils/Makefile.am b/disk-utils/Makefile.am
index 7d018b5..dc1b9c7 100644
--- a/disk-utils/Makefile.am
+++ b/disk-utils/Makefile.am
@@ -15,8 +15,8 @@ dist_man_MANS =3D isosize.8 mkfs.8 mkswap.8 \

 sbin_PROGRAMS =3D mkfs mkswap fsck.minix mkfs.minix mkfs.bfs

-fsck_minix_SOURCES =3D fsck.minix.c minix.h $(top_srcdir)/lib/ismounted.c
-mkfs_minix_SOURCES =3D mkfs.minix.c minix.h mkfs.h $(utils_common)
$(top_srcdir)/lib/strutils.c
+fsck_minix_SOURCES =3D fsck.minix.c $(top_srcdir)/lib/ismounted.c
+mkfs_minix_SOURCES =3D mkfs.minix.c mkfs.h $(utils_common)
$(top_srcdir)/lib/strutils.c
 mkfs_bfs_SOURCES =3D mkfs.bfs.c $(utils_common)

 swaplabel_SOURCES =3D swaplabel.c $(utils_common)
diff --git a/include/Makefile.am b/include/Makefile.am
index b6d9bb1..acc0c1b 100644
--- a/include/Makefile.am
+++ b/include/Makefile.am
@@ -19,6 +19,7 @@ dist_noinst_HEADERS =3D \
 	mangle.h \
 	mbsalign.h \
 	md5.h \
+	minix.h \
 	nls.h \
 	pathnames.h \
 	procutils.h \
diff --git a/disk-utils/minix.h b/include/minix.h
similarity index 74%
rename from disk-utils/minix.h
rename to include/minix.h
index a13a2a4..e25946e 100644
--- a/disk-utils/minix.h
+++ b/include/minix.h
@@ -1,69 +1,65 @@
 #ifndef __MINIX_H__
 #define __MINIX_H__

-#ifdef KERNEL_INCLUDES_ARE_CLEAN
-
-#include <linux/fs.h>
-#include <linux/minix_fs.h>
-
-#else
-
-typedef unsigned char u8;
-typedef unsigned short u16;
-typedef unsigned int u32;
+#include <stdint.h>

 struct minix_inode {
-        u16 i_mode;
-        u16 i_uid;
-        u32 i_size;
-        u32 i_time;
-        u8  i_gid;
-        u8  i_nlinks;
-        u16 i_zone[9];
+	uint16_t i_mode;
+	uint16_t i_uid;
+	uint32_t i_size;
+	uint32_t i_time;
+	uint8_t  i_gid;
+	uint8_t  i_nlinks;
+	uint16_t i_zone[9];
 };

 struct minix2_inode {
-        u16 i_mode;
-        u16 i_nlinks;
-        u16 i_uid;
-        u16 i_gid;
-        u32 i_size;
-        u32 i_atime;
-        u32 i_mtime;
-        u32 i_ctime;
-        u32 i_zone[10];
+	uint16_t i_mode;
+	uint16_t i_nlinks;
+	uint16_t i_uid;
+	uint16_t i_gid;
+	uint32_t i_size;
+	uint32_t i_atime;
+	uint32_t i_mtime;
+	uint32_t i_ctime;
+	uint32_t i_zone[10];
 };

 struct minix_super_block {
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
+	uint16_t s_ninodes;
+	uint16_t s_nzones;
+	uint16_t s_imap_blocks;
+	uint16_t s_zmap_blocks;
+	uint16_t s_firstdatazone;
+	uint16_t s_log_zone_size;
+	uint32_t s_max_size;
+	uint16_t s_magic;
+	uint16_t s_state;
+	uint32_t s_zones;
 };

 /* V3 minix super-block data on disk */
 struct minix3_super_block {
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
+	uint32_t s_ninodes;
+	uint16_t s_pad0;
+	uint16_t s_imap_blocks;
+	uint16_t s_zmap_blocks;
+	uint16_t s_firstdatazone;
+	uint16_t s_log_zone_size;
+	uint16_t s_pad1;
+	uint32_t s_max_size;
+	uint32_t s_zones;
+	uint16_t s_magic;
+	uint16_t s_pad2;
+	uint16_t s_blocksize;
+	uint8_t  s_disk_version;
 };

+/*
+ * Minix subpartitions are always within primary dos partition.
+ */
+#define MINIX_MAXPARTITIONS 4
+
 #define BLOCK_SIZE_BITS 10
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)

@@ -82,16 +78,14 @@ struct minix3_super_block {
 #define MINIX2_SUPER_MAGIC2  0x2478	     /* minix V2 fs, 30 char names */
 #define MINIX3_SUPER_MAGIC   0x4d5a          /* minix V3 fs (60 char names=
) */

-#endif /* KERNEL_INCLUDES_ARE_CLEAN */
-
 #define Inode (((struct minix_inode *) inode_buffer)-1)
 #define Inode2 (((struct minix2_inode *) inode_buffer)-1)

 #define INODE_SIZE (sizeof(struct minix_inode))
 #define INODE2_SIZE (sizeof(struct minix2_inode))

-int fs_version =3D 1; /* this default value needs to change in a near futu=
re */
-char *super_block_buffer, *inode_buffer =3D NULL;
+static int fs_version =3D 1; /* this default value needs to change in a
near future */
+static char *super_block_buffer, *inode_buffer =3D NULL;

 static char *inode_map;
 static char *zone_map;
diff --git a/libblkid/src/partitions/minix.c b/libblkid/src/partitions/mini=
x.c
index 0887d1a..b67d2c7 100644
--- a/libblkid/src/partitions/minix.c
+++ b/libblkid/src/partitions/minix.c
@@ -13,11 +13,7 @@

 #include "partitions.h"
 #include "dos.h"
-
-/*
- * Minix subpartitions are always within primary dos partition.
- */
-#define MINIX_MAXPARTITIONS 4
+#include "minix.h"

 static int probe_minix_pt(blkid_probe pr, const struct blkid_idmag *mag)
 {
diff --git a/libblkid/src/superblocks/minix.c b/libblkid/src/superblocks/mi=
nix.c
index 3290c27..e821ea7 100644
--- a/libblkid/src/superblocks/minix.c
+++ b/libblkid/src/superblocks/minix.c
@@ -11,38 +11,7 @@

 #include <string.h>
 #include "superblocks.h"
-
-struct minix_super_block {
-        uint16_t s_ninodes;
-        uint16_t s_nzones;
-        uint16_t s_imap_blocks;
-        uint16_t s_zmap_blocks;
-        uint16_t s_firstdatazone;
-        uint16_t s_log_zone_size;
-        uint32_t s_max_size;
-        uint16_t s_magic;
-        uint16_t s_state;
-        uint32_t s_zones;
-};
-
-struct minix3_super_block {
-	uint32_t s_ninodes;
-	uint16_t s_pad0;
-	uint16_t s_imap_blocks;
-	uint16_t s_zmap_blocks;
-	uint16_t s_firstdatazone;
-	uint16_t s_log_zone_size;
-	uint16_t s_pad1;
-	uint32_t s_max_size;
-	uint32_t s_zones;
-	uint16_t s_magic;
-	uint16_t s_pad2;
-	uint16_t s_blocksize;
-	uint8_t  s_disk_version;
-};
-
-#define MINIX_BLOCK_SIZE_BITS 10
-#define MINIX_BLOCK_SIZE (1 << MINIX_BLOCK_SIZE_BITS)
+#include "minix.h"

 static int probe_minix(blkid_probe pr, const struct blkid_idmag *mag)
 {
@@ -76,9 +45,9 @@ static int probe_minix(blkid_probe pr, const struct
blkid_idmag *mag)
 		zones =3D version =3D=3D 2 ? sb->s_zones : sb->s_nzones;

 		/* sanity checks to be sure that the FS is really minix */
-		if (sb->s_imap_blocks * MINIX_BLOCK_SIZE * 8 < sb->s_ninodes + 1)
+		if (sb->s_imap_blocks * BLOCK_SIZE * 8 < sb->s_ninodes + 1)
 			return -1;
-		if (sb->s_zmap_blocks * MINIX_BLOCK_SIZE * 8 < zones -
sb->s_firstdatazone + 1)
+		if (sb->s_zmap_blocks * BLOCK_SIZE * 8 < zones - sb->s_firstdatazone + 1=
)
 			return -1;

 	} else if (version =3D=3D 3) {

--=20
=A0=A0 Sami Kerola
=A0=A0 http://www.iki.fi/kerolasa/
