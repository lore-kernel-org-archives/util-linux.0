Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34162 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753172Ab1ISN3Q (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 Sep 2011 09:29:16 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 315A48F29D
	for <util-linux@vger.kernel.org>; Mon, 19 Sep 2011 15:29:16 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/7] sfdisk: fix weird indentation in msdos_partition()
Date: Mon, 19 Sep 2011 15:29:10 +0200
Message-Id: <1316438955-20790-3-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
References: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.c |   11 +++++------
 1 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 81a50ee..2c9de8f 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -1550,14 +1550,13 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 	do_warn(_("detected Disk Manager - unable to handle that\n"));
 	return 0;
     }
-    {
-	unsigned int sig = *(unsigned short *)(s->data + 2);
-	if (sig <= 0x1ae
-	    && *(unsigned short *)(s->data + sig) == 0x55aa
-	    && (1 & *(unsigned char *)(s->data + sig + 2))) {
+
+    unsigned int sig = *(unsigned short *)(s->data + 2);
+    if (sig <= 0x1ae
+	&& *(unsigned short *)(s->data + sig) == 0x55aa
+	&& (1 & *(unsigned char *)(s->data + sig + 2))) {
 	    do_warn(_("DM6 signature found - giving up\n"));
 	    return 0;
-	}
     }
 
     for (pno = 0; pno < 4; pno++, cp += sizeof(struct partition)) {
-- 
1.7.3.4

