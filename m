Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-lb0-f194.google.com ([209.85.217.194]:34236 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754235AbcFTUlH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 20 Jun 2016 16:41:07 -0400
Received: by mail-lb0-f194.google.com with SMTP id w10so160480lbo.1
        for <util-linux@vger.kernel.org>; Mon, 20 Jun 2016 13:40:44 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/6] libcommon: add ISO_8601_GMTIME that will print UTC-0 timestamps
Date: Mon, 20 Jun 2016 21:40:33 +0100
Message-Id: <20160620204037.3292-3-kerolasa@iki.fi>
In-Reply-To: <20160620204037.3292-1-kerolasa@iki.fi>
References: <20160620204037.3292-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When timestamps are intented to be conversable back from string to binary it
is best to stick with UTC-0 timezone.  This is needed in utmpdump(1).

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/timeutils.h |  3 ++-
 lib/timeutils.c     | 14 ++++++++++++--
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/timeutils.h b/include/timeutils.h
index 265577f..00d1820 100644
--- a/include/timeutils.h
+++ b/include/timeutils.h
@@ -61,7 +61,8 @@ enum {
 	ISO_8601_DOTUSEC	= (1 << 3),
 	ISO_8601_COMMAUSEC	= (1 << 4),
 	ISO_8601_TIMEZONE	= (1 << 5),
-	ISO_8601_SPACE		= (1 << 6)
+	ISO_8601_SPACE		= (1 << 6),
+	ISO_8601_GMTIME		= (1 << 7)
 };
 
 #define ISO_8601_BUFSIZ	32
diff --git a/lib/timeutils.c b/lib/timeutils.c
index 25a163e..fd9aa3e 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -396,7 +396,12 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 /* timeval to ISO 8601 */
 int strtimeval_iso(struct timeval *tv, int flags, char *buf, size_t bufsz)
 {
-	struct tm tm = *localtime(&tv->tv_sec);
+	struct tm tm;
+
+	if (flags & ISO_8601_GMTIME)
+		tm = *gmtime(&tv->tv_sec);
+	else
+		tm = *localtime(&tv->tv_sec);
 	return format_iso_time(&tm, tv->tv_usec, flags, buf, bufsz);
 }
 
@@ -409,7 +414,12 @@ int strtm_iso(struct tm *tm, int flags, char *buf, size_t bufsz)
 /* time_t to ISO 8601 */
 int strtime_iso(const time_t *t, int flags, char *buf, size_t bufsz)
 {
-	struct tm tm = *localtime(t);
+	struct tm tm;
+
+	if (flags & ISO_8601_GMTIME)
+		tm = *gmtime(t);
+	else
+		tm = *localtime(t);
 	return format_iso_time(&tm, 0, flags, buf, bufsz);
 }
 
-- 
2.9.0

