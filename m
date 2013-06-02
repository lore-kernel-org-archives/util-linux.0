Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f172.google.com ([209.85.212.172]:34395 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754990Ab3FBRwU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Jun 2013 13:52:20 -0400
Received: by mail-wi0-f172.google.com with SMTP id m6so2028410wiv.5
        for <util-linux@vger.kernel.org>; Sun, 02 Jun 2013 10:52:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/19] dmesg: make time format parsing to use enum bit field
Date: Sun,  2 Jun 2013 18:51:19 +0100
Message-Id: <1370195485-27907-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
References: <1370195485-27907-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This will pave way to add single option to define all time formats, such
as --time-format=[ctime|reltime|delta|none].

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 59 +++++++++++++++++++++++++++++++------------------------
 1 file changed, 33 insertions(+), 26 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index ae8e938..b882120 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -126,6 +126,13 @@ enum {
 	DMESG_METHOD_MMAP	/* mmap file with records (see --file) */
 };
 
+enum {
+	TIMEFTM_NONE	= (1 << 0),
+	TIMEFTM_CTIME	= (1 << 1),
+	TIMEFTM_DELTA	= (1 << 2),
+	TIMEFTM_RELTIME = (1 << 3),
+};
+
 struct dmesg_control {
 	/* bit arrays -- see include/bitops.h */
 	char levels[ARRAY_SIZE(level_names) / NBBY + 1];
@@ -152,16 +159,13 @@ struct dmesg_control {
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
@@ -689,9 +693,10 @@ static int get_next_syslog_record(struct dmesg_control *ctl,
 
 		if (*begin == '[' && (*(begin + 1) == ' ' ||
 				      isdigit(*(begin + 1)))) {
-			if (ctl->delta || ctl->ctime || ctl->reltime)
+			if (ctl->time_fmt & (TIMEFTM_DELTA | TIMEFTM_CTIME | TIMEFTM_RELTIME))
 				begin = parse_syslog_timestamp(begin + 1, &rec->tv);
-			else if (ctl->notime)
+
+			else if (ctl->time_fmt & TIMEFTM_NONE)
 				begin = skip_item(begin, end, "]");
 
 			if (begin < end && *begin == ' ')
@@ -855,12 +860,12 @@ static void print_record(struct dmesg_control *ctl,
 	/*
 	 * [sec.usec <delta>] or [ctime <delta>]
 	 */
-	if (ctl->delta) {
+	if (ctl->time_fmt & TIMEFTM_DELTA) {
 		if (ctl->color)
 			color_enable(DMESG_COLOR_TIME);
-		if (ctl->ctime)
+		if (ctl->time_fmt & TIMEFTM_CTIME)
 			printf("[%s ", record_ctime(ctl, rec, buf, sizeof(buf)));
-		else if (ctl->notime)
+		else if (ctl->time_fmt == TIMEFTM_NONE)
 			putchar('[');
 		else
 			printf("[%5d.%06d ", (int) rec->tv.tv_sec,
@@ -872,7 +877,7 @@ static void print_record(struct dmesg_control *ctl,
 	/*
 	 * [ctime]
 	 */
-	} else if (ctl->ctime) {
+	} else if (ctl->time_fmt & TIMEFTM_CTIME) {
 		if (ctl->color)
 			color_enable(DMESG_COLOR_TIME);
 		printf("[%s] ", record_ctime(ctl, rec, buf, sizeof(buf)));
@@ -883,7 +888,7 @@ static void print_record(struct dmesg_control *ctl,
 	/*
 	 * [reltime]
 	 */
-	else if (ctl->reltime) {
+	else if (ctl->time_fmt & TIMEFTM_RELTIME) {
 		double delta;
 		struct tm cur;
 
@@ -918,14 +923,15 @@ static void print_record(struct dmesg_control *ctl,
 	 * the [sec.usec] string.
 	 */
 	if (ctl->method == DMESG_METHOD_KMSG &&
-	    !ctl->notime && !ctl->delta && !ctl->ctime && !ctl->reltime) {
+	    !(ctl->time_fmt & TIMEFTM_NONE)
+	    && !(ctl->time_fmt & (TIMEFTM_CTIME | TIMEFTM_DELTA | TIMEFTM_RELTIME)))
+	{
 		if (ctl->color)
 			color_enable(DMESG_COLOR_TIME);
 		printf("[%5d.%06d] ", (int) rec->tv.tv_sec, (int) rec->tv.tv_usec);
 		if (ctl->color)
 			color_disable();
 	}
-
 mesg:
 	mesg = rec->mesg;
 	mesg_size = rec->mesg_size;
@@ -1065,7 +1071,7 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
 		goto mesg;
 
 	/* C) timestamp */
-	if (ctl->notime)
+	if (ctl->time_fmt & TIMEFTM_NONE)
 		p = skip_item(p, end, ",;");
 	else
 		p = parse_kmsg_timestamp(p, &rec->tv);
@@ -1148,6 +1154,7 @@ int main(int argc, char *argv[])
 		.action = SYSLOG_ACTION_READ_ALL,
 		.method = DMESG_METHOD_KMSG,
 		.kmsg = -1,
+		.time_fmt = 0,
 	};
 	int colormode = UL_COLORMODE_NEVER;
 
@@ -1209,13 +1216,13 @@ int main(int argc, char *argv[])
 			ctl.action = SYSLOG_ACTION_CONSOLE_OFF;
 			break;
 		case 'd':
-			ctl.delta = 1;
+			ctl.time_fmt |= TIMEFTM_DELTA;
 			break;
 		case 'E':
 			ctl.action = SYSLOG_ACTION_CONSOLE_ON;
 			break;
 		case 'e':
-			ctl.reltime = 1;
+			ctl.time_fmt |= TIMEFTM_RELTIME;
 			break;
 		case 'F':
 			ctl.filename = optarg;
@@ -1228,7 +1235,7 @@ int main(int argc, char *argv[])
 				return EXIT_FAILURE;
 			break;
 		case 'H':
-			ctl.reltime = 1;
+			ctl.time_fmt |= TIMEFTM_RELTIME;
 			ctl.color = 1;
 			ctl.pager = 1;
 			break;
@@ -1273,10 +1280,10 @@ int main(int argc, char *argv[])
 		case 'T':
 			ctl.boot_time = get_boot_time();
 			if (ctl.boot_time)
-				ctl.ctime = 1;
+				ctl.time_fmt |= TIMEFTM_CTIME;
 			break;
 		case 't':
-			ctl.notime = 1;
+			ctl.time_fmt |= TIMEFTM_NONE;
 			break;
 		case 'u':
 			ctl.fltr_fac = 1;
@@ -1304,20 +1311,20 @@ int main(int argc, char *argv[])
 	if (argc > 1)
 		usage(stderr);
 
-	if (ctl.raw && (ctl.fltr_lev || ctl.fltr_fac || ctl.delta ||
-			ctl.notime || ctl.ctime || ctl.decode))
+	if (ctl.raw && (ctl.fltr_lev || ctl.fltr_fac || ctl.decode ||
+			ctl.time_fmt & (TIMEFTM_NONE | TIMEFTM_DELTA | TIMEFTM_CTIME)))
 		errx(EXIT_FAILURE, _("--raw can't be used together with level, "
-		     "facility, decode, delta, ctime or notime options"));
+				     "facility, decode, delta, ctime or notime options"));
 
-	if (ctl.notime && (ctl.ctime || ctl.reltime))
+	if (ctl.time_fmt & TIMEFTM_NONE && (ctl.time_fmt & (TIMEFTM_CTIME | TIMEFTM_RELTIME)))
 		errx(EXIT_FAILURE, _("--notime can't be used together with --ctime or --reltime"));
-	if (ctl.reltime && ctl.ctime)
+	if ((ctl.time_fmt & TIMEFTM_RELTIME) && (ctl.time_fmt & TIMEFTM_CTIME))
 		errx(EXIT_FAILURE, _("--reltime can't be used together with --ctime "));
 
-	if (ctl.reltime) {
+	if (ctl.time_fmt & TIMEFTM_RELTIME) {
 		ctl.boot_time = get_boot_time();
 		if (!ctl.boot_time)
-			ctl.reltime = 0;
+			ctl.time_fmt &= TIMEFTM_RELTIME;
 	}
 
 	ctl.color = colors_init(colormode) ? 1 : 0;
-- 
1.8.3

