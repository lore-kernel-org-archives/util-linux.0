Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34164 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753934Ab1ISN3R (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 19 Sep 2011 09:29:17 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 906788EE5B
	for <util-linux@vger.kernel.org>; Mon, 19 Sep 2011 15:29:16 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/7] sfdisk: make the cylinder boundary check less fatal
Date: Mon, 19 Sep 2011 15:29:11 +0200
Message-Id: <1316438955-20790-4-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
References: <1316438955-20790-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

If the specified format is not cylinders, make the cylinder boundary
check only print a warning and proceed anyways.

Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisk/sfdisk.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 2c9de8f..820e23e 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -1313,12 +1313,14 @@ partitions_ok(struct disk_desc *z) {
 		    && (p->p.start_sect >= B.cylindersize)) {
 		    my_warn(_("Warning: partition %s does not start "
 			      "at a cylinder boundary\n"), PNO(p));
-		    return 0;
+		    if (specified_format == F_CYLINDER)
+			return 0;
 		}
 		if ((p->start + p->size) % B.cylindersize) {
 		    my_warn(_("Warning: partition %s does not end "
 			      "at a cylinder boundary\n"), PNO(p));
-		    return 0;
+		    if (specified_format == F_CYLINDER)
+			return 0;
 		}
 	    }
     }
-- 
1.7.3.4

