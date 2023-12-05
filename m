Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="rKjfluoU"
Received: from mail-il1-x162.google.com (mail-il1-x162.google.com [IPv6:2607:f8b0:4864:20::162])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0314A5
	for <util-linux@vger.kernel.org>; Tue,  5 Dec 2023 11:54:00 -0800 (PST)
Received: by mail-il1-x162.google.com with SMTP id e9e14a558f8ab-35d725ac060so8842035ab.2
        for <util-linux@vger.kernel.org>; Tue, 05 Dec 2023 11:54:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701806040; x=1702410840;
        h=content-transfer-encoding:message-id:date:subject:cc:to:from
         :dkim-signature:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2pZbVC711RiY8zwNbtdCrL95s2KSwDCS/6iaVyA7+nw=;
        b=JFPvxK3NP/XdsB1Kx143fDn/CYJ+t47TiAGpFPg193zMypTWXipXLicPkX5+6QKAAs
         fzA6eppqcWxE8IyhZMRoifp3L+UKV15eEug41fE0PG1ymOoDdaKNd9Tcu6A8y1WtN0G3
         0+seFox7q7ofiJYPBv21oL2127Zd3PjdLjIqA2iD6kIkP/jJaHrBhhaXGQD4VOsZc7by
         D2zTIkJ7BtzD0zMcFHv+mC22udUu7iRrWGNNW2G66OFRdFIYLtgpq6TX46Hxpbb9REc4
         LpJKiBGK3RHEDN6/v0ySvAdhfmrME94eAdC20MqngYmj8+r3kviKmNyYRJQRqHz5m+RF
         8BPw==
X-Gm-Message-State: AOJu0Yy6Ee73w4jk17iiY3Wfz6PcoLzGu66b+cCsmctYyRXw4qDQd53s
	t+ujjbx2f4FxVivaATeMuQkpHTWfEKwUbB7qYAHyPuZpl3xe
X-Google-Smtp-Source: AGHT+IGh2miTtfc42/i/yML4JaDpfo03wd+8HPgsu4vxAd/BFFIZO1ZvqNfoDDhl3esSfD356Z3naXks3sdE
X-Received: by 2002:a92:cf43:0:b0:35d:59a2:1291 with SMTP id c3-20020a92cf43000000b0035d59a21291mr6974591ilr.61.1701806039997;
        Tue, 05 Dec 2023 11:53:59 -0800 (PST)
Received: from smtp.aristanetworks.com ([74.123.28.25])
        by smtp-relay.gmail.com with ESMTPS id p13-20020a92da4d000000b0035d69093b7dsm278911ilq.30.2023.12.05.11.53.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Dec 2023 11:53:59 -0800 (PST)
X-Relaying-Domain: arista.com
Received: from rthukral-upstreamDmesgFix-1.sjc.aristanetworks.com (rthukral-upstreamDmesgFix-1-us310.sjc.aristanetworks.com [10.245.203.220])
	by smtp.aristanetworks.com (Postfix) with ESMTP id 1213F400F82;
	Tue,  5 Dec 2023 11:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arista.com;
	s=Arista-A; t=1701806039;
	bh=2pZbVC711RiY8zwNbtdCrL95s2KSwDCS/6iaVyA7+nw=;
	h=From:To:Cc:Subject:Date:From;
	b=rKjfluoU83wsq3I4dCMMaWWA493M3m9wJr9dvBUWTjJzpmicp35BjEpDnfzyYiGlK
	 o3u5WeawyhRvwlCUHW9J1WOjJ0OzbXYikkkJSXLt1XkOaENaDX7U46dRI/jLlfTMEP
	 hMbbmnMK1qmJi/FqKORi7NabIHGEkm15L8RJh3cpruW8WD51/ZmjOhA0SLPh1ppShI
	 +Pol1UfSY0O6N9zYrcNzVVPG13IVgRiXRwVsPgJ3CJ7bRIo7WiZA8kCptHq7rnWGpc
	 lNCBWKcUOL3AYg4MNq/JrJ6Wb/m354uqDexljkL6rJ6R9bm7GZ+p4KqmHzVu7BiAyt
	 sVVGAD9nR9BRA==
