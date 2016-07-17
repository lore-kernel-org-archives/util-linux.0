Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33931 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751743AbcGQNAc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 17 Jul 2016 09:00:32 -0400
Received: by mail-wm0-f67.google.com with SMTP id q128so8791063wma.1
        for <util-linux@vger.kernel.org>; Sun, 17 Jul 2016 06:00:32 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/13] libblkid: simplify if clause [oclint]
Date: Sun, 17 Jul 2016 14:00:07 +0100
Message-Id: <20160717130015.31760-6-kerolasa@iki.fi>
In-Reply-To: <20160717130015.31760-1-kerolasa@iki.fi>
References: <20160717130015.31760-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Move negative and positive testing of 'has' variable to top level, and test
flag bit mask on second level.  This way the 'has' needs to be checked only
once.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/probe.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index d7a3ba7..43ea4c7 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -552,13 +552,11 @@ int __blkid_probe_filter_types(blkid_probe pr, int chain, int flag, char *names[
 				break;
 			}
 		}
-		if (flag & BLKID_FLTR_ONLYIN) {
-		       if (!has)
+		if (has) {
+			if (flag & BLKID_FLTR_NOTIN)
 				blkid_bmp_set_item(fltr, i);
-		} else if (flag & BLKID_FLTR_NOTIN) {
-			if (has)
-				blkid_bmp_set_item(fltr, i);
-		}
+		} else if (flag & BLKID_FLTR_ONLYIN)
+			blkid_bmp_set_item(fltr, i);
 	}
 
 	DBG(LOWPROBE, ul_debug("%s: a new probing type-filter initialized",
-- 
2.9.0

