Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f51.google.com ([209.85.215.51]:35456 "EHLO
	mail-la0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932232AbaEEN3q (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 May 2014 09:29:46 -0400
Received: by mail-la0-f51.google.com with SMTP id mc6so781132lab.38
        for <util-linux@vger.kernel.org>; Mon, 05 May 2014 06:29:44 -0700 (PDT)
From: Alexander <alexsamilovskih@gmail.com>
To: alexander samilovskih <alexsamilovskih@gmail.com>,
        util-linux@vger.kernel.org, kerolasa@iki.fi
Subject: [PATCH 1/3] lib/timeutils: add monotonic clock support
Date: Mon, 05 May 2014 20:29:15 +0200
Message-ID: <1471196.p9mLsTAGGY@alexpc.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

>From b641e268ab0aa1597e46f79accd169c388f06c7c Mon Sep 17 00:00:00 2001
From: Alex Samilovskih <alexsamilovskih@gmail.com>
Date: Fri, 2 May 2014 18:15:12 +0000
Subject: [PATCH 1/3] Add support for monotonic clock

---
 include/timeutils.h |  1 +
 lib/timeutils.c     | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/timeutils.h b/include/timeutils.h
index bcae613..7cf972d 100644
--- a/include/timeutils.h
+++ b/include/timeutils.h
@@ -51,5 +51,6 @@ typedef uint64_t nsec_t;
 #define FORMAT_TIMESPAN_MAX 64
 
 int parse_timestamp(const char *t, usec_t *usec);
+int gettime_monotonic(struct timeval *tv);
 
 #endif /* UTIL_LINUX_TIME_UTIL_H */
diff --git a/lib/timeutils.c b/lib/timeutils.c
index 7fe6218..b3fb87b 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -336,3 +336,27 @@ int parse_timestamp(const char *t, usec_t *usec)
 
 	return 0;
 }
+
+/*  Get the current time that is not a subject to resetting and drifting  */
+int gettime_monotonic(struct timeval *tv)
+{
+#ifdef CLOCK_MONOTONIC
+	int ret;
+	struct timespec ts;
+	
+#ifdef CLOCK_MONOTONIC_RAW
+	if (!(ret = clock_gettime(CLOCK_MONOTONIC_RAW, &ts))) {
+#else /* CLOCK_MONOTONIC_RAW is not available */
+	if (!(ret = clock_gettime(CLOCK_MONOTONIC, &ts))) {
+#endif
+		tv->tv_sec = ts.tv_sec;
+		tv->tv_usec = ts.tv_nsec / 1000;
+	}
+	
+	return ret;
+	
+#else /* CLOCK_MONOTONIC is not available */
+
+	return gettimeofday(tv, NULL);
+#endif
+}
-- 
1.9.2
