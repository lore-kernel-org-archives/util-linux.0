Return-Path: g2p.code@gmail.com
From: Gabriel de Perthuis <g2p.code@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Rolf Fokkens <rolf@rolffokkens.nl>, util-linux@vger.kernel.org,
        Gabriel de Perthuis <g2p.code@gmail.com>
Subject: [PATCH 1/2] libblkid: Abort after an incorrect checksum
Date: Fri,  6 Sep 2013 20:11:28 +0200
Message-Id: <1378491089-1135-2-git-send-email-g2p.code@gmail.com>
In-Reply-To: <1378491089-1135-1-git-send-email-g2p.code@gmail.com>
References: <1378491089-1135-1-git-send-email-g2p.code@gmail.com>
List-ID: <util-linux.vger.kernel.org>

Log incorrect checksums and stop the superblock probing loop when
one is encountered.
This is to avoid exposing backend devices that are supposed
to be used through a stacked device (like raid or bcache).

Signed-off-by: Gabriel de Perthuis <g2p.code@gmail.com>
---
 libblkid/src/blkidP.h                   | 6 ++++++
 libblkid/src/probe.c                    | 7 +++++++
 libblkid/src/superblocks/lvm.c          | 9 ++++++---
 libblkid/src/superblocks/nilfs.c        | 3 +--
 libblkid/src/superblocks/silicon_raid.c | 7 ++++---
 libblkid/src/superblocks/superblocks.c  | 8 ++++++++
 libblkid/src/superblocks/via_raid.c     | 4 ++--
 7 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
index 1c05968..76a3731 100644
--- a/libblkid/src/blkidP.h
+++ b/libblkid/src/blkidP.h
@@ -213,10 +213,13 @@ struct blkid_struct_probe
 	struct blkid_prval	vals[BLKID_NVALS];	/* results */
 	int			nvals;		/* number of assigned vals */
 
 	struct blkid_struct_probe *parent;	/* for clones */
 	struct blkid_struct_probe *disk_probe;	/* whole-disk probing */
+
+	uint64_t		csum;
+	uint64_t		csum_expected;
 };
 
 /* private flags library flags */
 #define BLKID_FL_PRIVATE_FD	(1 << 1)	/* see blkid_new_probe_from_filename() */
 #define BLKID_FL_TINY_DEV	(1 << 2)	/* <= 1.47MiB (floppy or so) */
@@ -514,10 +517,13 @@ extern int blkid_probe_sprintf_value(blkid_probe pr, const char *name,
 
 extern int blkid_probe_set_magic(blkid_probe pr, blkid_loff_t offset,
 				size_t len, unsigned char *magic)
 			__attribute__((nonnull));
 
+extern int blkid_probe_set_csum(blkid_probe pr, uint64_t csum, uint64_t expected)
+			__attribute__((nonnull));
+
 extern void blkid_unparse_uuid(const unsigned char *uuid, char *str, size_t len)
 			__attribute__((nonnull));
 extern int blkid_uuid_is_empty(const unsigned char *buf, size_t len);
 
 extern size_t blkid_rtrim_whitespace(unsigned char *str)
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index d2b301d..e97380e 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -1339,10 +1339,17 @@ int blkid_probe_set_magic(blkid_probe pr, blkid_loff_t offset,
 	}
 
 	return rc;
 }
 
