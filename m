Return-Path: elseifthen@gmx.com
Subject: [PATCH 3/4] lib/timeutils.c:strxxx_iso: do not wrap tm_year
To: Karel Zak <kzak@redhat.com>
References: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <6192bcb6-4c2b-3886-1a4f-926a48760505@gmx.com>
Date: Sun, 10 Dec 2017 10:55:46 -0500
MIME-Version: 1.0
In-Reply-To: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Year can wrap when adding the tm struct epoch during iso formatting:
hwclock --utc --noadjfile --predict --date '67768034678844900 seconds'
-2147481749-12-31 23:59:59.000000-05:00

Patched:
hwclock --utc --noadjfile --predict --date '67768034678844900 seconds'
2147485547-12-31 23:59:59.000000-05:00

Comparable to date(1):
date -Ins --date '67768034678844900 seconds'
2147485547-12-31T23:59:59,547886165-0500

Note: the 'seconds' argument is relative to the current time, so
      reaching this max year output is a moving target. The values shown
      above were invalid one second later. They then overflow tm_year
      upon conversion with localtime(3) and friends, which causes them
      to return NULL indicating that an error occurred.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/timeutils.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/timeutils.c b/lib/timeutils.c
index dd763ecc3..a7459d2b6 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -406,8 +406,9 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 	int len;
 
 	if (flags & ISO_DATE) {
-		len = snprintf(p, bufsz, "%4d-%.2d-%.2d", tm->tm_year + 1900,
-						tm->tm_mon + 1, tm->tm_mday);
+		len = snprintf(p, bufsz, "%4ld-%.2d-%.2d",
+			       tm->tm_year + (long) 1900,
+			       tm->tm_mon + 1, tm->tm_mday);
 		if (len < 0 || (size_t) len > bufsz)
 			return -1;
 		bufsz -= len;
@@ -423,7 +424,7 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 
 	if (flags & ISO_TIME) {
 		len = snprintf(p, bufsz, "%02d:%02d:%02d", tm->tm_hour,
-						 tm->tm_min, tm->tm_sec);
+			       tm->tm_min, tm->tm_sec);
 		if (len < 0 || (size_t) len > bufsz)
 			return -1;
 		bufsz -= len;
@@ -451,7 +452,7 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 		int zmin  = abs(tmin % 60);
 		len = snprintf(p, bufsz, "%+03d:%02d", zhour,zmin);
 		if (len < 0 || (size_t) len > bufsz)
-		return -1;
+			return -1;
 	}
 	return 0;
 }
