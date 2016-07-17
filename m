Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35704 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751788AbcGQNAq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:46 -0400
Received: by mail-wm0-f65.google.com with SMTP id i5so8764091wmg.2
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:45 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 13/13] libblkid: fix debugging macro [oclint]
Date: Sun, 17 Jul 2016 14:00:15 +0100
Message-Id: <20160717130015.31760-14-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The oclint was complaining 'empty do/while statement' that turned out to be
true and I started to think it is best to use the same DBG() macro as in
other source files for this library.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/superblocks/zfs.c | 32 +++++++++++++-------------------
 1 file changed, 13 insertions(+), 19 deletions(-)

diff --git a/libblkid/src/superblocks/zfs.c b/libblkid/src/superblocks/zfs.c
index f44fe52..b6ffac5 100644
--- a/libblkid/src/superblocks/zfs.c
+++ b/libblkid/src/superblocks/zfs.c
@@ -65,9 +65,6 @@ struct nvlist {
 	struct nvpair	nvl_nvpair;
 };
 
-#define nvdebug(fmt, ...)	do { } while(0)
-/*#define nvdebug(fmt, a...)	fprintf(stderr, fmt, ##a)*/
-
 static void zfs_extract_guid_name(blkid_probe pr, loff_t offset)
 {
 	unsigned char *p, buff[4096];
@@ -90,7 +87,7 @@ static void zfs_extract_guid_name(blkid_probe pr, loff_t offset)
 	memcpy(buff, p, sizeof(buff));
 	nvl = (struct nvlist *) buff;
 
-	nvdebug("zfs_extract: nvlist offset %llu\n", offset);
+	DBG(LOWPROBE, ul_debug("zfs_extract: nvlist offset %jd\n", offset));
 
 	nvp = &nvl->nvl_nvpair;
 	while (left > sizeof(*nvp) && nvp->nvp_size != 0 && found < 3) {
@@ -101,15 +98,15 @@ static void zfs_extract_guid_name(blkid_probe pr, loff_t offset)
 		nvp->nvp_namelen = be32_to_cpu(nvp->nvp_namelen);
 		avail = nvp->nvp_size - nvp->nvp_namelen - sizeof(*nvp);
 
-		nvdebug("left %zd nvp_size %u\n", left, nvp->nvp_size);
+		DBG(LOWPROBE, ul_debug("left %zd nvp_size %u\n", left, nvp->nvp_size));
 		if (left < nvp->nvp_size || avail < 0)
 			break;
 
 		namesize = (nvp->nvp_namelen + 3) & ~3;
 
-		nvdebug("nvlist: size %u, namelen %u, name %*s\n",
+		DBG(LOWPROBE, ul_debug("nvlist: size %u, namelen %u, name %*s\n",
 			nvp->nvp_size, nvp->nvp_namelen, nvp->nvp_namelen,
-			nvp->nvp_name);
+			nvp->nvp_name));
 		if (strncmp(nvp->nvp_name, "name", nvp->nvp_namelen) == 0) {
 			struct nvstring *nvs = (void *)(nvp->nvp_name+namesize);
 
@@ -118,8 +115,8 @@ static void zfs_extract_guid_name(blkid_probe pr, loff_t offset)
 			if (nvs->nvs_strlen > UINT_MAX - sizeof(*nvs))
 				break;
 			avail -= nvs->nvs_strlen + sizeof(*nvs);
-			nvdebug("nvstring: type %u string %*s\n", nvs->nvs_type,
-				nvs->nvs_strlen, nvs->nvs_string);
+			DBG(LOWPROBE, ul_debug("nvstring: type %u string %*s\n", nvs->nvs_type,
+				nvs->nvs_strlen, nvs->nvs_string));
 			if (nvs->nvs_type == DATA_TYPE_STRING && avail >= 0)
 				blkid_probe_set_label(pr, nvs->nvs_string,
 						      nvs->nvs_strlen);
@@ -133,8 +130,8 @@ static void zfs_extract_guid_name(blkid_probe pr, loff_t offset)
 			nvu->nvu_type = be32_to_cpu(nvu->nvu_type);
 			nvu_value = be64_to_cpu(nvu_value);
 			avail -= sizeof(*nvu);
-			nvdebug("nvuint64: type %u value %"PRIu64"\n",
-				nvu->nvu_type, nvu_value);
+			DBG(LOWPROBE, ul_debug("nvuint64: type %u value %"PRIu64"\n",
+				nvu->nvu_type, nvu_value));
 			if (nvu->nvu_type == DATA_TYPE_UINT64 && avail >= 0)
 				blkid_probe_sprintf_value(pr, "UUID_SUB",
 							  "%"PRIu64, nvu_value);
@@ -148,8 +145,8 @@ static void zfs_extract_guid_name(blkid_probe pr, loff_t offset)
 			nvu->nvu_type = be32_to_cpu(nvu->nvu_type);
 			nvu_value = be64_to_cpu(nvu_value);
 			avail -= sizeof(*nvu);
-			nvdebug("nvuint64: type %u value %"PRIu64"\n",
-				nvu->nvu_type, nvu_value);
+			DBG(LOWPROBE, ul_debug("nvuint64: type %u value %"PRIu64"\n",
+				nvu->nvu_type, nvu_value));
 			if (nvu->nvu_type == DATA_TYPE_UINT64 && avail >= 0)
 				blkid_probe_sprintf_uuid(pr, (unsigned char *)
 							 &nvu_value,
@@ -165,9 +162,6 @@ static void zfs_extract_guid_name(blkid_probe pr, loff_t offset)
 	}
 }
 
-#define zdebug(fmt, ...)	do {} while(0)
-/*#define zdebug(fmt, a...)	fprintf(stderr, fmt, ##a)*/
-
 static int find_uberblocks(const void *label, loff_t *ub_offset, int *swap_endian)
 {
 	uint64_t swab_magic = swab64((uint64_t)UBERBLOCK_MAGIC);
@@ -182,14 +176,14 @@ static int find_uberblocks(const void *label, loff_t *ub_offset, int *swap_endia
 			*ub_offset = offset;
 			*swap_endian = 0;
 			found++;
-			zdebug("probe_zfs: found little-endian uberblock at %llu\n", offset >> 10);
+			DBG(LOWPROBE, ul_debug("probe_zfs: found little-endian uberblock at %jd\n", offset >> 10));
 		}
 
 		if (ub->ub_magic == swab_magic) {
 			*ub_offset = offset;
 			*swap_endian = 1;
 			found++;
-			zdebug("probe_zfs: found big-endian uberblock at %llu\n", offset >> 10);
+			DBG(LOWPROBE, ul_debug("probe_zfs: found big-endian uberblock at %jd\n", offset >> 10));
 		}
 	}
 
@@ -209,7 +203,7 @@ static int probe_zfs(blkid_probe pr,
 	void *label;
 	loff_t blk_align = (pr->size % (256 * 1024ULL));
 
-	zdebug("probe_zfs\n");
+	DBG(PROBE, ul_debug("probe_zfs\n"));
 	/* Look for at least 4 uberblocks to ensure a positive match */
 	for (label_no = 0; label_no < 4; label_no++) {
 		switch(label_no) {
-- 
2.9.0

