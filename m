Return-Path: <util-linux-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7D8EC4332F
	for <util-linux@archiver.kernel.org>; Fri, 10 Nov 2023 23:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229679AbjKJX1H (ORCPT <rfc822;util-linux@archiver.kernel.org>);
        Fri, 10 Nov 2023 18:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjKJX1H (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Fri, 10 Nov 2023 18:27:07 -0500
Received: from mail-yw1-x1164.google.com (mail-yw1-x1164.google.com [IPv6:2607:f8b0:4864:20::1164])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6B58D64
        for <util-linux@vger.kernel.org>; Fri, 10 Nov 2023 15:27:02 -0800 (PST)
Received: by mail-yw1-x1164.google.com with SMTP id 00721157ae682-5b3b17d36d5so31519777b3.0
        for <util-linux@vger.kernel.org>; Fri, 10 Nov 2023 15:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699658822; x=1700263622;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/sMVr0tjtnPib4bsltm4MgzqLDsb2A1voo2chBfS+wA=;
        b=cW7dZe58l7Yxn3GfyHUvF9a8obGb4WGdJebqZqRS+Q45mj6JiC2xDNesuNLOmcWSZK
         WnFF001VE1ehMqUEKh/GwTpAm0v65QwQZE/sAZhO7A8xKPDLfsXu06golXWVhWatDCR3
         QSEfS9NhFiZGoEIxKgZDhTynRlfmmP/EUEQo0MVg121IYfQd09jkWWpw+dUw5tID4tMS
         wjCIcA/7vsBDC5Hx3cwr+Hc/26uEWxkt3fpiuaxNevaB9R+YRk4qx1pqwOytuNyS3ZNl
         jCnPKroBf5bZPh/3NXdvcDkCkupWB2a3I7CwoZB4X1iW8nBc/2kKjDYTD380SDJJyboz
         MCcw==
X-Gm-Message-State: AOJu0YyVJfxSfSHzosCow5mCjhg3HFhQ3DP48zCsUafjbteuVhyclQNr
        FvHeuWqUDKKt/7aV9FjSaVMTZ/q0FGU8W8TbAHs2g9Fa39Is
X-Google-Smtp-Source: AGHT+IF0Fw01AHT+Xx9bx63orRhnJ4ruildj2ycmQnUVufPo6P4C0ufy/Ua9gyzv6lT4MIbDXA/z7+D317qa
X-Received: by 2002:a81:7c02:0:b0:5a7:b4d1:c4dd with SMTP id x2-20020a817c02000000b005a7b4d1c4ddmr453366ywc.5.1699658821862;
        Fri, 10 Nov 2023 15:27:01 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id c197-20020a814ece000000b005a7dddb5e52sm735232ywb.9.2023.11.10.15.27.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2023 15:27:01 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from rthukral-upstreamDmesgFix-1.sjc.aristanetworks.com (dhcp-245-203-220.sjc.aristanetworks.com [10.245.203.220])
        by smtp.aristanetworks.com (Postfix) with ESMTP id B872C402056;
        Fri, 10 Nov 2023 15:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
        s=Arista-A; t=1699658819;
        bh=/sMVr0tjtnPib4bsltm4MgzqLDsb2A1voo2chBfS+wA=;
        h=From:To:Cc:Subject:Date:From;
        b=CR1KwMdYHfJ0qSg6CZkOysA9fB1whZTx1yp3cc9VZiZkRv+kKKpLigX6FmOp/RliB
         i2oKLZVZ7EASLFZQW1uUhjwbjMkzl3f6paNVpVxNORgTie3zNNp0Ov8Id1fXzI0TPc
         7aGqgXZ9iWXnmVZsBPOVb5uLXQfbh1BaJ7PVURpCkqjcyXTJbUgy3A7RBY1l/YDnyq
         nu4V1f5zDpG80OvHW/qtDNvg3J7uQKIE0GMD/fJIZSvLokKpheNWxFs6R2OAehb2mw
         a9TZNylnAQ8ZCxZTNCn58sDUnfljIZ+5opdYDpYH5H5WCpCL5jIVk7VAWFBpxKHLYF
         UR4YAfr62j6Wg==
From:   Rishabh Thukral <rthukral@arista.com>
To:     util-linux@vger.kernel.org, kzak@redhat.com
Cc:     colona@arista.com, Rishabh Thukral <rthukral@arista.com>
Subject: [PATCH] util-linux/sys-utils dmesg support for additional human readable timestamp
Date:   Fri, 10 Nov 2023 15:26:12 -0800
Message-ID: <20231110232612.10969-1-rthukral@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <util-linux.vger.kernel.org>
X-Mailing-List: util-linux@vger.kernel.org

The dmesg logs have timestamps in seconds since boot format which can
be converted to other formats. However, there is no option to include
both the original timestamp as present in the buffer along with the
converted timestamp in the specified format.

This change updates the --time-format option in dmesg to enable the
user to specify it multiple times with different formats with each
input providing a timestamp format among the currently supported
choices. This enables seeing the dmesg logs in both seconds since boot
and human readable format simultaneously in each row of the log output.
The sequence of timestamp format is fixed and independent of the order
in which the user provides the desired formats.

Signed-off-by: Rishabh Thukral <rthukral@arista.com>
---
 sys-utils/dmesg.1.adoc |   4 +-
 sys-utils/dmesg.c      | 228 ++++++++++++++++++++++++-----------------
 2 files changed, 138 insertions(+), 94 deletions(-)

diff --git a/sys-utils/dmesg.1.adoc b/sys-utils/dmesg.1.adoc
index 6f4941ede..a968fe9f9 100644
--- a/sys-utils/dmesg.1.adoc
+++ b/sys-utils/dmesg.1.adoc
@@ -133,9 +133,11 @@ Display record until the specified time. Supported is the subsecond granularity.
 Do not print kernel's timestamps.
 
 *--time-format* _format_::
-Print timestamps using the given _format_, which can be *ctime*, *reltime*, *delta* or *iso*. The first three formats are aliases of the time-format-specific options. The *iso* format is a *dmesg* implementation of the ISO-8601 timestamp format. The purpose of this format is to make the comparing of timestamps between two systems, and any other parsing, easy. The definition of the *iso* timestamp is: YYYY-MM-DD<T>HH:MM:SS,<microseconds><-+><timezone offset from UTC>.
+Print timestamps using the given _format_, which can be *ctime*, *reltime*, *delta*, *iso* or *raw*. The first three formats are aliases of the time-format-specific options. The *raw* format uses the default timestamp format showing seconds since boot. The *iso* format is a *dmesg* implementation of the ISO-8601 timestamp format. The purpose of this format is to make the comparing of timestamps between two systems, and any other parsing, easy. The definition of the *iso* timestamp is: YYYY-MM-DD<T>HH:MM:SS,<microseconds><-+><timezone offset from UTC>.
 +
 The *iso* format has the same issue as *ctime*: the time may be inaccurate when a system is suspended and resumed.
++
+*--time-format* may be used multiple times with different values for _format_ to output each specified format in the following sequence *ctime, delta, reltime, raw, iso*
 
 *-u*, *--userspace*::
 Print userspace messages.
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 79e1c1690..9c8fea6c2 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -161,7 +161,13 @@ enum {
 	DMESG_TIMEFTM_TIME_DELTA,	/* [time <delta>] */
 	DMESG_TIMEFTM_ISO8601		/* 2013-06-13T22:11:00,123456+0100 */
 };
-#define is_timefmt(c, f) ((c)->time_fmt == (DMESG_TIMEFTM_ ##f))
+#define TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED 8
+
+enum {
+	TIMESTAMP_FMT_UNSET = 0,
+	TIMESTAMP_FMT_SET = 1,
+	TIMESTAMP_FMT_INIT_SET = 2
+};
 
 struct dmesg_control {
 	/* bit arrays -- see include/bitops.h */
@@ -199,7 +205,7 @@ struct dmesg_control {
 	char		*filename;
 	char		*mmap_buff;
 	size_t		pagesize;
-	unsigned int	time_fmt;	/* time format */
+	unsigned int	time_fmts[TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED];	/* time format */
 
 	struct ul_jsonwrt jfmt;		/* -J formatting */
 
@@ -316,7 +322,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -T, --ctime                 show human-readable timestamp (may be inaccurate!)\n"), out);
 	fputs(_(" -t, --notime                don't show any timestamp with messages\n"), out);
 	fputs(_("     --time-format <format>  show timestamp using the given format:\n"
-		"                               [delta|reltime|ctime|notime|iso]\n"
+		"                               [delta|reltime|ctime|notime|iso|raw]\n"
 		"Suspending/resume will make ctime and iso timestamps inaccurate.\n"), out);
 	fputs(_("     --since <time>          display the lines since the specified time\n"), out);
 	fputs(_("     --until <time>          display the lines until the specified time\n"), out);
@@ -764,7 +770,7 @@ static int get_next_syslog_record(struct dmesg_control *ctl,
 		if (*begin == '[' && (*(begin + 1) == ' ' ||
 				      isdigit(*(begin + 1)))) {
 
-			if (!is_timefmt(ctl, NONE))
+			if (ctl->time_fmts[DMESG_TIMEFTM_NONE] == TIMESTAMP_FMT_UNSET)
 				begin = parse_syslog_timestamp(begin + 1, &rec->tv);
 			else
 				begin = skip_item(begin, end, "]");
@@ -939,10 +945,21 @@ static void print_record(struct dmesg_control *ctl,
 	char buf[128];
 	char fpbuf[32] = "\0";
 	char tsbuf[64] = "\0";
+	char full_tsbuf[64*TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED] = "\0";
 	size_t mesg_size = rec->mesg_size;
 	int timebreak = 0;
 	char *mesg_copy = NULL;
 	const char *line = NULL;
+	unsigned int ts_format_sequence[TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED] = {
+		DMESG_TIMEFTM_NONE,
+		DMESG_TIMEFTM_CTIME, DMESG_TIMEFTM_CTIME_DELTA,
+		DMESG_TIMEFTM_DELTA,
+		DMESG_TIMEFTM_RELTIME,
+		DMESG_TIMEFTM_TIME, DMESG_TIMEFTM_TIME_DELTA,
+		DMESG_TIMEFTM_ISO8601
+	};
+	int format_iterator = 0;
+	double delta = record_count_delta(ctl, rec);
 
 	if (!accept_record(ctl, rec))
 		return;
@@ -967,7 +984,7 @@ static void print_record(struct dmesg_control *ctl,
 	 * backward compatibility with syslog(2) buffers only
 	 */
 	if (ctl->raw) {
-		ctl->indent = snprintf(tsbuf, sizeof(tsbuf),
+		ctl->indent = snprintf(full_tsbuf, sizeof(full_tsbuf),
 				       "<%d>[%5ld.%06ld] ",
 				       LOG_RAW_FAC_PRI(rec->facility, rec->level),
 				       (long) rec->tv.tv_sec,
@@ -982,64 +999,73 @@ static void print_record(struct dmesg_control *ctl,
 			 level_names[rec->level].name);
 
 	/* Store the timestamp in a buffer */
-	switch (ctl->time_fmt) {
-		double delta;
-		struct tm cur;
-	case DMESG_TIMEFTM_NONE:
-		ctl->indent = 0;
-		break;
-	case DMESG_TIMEFTM_CTIME:
-		ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "[%s] ",
-				      record_ctime(ctl, rec, buf, sizeof(buf)));
-		break;
-	case DMESG_TIMEFTM_CTIME_DELTA:
-		ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "[%s <%12.06f>] ",
-				      record_ctime(ctl, rec, buf, sizeof(buf)),
-				      record_count_delta(ctl, rec));
-		break;
-	case DMESG_TIMEFTM_DELTA:
-		ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "[<%12.06f>] ",
-				      record_count_delta(ctl, rec));
-		break;
-	case DMESG_TIMEFTM_RELTIME:
-		record_localtime(ctl, rec, &cur);
-		delta = record_count_delta(ctl, rec);
-		if (cur.tm_min != ctl->lasttm.tm_min ||
-		    cur.tm_hour != ctl->lasttm.tm_hour ||
-		    cur.tm_yday != ctl->lasttm.tm_yday) {
-			timebreak = 1;
+	for (format_iterator = 0; format_iterator < TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED;
+	     format_iterator++) {
+		if (ctl->time_fmts[ts_format_sequence[format_iterator]] == TIMESTAMP_FMT_UNSET)
+			continue;
+
+		switch (ts_format_sequence[format_iterator]) {
+			struct tm cur;
+		case DMESG_TIMEFTM_NONE:
+			ctl->indent = 0;
+			break;
+		case DMESG_TIMEFTM_CTIME:
 			ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "[%s] ",
-					      short_ctime(&cur, buf,
-							  sizeof(buf)));
-		} else {
-			if (delta < 10)
-				ctl->indent = snprintf(tsbuf, sizeof(tsbuf),
-						"[  %+8.06f] ",  delta);
-			else
-				ctl->indent = snprintf(tsbuf, sizeof(tsbuf),
-						"[ %+9.06f] ", delta);
+						record_ctime(ctl, rec, buf, sizeof(buf)));
+			break;
+		case DMESG_TIMEFTM_CTIME_DELTA:
+			ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "[%s <%12.06f>] ",
+						record_ctime(ctl, rec, buf, sizeof(buf)),
+						delta);
+			break;
+		case DMESG_TIMEFTM_DELTA:
+			ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "[<%12.06f>] ",
+						delta);
+			break;
+		case DMESG_TIMEFTM_RELTIME:
+			record_localtime(ctl, rec, &cur);
+			if (cur.tm_min != ctl->lasttm.tm_min ||
+				cur.tm_hour != ctl->lasttm.tm_hour ||
+				cur.tm_yday != ctl->lasttm.tm_yday) {
+				timebreak = 1;
+				ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "[%s] ",
+							short_ctime(&cur, buf,
+								sizeof(buf)));
+			} else {
+				if (delta < 10)
+					ctl->indent = snprintf(tsbuf, sizeof(tsbuf),
+							"[  %+8.06f] ",  delta);
+				else
+					ctl->indent = snprintf(tsbuf, sizeof(tsbuf),
+							"[ %+9.06f] ", delta);
+			}
+			ctl->lasttm = cur;
+			break;
+		case DMESG_TIMEFTM_TIME:
+			ctl->indent = snprintf(tsbuf, sizeof(tsbuf),
+						ctl->json ? "%5ld.%06ld" : "[%5ld.%06ld] ",
+						(long)rec->tv.tv_sec,
+						(long)rec->tv.tv_usec);
+			break;
+		case DMESG_TIMEFTM_TIME_DELTA:
+			ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "[%5ld.%06ld <%12.06f>] ",
+						(long)rec->tv.tv_sec,
+						(long)rec->tv.tv_usec,
+						delta);
+			break;
+		case DMESG_TIMEFTM_ISO8601:
+			ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "%s ",
+						iso_8601_time(ctl, rec, buf,
+								sizeof(buf)));
+			break;
+		default:
+			abort();
 		}
-		ctl->lasttm = cur;
-		break;
-	case DMESG_TIMEFTM_TIME:
-		ctl->indent = snprintf(tsbuf, sizeof(tsbuf),
-				      ctl->json ? "%5ld.%06ld" : "[%5ld.%06ld] ",
-				      (long)rec->tv.tv_sec,
-				      (long)rec->tv.tv_usec);
-		break;
-	case DMESG_TIMEFTM_TIME_DELTA:
-		ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "[%5ld.%06ld <%12.06f>] ",
-				      (long)rec->tv.tv_sec,
-				      (long)rec->tv.tv_usec,
-				      record_count_delta(ctl, rec));
-		break;
-	case DMESG_TIMEFTM_ISO8601:
-		ctl->indent = snprintf(tsbuf, sizeof(tsbuf), "%s ",
-				      iso_8601_time(ctl, rec, buf,
-						    sizeof(buf)));
-		break;
-	default:
-		abort();
+
+		if (*tsbuf)
+			strcat(full_tsbuf, tsbuf);
+		else if (ts_format_sequence[format_iterator] == DMESG_TIMEFTM_NONE)
+			break;
 	}
 
 	ctl->indent += strlen(fpbuf);
@@ -1057,23 +1083,23 @@ full_output:
 	}
 
 	/* Output the timestamp buffer */
