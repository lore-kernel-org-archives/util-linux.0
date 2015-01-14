Return-Path: util-linux-owner@vger.kernel.org
Received: from mout6.wup.tal.de ([195.8.233.33]:42717 "EHLO mout6.wup.tal.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752450AbbANSrh (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 14 Jan 2015 13:47:37 -0500
Received: from point.localnet (mue-88-130-84-236.dsl.tropolys.de [88.130.84.236])
	(Authenticated sender: ib@wtal.de)
	by smtp.tal.de (Postfix) with ESMTPA id 3C93E860D488
	for <util-linux@vger.kernel.org>; Wed, 14 Jan 2015 19:39:46 +0100 (CET)
Received: from ib by point.localnet with local (masqmail 0.2.21) id
 1YBSr3-0je-00 for <util-linux@vger.kernel.org>; Wed, 14 Jan 2015
 19:39:45 +0100
Message-ID: <54b6b75c.0b36989b.bm000@wupperonline.de>
From: =?ISO-8859-1?Q?Ingo=20Br=FCckl?= <ib@wupperonline.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] dmesg: Enable proper indent for messages containing line breaks
Date: Wed, 14 Jan 2015 19:36:55 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Messages containing line breaks somehow look broken when additional time,
facility or level information is displayed, because they partly appear in
time/facility/level column.

Indent them accordingly.


diff -Nur a/sys-utils/dmesg.c b/sys-utils/dmesg.c
--- a/sys-utils/dmesg.c	2014-10-24 11:21:20.441389247 +0200
+++ b/sys-utils/dmesg.c	2015-01-14 14:55:07.759977346 +0100
@@ -195,6 +195,7 @@
 			decode:1,	/* use "facility: level: " prefix */
 			pager:1,	/* pipe output into a pager */
 			color:1;	/* colorize messages */
