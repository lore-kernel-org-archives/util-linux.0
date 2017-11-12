Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:56348 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751007AbdKLP0O (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 12 Nov 2017 10:26:14 -0500
Subject: [v2 PATCH 4/5] lib/timeutils: add common ISO timestamp masks
To: Karel Zak <kzak@redhat.com>
References: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <1b65f2a1-46b1-982d-65b5-42b0312c22e0@gmx.com>
Date: Sun, 12 Nov 2017 10:26:10 -0500
MIME-Version: 1.0
In-Reply-To: <1a28a73d-2e05-7071-479a-af5a18fade3b@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* Start the ISO format flags at bit 0 instead of bit 1.

* Remove unnecessary _8601 from ISO format flag names to
  avoid line wrapping and to ease readability.

* ISO timestamps have date-time-timzone in common, so move
  the TIMEZONE flag to bit 2 causing all timestamp masks
  to have the first three bits set and the last four bits
  as timestamp 'options'.

* Change the 'SPACE' flag to a 'T' flag, because it makes
  the code and comments more concise.

* Add common ISO timestamp masks.

* Implement the ISO timestamp masks in all applicable code
  using the strxxx_iso() functions.

Signed-off-by: J William Piggott <elseifthen@gmx.com>
---
 include/timeutils.h    | 26 +++++++++++++++++---------
 lib/timeutils.c        | 32 +++++++++++++++-----------------
 login-utils/last.c     |  2 +-
 login-utils/lslogins.c |  5 ++---
 login-utils/utmpdump.c |  4 +---
 misc-utils/uuidparse.c | 12 +++---------
 sys-utils/dmesg.c      |  4 +---
 sys-utils/hwclock.c    |  6 ++----
 sys-utils/lsipc.c      |  2 +-
 sys-utils/rfkill.c     | 10 +++-------
 term-utils/script.c    |  8 ++------
 11 files changed, 48 insertions(+), 63 deletions(-)

diff --git a/include/timeutils.h b/include/timeutils.h
index e8a261462..230e6db5f 100644
--- a/include/timeutils.h
+++ b/include/timeutils.h
@@ -55,18 +55,26 @@ typedef uint64_t nsec_t;
 int parse_timestamp(const char *t, usec_t *usec);
 int get_gmtoff(const struct tm *tp);
 
-/* flags for strxxx_iso() functions */
+/* flags and masks for strxxx_iso() functions */
 enum {
-	ISO_8601_DATE		= (1 << 1),
-	ISO_8601_TIME		= (1 << 2),
-	ISO_8601_DOTUSEC	= (1 << 3),
-	ISO_8601_COMMAUSEC	= (1 << 4),
-	ISO_8601_TIMEZONE	= (1 << 5),
-	ISO_8601_SPACE		= (1 << 6),
-	ISO_8601_GMTIME		= (1 << 7)
+	ISO_DATE		= (1 << 0),
+	ISO_TIME		= (1 << 1),
+	ISO_TIMEZONE		= (1 << 2),
+	ISO_DOTUSEC		= (1 << 3),
+	ISO_COMMAUSEC		= (1 << 4),
+	ISO_T			= (1 << 5),
+	ISO_GMTIME		= (1 << 6),
+	ISO_TIMESTAMP		= ISO_DATE | ISO_TIME | ISO_TIMEZONE,
+	ISO_TIMESTAMP_T		= ISO_TIMESTAMP | ISO_T,
+	ISO_TIMESTAMP_DOT	= ISO_TIMESTAMP | ISO_DOTUSEC,
+	ISO_TIMESTAMP_DOT_T	= ISO_TIMESTAMP_DOT | ISO_T,
+	ISO_TIMESTAMP_COMMA	= ISO_TIMESTAMP | ISO_COMMAUSEC,
+	ISO_TIMESTAMP_COMMA_T	= ISO_TIMESTAMP_COMMA | ISO_T,
+	ISO_TIMESTAMP_COMMA_G	= ISO_TIMESTAMP_COMMA | ISO_GMTIME,
+	ISO_TIMESTAMP_COMMA_GT  = ISO_TIMESTAMP_COMMA_G | ISO_T
 };
 
-#define ISO_8601_BUFSIZ	42
+#define ISO_BUFSIZ	42
 
 int strtimeval_iso(struct timeval *tv, int flags, char *buf, size_t bufsz);
 int strtm_iso(struct tm *tm, int flags, char *buf, size_t bufsz);
diff --git a/lib/timeutils.c b/lib/timeutils.c
index adc255c33..fdaa2d4a9 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -405,7 +405,7 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 	char *p = buf;
 	int len;
 
-	if (flags & ISO_8601_DATE) {
+	if (flags & ISO_DATE) {
 		len = snprintf(p, bufsz, "%4d-%.2d-%.2d", tm->tm_year + 1900,
 						tm->tm_mon + 1, tm->tm_mday);
 		if (len < 0 || (size_t) len > bufsz)
@@ -414,14 +414,14 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 		p += len;
 	}
 
-	if ((flags & ISO_8601_DATE) && (flags & ISO_8601_TIME)) {
+	if ((flags & ISO_DATE) && (flags & ISO_TIME)) {
 		if (bufsz < 1)
 			return -1;
-		*p++ = (flags & ISO_8601_SPACE) ? ' ' : 'T';
+		*p++ = (flags & ISO_T) ? 'T' : ' ';
 		bufsz--;
 	}
 
-	if (flags & ISO_8601_TIME) {
+	if (flags & ISO_TIME) {
 		len = snprintf(p, bufsz, "%02d:%02d:%02d", tm->tm_hour,
 						 tm->tm_min, tm->tm_sec);
 		if (len < 0 || (size_t) len > bufsz)
@@ -430,14 +430,14 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 		p += len;
 	}
 
-	if (flags & ISO_8601_DOTUSEC) {
+	if (flags & ISO_DOTUSEC) {
 		len = snprintf(p, bufsz, ".%06ld", (long) usec);
 		if (len < 0 || (size_t) len > bufsz)
 			return -1;
 		bufsz -= len;
 		p += len;
 
-	} else if (flags & ISO_8601_COMMAUSEC) {
+	} else if (flags & ISO_COMMAUSEC) {
 		len = snprintf(p, bufsz, ",%06ld", (long) usec);
 		if (len < 0 || (size_t) len > bufsz)
 			return -1;
@@ -445,7 +445,7 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 		p += len;
 	}
 
-	if (flags & ISO_8601_TIMEZONE) {
+	if (flags & ISO_TIMEZONE) {
 		int tmin  = get_gmtoff(tm) / 60;
 		int zhour = tmin / 60;
 		int zmin  = abs(tmin % 60);
@@ -461,7 +461,7 @@ int strtimeval_iso(struct timeval *tv, int flags, char *buf, size_t bufsz)
 {
 	struct tm tm;
 
-	if (flags & ISO_8601_GMTIME)
+	if (flags & ISO_GMTIME)
 		tm = *gmtime(&tv->tv_sec);
 	else
 		tm = *localtime(&tv->tv_sec);
@@ -479,7 +479,7 @@ int strtime_iso(const time_t *t, int flags, char *buf, size_t bufsz)
 {
 	struct tm tm;
 
-	if (flags & ISO_8601_GMTIME)
+	if (flags & ISO_GMTIME)
 		tm = *gmtime(t);
 	else
 		tm = *localtime(t);
@@ -548,7 +548,7 @@ time_t timegm(struct tm *tm)
 int main(int argc, char *argv[])
 {
 	struct timeval tv = { 0 };
-	char buf[ISO_8601_BUFSIZ];
+	char buf[ISO_BUFSIZ];
 
 	if (argc < 2) {
 		fprintf(stderr, "usage: %s <time> [<usec>]\n", argv[0]);
@@ -559,19 +559,17 @@ int main(int argc, char *argv[])
 	if (argc == 3)
 		tv.tv_usec = strtos64_or_err(argv[2], "failed to parse <usec>");
 
-	strtimeval_iso(&tv, ISO_8601_DATE, buf, sizeof(buf));
+	strtimeval_iso(&tv, ISO_DATE, buf, sizeof(buf));
 	printf("Date: '%s'\n", buf);
 
-	strtimeval_iso(&tv, ISO_8601_TIME, buf, sizeof(buf));
+	strtimeval_iso(&tv, ISO_TIME, buf, sizeof(buf));
 	printf("Time: '%s'\n", buf);
 
-	strtimeval_iso(&tv, ISO_8601_DATE | ISO_8601_TIME | ISO_8601_COMMAUSEC,
-			    buf, sizeof(buf));
+	strtimeval_iso(&tv, ISO_DATE | ISO_TIME | ISO_COMMAUSEC | ISO_T,
+		       buf, sizeof(buf));
 	printf("Full: '%s'\n", buf);
 
-	strtimeval_iso(&tv, ISO_8601_DATE | ISO_8601_TIME | ISO_8601_DOTUSEC |
-			    ISO_8601_TIMEZONE | ISO_8601_SPACE,
-			    buf, sizeof(buf));
+	strtimeval_iso(&tv, ISO_TIMESTAMP_DOT, buf, sizeof(buf));
 	printf("Zone: '%s'\n", buf);
 
 	return EXIT_SUCCESS;
diff --git a/login-utils/last.c b/login-utils/last.c
index f2e8f834e..80d77d20b 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -349,7 +349,7 @@ static int time_formatter(int fmt, char *dst, size_t dlen, time_t *when)
 		ret = rtrim_whitespace((unsigned char *) dst);
 		break;
 	case LAST_TIMEFTM_ISO8601:
-		ret = strtime_iso(when, ISO_8601_DATE|ISO_8601_TIME|ISO_8601_TIMEZONE, dst, dlen);
+		ret = strtime_iso(when, ISO_TIMESTAMP_T, dst, dlen);
 		break;
 	default:
 		abort();
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 1042b9b41..51033b01b 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -333,11 +333,10 @@ static char *make_time(int mode, time_t time)
 				buf, sizeof(buf));
 		break;
 	case TIME_ISO:
-		rc = strtime_iso(&time, ISO_8601_DATE|ISO_8601_TIME|ISO_8601_TIMEZONE,
-				   buf, sizeof(buf));
+		rc = strtime_iso(&time, ISO_TIMESTAMP_T, buf, sizeof(buf));
 		break;
 	case TIME_ISO_SHORT:
-		rc = strtime_iso(&time, ISO_8601_DATE, buf, sizeof(buf));
+		rc = strtime_iso(&time, ISO_DATE, buf, sizeof(buf));
 		break;
 	default:
 		errx(EXIT_FAILURE, _("unsupported time type"));
diff --git a/login-utils/utmpdump.c b/login-utils/utmpdump.c
index 00c44b8db..5cc87834a 100644
--- a/login-utils/utmpdump.c
+++ b/login-utils/utmpdump.c
@@ -102,9 +102,7 @@ static void print_utline(struct utmpx *ut, FILE *out)
 	tv.tv_sec = ut->ut_tv.tv_sec;
 	tv.tv_usec = ut->ut_tv.tv_usec;
 
-	if (strtimeval_iso(&tv,
-			   ISO_8601_DATE | ISO_8601_TIME | ISO_8601_COMMAUSEC |
-			   ISO_8601_TIMEZONE | ISO_8601_GMTIME, time_string,
+	if (strtimeval_iso(&tv, ISO_TIMESTAMP_COMMA_GT, time_string,
 			   sizeof(time_string)) != 0)
 		return;
 	cleanse(ut->ut_id);
diff --git a/misc-utils/uuidparse.c b/misc-utils/uuidparse.c
index 08ba33415..777f9db5e 100644
--- a/misc-utils/uuidparse.c
+++ b/misc-utils/uuidparse.c
@@ -224,17 +224,11 @@ static void fill_table_row(struct libscols_table *tb, char const *const uuid)
 			}
 			if (variant == UUID_VARIANT_DCE && type == 1) {
 				struct timeval tv;
-				char date_buf[ISO_8601_BUFSIZ + 4];
+				char date_buf[ISO_BUFSIZ];
 
 				uuid_time(buf, &tv);
-				strtimeval_iso(&tv,
-					       ISO_8601_DATE |
-						 ISO_8601_TIME |
-						 ISO_8601_COMMAUSEC |
-						 ISO_8601_TIMEZONE |
-						 ISO_8601_SPACE,
-					       date_buf,
-					       sizeof(date_buf));
+				strtimeval_iso(&tv, ISO_TIMESTAMP_COMMA,
+					       date_buf, sizeof(date_buf));
 				str = xstrdup(date_buf);
 			}
 			break;
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 9fdc1d8a7..bdd50b474 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -840,9 +840,7 @@ static char *iso_8601_time(struct dmesg_control *ctl, struct dmesg_record *rec,
 		.tv_usec = rec->tv.tv_usec
 	};
 
-	if (strtimeval_iso(&tv,	ISO_8601_DATE|ISO_8601_TIME|ISO_8601_COMMAUSEC|
-				ISO_8601_TIMEZONE,
-				buf, bufsz) != 0)
+	if (strtimeval_iso(&tv,	ISO_TIMESTAMP_COMMA_T, buf, bufsz) != 0)
 		return NULL;
 
 	return buf;
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 3ac43efee..c93a5fd65 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -554,11 +554,9 @@ set_hardware_clock_exact(const struct hwclock_control *ctl,
 static int
 display_time(struct timeval hwctime)
 {
-	char buf[ISO_8601_BUFSIZ];
+	char buf[ISO_BUFSIZ];
 
-	if (strtimeval_iso(&hwctime, ISO_8601_DATE|ISO_8601_TIME|ISO_8601_DOTUSEC|
-				 ISO_8601_TIMEZONE|ISO_8601_SPACE,
-				 buf, sizeof(buf))) {
+	if (strtimeval_iso(&hwctime, ISO_TIMESTAMP_DOT, buf, sizeof(buf))) {
 		warnx(_("iso-8601 format overflow"));
 		return EXIT_FAILURE;
 	}
diff --git a/sys-utils/lsipc.c b/sys-utils/lsipc.c
index e99c861ab..4b3b0c92d 100644
--- a/sys-utils/lsipc.c
+++ b/sys-utils/lsipc.c
@@ -451,7 +451,7 @@ static char *make_time(int mode, time_t time)
 		strtime_short(&time, &now, 0, buf, sizeof(buf));
 		break;
 	case TIME_ISO:
-		strtime_iso(&time, ISO_8601_DATE|ISO_8601_TIME|ISO_8601_TIMEZONE, buf, sizeof(buf));
+		strtime_iso(&time, ISO_TIMESTAMP_T, buf, sizeof(buf));
 		break;
 	default:
 		errx(EXIT_FAILURE, _("unsupported time type"));
diff --git a/sys-utils/rfkill.c b/sys-utils/rfkill.c
index c9559ef48..75804ad41 100644
--- a/sys-utils/rfkill.c
+++ b/sys-utils/rfkill.c
@@ -223,7 +223,7 @@ static int rfkill_event(void)
 {
 	struct rfkill_event event;
 	struct timeval tv;
-	char date_buf[ISO_8601_BUFSIZ];
+	char date_buf[ISO_BUFSIZ];
 	struct pollfd p;
 	int fd, n;
 
@@ -253,12 +253,8 @@ static int rfkill_event(void)
 			continue;
 
 		gettimeofday(&tv, NULL);
-		strtimeval_iso(&tv,
-			       ISO_8601_DATE |
-			       ISO_8601_TIME |
-			       ISO_8601_COMMAUSEC |
-			       ISO_8601_TIMEZONE |
-			       ISO_8601_SPACE, date_buf, sizeof(date_buf));
+		strtimeval_iso(&tv, ISO_TIMESTAMP_COMMA, date_buf,
+			       sizeof(date_buf));
 		printf("%s: idx %u type %u op %u soft %u hard %u\n",
 		       date_buf,
 		       event.idx, event.type, event.op, event.soft, event.hard);
diff --git a/term-utils/script.c b/term-utils/script.c
index cf63ab336..f991de14e 100644
--- a/term-utils/script.c
+++ b/term-utils/script.c
@@ -472,9 +472,7 @@ static void do_io(struct script_control *ctl)
 
 
 	if (ctl->typescriptfp) {
-		strtime_iso(&tvec, ISO_8601_DATE | ISO_8601_TIME |
-				ISO_8601_TIMEZONE | ISO_8601_SPACE,
-				buf, sizeof(buf));
+		strtime_iso(&tvec, ISO_TIMESTAMP, buf, sizeof(buf));
 		fprintf(ctl->typescriptfp, _("Script started on %s\n"), buf);
 	}
 	gettime_monotonic(&ctl->oldtime);
@@ -546,9 +544,7 @@ static void do_io(struct script_control *ctl)
 
 	if (ctl->typescriptfp) {
 		tvec = script_time((time_t *)NULL);
-		strtime_iso(&tvec, ISO_8601_DATE | ISO_8601_TIME |
-				ISO_8601_TIMEZONE | ISO_8601_SPACE,
-				buf, sizeof(buf));
+		strtime_iso(&tvec, ISO_TIMESTAMP, buf, sizeof(buf));
 		fprintf(ctl->typescriptfp, _("\nScript done on %s\n"), buf);
 	}
 	done(ctl);
