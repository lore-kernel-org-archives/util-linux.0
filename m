Return-Path: elseifthen@gmx.com
Subject: [v2 PATCH 3/5] lib/timeutils: add get_gmtoff()
To: Karel Zak <kzak@redhat.com>
References: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <70824597-e322-0854-12b7-9bf9e719cb4f@gmx.com>
Date: Sun, 12 Nov 2017 10:25:24 -0500
MIME-Version: 1.0
In-Reply-To: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <util-linux.vger.kernel.org>


This new function returns the GMT offset relative to its
argument. It is used in this patch to fix two bugs:

1) On platforms that the tm struct excludes tm_gmtoff,
   hwclock assumes a one hour DST offset. This can cause
   an incorrect kernel timezone setting. For example:

 Master branch tested with tm_gmtoff illustrates the correct offset:
$ TZ="Australia/Lord_Howe" hwclock --hctosys --test | grep settimeofday
Calling settimeofday(1507494204.192398, -660)

 Master branch tested without tm_gmtoff has an incorrect offset:
$ TZ="Australia/Lord_Howe" hwclock --hctosys --test | grep settimeofday
Calling settimeofday(1507494249.193852, -690)

 Patched tested without tm_gmtoff has the correct offset:
$ TZ="Australia/Lord_Howe" hwclock --hctosys --test | grep settimeofday
Calling settimeofday(1507494260.194208, -660)

2) ISO 8601 'extended' format requires all time elements
   to use a colon (:).

Current invalid ISO 8601:
$ hwclock
2017-10-08 16:25:17.895462-0400

Patched:
$ hwclock
2017-10-08 16:25:34.141895-04:00

Also required by this change:
login-utils/last.c: increase ISO out_len and in_len by one to
                    accommodate the addition of the timezone colon.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 include/timeutils.h |  1 +
 lib/timeutils.c     | 68 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 login-utils/last.c  |  4 ++--
 sys-utils/hwclock.c |  8 +------
 4 files changed, 70 insertions(+), 11 deletions(-)

diff --git a/include/timeutils.h b/include/timeutils.h
index edd42f7fe..e8a261462 100644
--- a/include/timeutils.h
+++ b/include/timeutils.h
@@ -53,6 +53,7 @@ typedef uint64_t nsec_t;
 #define FORMAT_TIMESPAN_MAX 64
 
 int parse_timestamp(const char *t, usec_t *usec);
+int get_gmtoff(const struct tm *tp);
 
 /* flags for strxxx_iso() functions */
 enum {
diff --git a/lib/timeutils.c b/lib/timeutils.c
index d38970c10..adc255c33 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -341,6 +341,65 @@ int parse_timestamp(const char *t, usec_t *usec)
 	return 0;
 }
 
+/* Returns the difference in seconds between its argument and GMT. If if TP is
+ * invalid or no DST information is available default to UTC, that is, zero.
+ * tzset is called so, for example, 'TZ="UTC" hwclock' will work as expected.
+ * Derived from glibc/time/strftime_l.c
+ */
+int get_gmtoff(const struct tm *tp)
+{
+	if (tp->tm_isdst < 0)
+	return 0;
+
+#if HAVE_TM_GMTOFF
+	return tp->tm_gmtoff;
+#else
+	struct tm tm;
+	struct tm gtm;
+	struct tm ltm = *tp;
+	time_t lt;
+
+	tzset();
+	lt = mktime(&ltm);
+	/* Check if mktime returning -1 is an error or a valid time_t */
+	if (lt == (time_t) -1) {
+		if (! localtime_r(&lt, &tm)
+			|| ((ltm.tm_sec ^ tm.tm_sec)
+			    | (ltm.tm_min ^ tm.tm_min)
+			    | (ltm.tm_hour ^ tm.tm_hour)
+			    | (ltm.tm_mday ^ tm.tm_mday)
+			    | (ltm.tm_mon ^ tm.tm_mon)
+			    | (ltm.tm_year ^ tm.tm_year)))
+			return 0;
+	}
+
+	if (! gmtime_r(&lt, &gtm))
+		return 0;
+
+	/* Calculate the GMT offset, that is, the difference between the
+	 * TP argument (ltm) and GMT (gtm).
+	 *
+	 * Compute intervening leap days correctly even if year is negative.
+	 * Take care to avoid int overflow in leap day calculations, but it's OK
+	 * to assume that A and B are close to each other.
+	 */
+	int a4 = (ltm.tm_year >> 2) + (1900 >> 2) - ! (ltm.tm_year & 3);
+	int b4 = (gtm.tm_year >> 2) + (1900 >> 2) - ! (gtm.tm_year & 3);
+	int a100 = a4 / 25 - (a4 % 25 < 0);
+	int b100 = b4 / 25 - (b4 % 25 < 0);
+	int a400 = a100 >> 2;
+	int b400 = b100 >> 2;
+	int intervening_leap_days = (a4 - b4) - (a100 - b100) + (a400 - b400);
+
+	int years = ltm.tm_year - gtm.tm_year;
+	int days = (365 * years + intervening_leap_days
+		    + (ltm.tm_yday - gtm.tm_yday));
+
+	return (60 * (60 * (24 * days + (ltm.tm_hour - gtm.tm_hour))
+		+ (ltm.tm_min - gtm.tm_min)) + (ltm.tm_sec - gtm.tm_sec));
+#endif
+}
+
 static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf, size_t bufsz)
 {
 	char *p = buf;
@@ -386,9 +445,14 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 		p += len;
 	}
 
-	if (flags & ISO_8601_TIMEZONE && strftime(p, bufsz, "%z", tm) <= 0)
+	if (flags & ISO_8601_TIMEZONE) {
+		int tmin  = get_gmtoff(tm) / 60;
+		int zhour = tmin / 60;
+		int zmin  = abs(tmin % 60);
+		len = snprintf(p, bufsz, "%+03d:%02d", zhour,zmin);
+		if (len < 0 || (size_t) len > bufsz)
 		return -1;
-
+	}
 	return 0;
 }
 
diff --git a/login-utils/last.c b/login-utils/last.c
index f989836ba..f2e8f834e 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -145,8 +145,8 @@ static struct last_timefmt timefmts[] = {
 	},
 	[LAST_TIMEFTM_ISO8601] = {
 		.name    = "iso",
-		.in_len  = 24,
-		.out_len = 26,
+		.in_len  = 25,
+		.out_len = 27,
 		.in_fmt  = LAST_TIMEFTM_ISO8601,
 		.out_fmt = LAST_TIMEFTM_ISO8601
 	}
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index c2c20812c..3ac43efee 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -608,13 +608,7 @@ set_system_clock(const struct hwclock_control *ctl,
 	const struct timezone tz_utc = { 0 };
 
 	broken = localtime(&newtime.tv_sec);
-#ifdef HAVE_TM_GMTOFF
-	minuteswest = -broken->tm_gmtoff / 60;	/* GNU extension */
-#else
-	minuteswest = timezone / 60;
-	if (broken->tm_isdst)
-		minuteswest -= 60;
-#endif
+	minuteswest = -get_gmtoff(broken) / 60;
 
 	if (ctl->debug) {
 		if (ctl->hctosys && !ctl->universal)
