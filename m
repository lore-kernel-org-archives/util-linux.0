Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f169.google.com ([209.85.217.169]:56555 "EHLO
	mail-lb0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752977AbaKLPtJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 12 Nov 2014 10:49:09 -0500
Received: by mail-lb0-f169.google.com with SMTP id 10so9574976lbg.14
        for <util-linux@vger.kernel.org>; Wed, 12 Nov 2014 07:49:08 -0800 (PST)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH] Minor fixes: typo, missing break in switch
Date: Wed, 12 Nov 2014 21:49:01 +0600
Message-Id: <1415807341-22405-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 disk-utils/fdisk.c               | 1 +
 libblkid/src/superblocks/nilfs.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index e5fe31b..7d6951d 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -779,6 +779,7 @@ int main(int argc, char **argv)
 			if (!lb)
 				errx(EXIT_FAILURE, _("unsupported disklabel: %s"), optarg);
 			fdisk_label_set_disabled(lb, 0);
+			break;
 		}
 		case 'u':
 			if (optarg && *optarg == '=')
diff --git a/libblkid/src/superblocks/nilfs.c b/libblkid/src/superblocks/nilfs.c
index 7b87717..3f03901 100644
--- a/libblkid/src/superblocks/nilfs.c
+++ b/libblkid/src/superblocks/nilfs.c
@@ -97,7 +97,7 @@ static int probe_nilfs2(blkid_probe pr, const struct blkid_idmag *mag)
 	/* backup */
 	sbb = (struct nilfs_super_block *) blkid_probe_get_buffer(
 			pr, ((pr->size / 0x200) - 8) * 0x200, sizeof(struct nilfs_super_block));
-	if (!sbp)
+	if (!sbb)
 		return errno ? -errno : 1;
 
 	/*
-- 
2.1.3

