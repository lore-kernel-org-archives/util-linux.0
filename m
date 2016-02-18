Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:50245 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1946087AbcBRNXW (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:23:22 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MCcOw-1afmUE18CY-009P25 for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:23:20 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 15/15] include: fix sys/sysinfo.h
Date: Thu, 18 Feb 2016 14:23:19 +0100
Message-Id: <1455801799-10970-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/monotonic.c | 2 ++
 lib/timer.c     | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/monotonic.c b/lib/monotonic.c
index 372cc9c..bb58e15 100644
--- a/lib/monotonic.c
+++ b/lib/monotonic.c
@@ -4,7 +4,9 @@
  */
 #include <time.h>
 #include <signal.h>
+#ifdef HAVE_SYSINFO
 #include <sys/sysinfo.h>
+#endif
 #include <sys/time.h>
 
 #include "c.h"
diff --git a/lib/timer.c b/lib/timer.c
index 0ad0cad..6265693 100644
--- a/lib/timer.c
+++ b/lib/timer.c
@@ -5,7 +5,6 @@
  */
 #include <time.h>
 #include <signal.h>
-#include <sys/sysinfo.h>
 #include <sys/time.h>
 
 #include "c.h"
-- 
1.8.4.5

