Received: from out-2uec-a98.jellyfish.systems (out-2uec-a98.jellyfish.systems [63.250.43.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5491825B08D
	for <util-linux@vger.kernel.org>; Wed, 16 Sep 2026 18:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789581713; cv=none; b=q8A6f41RN5nGitJm6XD5B7+rx8sK0PESITearawFei3h2PYeaNCZaV64FPsjQO/yUycRy8do/1999HaILPJp69dZBwQrh/Pz9cuKdtcN+iocH5zOqKZD5Ai4H8Z8qOiZqEyq0vgIm5mYL5Her4vQIaO35r+eYb5k2gED7EiD3XU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789581713; c=relaxed/simple;
	bh=R2AZLzM4Q4COr9dfnutIsmmp0JDVD6q6OkkKYGLyMGw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JcxrrmyGoC3gUWS40EeABHjRd6FGIAgaR8h5X6ES0iuEgudEPqaLPkZqsarmbPj97w9rnm4HlMfqAXxWUBU+tjG7I+mQRbpTh4HnWnRgLZBYKJAhPrOwUVRCLzA6QlWCx6T6CfFoj1LtdK6gnXuaCSUueCwpgTGPT6I7m5/QjC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc; spf=pass smtp.mailfrom=tychen.cc; dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b=m97ulzlP; arc=none smtp.client-ip=63.250.43.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tychen.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tychen.cc
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tychen.cc header.i=@tychen.cc header.b="m97ulzlP"
Received: from fedora (unknown [117.147.120.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4hlQHr3s57z2x99;
	Wed, 16 Sep 2026 17:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tychen.cc;
	s=spacemail; t=1789578331;
	bh=v+9WfHNiBMoOm1R/qtnE/pPEDkfV3lGZsNv66+eImbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m97ulzlP2zqMkEQ/bWaRBv/wjve/xhaCKVBMun20nKZoYf/tY0ush5iywQ6NhDCXL
	 Jfbks8b00/z3tsuUjNwNFtna4hd/x+BYomt2eBdpmTdx2qKIdK7EIZPxyCpyzSGjoC
	 IqQMyA/G93vutsRIuz6rpEsVAqahBNKvX2Z5gAyOXmVo763XcdvBO1K4L8LSErMQ9X
	 uY1YAAJ9a7FFU94rsi37oSQBkUxFQZ9JAaoLS0s3fmUEiQgkD7zS1hOQGYgDREXoMd
	 +dTyNjrgyinMeMcFuQG7QH/ikQCi0ffGCLgmtRj94dyYLV+2dyUrMPCPPGrVonOvyp
	 GcpuQbZuI6mAA==
From: Tianyi Chen <hi@tychen.cc>
To: util-linux@vger.kernel.org
Cc: kzak@redhat.com
Subject: [PATCH 2/3] libfdisk: limit resized DOS extended partitions to two sectors
Date: Thu, 17 Sep 2026 01:05:13 +0800
Message-ID: <20260916170514.2595842-3-hi@tychen.cc>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916170514.2595842-1-hi@tychen.cc>
References: <20260916170514.2595842-1-hi@tychen.cc>
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: hi@tychen.cc

The kernel represents a DOS extended partition with at most two 512-byte
sectors. Passing its full on-disk size to BLKPG_RESIZE_PARTITION can
therefore overlap its logical partitions and fail with EBUSY.

Apply the same size limit when resizing as when adding an extended
partition, keeping its kernel representation consistent.

Assisted-by: LLM
Signed-off-by: Tianyi Chen <hi@tychen.cc>
---
 libfdisk/src/context.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index f06667c6..045c3ea5 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -1026,10 +1026,16 @@ int fdisk_reread_changes(struct fdisk_context *cxt, struct fdisk_table *org)
 		}
 	}
 	for (i = 0; i < nupds; i++) {
+		uint64_t sz;
+
 		pa = upd[i];
+		sz = pa->size * ssf;
+		if (fdisk_is_label(cxt, DOS) && fdisk_partition_is_container(pa))
+			sz = min(sz, (uint64_t) 2);
+
 		DBG_OBJ(PART, pa, ul_debug("#%zu calling BLKPG_RESIZE_PARTITION", pa->partno));
 		if (partx_resize_partition(cxt->dev_fd, pa->partno + 1,
-					   pa->start * ssf, pa->size * ssf) != 0) {
+					   pa->start * ssf, sz) != 0) {
 			fdisk_warn(cxt, _("Failed to update system information about partition %zu"), pa->partno + 1);
 			err++;
 		}
-- 
2.55.0

