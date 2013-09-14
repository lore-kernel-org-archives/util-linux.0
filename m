Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f49.google.com ([74.125.82.49]:53987 "EHLO
	mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932241Ab3INRDj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 14 Sep 2013 13:03:39 -0400
Received: by mail-wg0-f49.google.com with SMTP id l18so2195309wgh.28
        for <util-linux@vger.kernel.org>; Sat, 14 Sep 2013 10:03:38 -0700 (PDT)
From: Gabriel de Perthuis <g2p.code@gmail.com>
To: Karel Zak <kzak@redhat.com>
Cc: Rolf Fokkens <rolf@rolffokkens.nl>, util-linux@vger.kernel.org,
        Gabriel de Perthuis <g2p.code@gmail.com>
Subject: [PATCH] libblkid: Abort after an incorrect checksum
Date: Sat, 14 Sep 2013 19:03:13 +0200
Message-Id: <1379178193-26527-1-git-send-email-g2p.code@gmail.com>
In-Reply-To: <1378491089-1135-2-git-send-email-g2p.code@gmail.com>
References: <1378491089-1135-2-git-send-email-g2p.code@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Log incorrect checksums and stop the superblock probing loop when
one is encountered.
This is to avoid exposing backend devices that are supposed
to be used through a stacked device (like raid or bcache).

Signed-off-by: Gabriel de Perthuis <g2p.code@gmail.com>
---
 libblkid/src/blkidP.h                   |  5 ++++-
 libblkid/src/probe.c                    | 26 ++++----------------------
 libblkid/src/superblocks/bcache.c       |  4 ++--
 libblkid/src/superblocks/lvm.c          |  5 ++---
 libblkid/src/superblocks/nilfs.c        |  3 +--
 libblkid/src/superblocks/silicon_raid.c |  5 +++--
 libblkid/src/superblocks/superblocks.c  | 13 +++++++++++++
 libblkid/src/superblocks/via_raid.c     |  4 ++--
 8 files changed, 31 insertions(+), 34 deletions(-)

diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
index 0bbf310..76a3731 100644
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
@@ -514,11 +517,11 @@ extern int blkid_probe_sprintf_value(blkid_probe pr, const char *name,
 
 extern int blkid_probe_set_magic(blkid_probe pr, blkid_loff_t offset,
 				size_t len, unsigned char *magic)
 			__attribute__((nonnull));
 
-extern int blkid_probe_verify_csum(blkid_probe pr, uint64_t csum, uint64_t expected)
+extern int blkid_probe_set_csum(blkid_probe pr, uint64_t csum, uint64_t expected)
 			__attribute__((nonnull));
 
 extern void blkid_unparse_uuid(const unsigned char *uuid, char *str, size_t len)
 			__attribute__((nonnull));
 extern int blkid_uuid_is_empty(const unsigned char *buf, size_t len);
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 4b0c997..e0c99a6 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -1349,33 +1349,15 @@ int blkid_probe_set_magic(blkid_probe pr, blkid_loff_t offset,
 	}
 
 	return rc;
 }
 
-int blkid_probe_verify_csum(blkid_probe pr, uint64_t csum, uint64_t expected)
+int blkid_probe_set_csum(blkid_probe pr, uint64_t csum, uint64_t expected)
 {
-	if (csum != expected) {
-		struct blkid_chain *chn = blkid_probe_get_chain(pr);
-
-		DBG(LOWPROBE, blkid_debug(
-				"incorrect checksum for type %s,"
-				" got %jX, expected %jX",
-				blkid_probe_get_probername(pr),
-				csum, expected));
-		/*
-		 * Accept bad checksum if BLKID_SUBLKS_BADCSUM flags is set
-		 */
-		if (chn->driver->id == BLKID_CHAIN_SUBLKS
-		    && (chn->flags & BLKID_SUBLKS_BADCSUM)) {
-			blkid_probe_set_value(pr, "SBBADCSUM", (unsigned char *) "1", 2);
-			goto accept;
-		}
-		return 0;	/* bad checksum */
-	}
-
-accept:
-	return 1;
+	pr->csum = csum;
+	pr->csum_expected = expected;
+	return 0;
 }
 
 /**
  * blkid_probe_get_devno:
  * @pr: probe
diff --git a/libblkid/src/superblocks/bcache.c b/libblkid/src/superblocks/bcache.c
index 303f7ee..99d886d 100644
--- a/libblkid/src/superblocks/bcache.c
+++ b/libblkid/src/superblocks/bcache.c
@@ -106,12 +106,12 @@ static int probe_bcache (blkid_probe pr, const struct blkid_idmag *mag)
 	if (!bcs)
 		return -1;
 
 	if (le64_to_cpu(bcs->offset) != BCACHE_SB_OFF / 512)
 		return 1;
-	if (!blkid_probe_verify_csum(pr, bcache_crc64(bcs), le64_to_cpu(bcs->csum)))
-		return 1;
+	if (blkid_probe_set_csum(pr, bcache_crc64(bcs), le64_to_cpu(bcs->csum)))
+		return -1;
 
 	if (blkid_probe_set_uuid(pr, bcs->uuid) < 0)
 		return -1;
 
 	return 0;
diff --git a/libblkid/src/superblocks/lvm.c b/libblkid/src/superblocks/lvm.c
index 65c7c35..de419bd 100644
--- a/libblkid/src/superblocks/lvm.c
+++ b/libblkid/src/superblocks/lvm.c
@@ -95,16 +95,15 @@ static int probe_lvm2(blkid_probe pr, const struct blkid_idmag *mag)
 	}
 
 	if (le64_to_cpu(label->sector_xl) != (unsigned) sector)
 		return 1;
 
-	if (!blkid_probe_verify_csum(
+	blkid_probe_set_csum(
 		pr, lvm2_calc_crc(
 			&label->offset_xl, LVM2_LABEL_SIZE -
 			((char *) &label->offset_xl - (char *) label)),
-			le32_to_cpu(label->crc_xl)))
-		return 1;
+			le32_to_cpu(label->crc_xl));
 
 	format_lvm_uuid(uuid, (char *) label->pv_uuid);
 	blkid_probe_sprintf_uuid(pr, label->pv_uuid, sizeof(label->pv_uuid),
 			"%s", uuid);
 
diff --git a/libblkid/src/superblocks/nilfs.c b/libblkid/src/superblocks/nilfs.c
index 9207677..bf5f109 100644
--- a/libblkid/src/superblocks/nilfs.c
+++ b/libblkid/src/superblocks/nilfs.c
@@ -87,12 +87,11 @@ static int probe_nilfs2(blkid_probe pr, const struct blkid_idmag *mag)
 	bytes = le16_to_cpu(sb->s_bytes);
 	crc = crc32(le32_to_cpu(sb->s_crc_seed), (unsigned char *)sb, sumoff);
 	crc = crc32(crc, sum, 4);
 	crc = crc32(crc, (unsigned char *)sb + sumoff + 4, bytes - sumoff - 4);
 
-	if (!blkid_probe_verify_csum(pr, crc, le32_to_cpu(sb->s_sum)))
-		return 1;
+	blkid_probe_set_csum(pr, crc, le32_to_cpu(sb->s_sum));
 
 	if (strlen(sb->s_volume_name))
 		blkid_probe_set_label(pr, (unsigned char *) sb->s_volume_name,
 				      sizeof(sb->s_volume_name));
 
diff --git a/libblkid/src/superblocks/silicon_raid.c b/libblkid/src/superblocks/silicon_raid.c
index 10a3023..0202eea 100644
--- a/libblkid/src/superblocks/silicon_raid.c
+++ b/libblkid/src/superblocks/silicon_raid.c
@@ -102,12 +102,13 @@ static int probe_silraid(blkid_probe pr,
 
 	if (le32_to_cpu(sil->magic) != SILICON_MAGIC)
 		return 1;
 	if (sil->disk_number >= 8)
 		return 1;
-	if (!blkid_probe_verify_csum(pr, silraid_checksum(sil), le16_to_cpu(sil->checksum1)))
-		return 1;
+
+	if (blkid_probe_set_csum(pr, silraid_checksum(sil), le16_to_cpu(sil->checksum1)))
+		return -1;
 
 	if (blkid_probe_sprintf_version(pr, "%u.%u",
 				le16_to_cpu(sil->major_ver),
 				le16_to_cpu(sil->minor_ver)) != 0)
 		return -1;
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index c6394c4..dcba46d 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -389,10 +389,23 @@ static int superblocks_probe(blkid_probe pr, struct blkid_chain *chn)
 				blkid_probe_chain_reset_vals(pr, chn);
 				continue;
 			}
 		}
 
+		if (pr->csum != pr->csum_expected) {
+			DBG(LOWPROBE, blkid_debug(
+					"incorrect checksum for type %s,"
+					" got %jX, expected %jX",
+					id->name, pr->csum, pr->csum_expected));
+			if (chn->flags & BLKID_SUBLKS_BADCSUM)
+				/* flag a bad checksum but continue probing */
+				blkid_probe_set_value(pr, "SBBADCSUM", (unsigned char *) "1", 2);
+			else
+				/* stop probing */
+				goto nothing;
+		}
+
 		/* all cheks passed */
 		if (chn->flags & BLKID_SUBLKS_TYPE)
 			rc = blkid_probe_set_value(pr, "TYPE",
 				(unsigned char *) id->name,
 				strlen(id->name) + 1);
diff --git a/libblkid/src/superblocks/via_raid.c b/libblkid/src/superblocks/via_raid.c
index 5c15167..4630e8e 100644
--- a/libblkid/src/superblocks/via_raid.c
+++ b/libblkid/src/superblocks/via_raid.c
@@ -67,13 +67,13 @@ static int probe_viaraid(blkid_probe pr,
 
 	if (le16_to_cpu(v->signature) != VIA_SIGNATURE)
 		return 1;
 	if (v->version_number > 2)
 		return 1;
-	if (!blkid_probe_verify_csum(pr, via_checksum(v), v->checksum))
-		return 1;
 
+	if (blkid_probe_set_csum(pr, via_checksum(v), v->checksum))
+		return -1;
 	if (blkid_probe_sprintf_version(pr, "%u", v->version_number) != 0)
 		return -1;
 	if (blkid_probe_set_magic(pr, off,
 				sizeof(v->signature),
 				(unsigned char *) &v->signature))
-- 
1.8.4.25.g05e4ae6

