Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:50531 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbdLJPyx (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 10 Dec 2017 10:54:53 -0500
Subject: [PATCH 2/4] lib/timeutils.c:strxxx_iso: test conversion errors
To: Karel Zak <kzak@redhat.com>
References: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <fd8f1ed4-b215-1fc5-0fe5-d1a94934acd8@gmx.com>
Date: Sun, 10 Dec 2017 10:54:51 -0500
MIME-Version: 1.0
In-Reply-To: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Test for libc time conversion errors in ISO time format functions.

hwclock --utc --noadjfile --predict --date '67768034678846520 seconds'
Segmentation fault

Patched:
hwclock --utc --noadjfile --predict --date '67768034678846520 seconds'
hwclock: time 67768036191695381 is out of range.

Comparable to date(1):
date --date '67768034678846520 seconds'
date: time 67768036191695384 is out of range

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/timeutils.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/lib/timeutils.c b/lib/timeutils.c
index 994073700..dd763ecc3 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -460,12 +460,18 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 int strtimeval_iso(struct timeval *tv, int flags, char *buf, size_t bufsz)
 {
 	struct tm tm;
+	struct tm *rc;
 
 	if (flags & ISO_GMTIME)
-		gmtime_r(&tv->tv_sec, &tm);
+		rc = gmtime_r(&tv->tv_sec, &tm);
 	else
-		localtime_r(&tv->tv_sec, &tm);
-	return format_iso_time(&tm, tv->tv_usec, flags, buf, bufsz);
+		rc = localtime_r(&tv->tv_sec, &tm);
+
+	if (rc)
+		return format_iso_time(&tm, tv->tv_usec, flags, buf, bufsz);
+
+	warnx(_("time %ld is out of range."), tv->tv_sec);
+	return -1;
 }
 
 /* struct tm to ISO 8601 */
@@ -478,12 +484,18 @@ int strtm_iso(struct tm *tm, int flags, char *buf, size_t bufsz)
 int strtime_iso(const time_t *t, int flags, char *buf, size_t bufsz)
 {
 	struct tm tm;
+	struct tm *rc;
 
 	if (flags & ISO_GMTIME)
-		gmtime_r(t, &tm);
+		rc = gmtime_r(t, &tm);
 	else
-		localtime_r(t, &tm);
-	return format_iso_time(&tm, 0, flags, buf, bufsz);
+		rc = localtime_r(t, &tm);
+
+	if (rc)
+		return format_iso_time(&tm, 0, flags, buf, bufsz);
+
+	warnx(_("time %ld is out of range."), (long)t);
+	return -1;
 }
 
 /* relative time functions */
