Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:52628 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751726AbdLJPsp (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 10 Dec 2017 10:48:45 -0500
Subject: [PATCH 1/4] lib/timeutils.c: bug fix Segmentation fault
To: Karel Zak <kzak@redhat.com>
References: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <b8641e86-01aa-f2ef-e20c-f7b3c583a12a@gmx.com>
Date: Sun, 10 Dec 2017 10:48:46 -0500
MIME-Version: 1.0
In-Reply-To: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Use reentrant time functions to avoid sending a NULL pointer to
format_iso_time() (and to be reentrant ;). Followup commits test for
errors and tm_year wrapping (illustrated below).

hwclock --utc --noadjfile --predict --date '67768034678849400 seconds'
Segmentation fault

Patched
hwclock --utc --noadjfile --predict --date '67768034678849400 seconds'
-2147481748-01-00 00:10:46.000000-05:00

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/timeutils.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/lib/timeutils.c b/lib/timeutils.c
index fdaa2d4a9..994073700 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -462,9 +462,9 @@ int strtimeval_iso(struct timeval *tv, int flags, char *buf, size_t bufsz)
 	struct tm tm;
 
 	if (flags & ISO_GMTIME)
-		tm = *gmtime(&tv->tv_sec);
+		gmtime_r(&tv->tv_sec, &tm);
 	else
-		tm = *localtime(&tv->tv_sec);
+		localtime_r(&tv->tv_sec, &tm);
 	return format_iso_time(&tm, tv->tv_usec, flags, buf, bufsz);
 }
 
@@ -480,9 +480,9 @@ int strtime_iso(const time_t *t, int flags, char *buf, size_t bufsz)
 	struct tm tm;
 
 	if (flags & ISO_GMTIME)
-		tm = *gmtime(t);
+		gmtime_r(t, &tm);
 	else
-		tm = *localtime(t);
+		localtime_r(t, &tm);
 	return format_iso_time(&tm, 0, flags, buf, bufsz);
 }
 
