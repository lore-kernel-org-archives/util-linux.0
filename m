Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45661 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751767Ab2GZOEf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 26 Jul 2012 10:04:35 -0400
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: dave@gnu.org
Subject: [PATCH 3/5] fdisk: always print total number of sectors
Date: Thu, 26 Jul 2012 16:04:26 +0200
Message-Id: <1343311468-20206-3-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
References: <1343311468-20206-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Print it no regardless on units_per_sector.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisks/fdisk.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/fdisks/fdisk.c b/fdisks/fdisk.c
index 3eddfa1..fb897d8 100644
--- a/fdisks/fdisk.c
+++ b/fdisks/fdisk.c
@@ -997,17 +997,16 @@ list_disk_geometry(struct fdisk_context *cxt) {
 	long megabytes = bytes/1000000;
 
 	if (megabytes < 10000)
-		printf(_("\nDisk %s: %ld MB, %lld bytes\n"),
+		printf(_("\nDisk %s: %ld MB, %lld bytes"),
 		       cxt->dev_path, megabytes, bytes);
 	else {
 		long hectomega = (megabytes + 50) / 100;
-		printf(_("\nDisk %s: %ld.%ld GB, %llu bytes\n"),
+		printf(_("\nDisk %s: %ld.%ld GB, %llu bytes"),
 		       cxt->dev_path, hectomega / 10, hectomega % 10, bytes);
 	}
+	printf(_(", %llu sectors\n"), cxt->total_sectors);
 	printf(_("%d heads, %llu sectors/track, %llu cylinders"),
 	       cxt->geom.heads, cxt->geom.sectors, cxt->geom.cylinders);
-	if (units_per_sector == 1)
-		printf(_(", total %llu sectors"), cxt->total_sectors);
 	printf("\n");
 	printf(_("Units = %s of %d * %ld = %ld bytes\n"),
 	       str_units(PLURAL),
-- 
1.7.7

