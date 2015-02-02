Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:58169 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753260AbbBBUoi (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Feb 2015 15:44:38 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH] libfdisk: (dos) make a helpful message fit within 80 characters
Date: Mon,  2 Feb 2015 21:44:34 +0100
Message-Id: <1422909874-7510-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also add a hint for translators.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 libfdisk/src/dos.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/libfdisk/src/dos.c b/libfdisk/src/dos.c
index 8257d19..05dd6be 100644
--- a/libfdisk/src/dos.c
+++ b/libfdisk/src/dos.c
@@ -1581,11 +1581,9 @@ static int dos_add_partition(struct fdisk_context *cxt,
 			}
 			rc = add_logical(cxt, pa, &res);
 		} else {
-			fdisk_info(cxt,
-			     _(	"Impossible to create another primary partition. "
-				"If you want to create more partitions, you must "
-				"replace a primary partition with an extended "
-				"partition first."));
+			/* TRANSLATORS: Try to keep this within 80 characters. */
+			fdisk_info(cxt, _("To create more partitions, first replace "
+					  "a primary with an extended partition."));
 			return -EINVAL;
 		}
 	} else if (cxt->label->nparts_max >= MAXIMUM_PARTS) {
-- 
1.7.0.4

