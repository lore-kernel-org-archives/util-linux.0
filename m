Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f47.google.com ([209.85.220.47]:44436 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751634AbaANVUT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 14 Jan 2014 16:20:19 -0500
Received: by mail-pa0-f47.google.com with SMTP id kp14so185215pab.20
        for <util-linux@vger.kernel.org>; Tue, 14 Jan 2014 13:20:18 -0800 (PST)
From: Michael Marineau <michael.marineau@coreos.com>
To: util-linux@vger.kernel.org
Cc: Michael Marineau <michael.marineau@coreos.com>
Subject: [PATCH 1/2] libblkid: add PARTTYPE tag
Date: Tue, 14 Jan 2014 13:19:49 -0800
Message-Id: <1389734390-32485-1-git-send-email-michael.marineau@coreos.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add PARTTYPE to make searching for devices partition possible without
dropping to the low-level probe API and searching all devices by
PART_ENTRY_TYPE. For example to find any 'EFI System Partition' devices:

$ blkid -t PARTTYPE=c12a7328-f81f-11d2-ba4b-00a0c93ec93b
---
 libblkid/src/verify.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libblkid/src/verify.c b/libblkid/src/verify.c
index 1c0ca0f..eac613e 100644
--- a/libblkid/src/verify.c
+++ b/libblkid/src/verify.c
@@ -38,6 +38,8 @@ static void blkid_probe_to_tags(blkid_probe pr, blkid_dev dev)
 				blkid_set_tag(dev, "PARTUUID", data, len);
 			else if (strcmp(name, "PART_ENTRY_NAME") == 0)
 				blkid_set_tag(dev, "PARTLABEL", data, len);
+			else if (strcmp(name, "PART_ENTRY_TYPE") == 0)
+				blkid_set_tag(dev, "PARTTYPE", data, len);
 
 		} else if (!strstr(name, "_ID")) {
 			/* superblock UUID, LABEL, ...
-- 
1.8.3.2

