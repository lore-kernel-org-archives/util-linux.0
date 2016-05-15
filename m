Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34682 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750908AbcEORbF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 May 2016 13:31:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so13474589wmn.1
        for <util-linux@vger.kernel.org>; Sun, 15 May 2016 10:31:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/11] last: use timestamp helpers
Date: Sun, 15 May 2016 18:30:48 +0100
Message-Id: <1463333457-1011-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
References: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/last.c | 42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index b8c4b83..06708c6 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -49,6 +49,7 @@
 #include "closestream.h"
 #include "carefulputc.h"
 #include "strutils.h"
+#include "timestamps.h"
 #include "timeutils.h"
 #include "monotonic.h"
 
@@ -315,35 +316,34 @@ static int dns_lookup(char *result, int size, int useip, int32_t *a)
 static int time_formatter(const struct last_control *ctl, char *dst,
 			  size_t dlen, time_t *when, int pos)
 {
-	struct tm *tm;
 	int ret = 0;
+	struct ul_time t = { 0 };
+	struct tm tm;
 
+	if (ctl->time_fmt == LAST_TIMEFTM_NONE) {
+		*dst = '\0';
+		return 0;
+	}
+	t.tm = localtime_r(when, &tm);
+	if (pos) {
+		ret = snprintf(dst, dlen, "- ");
+		if (ret == 0)
+			return -1;
+	}
+	t.buf = dst + ret;
+	t.bufsz = dlen - ret;
 	switch (ctl->time_fmt) {
-	case LAST_TIMEFTM_NONE:
-		*dst = 0;
-		break;
 	case LAST_TIMEFTM_SHORT_CTIME:
-		if (pos == 0)
-			ret = sprintf(dst, "%s", ctime(when));
-		else {
-			tm = localtime(when);
-			if (!strftime(dst, dlen, "- %H:%M", tm))
-				ret = -1;
-		}
+		if (pos)
+			ret = ul_timestamp_hours_minutes(&t);
+		else
+			ret = ul_timestamp_ctime_full(&t);
 		break;
 	case LAST_TIMEFTM_FULL_CTIME:
-		if (pos == 0)
-			ret = sprintf(dst, "%s", ctime(when));
-		else
-			ret = sprintf(dst, "- %s", ctime(when));
+		ret = ul_timestamp_ctime_full(&t);
 		break;
 	case LAST_TIMEFTM_ISO8601:
-		tm = localtime(when);
-		if (pos == 0) {
-			if (!strftime(dst, dlen, "%Y-%m-%dT%H:%M:%S%z", tm))
-				ret = -1;
-		} else if (!strftime(dst, dlen, "- %Y-%m-%dT%H:%M:%S%z", tm))
-			ret = -1;
+		ret = ul_timestamp_iso_full(&t);
 		break;
 	default:
 		abort();
-- 
2.8.2