From: Rishabh Thukral <rthukral@arista.com>
To: util-linux@vger.kernel.org,
	kzak@redhat.com
Cc: colona@arista.com,
	Rishabh Thukral <rthukral@arista.com>
Subject: [PATCH] util-linux/sys-utils dmesg support for additional human readable timestamp
Date: Tue,  5 Dec 2023 11:53:33 -0800
Message-ID: <20231205195333.15832-1-rthukral@arista.com>
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: util-linux@vger.kernel.org
List-Id: <util-linux.vger.kernel.org>
List-Subscribe: <mailto:util-linux+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:util-linux+unsubscribe@vger.kernel.org>

The dmesg logs have timestamps in seconds since boot format which can
be converted to other formats. However, there is no option to include
both the original timestamp as present in the buffer along with the
converted timestamp in the specified format.

This change updates the --time-format option in dmesg to enable the
user to specify it multiple times with different formats with each
input providing a timestamp format among the currently supported
choices. This enables seeing the dmesg logs in both seconds since boot
and human readable format simultaneously in each row of the log output.
The sequence of timestamp format follows the order
in which the user provides the desired formats.

Signed-off-by: Rishabh Thukral <rthukral@arista.com>
---
 sys-utils/dmesg.1.adoc |   4 +-
 sys-utils/dmesg.c      | 257 ++++++++++++++++++++++++++---------------
 2 files changed, 168 insertions(+), 93 deletions(-)

diff --git a/sys-utils/dmesg.1.adoc b/sys-utils/dmesg.1.adoc
index 6f4941ede..16af7d940 100644
--- a/sys-utils/dmesg.1.adoc
+++ b/sys-utils/dmesg.1.adoc
@@ -133,9 +133,11 @@ Display record until the specified time. Supported is the subsecond granularity.
 Do not print kernel's timestamps.
 
 *--time-format* _format_::
-Print timestamps using the given _format_, which can be *ctime*, *reltime*, *delta* or *iso*. The first three formats are aliases of the time-format-specific options. The *iso* format is a *dmesg* implementation of the ISO-8601 timestamp format. The purpose of this format is to make the comparing of timestamps between two systems, and any other parsing, easy. The definition of the *iso* timestamp is: YYYY-MM-DD<T>HH:MM:SS,<microseconds><-+><timezone offset from UTC>.
++Print timestamps using the given _format_, which can be *ctime*, *reltime*, *delta*, *iso* or *raw*. The first three formats are aliases of the time-format-specific options. The *raw* format uses the default timestamp format showing seconds since boot. The *iso* format is a *dmesg* implementation of the ISO-8601 timestamp format. The purpose of this format is to make the comparing of timestamps between two systems, and any other parsing, easy. The definition of the *iso* timestamp is: YYYY-MM-DD<T>HH:MM:SS,<microseconds><-+><timezone offset from UTC>.
 +
 The *iso* format has the same issue as *ctime*: the time may be inaccurate when a system is suspended and resumed.
++
+*--time-format* may be used multiple times with different values for _format_ to output each specified format.
 
 *-u*, *--userspace*::
 Print userspace messages.
diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 79e1c1690..866d2da52 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -161,7 +161,8 @@ enum {
 	DMESG_TIMEFTM_TIME_DELTA,	/* [time <delta>] */
 	DMESG_TIMEFTM_ISO8601		/* 2013-06-13T22:11:00,123456+0100 */
 };
