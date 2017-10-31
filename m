Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:48740 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752386AbdJaMBz (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 31 Oct 2017 08:01:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id AE6F07E42C
        for <util-linux@vger.kernel.org>; Tue, 31 Oct 2017 12:01:55 +0000 (UTC)
From: Prarit Bhargava <prarit@redhat.com>
To: util-linux@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, kzak@redhat.com,
        anderson@redhat.com
Subject: [PATCH] dmesg: Add force-prefix option
Date: Tue, 31 Oct 2017 08:01:31 -0400
Message-Id: <20171031120131.5837-1-prarit@redhat.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The kernel outputs multi-line messages (kernel messages that contain
the end-of-line character '\n').  These message are currently displayed by
dmesg as

[965199.028940] runnable tasks:
                           task   PID         tree-key  switches  prio
wait-time             sum-exec        sum-sleep
                ----------------------------------------------------------------------------------------------------------

The kernel timestamps each of these lines with [965199.028940] and the
dmesg utility should do the same.

Add the 'force-prefix'/'-p' dmesg option to add decode & timestamp information
to each line of a multi-line message.

Notes: The new print_record() algorithm stores the decode & timestamp
information in buffers.  If the force-prefix option is used, the message is
split into separate lines and each line is prefixed with the stored decode &
timestamp information.  The splitting of the message into separate lines is
done using strtok() which requires write access to the message buffer (ie, the
const message buffer is now copied into a writeable buffer).

Successfully tested by me by looking at sysrq-t and sysrq-w output.
All known good /tests passed with these changes.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: kzak@redhat.com
Cc: anderson@redhat.com
---
 sys-utils/dmesg.c | 186 +++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 127 insertions(+), 59 deletions(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 6e5911a76dc8..f62ee35126d1 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -195,7 +195,9 @@ struct dmesg_control {
 			fltr_fac:1,	/* filter out by facilities[] */
 			decode:1,	/* use "facility: level: " prefix */
 			pager:1,	/* pipe output into a pager */
-			color:1;	/* colorize messages */
+			color:1,	/* colorize messages */
+			force_prefix:1;	/* force timestamp and decode prefix
+					   on each line */
 	int		indent;		/* due to timestamps if newline */
 };
 
@@ -252,7 +254,7 @@ static int set_level_color(int log_level, const char *mesg, size_t mesgsz)
 	if (id >= 0)
 		dmesg_enable_color(id);
 
-	return id >= 0 ? 0 : -1;
+	return id >= 0 ? 1 : 0;
 }
 
 static void __attribute__((__noreturn__)) usage(void)
@@ -293,7 +295,8 @@ static void __attribute__((__noreturn__)) usage(void)
 	fputs(_(" -t, --notime                don't show any timestamp with messages\n"), out);
 	fputs(_("     --time-format <format>  show timestamp using the given format:\n"
 		"                               [delta|reltime|ctime|notime|iso]\n"
-		"Suspending/resume will make ctime and iso timestamps inaccurate.\n"), out);
+		"                               Suspending/resume will make ctime and iso timestamps inaccurate.\n"), out);
+	fputs(_(" -p, --force-prefix          force timestamp output on each line of multi-line messages\n"), out);
 	fputs(USAGE_SEPARATOR, out);
 	printf(USAGE_HELP_OPTIONS(29));
 	fputs(_("\nSupported log facilities:\n"), out);
@@ -853,13 +856,13 @@ static double record_count_delta(struct dmesg_control *ctl,
 	return delta;
 }
 
