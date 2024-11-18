Received: from zebra.cherry.relay.mailchannels.net (zebra.cherry.relay.mailchannels.net [23.83.223.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F63014BF8F
	for <util-linux@vger.kernel.org>; Mon, 18 Nov 2024 20:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.195
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731962134; cv=pass; b=G9VPGsAsXrk/txzc7tt9/umKp+/eUbFWzmwT8XFJWxnd4Tdf4p2BHckF64Nm5+G2ORc54e6VYUT9x4emd0uCf8xqVg/fa7MRNJZa4qW8n7gQU9UGmCGLpnBMqMXU5y8/YqsJaOr7IMz7iWueplZa0QmYjjf1MO8uCCxJUIB31Hc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731962134; c=relaxed/simple;
	bh=b54kfDqZtG5bF8/NIn7ieUeCqDdpQcBTufNZLJ0aruw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KsTtqxNegaDUgszlCmsQm8OVnQzPluA2zqtWKk4iocCKKJ5xTtREEpMGHxvgJLVDnGGX3OnknUHvNc/KYpLbUMFidbW5C2scLsszgYzLw8H6SEaNrKSq/sku/ptjtXp7wO3dE7qwEjuYyJXgT6xTnG5D3Iha5IdXqMdhNhZQ2R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com; spf=pass smtp.mailfrom=templeofstupid.com; dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b=BspMUt7I; arc=pass smtp.client-ip=23.83.223.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=templeofstupid.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=templeofstupid.com header.i=@templeofstupid.com header.b="BspMUt7I"
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 788C590180D
	for <util-linux@vger.kernel.org>; Mon, 18 Nov 2024 20:35:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (100-112-192-11.trex-nlb.outbound.svc.cluster.local [100.112.192.11])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1EC99901650
	for <util-linux@vger.kernel.org>; Mon, 18 Nov 2024 20:35:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1731962124; a=rsa-sha256;
	cv=none;
	b=C2zSHaJLYuotOL2S4UsO79mvoCPazsI+2yXwoMP5e6Q0hQgllqrgXY6T5iMojRnu0s7SH0
	9HN1jRQj9/oomNg78qcFT0SesaK16h1ERKprRL8zOrJR3ttcP0sfctidtGbINnUvytynb4
	EmCGgrlB0bGhhk8abIeeW6WT1tTjnQiRgs6kU0cif7BTek98Ci5IDJzbZL9i2P07i19IDS
	Dg2ykOaV/ysTuZWQ5my3uNY7v1hbnTm9+MeS7KLZD0hOItJCiz+MwqL43CZqQyMYt5slxt
	idug2bZxcPWsLjuEb/T2QWcgDxfUWOCQJfo4xKmweGOyTUYEe1wzYUSxQVhblw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1731962124;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 dkim-signature; bh=4sRtRIcu0VlofAbGO0wyj0CL1htxk+BwyFnFJS0EarI=;
	b=17hUmBprQwvUW3I4ytRdv2SNmwTvlo/FgzSLergBgCoxylqEtRBUHa+Lf9xRq/emBC4MhR
	iw78NOuxyEiZFpEUctxzihuelHt/Ut9xeFEihu1wC0gIjecKMXYwnKtuFf6I7t4RyEproL
	ZXC4AH4NuOtnjxsjvfe/vl0YIlLyVCpDOhny/uZofMKFt0XGr4m7rmMvZsUTO8CrvjvatL
	cV9JEJN5ZNkn4tyO1kwvKY5P/yNFnJVP6/Dr1ogjrxICbbyYW3via6CZtE7XIKrGUfCoV4
	d5dOLKpRczpupTsHNUU3fxoxsbZWxOI7oa4ik8gO8SmDQqcareWuGhi+dLu37A==
ARC-Authentication-Results: i=1;
	rspamd-7456989c76-f8z67;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=kjlx@templeofstupid.com
X-Sender-Id: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|kjlx@templeofstupid.com
X-MailChannels-Auth-Id: dreamhost
X-Vacuous-Arithmetic: 0fffc5fc68ab2571_1731962124342_276354786
X-MC-Loop-Signature: 1731962124342:256200412
X-MC-Ingress-Time: 1731962124342
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.112.192.11 (trex/7.0.2);
	Mon, 18 Nov 2024 20:35:24 +0000
Received: from kmjvbox.templeofstupid.com (c-73-70-109-47.hsd1.ca.comcast.net [73.70.109.47])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kjlx@templeofstupid.com)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4XsfWv6lMbzyB
	for <util-linux@vger.kernel.org>; Mon, 18 Nov 2024 12:35:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=templeofstupid.com;
	s=dreamhost; t=1731962124;
	bh=4sRtRIcu0VlofAbGO0wyj0CL1htxk+BwyFnFJS0EarI=;
	h=Date:From:To:Cc:Subject:Content-Type;
	b=BspMUt7ISyiB0Ahwsb4810OZcNblyXMNWgNfQJQqBlCE3Ll9mJZXQXaFTivBnGNPA
	 AVtV9ZXiH8biPhJ2X01VjZfMPgWR58pyPCvT5uFIJTYeNRModGpAP+akmuvgEGs/iG
	 C2cZyV7YboiGuziOZCEXBTE687VrRpw0HuseDXoOZ58aXiARv9myE4me+vSqIasSyN
	 xW1gnWGu5yralkGvdnBQBBZ9AC4ZtrRxzcnB8aLDNE7JXlMy5+JcStc3yfleYYVroP
	 uAQ7X2RubO4YtWPCF1i5aTqLaReDsTfisyBOeqZONsGXBo7SQDALyioRqpgpOw1UB0
	 agHC1WNiZAU+Q==
Received: from johansen (uid 1000)
	(envelope-from kjlx@templeofstupid.com)
	id e00e4
	by kmjvbox.templeofstupid.com (DragonFly Mail Agent v0.12);
	Mon, 18 Nov 2024 12:35:22 -0800
Date: Mon, 18 Nov 2024 12:35:22 -0800
From: Krister Johansen <kjlx@templeofstupid.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, systemd-devel@lists.freedesktop.org,
	David Reaver <me@davidreaver.com>, Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] libblkid: fix spurious ext superblock checksum mismatches