-#define is_timefmt(c, f) ((c)->time_fmt == (DMESG_TIMEFTM_ ##f))
+#define TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED 8
+#define DEFAULT_TIMESTAMP_FORMAT DMESG_TIMEFTM_TIME
 
 struct dmesg_control {
 	/* bit arrays -- see include/bitops.h */
@@ -199,7 +200,8 @@ struct dmesg_control {
 	char		*filename;
 	char		*mmap_buff;
 	size_t		pagesize;
-	unsigned int	time_fmt;	/* time format */
+	size_t		ntime_fmts;
+	unsigned int	time_fmts[2 * TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED];	/* time format */
 
 	struct ul_jsonwrt jfmt;		/* -J formatting */
 
@@ -316,7 +318,7 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -T, --ctime                 show human-readable timestamp (may be inaccurate!)\n"), out);
 	fputs(_(" -t, --notime                don't show any timestamp with messages\n"), out);
 	fputs(_("     --time-format <format>  show timestamp using the given format:\n"
-		"                               [delta|reltime|ctime|notime|iso]\n"
+		"                               [delta|reltime|ctime|notime|iso|raw]\n"
 		"Suspending/resume will make ctime and iso timestamps inaccurate.\n"), out);
 	fputs(_("     --since <time>          display the lines since the specified time\n"), out);
 	fputs(_("     --until <time>          display the lines until the specified time\n"), out);
@@ -339,6 +341,53 @@ static void __attribute__((__noreturn__)) usage(void)
 	exit(EXIT_SUCCESS);
 }
 
+static void reset_time_fmts(struct dmesg_control *ctl)
+{
+	memset(ctl->time_fmts, 0,
+		TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED * sizeof(*(ctl->time_fmts)));
+	ctl->time_fmts[0] = DEFAULT_TIMESTAMP_FORMAT;
+}
+
+static int is_time_fmt_set(struct dmesg_control *ctl, unsigned int time_format)
+{
+	size_t i;
+
+	if (ctl->ntime_fmts == 0)
+		return time_format == DEFAULT_TIMESTAMP_FORMAT;
+
+	for (i = 0; i < ctl->ntime_fmts; i++)
+		if (ctl->time_fmts[i] == time_format)
+			return 1;
+	return 0;
+}
+
+static void include_time_fmt(struct dmesg_control *ctl, unsigned int time_format)
+{
+	if (ctl->ntime_fmts > 0 && is_time_fmt_set(ctl, time_format))
+		return;
+
+	if (ctl->ntime_fmts < TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED)
+		ctl->time_fmts[ctl->ntime_fmts++] = time_format;
+}
+
+static void exclude_time_fmt(struct dmesg_control *ctl, unsigned int time_format)
+{
+	size_t idx = 0;
+
+	while (idx < ctl->ntime_fmts && ctl->time_fmts[idx] != time_format)
+		idx++;
+
+	if (idx < ctl->ntime_fmts && ctl->time_fmts[idx] == time_format) {
+		while (idx + 1 < ctl->ntime_fmts) {
+			ctl->time_fmts[idx] = ctl->time_fmts[idx+1];
+			idx++;
+		}
+		ctl->ntime_fmts--;
+		if (ctl->ntime_fmts == 0)
+			reset_time_fmts(ctl);
+	}
+}
+
 /*
  * LEVEL     ::= <number> | <name>
  *  <number> ::= @len is set:  number in range <0..N>, where N < ARRAY_SIZE(level_names)
@@ -519,7 +568,6 @@ static const char *parse_kmsg_timestamp(const char *str0, struct timeval *tv)
 	return end + 1;	/* skip separator */
 }
 
