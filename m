Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:53326 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755606Ab2ISJsv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 19 Sep 2012 05:48:51 -0400
From: Thierry Reding <thierry.reding@avionic-design.de>
To: Karel Zak <kzak@redhat.com>
Cc: util-linux@vger.kernel.org
Subject: [PATCH] sfdisk: Fix format specifiers for size_t
Date: Wed, 19 Sep 2012 11:48:46 +0200
Message-Id: <1348048126-31365-1-git-send-email-thierry.reding@avionic-design.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The proper specifier for size_t is %zu. %lu will work fine on 64-bit
architectures but not on 32-bit.

Signed-off-by: Thierry Reding <thierry.reding@avionic-design.de>
---
 fdisks/sfdisk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index 2027202..da5c606 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -1426,7 +1426,7 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 	cp = s->data + 0x1be;
 
 	if (pno + 4 >= ARRAY_SIZE(z->partitions)) {
-	    warnx(_("too many partitions - ignoring those past nr (%ld)\n"),
+	    warnx(_("too many partitions - ignoring those past nr (%zu)\n"),
 		    pno - 1);
 	    break;
 	}
@@ -1504,7 +1504,7 @@ bsd_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z) {
     while (bp - bp0 < BSD_MAXPARTITIONS && bp - bp0 < l->d_npartitions) {
 	if (pno + 1 >= ARRAY_SIZE(z->partitions)) {
 	    warnx(_("too many partitions - ignoring those "
-		      "past nr (%ld)\n"), pno - 1);
+		      "past nr (%zu)\n"), pno - 1);
 	    break;
 	}
 	if (bp->p_fstype != BSD_FS_UNUSED) {
-- 
1.7.12