Message-ID: <6d16e6d83ab48d2ea4402db17c9c0ed5514933a7.1731961869.git.kjlx@templeofstupid.com>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Reads of ext superblocks can race with updates.  If libblkid observes a
checksum mismatch, re-read the superblock with O_DIRECT in order to get
a consistent view of its contents.  Only if the O_DIRECT read fails the
checksum should it be reported to have failed.

This fixes a problem where devices that were named by filesystem label
failed to be found when systemd attempted to mount them on boot.  The
problem was caused by systemd-udevd using libblkid. If a read of a
superblock resulted in a checksum mismatch, udev will remove the
by-label links which result in the mount call failing to find the
device.  The checksum mismatch that was triggering the problem was
spurious, and when we use O_DIRECT, or even perform a subsequent retry,
the superblock is correctly read.  This resulted in a failure to mount
/boot in one out of every 2,000 or so attempts in our environment.

e2fsprogs fixed[1] an identical version of this bug that afflicted
resize2fs during online grow operations when run from cloud-init.  The
fix there was also to use O_DIRECT in order to read the superblock.
This patch uses a similar approach: read the superblock with O_DIRECT in
the case where a bad checksum is detected.

[1] https://lore.kernel.org/linux-ext4/20230609042239.GA1436857@mit.edu/

Signed-off-by: Krister Johansen <kjlx@templeofstupid.com>
---
 libblkid/src/blkidP.h          |  5 +++++
 libblkid/src/probe.c           | 27 +++++++++++++++++++++++++++
 libblkid/src/superblocks/ext.c | 22 ++++++++++++++++++++--
 3 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
