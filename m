Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:32866 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751978AbbCOMzF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 Mar 2015 08:55:05 -0400
Received: by wgbcc7 with SMTP id cc7so20288757wgb.0
        for <util-linux@vger.kernel.org>; Sun, 15 Mar 2015 05:55:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/8] logger: tidy few indentation issues
Date: Sun, 15 Mar 2015 12:54:47 +0000
Message-Id: <1426424094-25451-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
References: <1426424094-25451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 115 ++++++++++++++++++++++++++--------------------------
 1 file changed, 58 insertions(+), 57 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index ab734dd..e3fc248 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -159,8 +159,8 @@ static int pencode(char *s)
 	level = decode(s, prioritynames);
 	if (level < 0)
 		errx(EXIT_FAILURE, _("unknown priority name: %s"), s);
-	if(facility == LOG_KERN)
-		facility = LOG_USER; /* kern is forbidden */
+	if (facility == LOG_KERN)
+		facility = LOG_USER;	/* kern is forbidden */
 	return ((level & LOG_PRIMASK) | (facility & LOG_FACMASK));
 }
 
@@ -294,21 +294,21 @@ static char *xgetlogin(void)
 	return cp;
 }
 
-
 /* this creates a timestamp based on current time according to the
  * fine rules of RFC3164, most importantly it ensures in a portable
  * way that the month day is correctly written (with a SP instead
  * of a leading 0). The function uses a static buffer which is
  * overwritten on the next call (just like ctime() does).
  */
-static const char *
-rfc3164_current_time(void)
+static const char *rfc3164_current_time(void)
 {
 	static char time[32];
 	struct timeval tv;
 	struct tm *tm;
-	static char *monthnames[] = { "Jan", "Feb", "Mar", "Apr",
-			"May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"};
+	static char *monthnames[] = {
+		"Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug",
+		"Sep", "Oct", "Nov", "Dec"
+	};
 
 	gettimeofday(&tv, NULL);
 	tm = localtime(&tv.tv_sec);
@@ -329,16 +329,15 @@ static void write_output(const struct logger_ctl *ctl, const char *const msg)
 	const size_t len = xasprintf(&buf, "%s%s", ctl->hdr, msg);
 	if (write_all(ctl->fd, buf, len) < 0)
 		warn(_("write failed"));
-	else
-		if (ctl->socket_type == TYPE_TCP)
-			/* using an additional write seems like the best compromise:
-			 * - writev() is not yet supported by framework
-			 * - adding the \n to the buffer in formatters violates layers
-			 * - adding \n after the fact requires memory copy
-			 * - logger is not a high-performance app
-			 */
-			if (write_all(ctl->fd, "\n", 1) < 0)
-				warn(_("write failed"));
+	else if (ctl->socket_type == TYPE_TCP)
+		/* using an additional write seems like the best compromise:
+		 * - writev() is not yet supported by framework
+		 * - adding the \n to the buffer in formatters violates layers
+		 * - adding \n after the fact requires memory copy
+		 * - logger is not a high-performance app
+		 */
+		if (write_all(ctl->fd, "\n", 1) < 0)
+			warn(_("write failed"));
 	if (ctl->stderr_printout)
 		fprintf(stderr, "%s\n", buf);
 }
@@ -387,29 +386,35 @@ static void syslog_rfc3164_header(struct logger_ctl *const ctl)
 #define NILVALUE "-"
 static void syslog_rfc5424_header(struct logger_ctl *const ctl)
 {
+	char *time;
+	char *hostname;
+	char *const app_name = ctl->tag;
+	char *procid;
+	char *const msgid = xstrdup(ctl->msgid ? ctl->msgid : NILVALUE);
+	char *structured_data;
+
 	if (ctl->fd < 0)
 		return;
 
-	char *time;
 	if (ctl->rfc5424_time) {
 		struct timeval tv;
 		struct tm *tm;
+
 		gettimeofday(&tv, NULL);
 		if ((tm = localtime(&tv.tv_sec)) != NULL) {
 			char fmt[64];
 			const size_t i = strftime(fmt, sizeof(fmt),
-					"%Y-%m-%dT%H:%M:%S.%%06u%z ", tm);
+						  "%Y-%m-%dT%H:%M:%S.%%06u%z ", tm);
 			/* patch TZ info to comply with RFC3339 (we left SP at end) */
-			fmt[i-1] = fmt[i-2];
-			fmt[i-2] = fmt[i-3];
-			fmt[i-3] = ':';
+			fmt[i - 1] = fmt[i - 2];
+			fmt[i - 2] = fmt[i - 3];
+			fmt[i - 3] = ':';
 			xasprintf(&time, fmt, tv.tv_usec);
 		} else
 			err(EXIT_FAILURE, _("localtime() failed"));
 	} else
 		time = xstrdup(NILVALUE);
 
