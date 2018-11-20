Return-Path: <SRS0=gIzA=N7=vger.kernel.org=util-linux-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B29FC41536
	for <util-linux@archiver.kernel.org>; Tue, 20 Nov 2018 16:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8A9220684
	for <util-linux@archiver.kernel.org>; Tue, 20 Nov 2018 16:11:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="MFJDOhNI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8A9220684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=util-linux-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727682AbeKUCl2 (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Tue, 20 Nov 2018 21:41:28 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37991 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbeKUCl2 (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 20 Nov 2018 21:41:28 -0500
Received: by mail-wr1-f65.google.com with SMTP id e3-v6so2581978wrs.5
        for <util-linux@vger.kernel.org>; Tue, 20 Nov 2018 08:11:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WJKduIhDw1ewzkdtRmPfNdjZAMcsjY1uHSuxLAWeWRg=;
        b=MFJDOhNI1XL8XvvaoB/2bzXbjfeJftO06OF9BfpVCACzXa4nV38Z3bns9eGcJIsV8n
         czMEyj/i8VGzNLUK8VOMlIhCOnhAVX8Vnhrp7qzc1Hg6nT4BNHDJHlhDXfn32Pw1icEW
         ULDXWS08bCC32Ip9UvL4m0eva2Nl0wur773Thu833ccpiycgAFyKS9wbVIEoPAfpewTV
         LMs084gogFj9Ud2s43sC+uFrk64vfTIgykJcFUVFxy+p7cbz9cUohnkr3I68tct0nRnA
         V0Gh8ioOzt8kqjOOScw0pA4jmrv4fM0Xz9WUJegkOLSeHz6tG7EmYClLbshHAdEiF5vC
         o1ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WJKduIhDw1ewzkdtRmPfNdjZAMcsjY1uHSuxLAWeWRg=;
        b=kgd7PuIgMd3R4bzqJkS8bgLS8LQ+Y3HwuDLx4UICcvf2Begjuut556aHTnz0Y77SYo
         Ddi4Yb7co2bKVbZD2VyhYey24lu8kp3so3DYPQd+BeK3toX6Ojd9U2O4aFpW7zDLoPqs
         s4D9j8MT59svCFoZL4+K52wu8tYCucTrKQD4KbUdXSMGgcS3k8LJc19UpLu+7w0fUfAv
         bvZHvuUWlSSk7wPelnGWCoc1DpHxk+gfRLJWzaAZnge6GEMhamY1JcAySp4L1vcb/gR6
         yAc7Nhy3VRHy6VXWC1Qkc0IrknwgpMSx0kYR+VSoZea7LuFLvEmY/jaUKEV6Sval5/dW
         pmjg==
X-Gm-Message-State: AA+aEWblhReXo6X6zOs4fPLo5RLp+BYk7YghwUmOjH77vL4GMZPpXyRs
        WrrKUqTzphnSgeCWkzNz9GMS9H3ngYk=
X-Google-Smtp-Source: AFSGD/Xz/v9xUsexI6jb81Cml6GuPf6fuM7Bq+SDthXeeQESAAxZU+ccMnRIIk7siTqkvb001Z5D6A==
X-Received: by 2002:adf:8342:: with SMTP id 60mr2427665wrd.212.1542730292713;
        Tue, 20 Nov 2018 08:11:32 -0800 (PST)
Received: from aperol.linbit. (212-186-191-219.static.upcbusiness.at. [212.186.191.219])
        by smtp.gmail.com with ESMTPSA id e8-v6sm85223369wmf.22.2018.11.20.08.11.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Nov 2018 08:11:30 -0800 (PST)
From:   Roland Kammerer <roland.kammerer@linbit.com>
To:     util-linux@vger.kernel.org
Cc:     Roland Kammerer <roland.kammerer@linbit.com>
Subject: [PATCH 1/1] libblkid: add check for DRBD9
Date:   Tue, 20 Nov 2018 17:10:49 +0100
Message-Id: <20181120161049.5687-1-roland.kammerer@linbit.com>
X-Mailer: git-send-email 2.18.0
Sender: util-linux-owner@vger.kernel.org
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

This adds the according meta-data structs + defines and an additional
function to detect DRBD9 magics.

Signed-off-by: Roland Kammerer <roland.kammerer@linbit.com>
---
 libblkid/src/superblocks/drbd.c | 111 ++++++++++++++++++++++++++++++--
 1 file changed, 107 insertions(+), 4 deletions(-)

diff --git a/libblkid/src/superblocks/drbd.c b/libblkid/src/superblocks/drbd.c
index e88e9f353..4ebaf1739 100644
--- a/libblkid/src/superblocks/drbd.c
+++ b/libblkid/src/superblocks/drbd.c
@@ -25,10 +25,12 @@
 
 /*
  * user/drbdmeta.c
- * We only support v08 for now
+ * We support v08 and v09
  */
 #define DRBD_MD_MAGIC_08         (DRBD_MAGIC+4)
 #define DRBD_MD_MAGIC_84_UNCLEAN (DRBD_MAGIC+5)
