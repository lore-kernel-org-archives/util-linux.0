Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:55176 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751064AbaD0UF4 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 27 Apr 2014 16:05:56 -0400
Received: by mail-we0-f180.google.com with SMTP id t61so741841wes.39
        for <util-linux@vger.kernel.org>; Sun, 27 Apr 2014 13:05:55 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 02/12] dmesg: move get_boot_time() to lib/timeutils
Date: Sun, 27 Apr 2014 21:05:28 +0100
Message-Id: <1398629138-31718-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
References: <1398629138-31718-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In future the last(1) will use get_boot_time() as well.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/timeutils.h |  1 +
 lib/timeutils.c     | 29 +++++++++++++++++++++++++++++
 sys-utils/dmesg.c   | 27 ---------------------------
 3 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/include/timeutils.h b/include/timeutils.h
index bcae613..b9ba0f7 100644
--- a/include/timeutils.h
+++ b/include/timeutils.h
@@ -51,5 +51,6 @@ typedef uint64_t nsec_t;
 #define FORMAT_TIMESPAN_MAX 64
 
 int parse_timestamp(const char *t, usec_t *usec);
+int get_boot_time(struct timeval *boot_time);
 
 #endif /* UTIL_LINUX_TIME_UTIL_H */
diff --git a/lib/timeutils.c b/lib/timeutils.c
index 7fe6218..c1b632e 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -21,9 +21,12 @@
 #include <assert.h>
 #include <ctype.h>
 #include <string.h>
+#include <sys/sysinfo.h>
+#include <sys/time.h>
 #include <time.h>
 
 #include "c.h"
+#include "nls.h"
 #include "strutils.h"
 #include "timeutils.h"
 
@@ -336,3 +339,29 @@ int parse_timestamp(const char *t, usec_t *usec)
 
 	return 0;
 }
+
+int get_boot_time(struct timeval *boot_time)
+{
+	struct timespec hires_uptime;
+	struct timeval lores_uptime, now;
+	struct sysinfo info;
+
+	if (gettimeofday(&now, NULL) != 0) {
+		warn(_("gettimeofday failed"));
+		return -errno;
+	}
+#ifdef CLOCK_BOOTTIME
+	if (clock_gettime(CLOCK_BOOTTIME, &hires_uptime) == 0) {
+		TIMESPEC_TO_TIMEVAL(&lores_uptime, &hires_uptime);
+		timersub(&now, &lores_uptime, boot_time);
+		return 0;
+	}
+#endif
+	/* fallback */
+	if (sysinfo(&info) != 0)
+		warn(_("sysinfo failed"));
+
+	boot_time->tv_sec = now.tv_sec - info.uptime;
+	boot_time->tv_usec = 0;
+	return 0;
+}
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index df68c84..196cc61 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -472,33 +472,6 @@ static int get_syslog_buffer_size(void)
 	return n > 0 ? n : 0;
 }
 
-static int get_boot_time(struct timeval *boot_time)
-{
-	struct timespec hires_uptime;
-	struct timeval lores_uptime, now;
-	struct sysinfo info;
-
-	if (gettimeofday(&now, NULL) != 0) {
-		warn(_("gettimeofday failed"));
-		return -errno;
-	}
-
-#ifdef CLOCK_BOOTTIME
-	if (clock_gettime(CLOCK_BOOTTIME, &hires_uptime) == 0) {
-		TIMESPEC_TO_TIMEVAL(&lores_uptime, &hires_uptime);
-		timersub(&now, &lores_uptime, boot_time);
-		return 0;
-	}
-#endif
-	/* fallback */
-	if (sysinfo(&info) != 0)
-		warn(_("sysinfo failed"));
-
-	boot_time->tv_sec = now.tv_sec - info.uptime;
-	boot_time->tv_usec = 0;
-	return 0;
-}
-
 /*
  * Reads messages from regular file by mmap
  */
-- 
1.9.2