-	if (*tsbuf) {
+	if (*full_tsbuf) {
 		/* Colorize the timestamp */
 		if (ctl->color)
 			dmesg_enable_color(timebreak ? DMESG_COLOR_TIMEBREAK :
 						       DMESG_COLOR_TIME);
-		if (ctl->time_fmt != DMESG_TIMEFTM_RELTIME) {
+		if (ctl->time_fmts[DMESG_TIMEFTM_RELTIME] == TIMESTAMP_FMT_UNSET) {
 			if (ctl->json)
-				ul_jsonwrt_value_raw(&ctl->jfmt, "time", tsbuf);
+				ul_jsonwrt_value_raw(&ctl->jfmt, "time", full_tsbuf);
 			else
-				fputs(tsbuf, stdout);
+				fputs(full_tsbuf, stdout);
 		} else {
 			/*
 			 * For relative timestamping, the first line's
 			 * timestamp is the offset and all other lines will
 			 * report an offset of 0.000000.
 			 */
-			fputs(!line ? tsbuf : "[  +0.000000] ", stdout);
+			fputs(!line ? full_tsbuf : "[  +0.000000] ", stdout);
 		}
 		if (ctl->color)
 			color_disable();
@@ -1254,7 +1280,7 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
 		goto mesg;
 
 	/* C) timestamp */
-	if (is_timefmt(ctl, NONE))
+	if (ctl->time_fmts[DMESG_TIMEFTM_NONE] == TIMESTAMP_FMT_SET)
 		p = skip_item(p, end, ",;");
 	else
 		p = parse_kmsg_timestamp(p, &rec->tv);
@@ -1346,6 +1372,8 @@ static int which_time_format(const char *s)
 		return DMESG_TIMEFTM_RELTIME;
 	if (!strcmp(s, "iso"))
 		return DMESG_TIMEFTM_ISO8601;
+	if (!strcmp(s, "raw"))
+		return DMESG_TIMEFTM_TIME;
 	errx(EXIT_FAILURE, _("unknown time format: %s"), s);
 }
 
@@ -1388,9 +1416,11 @@ int main(int argc, char *argv[])
 		.action = SYSLOG_ACTION_READ_ALL,
 		.method = DMESG_METHOD_KMSG,
 		.kmsg = -1,
-		.time_fmt = DMESG_TIMEFTM_TIME,
 		.indent = 0,
 	};
+	memset(ctl.time_fmts, 0,
+		TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED * sizeof(*(ctl.time_fmts)));
+	ctl.time_fmts[DMESG_TIMEFTM_TIME] = TIMESTAMP_FMT_INIT_SET;
 	int colormode = UL_COLORMODE_UNDEF;
 	enum {
 		OPT_TIME_FORMAT = CHAR_MAX + 1,
@@ -1475,7 +1505,9 @@ int main(int argc, char *argv[])
 			ctl.action = SYSLOG_ACTION_CONSOLE_ON;
 			break;
 		case 'e':
-			ctl.time_fmt = DMESG_TIMEFTM_RELTIME;
+			if (ctl.time_fmts[DMESG_TIMEFTM_TIME] == TIMESTAMP_FMT_INIT_SET)
+				ctl.time_fmts[DMESG_TIMEFTM_TIME] = TIMESTAMP_FMT_UNSET;
+			ctl.time_fmts[DMESG_TIMEFTM_RELTIME] = TIMESTAMP_FMT_SET;
 			break;
 		case 'F':
 			ctl.filename = optarg;
@@ -1488,7 +1520,9 @@ int main(int argc, char *argv[])
 				return EXIT_FAILURE;
 			break;
 		case 'H':
-			ctl.time_fmt = DMESG_TIMEFTM_RELTIME;
+			if (ctl.time_fmts[DMESG_TIMEFTM_TIME] == TIMESTAMP_FMT_INIT_SET)
+				ctl.time_fmts[DMESG_TIMEFTM_TIME] = TIMESTAMP_FMT_UNSET;
+			ctl.time_fmts[DMESG_TIMEFTM_RELTIME] = TIMESTAMP_FMT_SET;
 			colormode = UL_COLORMODE_AUTO;
 			ctl.pager = 1;
 			break;
@@ -1535,10 +1569,14 @@ int main(int argc, char *argv[])
 				ctl.bufsize = 4096;
 			break;
 		case 'T':
-			ctl.time_fmt = DMESG_TIMEFTM_CTIME;
+			if (ctl.time_fmts[DMESG_TIMEFTM_TIME] == TIMESTAMP_FMT_INIT_SET)
+				ctl.time_fmts[DMESG_TIMEFTM_TIME] = TIMESTAMP_FMT_UNSET;
+			ctl.time_fmts[DMESG_TIMEFTM_CTIME] = TIMESTAMP_FMT_SET;
 			break;
 		case 't':
-			ctl.time_fmt = DMESG_TIMEFTM_NONE;
+			memset(ctl.time_fmts, 0,
+				TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED * sizeof(*(ctl.time_fmts)));
+			ctl.time_fmts[DMESG_TIMEFTM_NONE] = TIMESTAMP_FMT_SET;
 			break;
 		case 'u':
 			ctl.fltr_fac = 1;
@@ -1556,7 +1594,9 @@ int main(int argc, char *argv[])
 			ctl.decode = 1;
 			break;
 		case OPT_TIME_FORMAT:
-			ctl.time_fmt = which_time_format(optarg);
+			if (ctl.time_fmts[DMESG_TIMEFTM_TIME] == TIMESTAMP_FMT_INIT_SET)
+				ctl.time_fmts[DMESG_TIMEFTM_TIME] = TIMESTAMP_FMT_UNSET;
+			ctl.time_fmts[which_time_format(optarg)] = TIMESTAMP_FMT_SET;
 			break;
 		case OPT_NOESC:
 			ctl.noesc = 1;
@@ -1588,7 +1628,9 @@ int main(int argc, char *argv[])
 	}
 
 	if (ctl.json) {
-		ctl.time_fmt = DMESG_TIMEFTM_TIME;
+		memset(ctl.time_fmts, 0,
+			TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED * sizeof(*(ctl.time_fmts)));
+		ctl.time_fmts[DMESG_TIMEFTM_TIME] = TIMESTAMP_FMT_SET;
 		delta = 0;
 		ctl.force_prefix = 0;
 		ctl.raw = 0;
@@ -1596,30 +1638,30 @@ int main(int argc, char *argv[])
 		nopager = 1;
 	}
 
-	if ((is_timefmt(&ctl, RELTIME) ||
-	     is_timefmt(&ctl, CTIME)   ||
-	     is_timefmt(&ctl, ISO8601)) ||
+	if ((ctl.time_fmts[DMESG_TIMEFTM_RELTIME] > 0 ||
+	     ctl.time_fmts[DMESG_TIMEFTM_CTIME] > 0   ||
+	     ctl.time_fmts[DMESG_TIMEFTM_ISO8601] > 0) ||
 	     ctl.since ||
 	     ctl.until) {
-		if (dmesg_get_boot_time(&ctl.boot_time) != 0)
-			ctl.time_fmt = DMESG_TIMEFTM_NONE;
-		else
+		if (dmesg_get_boot_time(&ctl.boot_time) != 0) {
+			memset(ctl.time_fmts, 0,
+				TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED * sizeof(*(ctl.time_fmts)));
+			ctl.time_fmts[DMESG_TIMEFTM_NONE] = TIMESTAMP_FMT_SET;
+		} else
 			ctl.suspended_time = dmesg_get_suspended_time();
 	}
 
-	if (delta) {
-		switch (ctl.time_fmt) {
-		case DMESG_TIMEFTM_CTIME:
-			ctl.time_fmt = DMESG_TIMEFTM_CTIME_DELTA;
-			break;
-		case DMESG_TIMEFTM_TIME:
-			ctl.time_fmt = DMESG_TIMEFTM_TIME_DELTA;
-			break;
-		case DMESG_TIMEFTM_ISO8601:
-			warnx(_("--show-delta is ignored when used together with iso8601 time format"));
-			break;
-		default:
-			ctl.time_fmt = DMESG_TIMEFTM_DELTA;
+	if (delta || ctl.time_fmts[DMESG_TIMEFTM_DELTA]) {
+		if (ctl.time_fmts[DMESG_TIMEFTM_TIME] > 0) {
+			ctl.time_fmts[DMESG_TIMEFTM_DELTA] = TIMESTAMP_FMT_UNSET;
+			ctl.time_fmts[DMESG_TIMEFTM_TIME] = TIMESTAMP_FMT_UNSET;
+			ctl.time_fmts[DMESG_TIMEFTM_TIME_DELTA] = TIMESTAMP_FMT_SET;
+		} else if (ctl.time_fmts[DMESG_TIMEFTM_CTIME] > 0) {
+			ctl.time_fmts[DMESG_TIMEFTM_DELTA] = TIMESTAMP_FMT_UNSET;
+			ctl.time_fmts[DMESG_TIMEFTM_CTIME] = TIMESTAMP_FMT_UNSET;
+			ctl.time_fmts[DMESG_TIMEFTM_CTIME_DELTA] = TIMESTAMP_FMT_SET;
+		} else {
+			ctl.time_fmts[DMESG_TIMEFTM_DELTA] = TIMESTAMP_FMT_SET;
 		}
 	}
 
-- 
2.41.0

