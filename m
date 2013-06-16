Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:48869 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403Ab3FPSyh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:37 -0400
Received: by mail-wi0-f170.google.com with SMTP id ey16so3395495wid.5
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:36 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 10/15] dmesg: add iso-8601 time format
Date: Sun, 16 Jun 2013 19:53:51 +0100
Message-Id: <1371408836-16663-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The ISO-8601 should be welcomed by anyone who tries to parse dmesg time
stamp, and compare them across servers.  Time format tries to imitate
coreutils 'date --iso-8601=ns' output, but instead of having nanoseconds
the dmesg is using microseconds.

Reference: http://www.cs.tut.fi/~jkorpela/iso8601.html
Addresses: http://xkcd.com/1179/
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 2199e7f..be08f6c 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -133,7 +133,8 @@ enum {
 	DMESG_TIMEFTM_DELTA,		/* [<delta>] */
 	DMESG_TIMEFTM_RELTIME,		/* [relative] */
 	DMESG_TIMEFTM_TIME,		/* [time] */
-	DMESG_TIMEFTM_TIME_DELTA	/* [time <delta>] */
+	DMESG_TIMEFTM_TIME_DELTA,	/* [time <delta>] */
+	DMESG_TIMEFTM_ISO8601		/* 2013-06-13T22:11:00,123456+0100 */
 };
 #define is_timefmt(c, f) (c->time_fmt == (DMESG_TIMEFTM_ ##f))
 
@@ -258,7 +259,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -w, --follow                wait for new messages\n"), out);
 	fputs(_(" -x, --decode                decode facility and level to readable string\n"), out);
 	fputs(_("     --time-format <format>  show time stamp using format:\n"
-		"                               [delta|reltime|ctime|notime]\n"), out);
+		"                               [delta|reltime|ctime|notime|iso]\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -794,6 +795,23 @@ static char *short_ctime(struct tm *tm, char *buf, size_t bufsiz)
 	return buf;
 }
 
+static char *iso_8601_time(struct dmesg_control *ctl, struct dmesg_record *rec,
+			   char *buf, size_t bufsiz)
+{
+	struct tm tm;
+	size_t len;
+	record_localtime(ctl, rec, &tm);
+	if (strftime(buf, bufsiz, "%Y-%m-%dT%H:%M:%S", &tm) == 0) {
+		*buf = '\0';
+		return buf;
+	}
+	len = strlen(buf);
+	snprintf(buf + len, bufsiz - len, ",%06d", (int)rec->tv.tv_usec);
+	len = strlen(buf);
+	strftime(buf + len, bufsiz - len, "%z", &tm);
+	return buf;
+}
+
 static double record_count_delta(struct dmesg_control *ctl,
 				 struct dmesg_record *rec)
 {
@@ -904,6 +922,9 @@ static void print_record(struct dmesg_control *ctl,
 		printf("[%5d.%06d <%12.06f>] ", (int)rec->tv.tv_sec,
 		       (int)rec->tv.tv_usec, record_count_delta(ctl, rec));
 		break;
+	case DMESG_TIMEFTM_ISO8601:
+		printf("%s ", iso_8601_time(ctl, rec, buf, sizeof(buf)));
+		break;
 	default:
 		abort();
 	}
@@ -1131,6 +1152,8 @@ static int which_time_format(const char *optarg)
 		return DMESG_TIMEFTM_DELTA;
 	if (!strcmp(optarg, "reltime"))
 		return DMESG_TIMEFTM_RELTIME;
+	if (!strcmp(optarg, "iso"))
+		return DMESG_TIMEFTM_ISO8601;
 	errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
 }
 
@@ -1314,7 +1337,7 @@ int main(int argc, char *argv[])
 	if (argc > 1)
 		usage(stderr);
 
-	if (is_timefmt(ctl, RELTIME) || is_timefmt(ctl, CTIME)) {
+	if (is_timefmt(ctl, RELTIME) || is_timefmt(ctl, CTIME) || is_timefmt(ctl, ISO8601)) {
 		ctl.boot_time = get_boot_time();
 		if (!ctl.boot_time)
 			ctl.time_fmt = DMESG_TIMEFTM_NONE;
-- 
1.8.3.1

