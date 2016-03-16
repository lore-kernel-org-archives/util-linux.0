Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:58554 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752984AbcCPI4G (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 04:56:06 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/8] sfdisk: improve the wording of seven error messages
Date: Wed, 16 Mar 2016 09:55:48 +0100
Message-Id: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/sfdisk.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index cc077f0..1d5050b 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -372,19 +372,19 @@ static int move_partition_data(struct sfdisk *sf, size_t partno, struct fdisk_pa
 	assert(sf->movedata);
 
 	if (!pa)
-		warnx(_("failed to read new partition from device (ignore --move-data)"));
+		warnx(_("failed to read new partition from device; ignoring --move-data"));
 	else if (!fdisk_partition_has_size(pa))
-		warnx(_("failed to get size of the new partition (ignore --move-data)"));
+		warnx(_("failed to get size of the new partition; ignoring --move-data"));
 	else if (!fdisk_partition_has_start(pa))
-		warnx(_("failed to get start of the new partition (ignore --move-data)"));
+		warnx(_("failed to get start of the new partition; ignoring --move-data"));
 	else if (!fdisk_partition_has_size(orig_pa))
-		warnx(_("failed to get size of the old partition (ignore --move-data)"));
+		warnx(_("failed to get size of the old partition; ignoring --move-data"));
 	else if (!fdisk_partition_has_start(orig_pa))
-		warnx(_("failed to get start of the old partition (ignore --move-data)"));
+		warnx(_("failed to get start of the old partition; ignoring --move-data"));
 	else if (fdisk_partition_get_start(pa) == fdisk_partition_get_start(orig_pa))
-		warnx(_("begin of the partition has not been moved (ignore --move-data)"));
+		warnx(_("start of the partition has not been moved; ignoring --move-data"));
 	else if (fdisk_partition_get_size(orig_pa) < fdisk_partition_get_size(pa))
-		warnx(_("new partition is smaller than original (ignore --move-data)"));
+		warnx(_("new partition is smaller than original; ignoring --move-data"));
 	else
 		ok = 1;
 	if (!ok)
-- 
1.7.0.4

