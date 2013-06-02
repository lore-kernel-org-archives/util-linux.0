Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:46452 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755027Ab3FBRwZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:52:25 -0400
Received: by mail-wg0-f48.google.com with SMTP id f12so2522872wgh.15
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:52:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 15/19] dmesg: add iso-8601 time format
Date: Sun,  2 Jun 2013 18:51:21 +0100
Message-Id: <1370195485-27907-16-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
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
 sys-utils/dmesg.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 6a8c64a..adfd6a5 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -131,6 +131,7 @@ enum {
 	TIMEFTM_CTIME	= (1 << 1),
 	TIMEFTM_DELTA	= (1 << 2),
 	TIMEFTM_RELTIME = (1 << 3),
+	TIMEFTM_ISO8601 = (1 << 4),
 };
 
 struct dmesg_control {
@@ -254,7 +255,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(_(" -w, --follow                wait for new messages\n"), out);
 	fputs(_(" -x, --decode                decode facility and level to readable string\n"), out);
 	fputs(_("     --time-format <format>  show time stamp using format:\n"
-		"                               [notime|ctime|delta|reltime]\n"), out);
+		"                               [notime|ctime|delta|reltime|iso]\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	fputs(USAGE_HELP, out);
 	fputs(USAGE_VERSION, out);
@@ -790,6 +791,23 @@ static char *short_ctime(struct tm *tm, char *buf, size_t bufsiz)
 	return buf;
 }
 
+static char *iso_8601_time(struct dmesg_control *ctl, struct dmesg_record *rec, char *buf,
+			   size_t bufsiz)
+{
+	struct tm tm;
+	size_t len;
+	record_localtime(ctl, rec, &tm);
+	if (strftime(buf, bufsiz, "%Y-%m-%dT%H:%M:%S", &tm) == 0) {
+		*buf = '\0';
+		return buf;
+	}
+	len = strlen(buf);
+	snprintf(buf + len, bufsiz - len, ",%06d", (int) rec->tv.tv_usec);
+	len = strlen(buf);
+	strftime(buf + len, bufsiz - len, "%z", &tm);
+	return buf;
+}
+
 static double record_count_delta(struct dmesg_control *ctl,
 				 struct dmesg_record *rec)
 {
@@ -888,6 +906,17 @@ static void print_record(struct dmesg_control *ctl,
 	}
 
 	/*
+	 * [iso-8601]
+	 */
+	else if (ctl->time_fmt & TIMEFTM_ISO8601) {
+		if (ctl->color)
+			color_enable(DMESG_COLOR_TIME);
+		printf("%s ", iso_8601_time(ctl, rec, buf, sizeof(buf)));
+		if (ctl->color)
+			color_disable();
+	}
+
+	/*
 	 * [reltime]
 	 */
 	else if (ctl->time_fmt & TIMEFTM_RELTIME) {
@@ -926,7 +955,8 @@ static void print_record(struct dmesg_control *ctl,
 	 */
 	if (ctl->method == DMESG_METHOD_KMSG &&
 	    !(ctl->time_fmt & TIMEFTM_NONE)
-	    && !(ctl->time_fmt & (TIMEFTM_CTIME | TIMEFTM_DELTA | TIMEFTM_RELTIME)))
+	    && !(ctl->time_fmt & (TIMEFTM_CTIME | TIMEFTM_DELTA |
+				  TIMEFTM_RELTIME | TIMEFTM_ISO8601)))
 	{
 		if (ctl->color)
 			color_enable(DMESG_COLOR_TIME);
@@ -1154,6 +1184,8 @@ static int which_time_format(const char *optarg)
 		return TIMEFTM_DELTA;
 	if (!strcmp(optarg, "reltime"))
 		return TIMEFTM_RELTIME;
+	if (!strcmp(optarg, "iso"))
+		return TIMEFTM_ISO8601;
 	errx(EXIT_FAILURE, _("unknown time format: %s"), optarg);
 }
 
@@ -1341,7 +1373,7 @@ int main(int argc, char *argv[])
 	if ((ctl.time_fmt & TIMEFTM_RELTIME) && (ctl.time_fmt & TIMEFTM_CTIME))
 		errx(EXIT_FAILURE, _("--reltime can't be used together with --ctime "));
 
-	if (ctl.time_fmt & (TIMEFTM_RELTIME | TIMEFTM_CTIME)) {
+	if (ctl.time_fmt & (TIMEFTM_RELTIME | TIMEFTM_CTIME | TIMEFTM_ISO8601)) {
 		ctl.boot_time = get_boot_time();
 		if (!ctl.boot_time)
 			ctl.time_fmt &= TIMEFTM_RELTIME | TIMEFTM_CTIME;
-- 
1.8.3

