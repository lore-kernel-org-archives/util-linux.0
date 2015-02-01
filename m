Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews09.kpnxchange.com ([213.75.39.14]:53576 "EHLO
	cpsmtpb-ews09.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605AbbBAOBZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Feb 2015 09:01:25 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 6/8] libfdisk: actually translate the human-readable name of the partition type
Date: Sun,  1 Feb 2015 15:00:11 +0100
Message-Id: <1422799213-16717-6-git-send-email-bensberg@justemail.net>
In-Reply-To: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 libfdisk/src/partition.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libfdisk/src/partition.c b/libfdisk/src/partition.c
index 9a02993..5b27d3a 100644
--- a/libfdisk/src/partition.c
+++ b/libfdisk/src/partition.c
@@ -735,7 +735,7 @@ int fdisk_partition_to_string(struct fdisk_partition *pa,
 		rc = asprintf(&p, "%ju", pa->cpg);
 		break;
 	case FDISK_FIELD_TYPE:
-		p = pa->type && pa->type->name ? strdup(pa->type->name) : NULL;
+		p = pa->type && pa->type->name ? strdup(_(pa->type->name)) : NULL;
 		break;
 	case FDISK_FIELD_TYPEID:
 		if (pa->type && fdisk_parttype_get_string(pa->type))
-- 
1.7.0.4

