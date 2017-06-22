Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:49515 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751154AbdFVCht (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 21 Jun 2017 22:37:49 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVJze-1dHrQS3xB0-00Yj1m for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 04:37:47 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 01/13] uuidd: remove unused define
Date: Thu, 22 Jun 2017 04:37:34 +0200
Message-Id: <1498099066-24235-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
References: <1498099066-24235-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/uuidd.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 313a4af..371975d 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -41,12 +41,6 @@
 
 #include "nls.h"
 
-#ifdef __GNUC__
-#define CODE_ATTR(x) __attribute__(x)
-#else
-#define CODE_ATTR(x)
-#endif
-
 /* length of textual representation of UUID, including trailing \0 */
 #define UUID_STR_LEN	37
 
-- 
1.8.5.6

