Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34705 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751019AbcEORbI (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 May 2016 13:31:08 -0400
Received: by mail-wm0-f66.google.com with SMTP id n129so13474736wmn.1
        for <util-linux@vger.kernel.org>; Sun, 15 May 2016 10:31:07 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 04/11] lsipc: use timestamp helpers
Date: Sun, 15 May 2016 18:30:50 +0100
Message-Id: <1463333457-1011-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
References: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/lsipc.c | 39 ++++++++++-----------------------------
 1 file changed, 10 insertions(+), 29 deletions(-)

diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index 195ee15..c1d4f1c 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -39,6 +39,7 @@
 #include "xalloc.h"
 #include "procutils.h"
 #include "ipcutils.h"
+#include "timestamps.h"
 
 /*
  * time modes
@@ -427,46 +428,26 @@ static int print_table(struct lsipc_control *ctl, struct libscols_table *tb)
 		scols_print_table(tb);
 	return 0;
 }
-static struct timeval now;
-
-static int date_is_today(time_t t)
-{
-	if (now.tv_sec == 0)
-		gettimeofday(&now, NULL);
-	return t / (3600 * 24) == now.tv_sec / (3600 * 24);
-}
-
-static int date_is_thisyear(time_t t)
-{
-	if (now.tv_sec == 0)
-		gettimeofday(&now, NULL);
-	return t / (3600 * 24 * 365) == now.tv_sec / (3600 * 24 * 365);
-}
 
 static char *make_time(int mode, time_t time)
 {
-	char *s;
 	struct tm tm;
-	char buf[64] = {0};
+	char buf[64] = { 0 };
+	struct ul_time t = { 0 };
 
-	localtime_r(&time, &tm);
+	t.tm = localtime_r(&time, &tm);
+	t.buf = buf;
+	t.bufsz = sizeof(buf);
 
-	switch(mode) {
+	switch (mode) {
 	case TIME_FULL:
-		asctime_r(&tm, buf);
-		if (*(s = buf + strlen(buf) - 1) == '\n')
-			*s = '\0';
+		ul_timestamp_ctime_full(&t);
 		break;
 	case TIME_SHORT:
-		if (date_is_today(time))
-			strftime(buf, sizeof(buf), "%H:%M", &tm);
-		else if (date_is_thisyear(time))
-			strftime(buf, sizeof(buf), "%b%d", &tm);
-		else
-			strftime(buf, sizeof(buf), "%Y-%b%d", &tm);
+		ul_timestamp_ctime_short(&t);
 		break;
 	case TIME_ISO:
-		strftime(buf, sizeof(buf), "%Y-%m-%dT%H:%M:%S%z", &tm);
+		ul_timestamp_iso_full(&t);
 		break;
 	default:
 		errx(EXIT_FAILURE, _("unsupported time type"));
-- 
2.8.2

