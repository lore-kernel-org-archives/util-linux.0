Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:47166 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751105AbaEZQ2G (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 26 May 2014 12:28:06 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 726B4AC0C
	for <util-linux@vger.kernel.org>; Mon, 26 May 2014 16:28:04 +0000 (UTC)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Cc: Roberto Angelino <rangelino@novell.com>,
        Holger Hetterich <hhetter@suse.com>,
        Stanislav Brabec <sbrabec@suse.cz>
Subject: [PATCH] sfdisk: suppress Linux-irrelevant warnings with -L
Date: Mon, 26 May 2014 18:28:03 +0200
Message-Id: <1401121683-18503-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Sfdisk prints out a warning about extended partition not
starting at a cylinder boundary. Since this is irrelevant
for linux, the -L option should suppress this warning.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 disk-utils/sfdisk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index 3c55d5e..12162af 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -1383,7 +1383,7 @@ extended_partition(char *dev, int fd, struct part_desc *ep, struct disk_desc *z)
 		      "from %lld to %lld\n"
 		      "(For listing purposes only. "
 		      "Do not change its contents.)"), ep->start, start);
-	} else {
+	} else if (!Linux) {
 	    warnx(_("Warning: extended partition does not start at a "
 		      "cylinder boundary.\n"
 		      "DOS and Linux will interpret the contents differently."));
-- 
1.8.4.5

