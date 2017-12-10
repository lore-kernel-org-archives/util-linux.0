Return-Path: elseifthen@gmx.com
Subject: [PATCH 4/4] lib/timeutils.c: warn format_iso_time() overflow
To: Karel Zak <kzak@redhat.com>
References: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <c90b81c3-24b4-e2f8-23ea-55ce75085634@gmx.com>
Date: Sun, 10 Dec 2017 10:56:41 -0500
MIME-Version: 1.0
In-Reply-To: <9da0ec7b-f109-1162-6677-1bc6f8635583@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


Print a message when the format_iso_time() buffer is exceeded, because
there is more than one type of failure that returns -1.

Also remove the corresponding message from hwclock.c.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 lib/timeutils.c     | 15 +++++++++------
 sys-utils/hwclock.c |  5 ++---
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/lib/timeutils.c b/lib/timeutils.c
index a7459d2b6..9c286aebc 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -410,14 +410,14 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 			       tm->tm_year + (long) 1900,
 			       tm->tm_mon + 1, tm->tm_mday);
 		if (len < 0 || (size_t) len > bufsz)
-			return -1;
+			goto err;
 		bufsz -= len;
 		p += len;
 	}
 
 	if ((flags & ISO_DATE) && (flags & ISO_TIME)) {
 		if (bufsz < 1)
-			return -1;
+			goto err;
 		*p++ = (flags & ISO_T) ? 'T' : ' ';
 		bufsz--;
 	}
@@ -426,7 +426,7 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 		len = snprintf(p, bufsz, "%02d:%02d:%02d", tm->tm_hour,
 			       tm->tm_min, tm->tm_sec);
 		if (len < 0 || (size_t) len > bufsz)
-			return -1;
+			goto err;
 		bufsz -= len;
 		p += len;
 	}
@@ -434,14 +434,14 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 	if (flags & ISO_DOTUSEC) {
 		len = snprintf(p, bufsz, ".%06ld", (long) usec);
 		if (len < 0 || (size_t) len > bufsz)
-			return -1;
+			goto err;
 		bufsz -= len;
 		p += len;
 
 	} else if (flags & ISO_COMMAUSEC) {
 		len = snprintf(p, bufsz, ",%06ld", (long) usec);
 		if (len < 0 || (size_t) len > bufsz)
-			return -1;
+			goto err;
 		bufsz -= len;
 		p += len;
 	}
@@ -452,9 +452,12 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 		int zmin  = abs(tmin % 60);
 		len = snprintf(p, bufsz, "%+03d:%02d", zhour,zmin);
 		if (len < 0 || (size_t) len > bufsz)
-			return -1;
+			goto err;
 	}
 	return 0;
+ err:
+	warnx(_("format_iso_time: buffer overflow."));
+	return -1;
 }
 
 /* timeval to ISO 8601 */
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index e5f90a44e..71d2b17b7 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -556,10 +556,9 @@ display_time(struct timeval hwctime)
 {
 	char buf[ISO_BUFSIZ];
 
-	if (strtimeval_iso(&hwctime, ISO_TIMESTAMP_DOT, buf, sizeof(buf))) {
-		warnx(_("iso-8601 format overflow"));
+	if (strtimeval_iso(&hwctime, ISO_TIMESTAMP_DOT, buf, sizeof(buf)))
 		return EXIT_FAILURE;
-	}
+
 	printf("%s\n", buf);
 	return EXIT_SUCCESS;
 }
