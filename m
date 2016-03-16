Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews03.kpnxchange.com ([213.75.39.6]:56087 "EHLO
	cpsmtpb-ews03.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S965454AbcCPI4f (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Wed, 16 Mar 2016 04:56:35 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/8] libfdisk: (bsd) fix spelling in warning message
Date: Wed, 16 Mar 2016 09:55:50 +0100
Message-Id: <1458118555-4691-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
References: <1458118555-4691-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 libfdisk/src/bsd.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libfdisk/src/bsd.c b/libfdisk/src/bsd.c
index 24272bc..79ba6b6 100644
--- a/libfdisk/src/bsd.c
+++ b/libfdisk/src/bsd.c
@@ -897,7 +897,7 @@ static int bsd_write_disklabel(struct fdisk_context *cxt)
 	sync_disks(cxt);
 
 	if (cxt->parent && fdisk_label_is_changed(cxt->parent->label))
-		fdisk_info(cxt, _("Disklabel written to %s (don't forget to write %s disklable too)."),
+		fdisk_info(cxt, _("Disklabel written to %s.  (Don't forget to write the %s disklabel too.)"),
 				cxt->dev_path, cxt->parent->dev_path);
 	else
 		fdisk_info(cxt, _("Disklabel written to %s."), cxt->dev_path);
-- 
1.7.0.4

