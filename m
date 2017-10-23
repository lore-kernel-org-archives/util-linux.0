Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:64059 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932158AbdJWAll (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Sun, 22 Oct 2017 20:41:41 -0400
Subject: [PATCH 4/4] lib/timeutils: add common ISO timestamp masks
To: Karel Zak <kzak@redhat.com>
References: <ac1afb00-aed1-4eed-aabe-89d26e29ca0d@gmx.com>
Cc: util-linux@vger.kernel.org
From: J William Piggott <elseifthen@gmx.com>
Message-ID: <661c0a48-59bb-8263-9fd7-c1ef80b160f2@gmx.com>
Date: Sun, 22 Oct 2017 20:41:33 -0400
MIME-Version: 1.0
In-Reply-To: <ac1afb00-aed1-4eed-aabe-89d26e29ca0d@gmx.com>
Content-Type: text/plain; charset=windows-1252
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


* Start the ISO format flags at bit 0 instead of bit 1.

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
 include/timeutils.h    | 20 ++++++++++++++------
 lib/timeutils.c        |  2 +-
 login-utils/last.c     |  2 +-
 login-utils/lslogins.c |  3 +--
 login-utils/utmpdump.c |  4 +---
 misc-utils/uuidparse.c | 10 ++--------
 sys-utils/dmesg.c      |  4 +---
 sys-utils/hwclock.c    |  4 +---
 sys-utils/lsipc.c      |  2 +-
 sys-utils/rfkill.c     |  8 ++------
 term-utils/script.c    |  8 ++------
 11 files changed, 27 insertions(+), 40 deletions(-)

diff --git a/include/timeutils.h b/include/timeutils.h
index e8a261462..7d5b13b2d 100644
--- a/include/timeutils.h
+++ b/include/timeutils.h
@@ -55,15 +55,23 @@ typedef uint64_t nsec_t;
 int parse_timestamp(const char *t, usec_t *usec);
 int get_gmtoff(const struct tm *tp);
 
-/* flags for strxxx_iso() functions */
+/* flags and masks for strxxx_iso() functions */
 enum {
-	ISO_8601_DATE		= (1 << 1),
-	ISO_8601_TIME		= (1 << 2),
+	ISO_8601_DATE		= (1 << 0),
+	ISO_8601_TIME		= (1 << 1),
+	ISO_8601_TIMEZONE	= (1 << 2),
 	ISO_8601_DOTUSEC	= (1 << 3),
 	ISO_8601_COMMAUSEC	= (1 << 4),
-	ISO_8601_TIMEZONE	= (1 << 5),
-	ISO_8601_SPACE		= (1 << 6),
-	ISO_8601_GMTIME		= (1 << 7)
+	ISO_8601_T		= (1 << 5),
+	ISO_8601_GMTIME		= (1 << 6),
+	ISO_TIMESTAMP		= 0x07,   /* 2017-10-13 17:27:04-04:00 */
+	ISO_TIMESTAMP_T		= 0x27,   /* 2017-10-13T17:27:04-04:00 */
+	ISO_TIMESTAMP_DOT	= 0x0F,   /* 2017-10-13 17:27:04.350452-04:00 */
+	ISO_TIMESTAMP_DOT_T	= 0x2F,   /* 2017-10-13T17:27:04.350452-04:00 */
+	ISO_TIMESTAMP_COMMA	= 0x17,   /* 2017-10-13 17:27:04,350452-04:00 */
+	ISO_TIMESTAMP_COMMA_T	= 0x37,   /* 2017-10-13T17:27:04,350452-04:00 */
+	ISO_TIMESTAMP_COMMA_G	= 0x57,   /* 2017-10-13 21:27:04,350452+00:00 */
+	ISO_TIMESTAMP_COMMA_GT  = 0x77    /* 2017-10-13T21:27:04,350452+00:00 */
 };
 
 #define ISO_8601_BUFSIZ	42
diff --git a/lib/timeutils.c b/lib/timeutils.c
index adc255c33..21d384c58 100644
--- a/lib/timeutils.c
+++ b/lib/timeutils.c
@@ -417,7 +417,7 @@ static int format_iso_time(struct tm *tm, suseconds_t usec, int flags, char *buf
 	if ((flags & ISO_8601_DATE) && (flags & ISO_8601_TIME)) {
 		if (bufsz < 1)
 			return -1;
-		*p++ = (flags & ISO_8601_SPACE) ? ' ' : 'T';
+		*p++ = (flags & ISO_8601_T) ? 'T' : ' ';
 		bufsz--;
 	}
 
diff --git a/login-utils/last.c b/login-utils/last.c
index f989836ba..8d69ed54e 100644
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
index 1042b9b41..9a55df880 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -333,8 +333,7 @@ static char *make_time(int mode, time_t time)
 				buf, sizeof(buf));
 		break;
 	case TIME_ISO:
-		rc = strtime_iso(&time, ISO_8601_DATE|ISO_8601_TIME|ISO_8601_TIMEZONE,
-				   buf, sizeof(buf));
+		rc = strtime_iso(&time, ISO_TIMESTAMP_T, buf, sizeof(buf));
 		break;
 	case TIME_ISO_SHORT:
 		rc = strtime_iso(&time, ISO_8601_DATE, buf, sizeof(buf));
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
index 08ba33415..5d2ea7810 100644
--- a/misc-utils/uuidparse.c
+++ b/misc-utils/uuidparse.c
@@ -227,14 +227,8 @@ static void fill_table_row(struct libscols_table *tb, char const *const uuid)
 				char date_buf[ISO_8601_BUFSIZ + 4];
 
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
index b626380f7..8a86c2ccb 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -844,9 +844,7 @@ static char *iso_8601_time(struct dmesg_control *ctl, struct dmesg_record *rec,
 		.tv_usec = rec->tv.tv_usec
 	};
 
-	if (strtimeval_iso(&tv,	ISO_8601_DATE|ISO_8601_TIME|ISO_8601_COMMAUSEC|
-				ISO_8601_TIMEZONE,
-				buf, bufsz) != 0)
+	if (strtimeval_iso(&tv,	ISO_TIMESTAMP_COMMA_T, buf, bufsz) != 0)
 		return NULL;
 
 	return buf;
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 3ac43efee..c1eb8b939 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -556,9 +556,7 @@ display_time(struct timeval hwctime)
 {
 	char buf[ISO_8601_BUFSIZ];
 
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
index c9559ef48..044624188 100644
--- a/sys-utils/rfkill.c
+++ b/sys-utils/rfkill.c
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
