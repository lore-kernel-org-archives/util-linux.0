Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33774 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751208AbcEORbJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 May 2016 13:31:09 -0400
Received: by mail-wm0-f67.google.com with SMTP id r12so13504227wme.0
        for <util-linux@vger.kernel.org>; Sun, 15 May 2016 10:31:09 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 05/11] dmesg: use timestamp helpers
Date: Sun, 15 May 2016 18:30:51 +0100
Message-Id: <1463333457-1011-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
References: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 62 ++++++++++++++++++-------------------------------------
 1 file changed, 20 insertions(+), 42 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index cf93331..94381da 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -32,6 +32,7 @@
 #include "bitops.h"
 #include "closestream.h"
 #include "optutils.h"
+#include "timestamps.h"
 #include "timeutils.h"
 #include "monotonic.h"
 #include "mangle.h"
@@ -804,43 +805,6 @@ static struct tm *record_localtime(struct dmesg_control *ctl,
 	return localtime_r(&t, tm);
 }
 
-static char *record_ctime(struct dmesg_control *ctl,
-			  struct dmesg_record *rec,
-			  char *buf, size_t bufsiz)
-{
-	struct tm tm;
-
-	record_localtime(ctl, rec, &tm);
-
-	if (strftime(buf, bufsiz, "%a %b %e %H:%M:%S %Y", &tm) == 0)
-		*buf = '\0';
-	return buf;
-}
-
-static char *short_ctime(struct tm *tm, char *buf, size_t bufsiz)
-{
-	if (strftime(buf, bufsiz, "%b%e %H:%M", tm) == 0)
-		*buf = '\0';
-	return buf;
-}
-
-static char *iso_8601_time(struct dmesg_control *ctl, struct dmesg_record *rec,
-			   char *buf, size_t bufsiz)
-{
-	struct tm tm;
-	size_t len;
-	record_localtime(ctl, rec, &tm);
-	if (strftime(buf, bufsiz, "%Y-%m-%dT%H:%M:%S", &tm) == 0) {
-		*buf = '\0';
-		return buf;
-	}
-	len = strlen(buf);
-	snprintf(buf + len, bufsiz - len, ",%06ld", (long)rec->tv.tv_usec);
-	len = strlen(buf);
-	strftime(buf + len, bufsiz - len, "%z", &tm);
-	return buf;
-}
-
 static double record_count_delta(struct dmesg_control *ctl,
 				 struct dmesg_record *rec)
 {
@@ -880,6 +844,12 @@ static void print_record(struct dmesg_control *ctl,
 	const char *mesg;
 	size_t mesg_size;
 	int indent = 0;
+	struct tm tm;
+	struct ul_time t = { 0 };
+
+	t.buf = buf;
+	t.bufsz = sizeof(buf);
+	t.tm = &tm;
 
 	if (!accept_record(ctl, rec))
 		return;
@@ -921,24 +891,29 @@ static void print_record(struct dmesg_control *ctl,
 		ctl->indent = 0;
 		break;
 	case DMESG_TIMEFTM_CTIME:
-		ctl->indent = printf("[%s] ", record_ctime(ctl, rec, buf, sizeof(buf)));
+		record_localtime(ctl, rec, &tm);
+		ul_timestamp_ctime_full(&t);
+		ctl->indent = printf("[%s] ", buf);
 		break;
 	case DMESG_TIMEFTM_CTIME_DELTA:
-		ctl->indent = printf("[%s <%12.06f>] ",
-		       		     record_ctime(ctl, rec, buf, sizeof(buf)),
+		record_localtime(ctl, rec, &tm);
+		ul_timestamp_ctime_full(&t);
+		ctl->indent = printf("[%s <%12.06f>] ", buf,
 		       		     record_count_delta(ctl, rec));
 		break;
 	case DMESG_TIMEFTM_DELTA:
 		ctl->indent = printf("[<%12.06f>] ", record_count_delta(ctl, rec));
 		break;
 	case DMESG_TIMEFTM_RELTIME:
+		t.tm = &cur;
 		record_localtime(ctl, rec, &cur);
 		delta = record_count_delta(ctl, rec);
 		if (cur.tm_min != ctl->lasttm.tm_min ||
 		    cur.tm_hour != ctl->lasttm.tm_hour ||
 		    cur.tm_yday != ctl->lasttm.tm_yday) {
 			dmesg_enable_color(DMESG_COLOR_TIMEBREAK);
-			ctl->indent = printf("[%s] ", short_ctime(&cur, buf, sizeof(buf)));
+			ul_timestamp_ctime_short_date(&t, 'e', ' ');
+			ctl->indent = printf("[%s] ", buf);
 		} else {
 			if (delta < 10)
 				ctl->indent = printf("[  %+8.06f] ", delta);
@@ -956,7 +931,10 @@ static void print_record(struct dmesg_control *ctl,
 		               (long)rec->tv.tv_usec, record_count_delta(ctl, rec));
 		break;
 	case DMESG_TIMEFTM_ISO8601:
-		ctl->indent = printf("%s ", iso_8601_time(ctl, rec, buf, sizeof(buf)));
+		record_localtime(ctl, rec, &tm);
+		t.microseconds = (long)rec->tv.tv_usec;
+		ul_timestamp_iso_ms(&t);
+		ctl->indent = printf("%s ", buf);
 		break;
 	default:
 		abort();
-- 
2.8.2

