Return-Path: dave@gnu.org
Subject: [PATCH 1/3] minix: add version 3 layout
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 29 Jun 2011 13:28:13 -0400
Message-ID: <1309368493.3162.3.camel@offbook>
Mime-Version: 1.0
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>
Date: Wed, 29 Jun 2011 12:55:18 -0400

Create a specific minix v3 superblock structure and adjust the attribute wr=
apper functions to handle it.

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 disk-utils/minix.h |   83 +++++++++++++++++++++++++++++++++++++++++++++---=
----
 1 files changed, 72 insertions(+), 11 deletions(-)

diff --git a/disk-utils/minix.h b/disk-utils/minix.h
index 0ebaa26..fc1d1c0 100644
--- a/disk-utils/minix.h
+++ b/disk-utils/minix.h
@@ -47,10 +47,29 @@ struct minix_super_block {
         u32 s_zones;
 };
=20
+/* V3 minix super-block data on disk */
+struct minix3_super_block {
+	u32 s_ninodes;
+	u16 s_pad0;
+	u16 s_imap_blocks;
+	u16 s_zmap_blocks;
+	u16 s_firstdatazone;
+	u16 s_log_zone_size;
+	u16 s_pad1;
+	u32 s_max_size;
+	u32 s_zones;
+	u16 s_magic;
+	u16 s_pad2;
+	u16 s_blocksize;
+	u8  s_disk_version;
+        u16 s_state;
+};
+
 #define BLOCK_SIZE_BITS 10
 #define BLOCK_SIZE (1<<BLOCK_SIZE_BITS)
=20
-#define NAME_MAX         255   /* # chars in a file name */
+#define NAME_MAX   255   /* # chars in a file name */
+#define MAX_INODES 65535
=20
 #define MINIX_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix_inode))=
)
 #define MINIX2_INODES_PER_BLOCK ((BLOCK_SIZE)/(sizeof (struct minix2_inode=
)))
@@ -62,6 +81,7 @@ struct minix_super_block {
 #define MINIX_SUPER_MAGIC2   0x138F          /* minix fs, 30 char names */
 #define MINIX2_SUPER_MAGIC   0x2468	     /* minix V2 fs */
 #define MINIX2_SUPER_MAGIC2  0x2478	     /* minix V2 fs, 30 char names */
+#define MINIX3_SUPER_MAGIC   0x4d5a          /* minix V3 fs (60 char names=
) */
=20
 #endif /* KERNEL_INCLUDES_ARE_CLEAN */
=20
@@ -71,7 +91,7 @@ struct minix_super_block {
 #define INODE_SIZE (sizeof(struct minix_inode))
 #define INODE2_SIZE (sizeof(struct minix2_inode))
=20
-int fs_version =3D 1;
+int fs_version =3D 1; /* this default value needs to change in a near futu=
re */
 char *super_block_buffer, *inode_buffer =3D NULL;
=20
 static char *inode_map;
@@ -85,48 +105,89 @@ static char *zone_map;
  * wrappers to different superblock attributes
  */
 #define Super (*(struct minix_super_block *)super_block_buffer)
+#define Super3 (*(struct minix3_super_block *)super_block_buffer)
=20
 static inline unsigned long get_ninodes(void)
 {
-	return (unsigned long) Super.s_ninodes;
+	switch (fs_version) {
+	case 3:
+		return Super3.s_ninodes;
+	default:
+		return (unsigned long) Super.s_ninodes;
+	}
 }
=20
 static inline unsigned long get_nzones(void)
 {
-	return (unsigned long) fs_version =3D=3D 2 ? Super.s_zones : Super.s_nzon=
es;
+	switch (fs_version) {
+	case 3:
+		return (unsigned long) Super3.s_zones;
+	case 2:
+		return (unsigned long) Super.s_zones;
+	default:
+		return (unsigned long) Super.s_nzones;
+	}
 }
=20
 static inline unsigned long get_nimaps(void)
 {
-	return (unsigned long)Super.s_imap_blocks;
+	switch (fs_version) {
+	case 3:
+		return (unsigned long) Super3.s_imap_blocks;
+	default:
+		return (unsigned long) Super.s_imap_blocks;
+	}
 }
=20
 static inline unsigned long get_nzmaps(void)
 {
-	return (unsigned long)Super.s_zmap_blocks;
+	switch (fs_version) {
+	case 3:
+		return (unsigned long) Super3.s_zmap_blocks;
+	default:
+		return (unsigned long) Super.s_zmap_blocks;
+	}
 }
=20
 static inline unsigned long get_first_zone(void)
 {
-	return (unsigned long)Super.s_firstdatazone;
+	switch (fs_version) {
+	case 3:
+		return (unsigned long) Super3.s_firstdatazone;
+	default:
+		return (unsigned long) Super.s_firstdatazone;
+	}
 }
=20
 static inline unsigned long get_zone_size(void)
 {
-	return (unsigned long)Super.s_log_zone_size;
+	switch (fs_version) {
+	case 3:
+		return (unsigned long) Super3.s_log_zone_size;
+	default:
+		return (unsigned long) Super.s_log_zone_size;
+	}
 }
=20
 static inline unsigned long get_max_size(void)
 {
-	return (unsigned long)Super.s_max_size;
+	switch (fs_version) {
+	case 3:
+		return (unsigned long) Super3.s_max_size;
+	default:
+		return (unsigned long) Super.s_max_size;
+	}
 }
=20
 static unsigned long inode_blocks(void)
 {
-	if (fs_version =3D=3D 2)
+	switch (fs_version) {
+	case 3:
+	case 2:
 		return UPPER(get_ninodes(), MINIX2_INODES_PER_BLOCK);
-	else
+	default:
 		return UPPER(get_ninodes(), MINIX_INODES_PER_BLOCK);
+	}
 }
=20
 static inline unsigned long first_zone_data(void)
--=20
1.7.4.1
