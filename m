Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews07.kpnxchange.com ([213.75.39.10]:61114 "EHLO
	cpsmtpb-ews07.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751605AbbBAOBH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 1 Feb 2015 09:01:07 -0500
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/8] cfdisk: punctuate the bottombar messages consistently
Date: Sun,  1 Feb 2015 15:00:08 +0100
Message-Id: <1422799213-16717-3-git-send-email-bensberg@justemail.net>
In-Reply-To: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
References: <1422799213-16717-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Also adjust the style of two comments and add another.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index f414f55..eb3141b 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1923,7 +1923,7 @@ static int main_menu_action(struct cfdisk *cf, int key)
 			info = _("Partition %zu has been deleted.");
 		ref = 1;
 		break;
-	case 'h': /* help */
+	case 'h': /* Help */
 		ui_help();
 		ref = 1;
 		break;
@@ -1989,13 +1989,13 @@ static int main_menu_action(struct cfdisk *cf, int key)
 			info = _("The type of partition %zu is unchanged.");
 		break;
 	}
-	case 's': /* fix order */
+	case 's': /* Sort */
 		if (cf->wrong_order) {
 			fdisk_reorder_partitions(cf->cxt);
 			ref = 1;
 		}
 		break;
-	case 'u':
+	case 'u': /* dUmp */
 		ui_script_write(cf);
 		break;
 	case 'W': /* Write */
@@ -2003,7 +2003,7 @@ static int main_menu_action(struct cfdisk *cf, int key)
 		char buf[64] = { 0 };
 
 		if (fdisk_is_readonly(cf->cxt)) {
-			warn = _("Device open in read-only mode");
+			warn = _("Device is open in read-only mode.");
 			break;
 		}
 
@@ -2016,12 +2016,12 @@ static int main_menu_action(struct cfdisk *cf, int key)
 		ref = 1;
 		if (rc <= 0 || (strcasecmp(buf, "yes") != 0 &&
 				strcasecmp(buf, _("yes")) != 0)) {
-			info = _("Did not write partition table to disk");
+			info = _("Did not write partition table to disk.");
 			break;
 		}
 		rc = fdisk_write_disklabel(cf->cxt);
 		if (rc)
-			warn = _("Failed to write disklabel");
+			warn = _("Failed to write disklabel.");
 		else {
 			fdisk_reread_partition_table(cf->cxt);
 			info = _("The partition table has been altered.");
-- 
1.7.0.4