+	int		indent;		/* due to timestamps if newline */
 };

 struct dmesg_record {
@@ -602,9 +603,10 @@
 /*
  * Prints to 'out' and non-printable chars are replaced with \x<hex> sequences.
  */
-static void safe_fwrite(const char *buf, size_t size, FILE *out)
+static void safe_fwrite(const char *buf, size_t size, int indent, FILE *out)
 {
 	size_t i;
+	int in;
 #ifdef HAVE_WIDECHAR
 	mbstate_t s;
 	memset(&s, 0, sizeof (s));
@@ -636,6 +638,15 @@
 #endif
 		if (hex)
 			rc = fwrite_hex(p, len, out);
+		else if (*p == '\n' && *(p + 1) && indent) {
+			char s = ' ';
+			rc = fwrite(p, 1, len, out) != len;
+			in = indent;
+			do {
+				if (!rc) rc = fwrite(&s, 1, 1, out) != 1;
+				in--;
+			} while (in && !rc);
+		}
 		else
 			rc = fwrite(p, 1, len, out) != len;
 		if (rc != 0) {
@@ -760,7 +771,7 @@
 		/*
 		 * Print whole ring buffer
 		 */
-		safe_fwrite(buf, size, stdout);
+		safe_fwrite(buf, size, ctl->indent, stdout);
 		lastc = buf[size - 1];
 	} else {
 		/*
@@ -770,7 +781,7 @@
 			size_t sz = size > ctl->pagesize ? ctl->pagesize : size;
 			char *x = ctl->mmap_buff;

-			safe_fwrite(x, sz, stdout);
+			safe_fwrite(x, sz, ctl->indent, stdout);
 			lastc = x[sz - 1];
 			size -= sz;
 			ctl->mmap_buff += sz;
@@ -865,6 +876,7 @@
 	int has_color = 0;
 	const char *mesg;
 	size_t mesg_size;
+	int indent = 0;

 	if (!accept_record(ctl, rec))
 		return;
@@ -879,10 +891,10 @@
 	 * backward compatibility with syslog(2) buffers only
 	 */
 	if (ctl->raw) {
-		printf("<%d>[%5d.%06d] ",
-			LOG_MAKEPRI(rec->facility, rec->level),
-			(int) rec->tv.tv_sec,
-			(int) rec->tv.tv_usec);
+		ctl->indent = printf("<%d>[%5d.%06d] ",
+				     LOG_MAKEPRI(rec->facility, rec->level),
+				     (int) rec->tv.tv_sec,
+				     (int) rec->tv.tv_usec);

 		goto mesg;
 	}
@@ -893,8 +905,8 @@
 	if (ctl->decode &&
 	    -1 < rec->level    && rec->level     < (int) ARRAY_SIZE(level_names) &&
 	    -1 < rec->facility && rec->facility  < (int) ARRAY_SIZE(facility_names))
-		printf("%-6s:%-6s: ", facility_names[rec->facility].name,
-				      level_names[rec->level].name);
+		indent = printf("%-6s:%-6s: ", facility_names[rec->facility].name,
+				               level_names[rec->level].name);

 	if (ctl->color)
 		dmesg_enable_color(DMESG_COLOR_TIME);
@@ -903,17 +915,18 @@
 		double delta;
 		struct tm cur;
 	case DMESG_TIMEFTM_NONE:
+		ctl->indent = 0;
 		break;
 	case DMESG_TIMEFTM_CTIME:
-		printf("[%s] ", record_ctime(ctl, rec, buf, sizeof(buf)));
+		ctl->indent = printf("[%s] ", record_ctime(ctl, rec, buf, sizeof(buf)));
 		break;
 	case DMESG_TIMEFTM_CTIME_DELTA:
-		printf("[%s <%12.06f>] ",
-		       record_ctime(ctl, rec, buf, sizeof(buf)),
-		       record_count_delta(ctl, rec));
+		ctl->indent = printf("[%s <%12.06f>] ",
+		       		     record_ctime(ctl, rec, buf, sizeof(buf)),
+		       		     record_count_delta(ctl, rec));
 		break;
 	case DMESG_TIMEFTM_DELTA:
-		printf("[<%12.06f>] ", record_count_delta(ctl, rec));
+		ctl->indent = printf("[<%12.06f>] ", record_count_delta(ctl, rec));
 		break;
 	case DMESG_TIMEFTM_RELTIME:
 		record_localtime(ctl, rec, &cur);
@@ -921,29 +934,31 @@
 		if (cur.tm_min != ctl->lasttm.tm_min ||
 		    cur.tm_hour != ctl->lasttm.tm_hour ||
 		    cur.tm_yday != ctl->lasttm.tm_yday) {
-			printf("[%s] ", short_ctime(&cur, buf, sizeof(buf)));
+			ctl->indent = printf("[%s] ", short_ctime(&cur, buf, sizeof(buf)));
 		} else {
 			if (delta < 10)
-				printf("[  %+8.06f] ", delta);
+				ctl->indent = printf("[  %+8.06f] ", delta);
 			else
-				printf("[ %+9.06f] ", delta);
+				ctl->indent = printf("[ %+9.06f] ", delta);
 		}
 		ctl->lasttm = cur;
 		break;
 	case DMESG_TIMEFTM_TIME:
-		printf("[%5d.%06d] ", (int)rec->tv.tv_sec, (int)rec->tv.tv_usec);
+		ctl->indent = printf("[%5d.%06d] ", (int)rec->tv.tv_sec, (int)rec->tv.tv_usec);
 		break;
 	case DMESG_TIMEFTM_TIME_DELTA:
-		printf("[%5d.%06d <%12.06f>] ", (int)rec->tv.tv_sec,
-		       (int)rec->tv.tv_usec, record_count_delta(ctl, rec));
+		ctl->indent = printf("[%5d.%06d <%12.06f>] ", (int)rec->tv.tv_sec,
+		       		     (int)rec->tv.tv_usec, record_count_delta(ctl, rec));
 		break;
 	case DMESG_TIMEFTM_ISO8601:
-		printf("%s ", iso_8601_time(ctl, rec, buf, sizeof(buf)));
+		ctl->indent = printf("%s ", iso_8601_time(ctl, rec, buf, sizeof(buf)));
 		break;
 	default:
 		abort();
 	}

+	ctl->indent += indent;
+
 	if (ctl->color)
 		color_disable();

@@ -957,7 +972,7 @@
 		const char *subsys = get_subsys_delimiter(mesg, mesg_size);
 		if (subsys) {
 			dmesg_enable_color(DMESG_COLOR_SUBSYS);
-			safe_fwrite(mesg, subsys - mesg, stdout);
+			safe_fwrite(mesg, subsys - mesg, ctl->indent, stdout);
 			color_disable();

 			mesg_size -= subsys - mesg;
@@ -965,11 +980,11 @@
 		}
 		/* error, alert .. etc. colors */
 		has_color = set_level_color(rec->level, mesg, mesg_size) == 0;
-		safe_fwrite(mesg, mesg_size, stdout);
+		safe_fwrite(mesg, mesg_size, ctl->indent, stdout);
 		if (has_color)
 			color_disable();
 	} else
-		safe_fwrite(mesg, mesg_size, stdout);
+		safe_fwrite(mesg, mesg_size, ctl->indent, stdout);

 	if (*(mesg + mesg_size - 1) != '\n')
 		putchar('\n');
@@ -1188,6 +1203,7 @@
 		.method = DMESG_METHOD_KMSG,
 		.kmsg = -1,
 		.time_fmt = DMESG_TIMEFTM_TIME,
+		.indent = 0,
 	};
 	int colormode = UL_COLORMODE_UNDEF;
 	enum {
