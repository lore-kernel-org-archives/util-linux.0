Return-Path: util-linux-owner@vger.kernel.org
Received: from caiajhbdccac.dreamhost.com ([208.97.132.202]:40622 "EHLO
	homiemail-a62.g.dreamhost.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1757509Ab2FQQKJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 17 Jun 2012 12:10:09 -0400
Subject: [PATCH 2/9] fdisk: API: add topology debug
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
To: Karel Zak <kzak@redhat.com>, Petr Uzel <petr.uzel@suse.cz>
Cc: util-linux <util-linux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 17 Jun 2012 18:10:04 +0200
Message-ID: <1339949404.2668.14.camel@offbook>
Mime-Version: 1.0
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Davidlohr Bueso <dave@gnu.org>

Signed-off-by: Davidlohr Bueso <dave@gnu.org>
---
 fdisk/fdisk.h |    1 +
 fdisk/utils.c |    5 +++++
 2 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/fdisk/fdisk.h b/fdisk/fdisk.h
index c645b24..9d17cdd 100644
--- a/fdisk/fdisk.h
+++ b/fdisk/fdisk.h
@@ -35,6 +35,7 @@
 /* fdisk debugging flags/options */
 #define FDISK_DEBUG_INIT	(1 << 1)
 #define FDISK_DEBUG_CONTEXT	(1 << 2)
+#define FDISK_DEBUG_TOPOLOGY    (1 << 3)
 #define FDISK_DEBUG_ALL		0xFFFF
 
 # define ON_DBG(m, x)	do { \
diff --git a/fdisk/utils.c b/fdisk/utils.c
index 5bb4984..d105d8e 100644
--- a/fdisk/utils.c
+++ b/fdisk/utils.c
@@ -85,6 +85,11 @@ static int __discover_topology(struct fdisk_context *cxt)
 	if (!cxt->phy_sector_size) /* could not discover physical size */
 		cxt->phy_sector_size = cxt->sector_size;
 
+	DBG(TOPOLOGY, dbgprint("topology discovered for %s:\n"
+			       "\tlogical/physical sector sizes: %ld/%ld\n"
+			       "\tfdisk/minimal/optimal io sizes: %ld/%ld/%ld\n",
+			       cxt->dev_path, cxt->sector_size, cxt->phy_sector_size,
+			       cxt->io_size, cxt->optimal_io_size, cxt->min_io_size));
 	return 0;
 }
 
-- 
1.7.4.1




