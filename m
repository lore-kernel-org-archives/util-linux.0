Return-Path: hare@suse.de
From: Hannes Reinecke <hare@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: Werner Fink <werner@suse.de>, Stanislav Brabec <sbrabec@suse.com>,
        <util-linux@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] blkid: stop scanning on I/O error
Date: Thu, 20 Mar 2014 11:03:49 +0100
Message-Id: <1395309830-58744-2-git-send-email-hare@suse.de>
In-Reply-To: <1395309830-58744-1-git-send-email-hare@suse.de>
References: <1395309830-58744-1-git-send-email-hare@suse.de>
List-ID: <util-linux.vger.kernel.org>

Whenever we fail to read from a device it's pointless to
continue with probing; we should be failing immediately.
Otherwise the system will continue logging I/O errors.

This patch updates the probe functions to return the
negative error number on error and BLKID_PROBE_NONE
if not found.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 libblkid/src/blkidP.h                  |  3 +++
 libblkid/src/partitions/partitions.c   | 44 ++++++++++++++++++----------------
 libblkid/src/probe.c                   | 30 +++++++++++++++++++----
 libblkid/src/superblocks/superblocks.c | 38 +++++++++++++++++++----------
 4 files changed, 78 insertions(+), 37 deletions(-)

diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
index 4a968d9..58a81d9 100644
--- a/libblkid/src/blkidP.h
+++ b/libblkid/src/blkidP.h
@@ -297,6 +297,9 @@ struct blkid_struct_cache
 /* old systems */
 #define BLKID_CACHE_FILE_OLD	"/etc/blkid.tab"
 
+#define BLKID_PROBE_OK	 0
+#define BLKID_PROBE_NONE 1
+
 #define BLKID_ERR_IO	 5
 #define BLKID_ERR_PROC	 9
 #define BLKID_ERR_MEM	12