+int blkid_probe_set_csum(blkid_probe pr, uint64_t csum, uint64_t expected)
+{
+	pr->csum = csum;
+	pr->csum_expected = expected;
+	return 0;
+}
+
 /**
  * blkid_probe_get_devno:
  * @pr: probe
  *
  * Returns: block device number, or 0 for regular files.
diff --git a/libblkid/src/superblocks/lvm.c b/libblkid/src/superblocks/lvm.c
index dc38f2e..66e17c8 100644
--- a/libblkid/src/superblocks/lvm.c
+++ b/libblkid/src/superblocks/lvm.c
@@ -95,13 +95,16 @@ static int probe_lvm2(blkid_probe pr, const struct blkid_idmag *mag)
 	}
 
 	if (le64_to_cpu(label->sector_xl) != (unsigned) sector)
 		return 1;
 
-	if (lvm2_calc_crc(&label->offset_xl, LVM2_LABEL_SIZE -
-			((char *) &label->offset_xl - (char *) label)) !=
-			le32_to_cpu(label->crc_xl)) {
+	blkid_probe_set_csum(
+		pr, lvm2_calc_crc(
+			&label->offset_xl, LVM2_LABEL_SIZE -
+			((char *) &label->offset_xl - (char *) label)),
+			le32_to_cpu(label->crc_xl));
+	if (0) {
 		DBG(PROBE, blkid_debug("LVM2: label checksum incorrect at sector %d",
 			   sector));
 		return 1;
 	}
 
diff --git a/libblkid/src/superblocks/nilfs.c b/libblkid/src/superblocks/nilfs.c
index 1f8f3a6..bf5f109 100644
--- a/libblkid/src/superblocks/nilfs.c
+++ b/libblkid/src/superblocks/nilfs.c
@@ -87,12 +87,11 @@ static int probe_nilfs2(blkid_probe pr, const struct blkid_idmag *mag)
 	bytes = le16_to_cpu(sb->s_bytes);
 	crc = crc32(le32_to_cpu(sb->s_crc_seed), (unsigned char *)sb, sumoff);
 	crc = crc32(crc, sum, 4);
 	crc = crc32(crc, (unsigned char *)sb + sumoff + 4, bytes - sumoff - 4);
 
-	if (crc != le32_to_cpu(sb->s_sum))
-		return -1;
+	blkid_probe_set_csum(pr, crc, le32_to_cpu(sb->s_sum));
 
 	if (strlen(sb->s_volume_name))
 		blkid_probe_set_label(pr, (unsigned char *) sb->s_volume_name,
 				      sizeof(sb->s_volume_name));
 
diff --git a/libblkid/src/superblocks/silicon_raid.c b/libblkid/src/superblocks/silicon_raid.c
index aeab4bf..eac6cc1 100644
--- a/libblkid/src/superblocks/silicon_raid.c
+++ b/libblkid/src/superblocks/silicon_raid.c
@@ -65,22 +65,22 @@ struct silicon_metadata {
 	uint16_t	checksum2;
 } __attribute__((packed));
 
 #define SILICON_MAGIC		0x2F000000
 
-static int checksum(struct silicon_metadata *sil)
+static uint16_t checksum(struct silicon_metadata *sil)
 {
 	int sum = 0;
 	unsigned short count = offsetof(struct silicon_metadata, checksum1) / 2;
 	uint16_t *p = (uint16_t *) sil;
 
 	while (count--) {
 		uint16_t x = *p++;
 		sum += le16_to_cpu(x);
 	}
 
-	return (-sum & 0xFFFF) == le16_to_cpu(sil->checksum1);
+	return -sum & 0xFFFF;
 }
 
 static int probe_silraid(blkid_probe pr,
 		const struct blkid_idmag *mag __attribute__((__unused__)))
 {
@@ -102,11 +102,12 @@ static int probe_silraid(blkid_probe pr,
 
 	if (le32_to_cpu(sil->magic) != SILICON_MAGIC)
 		return -1;
 	if (sil->disk_number >= 8)
 		return -1;
-	if (!checksum(sil)) {
+	blkid_probe_set_csum(pr, checksum(sil), le16_to_cpu(sil->checksum1));
+	if (0) {
 		DBG(LOWPROBE, blkid_debug("silicon raid: incorrect checksum"));
 		return -1;
 	}
 
 	if (blkid_probe_sprintf_version(pr, "%u.%u",
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index 5f43b24..2a023f8 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -385,10 +385,18 @@ static int superblocks_probe(blkid_probe pr, struct blkid_chain *chn)
 				blkid_probe_chain_reset_vals(pr, chn);
 				continue;
 			}
 		}
 
+		if (pr->csum != pr->csum_expected) {
+			DBG(LOWPROBE, blkid_debug(
+					"incorrect checksum for type %s,"
+					" got %jX, expected %jX",
+					id->name, pr->csum, pr->csum_expected));
+			goto nothing;
+		}
+
 		/* all cheks passed */
 		if (chn->flags & BLKID_SUBLKS_TYPE)
 			rc = blkid_probe_set_value(pr, "TYPE",
 				(unsigned char *) id->name,
 				strlen(id->name) + 1);
diff --git a/libblkid/src/superblocks/via_raid.c b/libblkid/src/superblocks/via_raid.c
index eba7e4b..acfefac 100644
--- a/libblkid/src/superblocks/via_raid.c
+++ b/libblkid/src/superblocks/via_raid.c
@@ -40,11 +40,11 @@ static uint8_t via_checksum(struct via_metadata *v)
 	uint8_t i = 50, cs = 0;
 
 	while (i--)
 		cs += ((uint8_t*) v)[i];
 
-	return cs == v->checksum;
+	return cs;
 }
 
 static int probe_viaraid(blkid_probe pr,
 		const struct blkid_idmag *mag __attribute__((__unused__)))
 {
@@ -66,11 +66,11 @@ static int probe_viaraid(blkid_probe pr,
 		return -1;
 	if (le16_to_cpu(v->signature) != VIA_SIGNATURE)
 		return -1;
 	if (v->version_number > 2)
 		return -1;
-	if (!via_checksum(v))
+	if (blkid_probe_set_csum(pr, via_checksum(v), v->checksum))
 		return -1;
 	if (blkid_probe_sprintf_version(pr, "%u", v->version_number) != 0)
 		return -1;
 	if (blkid_probe_set_magic(pr, off,
 				sizeof(v->signature),
-- 
1.8.4.25.g05e4ae6