-static const char *get_subsys_delimiter(const char *mesg, size_t mesg_size)
+static char *get_subsys_delimiter(char *mesg, size_t mesg_size)
 {
-	const char *p = mesg;
+	char *p = mesg;
 	size_t sz = mesg_size;
 
 	while (sz > 0) {
-		const char *d = strnchr(p, sz, ':');
+		char *d = strnchr(p, sz, ':');
 		if (!d)
 			return NULL;
 		sz -= d - p + 1;
@@ -875,11 +878,13 @@ static const char *get_subsys_delimiter(const char *mesg, size_t mesg_size)
 static void print_record(struct dmesg_control *ctl,
 			 struct dmesg_record *rec)
 {
-	char buf[256];
+	char buf[128];
+	char fpbuf[32] = "\0";
+	char tsbuf[64] = "\0";
 	int has_color = 0;
-	const char *mesg;
 	size_t mesg_size;
-	int indent = 0;
+	int timebreak_color = 0;
+	char *mesg_copy, *line = NULL;
 
 	if (!accept_record(ctl, rec))
 		return;
@@ -890,30 +895,27 @@ static void print_record(struct dmesg_control *ctl,
 	}
 
 	/*
-	 * compose syslog(2) compatible raw output -- used for /dev/kmsg for
+	 * Compose syslog(2) compatible raw output -- used for /dev/kmsg for
 	 * backward compatibility with syslog(2) buffers only
 	 */
 	if (ctl->raw) {
-		ctl->indent = printf("<%d>[%5ld.%06ld] ",
-				     LOG_MAKEPRI(rec->facility, rec->level),
-				     (long) rec->tv.tv_sec,
-				     (long) rec->tv.tv_usec);
-
-		goto mesg;
+		ctl->indent = sprintf(tsbuf, "<%d>[%5ld.%06ld] ",
+				      LOG_MAKEPRI(rec->facility, rec->level),
+				      (long) rec->tv.tv_sec,
+				      (long) rec->tv.tv_usec);
+		goto syslog2;
 	}
 
-	/*
-	 * facility : priority :
-	 */
+	/* Store decode information (facility & priority level) in a buffer */
 	if (ctl->decode &&
-	    -1 < rec->level    && rec->level     < (int) ARRAY_SIZE(level_names) &&
-	    -1 < rec->facility && rec->facility  < (int) ARRAY_SIZE(facility_names))
-		indent = printf("%-6s:%-6s: ", facility_names[rec->facility].name,
-				               level_names[rec->level].name);
-
-	if (ctl->color)
-		dmesg_enable_color(DMESG_COLOR_TIME);
-
+	    (rec->level > -1) && (rec->level < (int) ARRAY_SIZE(level_names)) &&
+	    (rec->facility > -1) &&
+	    (rec->facility < (int) ARRAY_SIZE(facility_names)))
+		snprintf(fpbuf, 32, "%-6s:%-6s: ",
+			 facility_names[rec->facility].name,
+			 level_names[rec->level].name);
+
+	/* Store the timestamp in a buffer */
 	switch (ctl->time_fmt) {
 		double delta;
 		struct tm cur;
@@ -921,15 +923,17 @@ static void print_record(struct dmesg_control *ctl,
 		ctl->indent = 0;
 		break;
 	case DMESG_TIMEFTM_CTIME:
-		ctl->indent = printf("[%s] ", record_ctime(ctl, rec, buf, sizeof(buf)));
+		ctl->indent = sprintf(tsbuf, "[%s] ",
+				      record_ctime(ctl, rec, buf, sizeof(buf)));
 		break;
 	case DMESG_TIMEFTM_CTIME_DELTA:
-		ctl->indent = printf("[%s <%12.06f>] ",
-		       		     record_ctime(ctl, rec, buf, sizeof(buf)),
-		       		     record_count_delta(ctl, rec));
+		ctl->indent = sprintf(tsbuf, "[%s <%12.06f>] ",
+				      record_ctime(ctl, rec, buf, sizeof(buf)),
+				      record_count_delta(ctl, rec));
 		break;
 	case DMESG_TIMEFTM_DELTA:
-		ctl->indent = printf("[<%12.06f>] ", record_count_delta(ctl, rec));
+		ctl->indent = sprintf(tsbuf, "[<%12.06f>] ",
+				      record_count_delta(ctl, rec));
 		break;
 	case DMESG_TIMEFTM_RELTIME:
 		record_localtime(ctl, rec, &cur);
@@ -937,61 +941,121 @@ static void print_record(struct dmesg_control *ctl,
 		if (cur.tm_min != ctl->lasttm.tm_min ||
 		    cur.tm_hour != ctl->lasttm.tm_hour ||
 		    cur.tm_yday != ctl->lasttm.tm_yday) {
-			dmesg_enable_color(DMESG_COLOR_TIMEBREAK);
-			ctl->indent = printf("[%s] ", short_ctime(&cur, buf, sizeof(buf)));
+			timebreak_color = 1;
+			ctl->indent = sprintf(tsbuf, "[%s] ",
+					      short_ctime(&cur, buf,
+							  sizeof(buf)));
 		} else {
 			if (delta < 10)
-				ctl->indent = printf("[  %+8.06f] ", delta);
+				ctl->indent = sprintf(tsbuf, "[  %+8.06f] ",
+						      delta);
 			else
-				ctl->indent = printf("[ %+9.06f] ", delta);
+				ctl->indent = sprintf(tsbuf, "[ %+9.06f] ",
+						      delta);
 		}
 		ctl->lasttm = cur;
 		break;
 	case DMESG_TIMEFTM_TIME:
-		ctl->indent = printf("[%5ld.%06ld] ",
-		               (long)rec->tv.tv_sec, (long)rec->tv.tv_usec);
+		ctl->indent = sprintf(tsbuf, "[%5ld.%06ld] ",
+				      (long)rec->tv.tv_sec,
+				      (long)rec->tv.tv_usec);
 		break;
 	case DMESG_TIMEFTM_TIME_DELTA:
-		ctl->indent = printf("[%5ld.%06ld <%12.06f>] ", (long)rec->tv.tv_sec,
-		               (long)rec->tv.tv_usec, record_count_delta(ctl, rec));
+		ctl->indent = sprintf(tsbuf, "[%5ld.%06ld <%12.06f>] ",
+				      (long)rec->tv.tv_sec,
+				      (long)rec->tv.tv_usec,
+				      record_count_delta(ctl, rec));
 		break;
 	case DMESG_TIMEFTM_ISO8601:
-		ctl->indent = printf("%s ", iso_8601_time(ctl, rec, buf, sizeof(buf)));
+		ctl->indent = sprintf(tsbuf, "%s ",
+				      iso_8601_time(ctl, rec, buf,
+						    sizeof(buf)));
 		break;
 	default:
 		abort();
 	}
 
-	ctl->indent += indent;
+	ctl->indent += strlen(fpbuf);
 
-	if (ctl->color)
-		color_disable();
+full_output:
+	/* Output the decode information */
+	if (strlen(fpbuf))
+		printf("%s", fpbuf);
 
-mesg:
-	mesg = rec->mesg;
-	mesg_size = rec->mesg_size;
+	/* Output the timestamp buffer */
+	if (strlen(tsbuf)) {
+		/* Colorize the timestamp */
+		if (ctl->color)
+			dmesg_enable_color(DMESG_COLOR_TIME);
+		if (timebreak_color)
+			dmesg_enable_color(DMESG_COLOR_TIMEBREAK);
+		if (ctl->time_fmt != DMESG_TIMEFTM_RELTIME) {
+			printf("%s", tsbuf);
+		} else {
+			/*
+			 * For relative timestamping, the first line's
+			 * timestamp is the offset and all other lines will
+			 * report an offset of 0.000000.
+			 */
+			if (!line)
+				printf("%s", tsbuf);
+			else
+				printf("[  +0.000000] ");
+		}
+		if (ctl->color)
+			color_disable();
+	}
+
+syslog2:
+	/*
+	 * A kernel message may contain several lines of output, separated
+	 * by '\n'.  If the timestamp and decode outputs are forced then each
+	 * line of the message must be displayed with that information.
+	 */
+	if (!line) {
+		mesg_copy = strdup(rec->mesg);
+		if (ctl->force_prefix) {
+			line = strtok(mesg_copy, "\n");
+			mesg_size = strlen(line);
+		} else {
+			line = mesg_copy;
+			mesg_size = rec->mesg_size;
+		}
+	}
 
-	/* Colorize output */
+	/* Colorize kernel message output */
 	if (ctl->color) {
-		/* subsystem prefix */
-		const char *subsys = get_subsys_delimiter(mesg, mesg_size);
+		/* Subsystem prefix */
+		char *subsys = get_subsys_delimiter(line, mesg_size);
 		if (subsys) {
 			dmesg_enable_color(DMESG_COLOR_SUBSYS);
-			safe_fwrite(mesg, subsys - mesg, ctl->indent, stdout);
+			safe_fwrite(line, subsys - line, ctl->indent, stdout);
 			color_disable();
 
-			mesg_size -= subsys - mesg;
-			mesg = subsys;
+			mesg_size -= subsys - line;
+			line = subsys;
 		}
-		/* error, alert .. etc. colors */
-		has_color = set_level_color(rec->level, mesg, mesg_size) == 0;
-		safe_fwrite(mesg, mesg_size, ctl->indent, stdout);
+		/* Error, alert .. etc. colors */
+		has_color = set_level_color(rec->level, line, mesg_size);
+		safe_fwrite(line, mesg_size, ctl->indent, stdout);
 		if (has_color)
 			color_disable();
 	} else
-		safe_fwrite(mesg, mesg_size, ctl->indent, stdout);
+		safe_fwrite(line, mesg_size, ctl->indent, stdout);
+
+	/* Get the next line */
+	if (ctl->force_prefix) {
+		line = strtok(NULL, "\n");
+		if (line) {
+			printf("\n");
+			mesg_size = strlen(line);
+			goto full_output;
+		}
+	}
+
+	free(mesg_copy);
 
-	if (*(mesg + mesg_size - 1) != '\n')
+	if (*(rec->mesg + mesg_size - 1) != '\n')
 		putchar('\n');
 }
 
@@ -1257,6 +1321,7 @@ int main(int argc, char *argv[])
 		{ "userspace",     no_argument,       NULL, 'u' },
 		{ "version",       no_argument,	      NULL, 'V' },
 		{ "time-format",   required_argument, NULL, OPT_TIME_FORMAT },
+		{ "force-prefix",  no_argument,       NULL, 'p' },
 		{ NULL,	           0, NULL, 0 }
 	};
 
@@ -1279,7 +1344,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	while ((c = getopt_long(argc, argv, "CcDdEeF:f:HhkL::l:n:iPrSs:TtuVwx",
+	while ((c = getopt_long(argc, argv, "CcDdEeF:f:HhkL::l:n:iPprSs:TtuVwx",
 				longopts, NULL)) != -1) {
 
 		err_exclusive_options(c, longopts, excl, excl_st);
@@ -1344,6 +1409,9 @@ int main(int argc, char *argv[])
 		case 'P':
 			nopager = 1;
 			break;
+		case 'p':
+			ctl.force_prefix = 1;
+			break;
 		case 'r':
 			ctl.raw = 1;
 			break;
-- 
1.8.3.1

