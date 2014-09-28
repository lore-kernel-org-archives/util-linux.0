Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:63124 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753049AbaI1Twk (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:52:40 -0400
Received: by mail-wg0-f47.google.com with SMTP id b13so752946wgh.18
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:52:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 12/23] libblkid: use pre-processor to optimize out code
Date: Sun, 28 Sep 2014 20:51:45 +0100
Message-Id: <1411933916-30576-13-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/superblocks/zfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/libblkid/src/superblocks/zfs.c b/libblkid/src/superblocks/zfs.c
index 6ffa24d..088d110 100644
--- a/libblkid/src/superblocks/zfs.c
+++ b/libblkid/src/superblocks/zfs.c
@@ -156,7 +156,6 @@ static void zfs_extract_guid_name(blkid_probe pr, loff_t offset)
 	}
 }
 
-#define zdebug(fmt, ...)	do {} while(0)
 /*#define zdebug(fmt, a...)	fprintf(stderr, fmt, ##a)*/
 
 /* ZFS has 128x1kB host-endian root blocks, stored in 2 areas at the start
@@ -172,7 +171,9 @@ static int probe_zfs(blkid_probe pr,
 	int tried;
 	int found;
 
+#ifdef zdebug
 	zdebug("probe_zfs\n");
+#endif
 	/* Look for at least 4 uberblocks to ensure a positive match */
 	for (tried = found = 0, offset = VDEV_LABEL_UBERBLOCK;
 	     tried < ZFS_TRIES && found < ZFS_WANT;
@@ -196,9 +197,10 @@ static int probe_zfs(blkid_probe pr,
 			ub_offset = offset;
 			found++;
 		}
-
+#ifdef zdebug
 		zdebug("probe_zfs: found %s-endian uberblock at %llu\n",
 		       swab_endian ? "big" : "little", offset >> 10);
+#endif
 	}
 
 	if (found < 4)
-- 
2.1.1