+#define DRBD_MD_MAGIC_09         (DRBD_MAGIC+6)
+/* there is no DRBD_MD_MAGIC_09_UNCLEAN */
 
 /*
  * drbd/linux/drbd.h
@@ -44,7 +46,7 @@ enum drbd_uuid_index {
 };
 
 /*
- * user/drbdmeta.c
+ * user/shared/drbdmeta.c
  * Minor modifications wrt. types
  */
 struct md_on_disk_08 {
@@ -64,9 +66,54 @@ struct md_on_disk_08 {
 	char reserved[8 * 512 - (8*(UI_SIZE+3)+4*11)];
 };
 
+/*
+ * linux/drbd.h, v9 only
+ */
+#define DRBD_PEERS_MAX 32
+#define HISTORY_UUIDS DRBD_PEERS_MAX
 
-static int probe_drbd(blkid_probe pr,
-		const struct blkid_idmag *mag __attribute__((__unused__)))
+/*
+ * drbd-headers/drbd_meta_data.h
+ * Minor modifications wrt. types
+ */
+struct peer_dev_md_on_disk_9 {
+	uint64_t bitmap_uuid;
+	uint64_t bitmap_dagtag;
+	uint32_t flags;
+	int32_t bitmap_index;
+	uint32_t reserved_u32[2];
+} __attribute__((packed));
+
+struct meta_data_on_disk_9 {
+	uint64_t effective_size;    /* last agreed size */
+	uint64_t current_uuid;
+	uint64_t reserved_u64[4];   /* to have the magic at the same position as in v07, and v08 */
+	uint64_t device_uuid;
+	uint32_t flags;             /* MDF */
+	uint32_t magic;
+	uint32_t md_size_sect;
+	uint32_t al_offset;         /* offset to this block */
+	uint32_t al_nr_extents;     /* important for restoring the AL */
+	uint32_t bm_offset;         /* offset to the bitmap, from here */
+	uint32_t bm_bytes_per_bit;  /* BM_BLOCK_SIZE */
+	uint32_t la_peer_max_bio_size;   /* last peer max_bio_size */
+	uint32_t bm_max_peers;
+	int32_t node_id;
+
+	/* see al_tr_number_to_on_disk_sector() */
+	uint32_t al_stripes;
+	uint32_t al_stripe_size_4k;
+
+	uint32_t reserved_u32[2];
+
+	struct peer_dev_md_on_disk_9 peers[DRBD_PEERS_MAX];
+	uint64_t history_uuids[HISTORY_UUIDS];
+
+	char padding[0] __attribute__((aligned(4096)));
+} __attribute__((packed));
+
+
+static int probe_drbd_84(blkid_probe pr)
 {
 	struct md_on_disk_08 *md;
 	off_t off;
@@ -107,6 +154,62 @@ static int probe_drbd(blkid_probe pr,
 	return 0;
 }
 
+static int probe_drbd_90(blkid_probe pr)
+{
+	struct meta_data_on_disk_9 *md;
+	off_t off;
+
+	off = pr->size - sizeof(*md);
+
+	/*
+	 * Smaller ones are certainly not DRBD9 devices.
+	 * Recent utils even refuse to generate larger ones,
+	 * keep this as a sufficient lower bound.
+	 */
+	if (pr->size < 0x10000)
+		return 1;
+
+	md = (struct meta_data_on_disk_9 *)
+			blkid_probe_get_buffer(pr,
+					off,
+					sizeof(struct meta_data_on_disk_9));
+	if (!md)
+		return errno ? -errno : 1;
+
+	if (be32_to_cpu(md->magic) != DRBD_MD_MAGIC_09)
+		return 1;
+
+	/*
+	 * DRBD does not have "real" uuids; the following resembles DRBD's
+	 * notion of uuids (64 bit, see struct above)
+	 */
+	blkid_probe_sprintf_uuid(pr,
+		(unsigned char *) &md->device_uuid, sizeof(md->device_uuid),
+		"%" PRIx64, be64_to_cpu(md->device_uuid));
+
+	blkid_probe_set_version(pr, "v09");
+
+	if (blkid_probe_set_magic(pr,
+				off + offsetof(struct meta_data_on_disk_9, magic),
+				sizeof(md->magic),
+				(unsigned char *) &md->magic))
+		return 1;
+
+	return 0;
+}
+
+static int probe_drbd(blkid_probe pr,
+		const struct blkid_idmag *mag __attribute__((__unused__)))
+{
+	int ret;
+
+	ret = probe_drbd_84(pr);
+	if (ret <= 0) /* success or fatal (-errno) */
+		return ret;
+
+	return probe_drbd_90(pr);
+}
+
 const struct blkid_idinfo drbd_idinfo =
 {
 	.name		= "drbd",
-- 
2.18.0

