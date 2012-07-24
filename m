Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:34316 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753305Ab2GXLxA (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 24 Jul 2012 07:53:00 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id BF3ECA3F4A
	for <util-linux@vger.kernel.org>; Tue, 24 Jul 2012 13:52:59 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 2/2] fdisk: return success from sgi_create_disklabel
Date: Tue, 24 Jul 2012 13:52:32 +0200
Message-Id: <1343130752-6626-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1343130752-6626-1-git-send-email-petr.uzel@suse.cz>
References: <1343130752-6626-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 fdisks/fdisksgilabel.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/fdisks/fdisksgilabel.c b/fdisks/fdisksgilabel.c
index af0ad14..2596a21 100644
--- a/fdisks/fdisksgilabel.c
+++ b/fdisks/fdisksgilabel.c
@@ -840,6 +840,7 @@ static int sgi_create_disklabel(struct fdisk_context *cxt)
 			sgi_set_partition(cxt, i, old[i].start, old[i].nsect, old[i].sysid);
 		}
 	}
+	return 0;
 }
 
 void
-- 
1.7.10.4

