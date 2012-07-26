Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45667 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab2GZOEg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 10:04:36 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: dave@gnu.org
Subject: [PATCH 4/5] fdisk: don't print CHS geometry unless DOS compatible mode is set
Date: Thu, 26 Jul 2012 16:04:27 +0200
Message-Id: <1343311468-20206-4-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
References: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

References: http://marc.info/?l=util-linux-ng&m=134329693623430&w=2

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisks/fdisk.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index fb897d8..fa20218 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -1005,9 +1005,9 @@ list_disk_geometry(struct fdisk_context *cxt) {
 		       cxt->dev_path, hectomega / 10, hectomega % 10, bytes);
 	}
 	printf(_(", %llu sectors\n"), cxt->total_sectors);
-	printf(_("%d heads, %llu sectors/track, %llu cylinders"),
-	       cxt->geom.heads, cxt->geom.sectors, cxt->geom.cylinders);
-	printf("\n");
+	if (dos_compatible_flag)
+		printf(_("%d heads, %llu sectors/track, %llu cylinders\n"),
+		       cxt->geom.heads, cxt->geom.sectors, cxt->geom.cylinders);
 	printf(_("Units = %s of %d * %ld = %ld bytes\n"),
 	       str_units(PLURAL),
 	       units_per_sector, cxt->sector_size, units_per_sector * cxt->sector_size);
-- 
1.7.7

