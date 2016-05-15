Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34693 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750975AbcEORbG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 May 2016 13:31:06 -0400
Received: by mail-wm0-f68.google.com with SMTP id n129so13474668wmn.1
        for <util-linux@vger.kernel.org>; Sun, 15 May 2016 10:31:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/11] lslogins: use timestamp helpers
Date: Sun, 15 May 2016 18:30:49 +0100
Message-Id: <1463333457-1011-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
References: <1463333457-1011-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 43 +++++++++++--------------------------------
 1 file changed, 11 insertions(+), 32 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 40a1343..9e80b25 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -56,6 +56,7 @@
 #include "pathnames.h"
 #include "logindefs.h"
 #include "procutils.h"
+#include "timestamps.h"
 
 /*
  * column description
@@ -293,22 +294,6 @@ static inline size_t err_columns_index(size_t arysz, size_t idx)
 #define add_column(ary, n, id)	\
 		((ary)[ err_columns_index(ARRAY_SIZE(ary), (n)) ] = (id))
 
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
-
 static int column_name_to_id(const char *name, size_t namesz)
 {
 	size_t i;
@@ -325,31 +310,26 @@ static int column_name_to_id(const char *name, size_t namesz)
 
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
-			strftime(buf, sizeof(buf), "%H:%M:%S", &tm);
-		else if (date_is_thisyear(time))
-			strftime(buf, sizeof(buf), "%b%d/%H:%M", &tm);
-		else
-			strftime(buf, sizeof(buf), "%Y-%b%d", &tm);
+		ul_timestamp_ctime_short(&t);
 		break;
 	case TIME_ISO:
-		strftime(buf, sizeof(buf), "%Y-%m-%dT%H:%M:%S%z", &tm);
+		ul_timestamp_iso_full(&t);
 		break;
 	case TIME_ISO_SHORT:
-		strftime(buf, sizeof(buf), "%Y-%m-%d", &tm);
+		ul_timestamp_iso_short(&t);
 		break;
 	default:
 		errx(EXIT_FAILURE, _("unsupported time type"));
@@ -357,7 +337,6 @@ static char *make_time(int mode, time_t time)
 	return xstrdup(buf);
 }
 
-
 static char *uidtostr(uid_t uid)
 {
 	char *str_uid = NULL;
-- 
2.8.2

