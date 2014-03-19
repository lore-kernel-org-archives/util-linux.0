Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:59884 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933951AbaCSNvE (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 19 Mar 2014 09:51:04 -0400
From: Hannes Reinecke <hare@suse.de>
To: Karel Zak <kzak@redhat.com>
Cc: Werner Fink <werner@suse.de>, Stanislav Brabec <sbrabec@suse.com>,
        <util-linux@vger.kernel.org>, Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/2] blkid: stop scanning on I/O error
Date: Wed, 19 Mar 2014 14:50:55 +0100
Message-Id: <1395237056-26595-2-git-send-email-hare@suse.de>
In-Reply-To: <1395237056-26595-1-git-send-email-hare@suse.de>
References: <1395237056-26595-1-git-send-email-hare@suse.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Whenever we fail to read from a device it's pointless to
continue with probing; we should be failing immediately.
Otherwise the system will continue logging I/O errors.

This patch updates the probe functions to return -1
on I/O error and 1 if not found.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 libblkid/src/partitions/partitions.c   | 13 +++++++++----
 libblkid/src/probe.c                   | 13 +++++++++++--
 libblkid/src/superblocks/superblocks.c | 13 ++++++++++---
 3 files changed, 30 insertions(+), 9 deletions(-)

diff --git a/libblkid/src/partitions/partitions.c b/libblkid/src/partitions/partitions.c
index d9419f2..53e5009 100644
--- a/libblkid/src/partitions/partitions.c
+++ b/libblkid/src/partitions/partitions.c
@@ -540,7 +540,8 @@ static int idinfo_probe(blkid_probe pr, const struct blkid_idinfo *id,
 	if (pr->size <= 0 || (id->minsz && id->minsz > pr->size))
 		goto nothing;	/* the device is too small */
 
-	if (blkid_probe_get_idmag(pr, id, &off, &mag))
+	rc = blkid_probe_get_idmag(pr, id, &off, &mag);
+	if (rc != 0)
 		goto nothing;
 
 	/* final check by probing function */
@@ -548,12 +549,13 @@ static int idinfo_probe(blkid_probe pr, const struct blkid_idinfo *id,
 		DBG(LOWPROBE, blkid_debug(
 			"%s: ---> call probefunc()", id->name));
 		rc = id->probefunc(pr, mag);
-	        if (rc == -1) {
+		if (rc != 0) {
 			/* reset after error */
 			reset_partlist(blkid_probe_get_partlist(pr));
 			if (chn && !chn->binary)
 				blkid_probe_chain_reset_vals(pr, chn);
-			DBG(LOWPROBE, blkid_debug("%s probefunc failed", id->name));
+			DBG(LOWPROBE, blkid_debug("%s probefunc failed, rc %d",
+						  id->name, rc));
 		}
 		if (rc == 0 && mag && chn && !chn->binary)
 			rc = blkid_probe_set_magic(pr, off, mag->len,
@@ -599,7 +601,10 @@ static int partitions_probe(blkid_probe pr, struct blkid_chain *chn)
 			continue;
 
 		/* apply checks from idinfo */
-		if (idinfo_probe(pr, idinfos[i], chn) != 0)
+		rc = idinfo_probe(pr, idinfos[i], chn);
+		if (rc < 0)
+			return rc;
+		if (rc > 0)
 			continue;
 
 		name = idinfos[i]->name;
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index e20c61b..f33fd85 100644
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
+			errno = 0;
 			return NULL;
+		}
 
 		bf->data = ((unsigned char *) bf) + sizeof(struct blkid_bufinfo);
 		bf->len = len;
@@ -587,7 +591,10 @@ unsigned char *blkid_probe_get_buffer(blkid_probe pr,
 
 		ret = read(pr->fd, bf->data, len);
 		if (ret != (ssize_t) len) {
+			DBG(LOWPROBE, blkid_debug("\tbuffer read: return %d error %d", ret, errno));
 			free(bf);
+			if (ret >= 0 || errno != EIO)
+				errno = 0;
 			return NULL;
 		}
 		list_add_tail(&bf->bufs, &pr->buffers);
@@ -794,6 +801,8 @@ int blkid_probe_get_idmag(blkid_probe pr, const struct blkid_idinfo *id,
 		off = (mag->kboff + (mag->sboff >> 10)) << 10;
 		buf = blkid_probe_get_buffer(pr, off, 1024);
 
+		if (!buf && errno)
+			return -1;
 		if (buf && !memcmp(mag->magic,
 				buf + (mag->sboff & 0x3ff), mag->len)) {
 			DBG(LOWPROBE, blkid_debug("\tmagic sboff=%u, kboff=%ld",
diff --git a/libblkid/src/superblocks/superblocks.c b/libblkid/src/superblocks/superblocks.c
index c6394c4..35cfd50 100644
--- a/libblkid/src/superblocks/superblocks.c
+++ b/libblkid/src/superblocks/superblocks.c
@@ -379,15 +379,22 @@ static int superblocks_probe(blkid_probe pr, struct blkid_chain *chn)
 
 		DBG(LOWPROBE, blkid_debug("[%zd] %s:", i, id->name));
 
-		if (blkid_probe_get_idmag(pr, id, &off, &mag))
+		rc = blkid_probe_get_idmag(pr, id, &off, &mag);
+		if (rc < 0)
+			break;
+		if (rc > 0)
 			continue;
 
 		/* final check by probing function */
 		if (id->probefunc) {
 			DBG(LOWPROBE, blkid_debug("\tcall probefunc()"));
-			if (id->probefunc(pr, mag) != 0) {
+			rc = id->probefunc(pr, mag);
+			if (rc != 0) {
 				blkid_probe_chain_reset_vals(pr, chn);
-				continue;
+				if (rc < 0)
+					break;
+				else
+					continue;
 			}
 		}
 
-- 
1.7.12.4