index f71e13cb3..fa2379c4d 100644
--- a/libblkid/src/blkidP.h
+++ b/libblkid/src/blkidP.h
@@ -421,6 +421,11 @@ extern const unsigned char *blkid_probe_get_buffer(blkid_probe pr,
 			__attribute__((nonnull))
 			__attribute__((warn_unused_result));
 
+extern const unsigned char *blkid_probe_get_buffer_direct(blkid_probe pr,
+                                uint64_t off, uint64_t len)
+			__attribute__((nonnull))
+			__attribute__((warn_unused_result));
+
 extern const unsigned char *blkid_probe_get_sector(blkid_probe pr, unsigned int sector)
 			__attribute__((nonnull))
 			__attribute__((warn_unused_result));
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index 5a17e873d..e029f5649 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -791,6 +791,33 @@ const unsigned char *blkid_probe_get_buffer(blkid_probe pr, uint64_t off, uint64
 	return real_off ? bf->data + (real_off - bf->off + bias) : bf->data + bias;
 }
 
+/*
+ * This is blkid_probe_get_buffer with the read done as an O_DIRECT operation.
+ * Note that @off is offset within probing area, the probing area is defined by
+ * pr->off and pr->size.
+ */
+const unsigned char *blkid_probe_get_buffer_direct(blkid_probe pr, uint64_t off, uint64_t len)
+{
+	const unsigned char *ret = NULL;
+	int flags, rc, olderrno;
+
+	flags = fcntl(pr->fd, F_GETFL);
+	rc = fcntl(pr->fd, F_SETFL, flags | O_DIRECT);
+	if (rc) {
+		DBG(LOWPROBE, ul_debug("fcntl F_SETFL failed to set O_DIRECT"));
+		errno = 0;
+		return NULL;
+	}
+	ret = blkid_probe_get_buffer(pr, off, len);
+	olderrno = errno;
+	rc = fcntl(pr->fd, F_SETFL, flags);
+	if (rc) {
+		DBG(LOWPROBE, ul_debug("fcntl F_SETFL failed to clear O_DIRECT"));
+		errno = olderrno;
+	}
+	return ret;
+}
+
 /**
  * blkid_probe_reset_buffers:
  * @pr: prober
diff --git a/libblkid/src/superblocks/ext.c b/libblkid/src/superblocks/ext.c
index a5f34810f..7a9f8c9b9 100644
--- a/libblkid/src/superblocks/ext.c
+++ b/libblkid/src/superblocks/ext.c
@@ -156,8 +156,26 @@ static struct ext2_super_block *ext_get_super(
 		return NULL;
 	if (le32_to_cpu(es->s_feature_ro_compat) & EXT4_FEATURE_RO_COMPAT_METADATA_CSUM) {
 		uint32_t csum = crc32c(~0, es, offsetof(struct ext2_super_block, s_checksum));
-		if (!blkid_probe_verify_csum(pr, csum, le32_to_cpu(es->s_checksum)))
-			return NULL;
+		/*
+		 * A read of the superblock can race with other updates to the
+		 * same superblock.  In the unlikely event that this occurs and
+		 * we see a checksum failure, re-read the superblock with
+		 * O_DIRECT to ensure that it's consistent.  If it _still_ fails
+		 * then declare a checksum mismatch.
+		 */
+		if (!blkid_probe_verify_csum(pr, csum, le32_to_cpu(es->s_checksum))) {
+			if (blkid_probe_reset_buffers(pr))
+				return NULL;
+
+			es = (struct ext2_super_block *)
+			    blkid_probe_get_buffer_direct(pr, EXT_SB_OFF, sizeof(struct ext2_super_block));
+			if (!es)
+				return NULL;
+
+			csum = crc32c(~0, es, offsetof(struct ext2_super_block, s_checksum));
+			if (!blkid_probe_verify_csum(pr, csum, le32_to_cpu(es->s_checksum)))
+				return NULL;
+		}
 	}
 	if (fc)
 		*fc = le32_to_cpu(es->s_feature_compat);
-- 
2.25.1