-	char *hostname;
 	if (ctl->rfc5424_host) {
 		hostname = xgethostname();
 		/* Arbitrary looking 'if (var < strlen()) checks originate from
@@ -420,22 +425,18 @@ static void syslog_rfc5424_header(struct logger_ctl *const ctl)
 	} else
 		hostname = xstrdup(NILVALUE);
 
-	char *const app_name = ctl->tag;
 	if (48 < strlen(ctl->tag))
 		errx(EXIT_FAILURE, _("tag '%s' is too long"), ctl->tag);
 
-	char *procid;
 	if (ctl->pid)
 		xasprintf(&procid, "%d", ctl->pid);
 	else
 		procid = xstrdup(NILVALUE);
 
-	char *const msgid = xstrdup((ctl->msgid) ? ctl->msgid : NILVALUE);
-
-	char *structured_data;
 	if (ctl->rfc5424_tq) {
 #ifdef HAVE_NTP_GETTIME
 		struct ntptimeval ntptv;
+
 		if (ntp_gettime(&ntptv) == TIME_OK)
 			xasprintf(&structured_data,
 				 "[timeQuality tzKnown=\"1\" isSynced=\"1\" syncAccuracy=\"%ld\"]",
@@ -527,8 +528,8 @@ static void logger_open(struct logger_ctl *ctl)
 	ctl->fd = unix_socket(ctl, ctl->unix_socket, ctl->socket_type);
 	if (!ctl->syslogfp)
 		ctl->syslogfp = syslog_local_header;
-	if(!ctl->tag)
-			ctl->tag = xgetlogin();
+	if (!ctl->tag)
+		ctl->tag = xgetlogin();
 	generate_syslog_header(ctl);
 }
 
@@ -581,9 +582,9 @@ static void logger_stdin(struct logger_ctl *ctl)
 			if (c == '<') {
 				pri = 0;
 				buf[i++] = c;
-				while(isdigit(c = getchar()) && pri <= 191) {
-						buf[i++] = c;
-						pri = pri * 10 + c - '0';
+				while (isdigit(c = getchar()) && pri <= 191) {
+					buf[i++] = c;
+					pri = pri * 10 + c - '0';
 				}
 				if (c != EOF && c != '\n')
 					buf[i++] = c;
@@ -611,10 +612,10 @@ static void logger_stdin(struct logger_ctl *ctl)
 		}
 		buf[i] = '\0';
 
-		if(i > 0 || !ctl->skip_empty_lines)
+		if (i > 0 || !ctl->skip_empty_lines)
 			write_output(ctl, buf);
 
-		if (c == '\n') /* discard line terminator */
+		if (c == '\n')	/* discard line terminator */
 			c = getchar();
 	}
 }
@@ -701,29 +702,29 @@ int main(int argc, char **argv)
 	FILE *jfd = NULL;
 #endif
 	static const struct option longopts[] = {
-		{ "id",		optional_argument,  0, OPT_ID },
-		{ "stderr",	no_argument,	    0, 's' },
-		{ "file",	required_argument,  0, 'f' },
-		{ "priority",	required_argument,  0, 'p' },
-		{ "tag",	required_argument,  0, 't' },
-		{ "socket",	required_argument,  0, 'u' },
+		{ "id",		   optional_argument, 0, OPT_ID		   },
+		{ "stderr",	   no_argument,	      0, 's'		   },
+		{ "file",	   required_argument, 0, 'f'		   },
+		{ "priority",	   required_argument, 0, 'p'		   },
+		{ "tag",	   required_argument, 0, 't'		   },
+		{ "socket",	   required_argument, 0, 'u'		   },
 		{ "socket-errors", required_argument, 0, OPT_SOCKET_ERRORS },
-		{ "udp",	no_argument,	    0, 'd' },
-		{ "tcp",	no_argument,	    0, 'T' },
-		{ "server",	required_argument,  0, 'n' },
-		{ "port",	required_argument,  0, 'P' },
-		{ "version",	no_argument,	    0, 'V' },
-		{ "help",	no_argument,	    0, 'h' },
-		{ "prio-prefix", no_argument, 0, OPT_PRIO_PREFIX },
-		{ "rfc3164",	no_argument,  0, OPT_RFC3164 },
-		{ "rfc5424",	optional_argument,  0, OPT_RFC5424 },
-		{ "size",       required_argument,  0, 'S' },
-		{ "msgid",      required_argument,  0, OPT_MSGID },
-		{ "skip-empty", no_argument,  0, 'e' },
+		{ "udp",	   no_argument,	      0, 'd'		   },
+		{ "tcp",	   no_argument,	      0, 'T'		   },
+		{ "server",	   required_argument, 0, 'n'		   },
+		{ "port",	   required_argument, 0, 'P'		   },
+		{ "version",	   no_argument,	      0, 'V'		   },
+		{ "help",	   no_argument,	      0, 'h'		   },
+		{ "prio-prefix",   no_argument,	      0, OPT_PRIO_PREFIX   },
+		{ "rfc3164",	   no_argument,	      0, OPT_RFC3164	   },
+		{ "rfc5424",	   optional_argument, 0, OPT_RFC5424	   },
+		{ "size",	   required_argument, 0, 'S'		   },
+		{ "msgid",	   required_argument, 0, OPT_MSGID	   },
+		{ "skip-empty",	   no_argument,	      0, 'e'		   },
 #ifdef HAVE_LIBSYSTEMD
-		{ "journald",   optional_argument,  0, OPT_JOURNALD },
+		{ "journald",	   optional_argument, 0, OPT_JOURNALD	   },
 #endif
-		{ NULL,		0, 0, 0 }
+		{ NULL,		   0,		      0, 0		   }
 	};
 
 	setlocale(LC_ALL, "");
@@ -800,8 +801,8 @@ int main(int argc, char **argv)
 				parse_rfc5424_flags(&ctl, optarg);
 			break;
 		case OPT_MSGID:
-			if(strchr(optarg, ' '))
-					err(EXIT_FAILURE, _("--msgid cannot contain space"));
+			if (strchr(optarg, ' '))
+				err(EXIT_FAILURE, _("--msgid cannot contain space"));
 			ctl.msgid = optarg;
 			break;
 #ifdef HAVE_LIBSYSTEMD
-- 
2.3.2