diff --git a/libblkid/src/partitions/partitions.c b/libblkid/src/partitions/partitions.c
index d9419f2..b116546 100644
--- a/libblkid/src/partitions/partitions.c
+++ b/libblkid/src/partitions/partitions.c
@@ -535,12 +535,13 @@ static int idinfo_probe(blkid_probe pr, const struct blkid_idinfo *id,
 {
 	const struct blkid_idmag *mag = NULL;
 	blkid_loff_t off;
-	int rc = 1;		/* = nothing detected */
+	int rc = BLKID_PROBE_NONE;		/* = nothing detected */
 
 	if (pr->size <= 0 || (id->minsz && id->minsz > pr->size))
 		goto nothing;	/* the device is too small */
 
-	if (blkid_probe_get_idmag(pr, id, &off, &mag))
+	rc = blkid_probe_get_idmag(pr, id, &off, &mag);
+	if (rc != BLKID_PROBE_OK)
 		goto nothing;
 
 	/* final check by probing function */
@@ -548,14 +549,15 @@ static int idinfo_probe(blkid_probe pr, const struct blkid_idinfo *id,
 		DBG(LOWPROBE, blkid_debug(
 			"%s: ---> call probefunc()", id->name));
 		rc = id->probefunc(pr, mag);
-	        if (rc == -1) {
+		if (rc < 0) {
 			/* reset after error */
 			reset_partlist(blkid_probe_get_partlist(pr));
 			if (chn && !chn->binary)
 				blkid_probe_chain_reset_vals(pr, chn);
-			DBG(LOWPROBE, blkid_debug("%s probefunc failed", id->name));
+			DBG(LOWPROBE, blkid_debug("%s probefunc failed, rc %d",
+						  id->name, rc));
 		}
-		if (rc == 0 && mag && chn && !chn->binary)
+		if (rc == BLKID_PROBE_OK && mag && chn && !chn->binary)
 			rc = blkid_probe_set_magic(pr, off, mag->len,
 					(unsigned char *) mag->magic);
 
@@ -571,11 +573,11 @@ nothing:
  */
 static int partitions_probe(blkid_probe pr, struct blkid_chain *chn)
 {
-	int rc = 1;
+	int rc = BLKID_PROBE_NONE;
 	size_t i;
 
 	if (!pr || chn->idx < -1)
-		return -1;
+		return -EINVAL;
 	blkid_probe_chain_reset_vals(pr, chn);
 
 	if (chn->binary)
@@ -599,7 +601,10 @@ static int partitions_probe(blkid_probe pr, struct blkid_chain *chn)
 			continue;
 
 		/* apply checks from idinfo */
-		if (idinfo_probe(pr, idinfos[i], chn) != 0)
+		rc = idinfo_probe(pr, idinfos[i], chn);
+		if (rc < 0)
+			break;
+		if (rc != BLKID_PROBE_OK)
 			continue;
 
 		name = idinfos[i]->name;
@@ -620,20 +625,19 @@ static int partitions_probe(blkid_probe pr, struct blkid_chain *chn)
 		break;
 	}
 
-	if (rc == 1) {
-		DBG(LOWPROBE, blkid_debug("<-- leaving probing loop (failed) [PARTS idx=%d]",
-			chn->idx));
+	if (rc != BLKID_PROBE_OK) {
+		DBG(LOWPROBE, blkid_debug("<-- leaving probing loop (failed=%d) [PARTS idx=%d]",
+			rc, chn->idx));
 	}
 
 details_only:
 	/*
 	 * Gather PART_ENTRY_* values if the current device is a partition.
 	 */
-	if (!chn->binary &&
+	if (rc == BLKID_PROBE_OK && !chn->binary &&
 	    (blkid_partitions_get_flags(pr) & BLKID_PARTS_ENTRY_DETAILS)) {
 
-		if (!blkid_partitions_probe_partition(pr))
-			rc = 0;
+		rc = blkid_partitions_probe_partition(pr);
 	}
 
 	return rc;
@@ -644,7 +648,7 @@ int blkid_partitions_do_subprobe(blkid_probe pr, blkid_partition parent,
 		const struct blkid_idinfo *id)
 {
 	blkid_probe prc;
-	int rc = 1;
+	int rc;
 	blkid_partlist ls;
 	blkid_loff_t sz, off;
 
@@ -653,7 +657,7 @@ int blkid_partitions_do_subprobe(blkid_probe pr, blkid_partition parent,
 		id->name, parent));
 
 	if (!pr || !parent || !parent->size)
-		return -1;
+		return -EINVAL;
 
 	/* range defined by parent */
 	sz = ((blkid_loff_t) parent->size) << 9;
@@ -663,13 +667,13 @@ int blkid_partitions_do_subprobe(blkid_probe pr, blkid_partition parent,
 		DBG(LOWPROBE, blkid_debug(
 			"ERROR: parts: <---- '%s' subprobe: overflow detected.",
 			id->name));
-		return -1;
+		return -ENOSPC;
 	}
 
 	/* create private prober */
 	prc = blkid_clone_probe(pr);
 	if (!prc)
-		return -1;
+		return -ENOMEM;
 
 	blkid_probe_set_dimension(prc, off, sz);
 
@@ -702,7 +706,7 @@ int blkid_partitions_do_subprobe(blkid_probe pr, blkid_partition parent,
 
 static int blkid_partitions_probe_partition(blkid_probe pr)
 {
-	int rc = 1;
+	int rc = BLKID_PROBE_NONE;
 	blkid_probe disk_pr = NULL;
 	blkid_partlist ls;
 	blkid_partition par;
@@ -768,7 +772,7 @@ static int blkid_partitions_probe_partition(blkid_probe pr)
 		blkid_probe_sprintf_value(pr, "PART_ENTRY_DISK", "%u:%u",
 				major(disk), minor(disk));
 	}
-	rc = 0;
+	rc = BLKID_PROBE_OK;
 nothing:
 	return rc;
 }
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index e20c61b..eea8dbf 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -569,13 +569,17 @@ unsigned char *blkid_probe_get_buffer(blkid_probe pr,
 	if (!bf) {
 		ssize_t ret;
 
-		if (blkid_llseek(pr->fd, pr->off + off, SEEK_SET) < 0)
+		if (blkid_llseek(pr->fd, pr->off + off, SEEK_SET) < 0) {
+			errno = 0;
 			return NULL;
+		}
 
 		/* allocate info and space for data by why call */
 		bf = calloc(1, sizeof(struct blkid_bufinfo) + len);
-		if (!bf)
+		if (!bf) {
+			errno = ENOMEM;
 			return NULL;
+		}
 
 		bf->data = ((unsigned char *) bf) + sizeof(struct blkid_bufinfo);
 		bf->len = len;
@@ -587,7 +591,10 @@ unsigned char *blkid_probe_get_buffer(blkid_probe pr,
 
 		ret = read(pr->fd, bf->data, len);
 		if (ret != (ssize_t) len) {
+			DBG(LOWPROBE, blkid_debug("\tbuffer read: return %d error %d", ret, errno));
 			free(bf);
+			if (ret >= 0)
+				errno = 0;
 			return NULL;
 		}
 		list_add_tail(&bf->bufs, &pr->buffers);
@@ -776,6 +783,17 @@ int blkid_probe_set_dimension(blkid_probe pr,
 	return 0;
 }
 
+/**
+ * blkid_probe_get_idmag:
+ * @pr: probe
+ * @id: id information
+ * @offset: begin of probing area
+ * @res: found id information
+ *
+ * Check for matching magic value.
+ * Returns BLKID_PROBE_OK if found, BLKID_PROBE_NONE if not found
+ * or no magic present, or negative value on error.
+ */
 int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 			blkid_loff_t *offset, const struct blkid_idmag **res)
 {
@@ -794,6 +812,8 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 		off = (mag->kboff + (mag->sboff >> 10)) << 10;
 		buf = blkid_probe_get_buffer(pr, off, 1024);
 
+		if (!buf && errno)
+			return errno;
 		if (buf && !memcmp(mag->magic,
 				buf + (mag->sboff & 0x3ff), mag->len)) {
 			DBG(LOWPROBE, blkid_debug("\tmagic sboff=%u, kboff=%ld",
@@ -802,16 +822,16 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 				*offset = off + (mag->sboff & 0x3ff);
 			if (res)
 				*res = mag;
-			return 0;
+			return BLKID_PROBE_OK;
 		}
 		mag++;
 	}
 
 	if (id && id->magics[0].magic)
 		/* magic string(s) defined, but not found */
-		return 1;
+		return BLKID_PROBE_NONE;
 
-	return 0;
+	return BLKID_PROBE_OK;
 }
 
 static inline void blkid_probe_start(blkid_probe pr)
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index c6394c4..c0ed259 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -335,9 +335,10 @@ int blkid_superblocks_get_name(size_t idx, const char **name, int *usage)
 static int superblocks_probe(blkid_probe pr, struct blkid_chain *chn)
 {
 	size_t i;
+	int rc = BLKID_PROBE_NONE;
 
 	if (!pr || chn->idx < -1)
-		return -1;
+		return -EINVAL;
 	blkid_probe_chain_reset_vals(pr, chn);
 
 	DBG(LOWPROBE, blkid_debug("--> starting probing loop [SUBLKS idx=%d]",
@@ -355,39 +356,52 @@ static int superblocks_probe(blkid_probe pr, struct blkid_chain *chn)
 		const struct blkid_idinfo *id;
 		const struct blkid_idmag *mag = NULL;
 		blkid_loff_t off = 0;
-		int rc = 0;
 
 		chn->idx = i;
 		id = idinfos[i];
 
 		if (chn->fltr && blkid_bmp_get_item(chn->fltr, i)) {
 			DBG(LOWPROBE, blkid_debug("filter out: %s", id->name));
+			rc = BLKID_PROBE_NONE;
 			continue;
 		}
 
-		if (id->minsz && id->minsz > pr->size)
+		if (id->minsz && id->minsz > pr->size) {
+			rc = BLKID_PROBE_NONE;
 			continue;	/* the device is too small */
+		}
 
 		/* don't probe for RAIDs, swap or journal on CD/DVDs */
 		if ((id->usage & (BLKID_USAGE_RAID | BLKID_USAGE_OTHER)) &&
-		    blkid_probe_is_cdrom(pr))
+		    blkid_probe_is_cdrom(pr)) {
+			rc = BLKID_PROBE_NONE;
 			continue;
+		}
 
 		/* don't probe for RAIDs on floppies */
-		if ((id->usage & BLKID_USAGE_RAID) && blkid_probe_is_tiny(pr))
+		if ((id->usage & BLKID_USAGE_RAID) && blkid_probe_is_tiny(pr)) {
+			rc = BLKID_PROBE_NONE;
 			continue;
+		}
 
 		DBG(LOWPROBE, blkid_debug("[%zd] %s:", i, id->name));
 
-		if (blkid_probe_get_idmag(pr, id, &off, &mag))
+		rc = blkid_probe_get_idmag(pr, id, &off, &mag);
+		if (rc < 0)
+			break;
+		if (rc != BLKID_PROBE_OK)
 			continue;
 
 		/* final check by probing function */
 		if (id->probefunc) {
 			DBG(LOWPROBE, blkid_debug("\tcall probefunc()"));
-			if (id->probefunc(pr, mag) != 0) {
+			rc = id->probefunc(pr, mag);
+			if (rc != BLKID_PROBE_OK) {
 				blkid_probe_chain_reset_vals(pr, chn);
-				continue;
+				if (rc < 0)
+					break;
+				else
+					continue;
 			}
 		}
 
@@ -411,13 +425,13 @@ static int superblocks_probe(blkid_probe pr, struct blkid_chain *chn)
 
 		DBG(LOWPROBE, blkid_debug("<-- leaving probing loop (type=%s) [SUBLKS idx=%d]",
 			id->name, chn->idx));
-		return 0;
+		return BLKID_PROBE_OK;
 	}
 
 nothing:
-	DBG(LOWPROBE, blkid_debug("<-- leaving probing loop (failed) [SUBLKS idx=%d]",
-		chn->idx));
-	return 1;
+	DBG(LOWPROBE, blkid_debug("<-- leaving probing loop (failed=%d) [SUBLKS idx=%d]",
+			rc, chn->idx));
+	return rc;
 }
 
 /*
-- 
1.7.12.4