-
 static double time_diff(struct timeval *a, struct timeval *b)
 {
 	return (a->tv_sec - b->tv_sec) + (a->tv_usec - b->tv_usec) / 1E6;
@@ -764,7 +812,7 @@ static int get_next_syslog_record(struct dmesg_control *ctl,
 		if (*begin == '[' && (*(begin + 1) == ' ' ||
 				      isdigit(*(begin + 1)))) {
 
-			if (!is_timefmt(ctl, NONE))
+			if (!is_time_fmt_set(ctl, DMESG_TIMEFTM_NONE))
 				begin = parse_syslog_timestamp(begin + 1, &rec->tv);
 			else
 				begin = skip_item(begin, end, "]");
@@ -939,10 +987,13 @@ static void print_record(struct dmesg_control *ctl,
 	char buf[128];
 	char fpbuf[32] = "\0";
 	char tsbuf[64] = "\0";
+	char full_tsbuf[64*TOTAL_DMESG_TIMESTAMP_FORMATS_SUPPORTED] = "\0";
 	size_t mesg_size = rec->mesg_size;
 	int timebreak = 0;
 	char *mesg_copy = NULL;
 	const char *line = NULL;
+	double delta = record_count_delta(ctl, rec);
+	size_t format_iter = 0;
 
 	if (!accept_record(ctl, rec))
 		return;
@@ -967,7 +1018,7 @@ static void print_record(struct dmesg_control *ctl,
 	 * backward compatibility with syslog(2) buffers only
 	 */
 	if (ctl->raw) {
-		ctl->indent = snprintf(tsbuf, sizeof(tsbuf),
+		ctl->indent = snprintf(full_tsbuf, sizeof(full_tsbuf),
 				       "<%d>[%5ld.%06ld] ",
 				       LOG_RAW_FAC_PRI(rec->facility, rec->level),
 				       (long) rec->tv.tv_sec,
@@ -982,64 +1033,71 @@ static void print_record(struct dmesg_control *ctl,
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
+	for (format_iter = 0; format_iter < (ctl->ntime_fmts > 0 ? ctl->ntime_fmts : 1);
+		 format_iter++) {
+		switch (ctl->time_fmts[format_iter]) {
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
+		if (is_time_fmt_set(ctl, DMESG_TIMEFTM_NONE))
+			break;
+		else if (*tsbuf)
+			strcat(full_tsbuf, tsbuf);
+
 	}
 
 	ctl->indent += strlen(fpbuf);
@@ -1057,23 +1115,23 @@ full_output:
 	}
 
 	/* Output the timestamp buffer */
-	if (*tsbuf) {
+	if (*full_tsbuf) {
 		/* Colorize the timestamp */
 		if (ctl->color)
 			dmesg_enable_color(timebreak ? DMESG_COLOR_TIMEBREAK :
 						       DMESG_COLOR_TIME);
-		if (ctl->time_fmt != DMESG_TIMEFTM_RELTIME) {
+		if (!is_time_fmt_set(ctl, DMESG_TIMEFTM_RELTIME)) {
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
@@ -1254,7 +1312,7 @@ static int parse_kmsg_record(struct dmesg_control *ctl,
 		goto mesg;
 
 	/* C) timestamp */
-	if (is_timefmt(ctl, NONE))
+	if (is_time_fmt_set(ctl, DMESG_TIMEFTM_NONE))
 		p = skip_item(p, end, ",;");
 	else
 		p = parse_kmsg_timestamp(p, &rec->tv);
@@ -1346,6 +1404,8 @@ static int which_time_format(const char *s)
 		return DMESG_TIMEFTM_RELTIME;
 	if (!strcmp(s, "iso"))
 		return DMESG_TIMEFTM_ISO8601;
+	if (!strcmp(s, "raw"))
+		return DMESG_TIMEFTM_TIME;
 	errx(EXIT_FAILURE, _("unknown time format: %s"), s);
 }
 
@@ -1388,9 +1448,10 @@ int main(int argc, char *argv[])
 		.action = SYSLOG_ACTION_READ_ALL,
 		.method = DMESG_METHOD_KMSG,
 		.kmsg = -1,
-		.time_fmt = DMESG_TIMEFTM_TIME,
+		.ntime_fmts = 0,
 		.indent = 0,
 	};
+	ctl.time_fmts[0] = DEFAULT_TIMESTAMP_FORMAT;
 	int colormode = UL_COLORMODE_UNDEF;
 	enum {
 		OPT_TIME_FORMAT = CHAR_MAX + 1,
@@ -1475,7 +1536,7 @@ int main(int argc, char *argv[])
 			ctl.action = SYSLOG_ACTION_CONSOLE_ON;
 			break;
 		case 'e':
-			ctl.time_fmt = DMESG_TIMEFTM_RELTIME;
+			include_time_fmt(&ctl, DMESG_TIMEFTM_RELTIME);
 			break;
 		case 'F':
 			ctl.filename = optarg;
@@ -1488,7 +1549,7 @@ int main(int argc, char *argv[])
 				return EXIT_FAILURE;
 			break;
 		case 'H':
-			ctl.time_fmt = DMESG_TIMEFTM_RELTIME;
+			include_time_fmt(&ctl, DMESG_TIMEFTM_RELTIME);
 			colormode = UL_COLORMODE_AUTO;
 			ctl.pager = 1;
 			break;
@@ -1535,10 +1596,11 @@ int main(int argc, char *argv[])
 				ctl.bufsize = 4096;
 			break;
 		case 'T':
-			ctl.time_fmt = DMESG_TIMEFTM_CTIME;
+			include_time_fmt(&ctl, DMESG_TIMEFTM_CTIME);
 			break;
 		case 't':
-			ctl.time_fmt = DMESG_TIMEFTM_NONE;
+			reset_time_fmts(&ctl);
+			include_time_fmt(&ctl, DMESG_TIMEFTM_NONE);
 			break;
 		case 'u':
 			ctl.fltr_fac = 1;
@@ -1556,7 +1618,7 @@ int main(int argc, char *argv[])
 			ctl.decode = 1;
 			break;
 		case OPT_TIME_FORMAT:
-			ctl.time_fmt = which_time_format(optarg);
+			include_time_fmt(&ctl, which_time_format(optarg));
 			break;
 		case OPT_NOESC:
 			ctl.noesc = 1;
@@ -1588,7 +1650,8 @@ int main(int argc, char *argv[])
 	}
 
 	if (ctl.json) {
-		ctl.time_fmt = DMESG_TIMEFTM_TIME;
+		reset_time_fmts(&ctl);
+		ctl.ntime_fmts = 0;
 		delta = 0;
 		ctl.force_prefix = 0;
 		ctl.raw = 0;
@@ -1596,30 +1659,40 @@ int main(int argc, char *argv[])
 		nopager = 1;
 	}
 
-	if ((is_timefmt(&ctl, RELTIME) ||
-	     is_timefmt(&ctl, CTIME)   ||
-	     is_timefmt(&ctl, ISO8601)) ||
+	if ((is_time_fmt_set(&ctl, DMESG_TIMEFTM_RELTIME) ||
+	     is_time_fmt_set(&ctl, DMESG_TIMEFTM_CTIME)   ||
+	     is_time_fmt_set(&ctl, DMESG_TIMEFTM_ISO8601)) ||
 	     ctl.since ||
 	     ctl.until) {
 		if (dmesg_get_boot_time(&ctl.boot_time) != 0)
-			ctl.time_fmt = DMESG_TIMEFTM_NONE;
+			include_time_fmt(&ctl, DMESG_TIMEFTM_NONE);
 		else
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
+	if (delta || is_time_fmt_set(&ctl, DMESG_TIMEFTM_DELTA)) {
+		if (is_time_fmt_set(&ctl, DMESG_TIMEFTM_TIME)) {
+			if (ctl.ntime_fmts == 0) {
+				ctl.time_fmts[ctl.ntime_fmts++] = DMESG_TIMEFTM_TIME_DELTA;
+			} else {
+				exclude_time_fmt(&ctl, DMESG_TIMEFTM_DELTA);
+				for (n = 0; (size_t) n < ctl.ntime_fmts; n++) {
+					if (ctl.time_fmts[n] == DMESG_TIMEFTM_TIME) {
+						ctl.time_fmts[n] = DMESG_TIMEFTM_TIME_DELTA;
+						break;
+					}
+				}
+			}
+		} else if (is_time_fmt_set(&ctl, DMESG_TIMEFTM_CTIME)) {
+			exclude_time_fmt(&ctl, DMESG_TIMEFTM_DELTA);
+			for (n = 0; (size_t) n < ctl.ntime_fmts; n++) {
+				if (ctl.time_fmts[n] == DMESG_TIMEFTM_CTIME) {
+					ctl.time_fmts[n] = DMESG_TIMEFTM_CTIME_DELTA;
+					break;
+				}
+			}
+		} else {
+			include_time_fmt(&ctl, DMESG_TIMEFTM_DELTA);
 		}
 	}
 
-- 
2.41.0

