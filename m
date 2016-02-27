Return-Path: util-linux-owner@vger.kernel.org
Received: from plane.gmane.org ([80.91.229.3]:41621 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756529AbcB0PBF (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sat, 27 Feb 2016 10:01:05 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcuu-util-linux-ng@m.gmane.org>)
	id 1aZgMf-0000YU-T7
	for util-linux@vger.kernel.org; Sat, 27 Feb 2016 16:01:01 +0100
Received: from ppp37-190-56-35.pppoe.spdop.ru ([37.190.56.35])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 27 Feb 2016 16:01:01 +0100
Received: from yumkam by ppp37-190-56-35.pppoe.spdop.ru with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <util-linux@vger.kernel.org>; Sat, 27 Feb 2016 16:01:01 +0100
To: util-linux@vger.kernel.org
From: yumkam@gmail.com (Yuriy M. Kaminskiy)
Subject: [PATCH] lscpu: fix backward buffer size adjustment after adding delimiter
Date: Sat, 27 Feb 2016 18:00:50 +0300
Message-ID: <m3r3fymc4d.fsf@gmail.com>
Mime-Version: 1.0
Content-Type: text/x-diff
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From dfa883887123b5dd0f4230ae4aadd178bb49f4e5 Mon Sep 17 00:00:00 2001
From: "Yuriy M. Kaminskiy" <yumkam@gmail.com>
Date: Sat, 27 Feb 2016 17:55:07 +0300
Subject: [PATCH] lscpu: fix backward size buffer adjustment after adding
 delimiter

remaining buffer space was increased after adding character, instead of
decreasing
---
 sys-utils/lscpu.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/lscpu.c b/sys-utils/lscpu.c
index b169d7a..ecff1a7 100644
--- a/sys-utils/lscpu.c
+++ b/sys-utils/lscpu.c
@@ -1281,7 +1281,7 @@ get_cell_data(struct lscpu_desc *desc, int idx, int col,
 			if (j != 0) {
 				*p++ = mod->compat ? ',' : ':';
 				*p = '\0';
-				sz++;
+				sz--;
 			}
 		}
 		break;
@@ -1353,7 +1353,7 @@ get_cell_header(struct lscpu_desc *desc, int col,
 			if (i > 0) {
 				*p++ = mod->compat ? ',' : ':';
 				*p = '\0';
-				sz++;
+				sz--;
 			}
 		}
 		if (desc->ncaches)
-- 
2.1.4


