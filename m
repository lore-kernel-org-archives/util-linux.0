Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:49463 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426394AbcBRNMx (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:12:53 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0Lkwc9-1Zvgaf1KgH-00ajPK for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:12:52 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 08/15] lib: define LOGIN_NAME_MAX fallback
Date: Thu, 18 Feb 2016 14:12:48 +0100
Message-Id: <1455801169-10470-9-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

LOGIN_NAME_MAX was unused in misc-utils/namei.c since 04a5cb58.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/idcache.c      | 4 ++++
 misc-utils/namei.c | 4 ----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/idcache.c b/lib/idcache.c
index 4cb20fd..3c358b8 100644
--- a/lib/idcache.c
+++ b/lib/idcache.c
@@ -7,6 +7,10 @@
 #include "c.h"
 #include "idcache.h"
 
+#ifndef LOGIN_NAME_MAX
+#define LOGIN_NAME_MAX 256
+#endif
+
 struct identry *get_id(struct idcache *ic, unsigned long int id)
 {
 	struct identry *ent;
diff --git a/misc-utils/namei.c b/misc-utils/namei.c
index 576e3ef..df678e0 100644
--- a/misc-utils/namei.c
+++ b/misc-utils/namei.c
@@ -44,10 +44,6 @@
 #define MAXSYMLINKS 256
 #endif
 
-#ifndef LOGIN_NAME_MAX
-#define LOGIN_NAME_MAX 256
-#endif
-
 #define NAMEI_NOLINKS	(1 << 1)
 #define NAMEI_MODES	(1 << 2)
 #define NAMEI_MNTS	(1 << 3)
-- 
1.8.4.5

