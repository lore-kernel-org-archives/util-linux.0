Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f171.google.com ([209.85.212.171]:34374 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755408Ab3FPSyc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Jun 2013 14:54:32 -0400
Received: by mail-wi0-f171.google.com with SMTP id hj3so1660673wib.4
        for <util-linux@vger.kernel.org>; Sun, 16 Jun 2013 11:54:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/15] dmesg: convert time format bitfield to enum
Date: Sun, 16 Jun 2013 19:53:49 +0100
Message-Id: <1371408836-16663-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
References: <1371408836-16663-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Foremost this commit makes time printing formats explicit.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 159 ++++++++++++++++++++++++++----------------------------
 1 file changed, 77 insertions(+), 82 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index ae8e938..5677836 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -126,6 +126,17 @@ enum {
 	DMESG_METHOD_MMAP	/* mmap file with records (see --file) */
 };
 
+enum {
+	DMESG_TIMEFTM_NONE = 0,
+	DMESG_TIMEFTM_CTIME,		/* [ctime] */
+	DMESG_TIMEFTM_CTIME_DELTA,	/* [ctime <delta>] */
+	DMESG_TIMEFTM_DELTA,		/* [<delta>] */
+	DMESG_TIMEFTM_RELTIME,		/* [relative] */
+	DMESG_TIMEFTM_TIME,		/* [time] */
+	DMESG_TIMEFTM_TIME_DELTA	/* [time <delta>] */
+};
+#define is_timefmt(c, f) (c->time_fmt == (DMESG_TIMEFTM_ ##f))
+
 struct dmesg_control {
 	/* bit arrays -- see include/bitops.h */
 	char levels[ARRAY_SIZE(level_names) / NBBY + 1];
@@ -152,16 +163,13 @@ struct dmesg_control {
 	char		*filename;
 	char		*mmap_buff;
 	size_t		pagesize;
+	unsigned int	time_fmt;	/* time format */
 
 	unsigned int	follow:1,	/* wait for new messages */
 			raw:1,		/* raw mode */
 			fltr_lev:1,	/* filter out by levels[] */
 			fltr_fac:1,	/* filter out by facilities[] */
 			decode:1,	/* use "facility: level: " prefix */
-			notime:1,	/* don't print timestamp */
-			delta:1,	/* show time deltas */
-			reltime:1,	/* show human readable relative times */
-			ctime:1,	/* show human readable time */
 			pager:1,	/* pipe output into a pager */
 			color:1;	/* colorize messages */
 };
@@ -689,9 +697,10 @@ static int get_next_syslog_record(struct dmesg_control *ctl,
 
 		if (*begin == '[' && (*(begin + 1) == ' ' ||
 				      isdigit(*(begin + 1)))) {
-			if (ctl->delta || ctl->ctime || ctl->reltime)
+
+			if (!is_timefmt(ctl, NONE))
 				begin = parse_syslog_timestamp(begin + 1, &rec->tv);
-			else if (ctl->notime)
+			else
 				begin = skip_item(begin, end, "]");
 
 			if (begin < end && *begin == ' ')
@@ -852,79 +861,53 @@ static void print_record(struct dmesg_control *ctl,
 		printf("%-6s:%-6s: ", facility_names[rec->facility].name,
 				      level_names[rec->level].name);
 
-	/*
-	 * [sec.usec <delta>] or [ctime <delta>]
-	 */
-	if (ctl->delta) {
-		if (ctl->color)
-			color_enable(DMESG_COLOR_TIME);
-		if (ctl->ctime)
-			printf("[%s ", record_ctime(ctl, rec, buf, sizeof(buf)));
-		else if (ctl->notime)
-			putchar('[');
-		else
-			printf("[%5d.%06d ", (int) rec->tv.tv_sec,
-					     (int) rec->tv.tv_usec);
-		printf("<%12.06f>] ", record_count_delta(ctl, rec));
-		if (ctl->color)
-			color_disable();
+	if (ctl->color)
+		color_enable(DMESG_COLOR_TIME);
 
-	/*
-	 * [ctime]
-	 */
-	} else if (ctl->ctime) {
-		if (ctl->color)
-			color_enable(DMESG_COLOR_TIME);
-		printf("[%s] ", record_ctime(ctl, rec, buf, sizeof(buf)));
-		if (ctl->color)
-			color_disable();
-	}
-
-	/*
-	 * [reltime]
-	 */
-	else if (ctl->reltime) {
+	switch (ctl->time_fmt) {
 		double delta;
 		struct tm cur;
-
+	case DMESG_TIMEFTM_NONE:
+		break;
+	case DMESG_TIMEFTM_CTIME:
+		printf("[%s] ", record_ctime(ctl, rec, buf, sizeof(buf)));
+		break;
+	case DMESG_TIMEFTM_CTIME_DELTA:
+		printf("[%s <%12.06f>] ",
+		       record_ctime(ctl, rec, buf, sizeof(buf)),
+		       record_count_delta(ctl, rec));
+		break;
+	case DMESG_TIMEFTM_DELTA:
+		printf("[<%12.06f>] ", record_count_delta(ctl, rec));
+		break;
+	case DMESG_TIMEFTM_RELTIME:
 		record_localtime(ctl, rec, &cur);
 		delta = record_count_delta(ctl, rec);
-
-		if (cur.tm_min  != ctl->lasttm.tm_min ||
+		if (cur.tm_min != ctl->lasttm.tm_min ||
 		    cur.tm_hour != ctl->lasttm.tm_hour ||
 		    cur.tm_yday != ctl->lasttm.tm_yday) {
-			if (ctl->color)
-				color_enable(DMESG_COLOR_RELTIME);
 			printf("[%s] ", short_ctime(&cur, buf, sizeof(buf)));
 		} else {
-			if (ctl->color)
-				color_enable(DMESG_COLOR_TIME);
 			if (delta < 10)
 				printf("[  %+8.06f] ", delta);
 			else
 				printf("[ %+9.06f] ", delta);
 		}
-		if (ctl->color)
-			color_disable();
 		ctl->lasttm = cur;
+		break;
+	case DMESG_TIMEFTM_TIME:
+		printf("[%5d.%06d] ", (int)rec->tv.tv_sec, (int)rec->tv.tv_usec);
+		break;
+	case DMESG_TIMEFTM_TIME_DELTA:
+		printf("[%5d.%06d <%12.06f>] ", (int)rec->tv.tv_sec,
+		       (int)rec->tv.tv_usec, record_count_delta(ctl, rec));
+		break;
+	default:
+		abort();
 	}
 
-	/*
-	 * In syslog output the timestamp is part of the message and we don't
-	 * parse the timestamp by default. We parse the timestamp only if
-	 * --show-delta or --ctime is specified.
-	 *
-	 * In kmsg output we always parse the timesptamp, so we have to compose
-	 * the [sec.usec] string.
-	 */
-	if (ctl->method == DMESG_METHOD_KMSG &&
-	    !ctl->notime && !ctl->delta && !ctl->ctime && !ctl->reltime) {
-		if (ctl->color)
-			color_enable(DMESG_COLOR_TIME);
-		printf("[%5d.%06d] ", (int) rec->tv.tv_sec, (int) rec->tv.tv_usec);
-		if (ctl->color)
-			color_disable();
-	}
+	if (ctl->color)
+		color_disable();
 
 mesg:
 	mesg = rec->mesg;
@@ -1065,7 +1048,7 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
 		goto mesg;
 
 	/* C) timestamp */
-	if (ctl->notime)
+	if (is_timefmt(ctl, NONE))
 		p = skip_item(p, end, ",;");
 	else
 		p = parse_kmsg_timestamp(p, &rec->tv);
@@ -1136,18 +1119,22 @@ static int read_kmsg(struct dmesg_control *ctl)
 	return 0;
 }
 
+#undef is_timefmt
+#define is_timefmt(c, f) (c.time_fmt == (DMESG_TIMEFTM_ ##f))
 int main(int argc, char *argv[])
 {
 	char *buf = NULL;
 	int  c, nopager = 0;
 	int  console_level = 0;
 	int  klog_rc = 0;
+	int  delta = 0;
 	ssize_t n;
 	static struct dmesg_control ctl = {
 		.filename = NULL,
 		.action = SYSLOG_ACTION_READ_ALL,
 		.method = DMESG_METHOD_KMSG,
 		.kmsg = -1,
+		.time_fmt = DMESG_TIMEFTM_TIME,
 	};
 	int colormode = UL_COLORMODE_NEVER;
 
@@ -1209,13 +1196,13 @@ int main(int argc, char *argv[])
 			ctl.action = SYSLOG_ACTION_CONSOLE_OFF;
 			break;
 		case 'd':
-			ctl.delta = 1;
+			delta = 1;
 			break;
 		case 'E':
 			ctl.action = SYSLOG_ACTION_CONSOLE_ON;
 			break;
 		case 'e':
-			ctl.reltime = 1;
+			ctl.time_fmt = DMESG_TIMEFTM_RELTIME;
 			break;
 		case 'F':
 			ctl.filename = optarg;
@@ -1228,7 +1215,7 @@ int main(int argc, char *argv[])
 				return EXIT_FAILURE;
 			break;
 		case 'H':
-			ctl.reltime = 1;
+			ctl.time_fmt = DMESG_TIMEFTM_RELTIME;
 			ctl.color = 1;
 			ctl.pager = 1;
 			break;
@@ -1260,6 +1247,8 @@ int main(int argc, char *argv[])
 			break;
 		case 'r':
 			ctl.raw = 1;
+			ctl.time_fmt = DMESG_TIMEFTM_NONE;
+			delta = 0;
 			break;
 		case 'S':
 			ctl.method = DMESG_METHOD_SYSLOG;
@@ -1271,12 +1260,11 @@ int main(int argc, char *argv[])
 				ctl.bufsize = 4096;
 			break;
 		case 'T':
-			ctl.boot_time = get_boot_time();
-			if (ctl.boot_time)
-				ctl.ctime = 1;
+			ctl.time_fmt = DMESG_TIMEFTM_CTIME;
 			break;
 		case 't':
-			ctl.notime = 1;
+			ctl.time_fmt = DMESG_TIMEFTM_NONE;
+			delta = 0;
 			break;
 		case 'u':
 			ctl.fltr_fac = 1;
@@ -1304,22 +1292,29 @@ int main(int argc, char *argv[])
 	if (argc > 1)
 		usage(stderr);
 
-	if (ctl.raw && (ctl.fltr_lev || ctl.fltr_fac || ctl.delta ||
-			ctl.notime || ctl.ctime || ctl.decode))
-		errx(EXIT_FAILURE, _("--raw can't be used together with level, "
-		     "facility, decode, delta, ctime or notime options"));
-
-	if (ctl.notime && (ctl.ctime || ctl.reltime))
-		errx(EXIT_FAILURE, _("--notime can't be used together with --ctime or --reltime"));
-	if (ctl.reltime && ctl.ctime)
-		errx(EXIT_FAILURE, _("--reltime can't be used together with --ctime "));
-
-	if (ctl.reltime) {
+	if (is_timefmt(ctl, RELTIME) || is_timefmt(ctl, CTIME)) {
 		ctl.boot_time = get_boot_time();
 		if (!ctl.boot_time)
-			ctl.reltime = 0;
+			ctl.time_fmt = DMESG_TIMEFTM_NONE;
 	}
 
+	if (delta)
+		switch (ctl.time_fmt) {
+		case DMESG_TIMEFTM_CTIME:
+			ctl.time_fmt = DMESG_TIMEFTM_CTIME_DELTA;
+			break;
+		case DMESG_TIMEFTM_TIME:
+			ctl.time_fmt = DMESG_TIMEFTM_TIME_DELTA;
+			break;
+		default:
+			ctl.time_fmt = DMESG_TIMEFTM_DELTA;
+		}
+
+	if (ctl.raw
+	    && (ctl.fltr_lev || ctl.fltr_fac || ctl.decode || !is_timefmt(ctl, NONE)))
+	    errx(EXIT_FAILURE, _("--raw can't be used together with level, "
+				 "facility, decode, delta, ctime or notime options"));
+
 	ctl.color = colors_init(colormode) ? 1 : 0;
 
 	ctl.pager = nopager ? 0 : ctl.pager;
-- 
1.8.3.1

