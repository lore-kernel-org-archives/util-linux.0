Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f172.google.com ([209.85.192.172]:36471 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753945AbbDWEuD (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 23 Apr 2015 00:50:03 -0400
Received: by pdea3 with SMTP id a3so7901950pde.3
        for <util-linux@vger.kernel.org>; Wed, 22 Apr 2015 21:50:02 -0700 (PDT)
From: Isaac Dunham <ibid.ag@gmail.com>
To: util-linux@vger.kernel.org
Cc: Isaac Dunham <ibid.ag@gmail.com>
Subject: [PATCH] hwclock: avoid UB if TZUTC is unset; include sys/time.h for timeval
Date: Wed, 22 Apr 2015 21:49:52 -0700
Message-Id: <1429764592-15947-1-git-send-email-ibid.ag@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Fix a crash reported by Jean-Marc Pigeon on the musl mailing list.

If TZUTC is unset, setenv() will be called with value = NULL,
which invokes undefined behavior.
With musl libc, this causes a crash.
On uclibc and glibc, this currently happens to act like the long form
here, but glibc will make this an error:
 https://sourceware.org/ml/libc-alpha/2015-03/threads.html#00449

Additionally, include <sys/time.h> to define struct timeval.
---
 sys-utils/hwclock.c | 5 ++++-
 sys-utils/hwclock.h | 1 +
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e1e5816..67971f0 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -408,7 +408,10 @@ mktime_tz(struct tm tm, const bool universal,
 		 * libc's:
 		 *    TZUTC=:/usr/share/zoneinfo/right/UTC
 		 */
-		setenv("TZ", getenv("TZUTC"), TRUE);
+		char *tzutc;
+
+		tzutc = getenv("TZUTC");
+		setenv("TZ", tzutc ? tzutc : "", TRUE);
 		/*
 		 * Note: tzset() gets called implicitly by the time code,
 		 * but only the first time. When changing the environment
diff --git a/sys-utils/hwclock.h b/sys-utils/hwclock.h
index 974d96a..7f19c39 100644
--- a/sys-utils/hwclock.h
+++ b/sys-utils/hwclock.h
@@ -6,6 +6,7 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
+#include <sys/time.h>
 
 #include "c.h"
 
-- 
2.3.5

