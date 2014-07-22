Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f172.google.com ([74.125.82.172]:33628 "EHLO
	mail-we0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756949AbaGVWBn (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:43 -0400
Received: by mail-we0-f172.google.com with SMTP id x48so291240wes.3
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:42 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Kodiak Firesmith <ksf@sei.cmu.edu>
Subject: [PATCH 07/10] logger: add rfc5424 support
Date: Tue, 22 Jul 2014 23:00:56 +0100
Message-Id: <1406066459-4816-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add support the more recent syslog protocol and make it default.  The
older BSD syslog protocol can still be used with option --rfc3164.
Protocols are meaningful only when messages are sent to remote syslog
server.

Requested-by: Kodiak Firesmith <ksf@sei.cmu.edu>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 audit_getloginuid   |   0
 misc-utils/logger.c | 116 ++++++++++++++++++++++++++++++++++++++++++++++++----
 2 files changed, 108 insertions(+), 8 deletions(-)
 create mode 100644 audit_getloginuid

diff --git a/audit_getloginuid b/audit_getloginuid
new file mode 100644
index 0000000..e69de29
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index d49bb19..3974f11 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -44,6 +44,7 @@
 #include <stdio.h>
 #include <ctype.h>
 #include <string.h>
+#include <sys/timex.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <sys/un.h>
@@ -74,7 +75,9 @@ enum {
 
 enum {
 	OPT_PRIO_PREFIX = CHAR_MAX + 1,
-	OPT_JOURNALD
+	OPT_JOURNALD,
+	OPT_RFC3164,
+	OPT_RFC5424
 };
 
 struct logger_ctl {
@@ -82,6 +85,9 @@ struct logger_ctl {
 	int logflags;
 	int pri;
 	char *tag;
+	unsigned int	rfc5424_time:1,
+			rfc5424_tq:1,
+			rfc5424_host:1;
 };
 
 static char *get_prio_prefix(char *msg, int *prio)
@@ -298,6 +304,82 @@ static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 		warn(_("write failed"));
 }
 
+static void syslog_rfc5424(struct logger_ctl *ctl, char *msg)
+{
+	char *buf, pid[32], *tag;
+	struct ntptimeval ntptv;
+	char fmt[64], time[64], timeq[80], *hostname;
+	struct timeval tv;
+	struct tm *tm;
+
+	if (ctl->fd < 0)
+		return;
+	if (ctl->rfc5424_time) {
+		gettimeofday(&tv, NULL);
+		if ((tm = localtime(&tv.tv_sec)) != NULL) {
+			strftime(fmt, sizeof(fmt), " %Y-%m-%dT%H:%M:%S.%%06u%z",
+				 tm);
+			snprintf(time, sizeof(time), fmt, tv.tv_usec);
+		} else
+			err(EXIT_FAILURE, _("localtime() failed"));
+	} else
+		time[0] = 0;
+	if (ctl->rfc5424_host) {
+		hostname = xgethostname();
+		/* Arbitrary looking 'if (var < strlen()) checks originate from
+		 * RFC 5424 - 6 Syslog Message Format definition.  */
+		if (255 < strlen(hostname))
+			errx(EXIT_FAILURE, _("hostname '%s' is too long"),
+			     hostname);
+	} else
+		hostname = xcalloc(1, sizeof(char));
+	if (ctl->tag)
+		tag = ctl->tag;
+	else
+		tag = xgetlogin();
+	if (48 < strlen(tag))
+		errx(EXIT_FAILURE, _("tag '%s' is too long"), tag);
+	if (ctl->logflags & LOG_PID)
+		snprintf(pid, sizeof(pid), " %d", getpid());
+	else
+		pid[0] = 0;
+	if (ctl->rfc5424_tq) {
+		if (ntp_gettime(&ntptv) == TIME_OK)
+			snprintf(timeq, sizeof(timeq),
+				 " [timeQuality tzKnown=\"1\" isSynced=\"1\" syncAccuracy=\"%ld\"]",
+				 ntptv.maxerror);
+		else
+			snprintf(timeq, sizeof(timeq),
+				 " [timeQuality tzKnown=\"1\" isSynced=\"0\"]");
+	} else
+		timeq[0] = 0;
+	xasprintf(&buf, "<%d>1%s%s%s %s -%s%s %s", ctl->pri, time,
+		  hostname[0] ? " " : "", hostname, tag, pid, timeq, msg);
+	if (write_all(ctl->fd, buf, strlen(buf) + 1) < 0)
+		warn(_("write failed"));
+	free(hostname);
+	free(buf);
+}
+
+static void parse_rfc5424(struct logger_ctl *ctl, char *optarg)
+{
+	char *in, *tok;
+
+	in = optarg;
+	while ((tok = strtok(in, ","))) {
+		in = NULL;
+		if (!strcmp(tok, "notime")) {
+			ctl->rfc5424_time = 0;
+			ctl->rfc5424_tq = 0;
+		} else if (!strcmp(tok, "notq"))
+			ctl->rfc5424_tq = 0;
+		else if (!strcmp(tok, "nohost"))
+			ctl->rfc5424_host = 0;
+		else
+			warnx(_("ignoring unknown option argument: %s"), tok);
+	}
+}
+
 static void syslog_local(struct logger_ctl *ctl, char *msg)
 {
 	syslog(ctl->pri, "%s", msg);
@@ -309,16 +391,19 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	fprintf(out, _(" %s [options] [<message>]\n"), program_invocation_short_name);
 
 	fputs(USAGE_OPTIONS, out);
-	fputs(_(" -T, --tcp             use TCP only\n"), out);
-	fputs(_(" -d, --udp             use UDP only\n"), out);
 	fputs(_(" -i, --id              log the process ID too\n"), out);
 	fputs(_(" -f, --file <file>     log the contents of this file\n"), out);
-	fputs(_(" -n, --server <name>   write to this remote syslog server\n"), out);
-	fputs(_(" -P, --port <number>   use this UDP port\n"), out);
 	fputs(_(" -p, --priority <prio> mark given message with this priority\n"), out);
 	fputs(_("     --prio-prefix     look for a prefix on every line read from stdin\n"), out);
 	fputs(_(" -s, --stderr          output message to standard error as well\n"), out);
 	fputs(_(" -t, --tag <tag>       mark every line with this tag\n"), out);
+	fputs(_(" -n, --server <name>   write to this remote syslog server\n"), out);
+	fputs(_(" -P, --port <number>   use this UDP port\n"), out);
+	fputs(_(" -T, --tcp             use TCP only\n"), out);
+	fputs(_(" -d, --udp             use UDP only\n"), out);
+	fputs(_("     --rfc3164         use the BSD syslog protocol\n"), out);
+	fputs(_("     --rfc5424[=<notime,notq,nohost>]\n"), out);
+	fputs(_("                       use the syslog protocol (default)\n"), out);
 	fputs(_(" -u, --socket <socket> write to this Unix socket\n"), out);
 #ifdef HAVE_LIBSYSTEMD
 	fputs(_("     --journald[=<file>]  write journald entry\n"), out);
@@ -345,6 +430,9 @@ int main(int argc, char **argv)
 		.logflags = 0,
 		.pri = LOG_NOTICE,
 		.tag = NULL,
+		.rfc5424_time = 1,
+		.rfc5424_tq = 1,
+		.rfc5424_host = 1,
 	};
 	int ch, prio_prefix;
 	char buf[1024];
@@ -369,12 +457,14 @@ int main(int argc, char **argv)
 		{ "version",	no_argument,	    0, 'V' },
 		{ "help",	no_argument,	    0, 'h' },
 		{ "prio-prefix", no_argument, 0, OPT_PRIO_PREFIX },
+		{ "rfc3164",	no_argument,  0, OPT_RFC3164 },
+		{ "rfc5424",	optional_argument,  0, OPT_RFC5424 },
 #ifdef HAVE_LIBSYSTEMD
 		{ "journald",   optional_argument,  0, OPT_JOURNALD },
 #endif
 		{ NULL,		0, 0, 0 }
 	};
-	void (*syslogfp)(struct logger_ctl *ctl, char *msg);
+	void (*syslogfp)(struct logger_ctl *ctl, char *msg) = NULL;
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
@@ -424,6 +514,14 @@ int main(int argc, char **argv)
 		case OPT_PRIO_PREFIX:
 			prio_prefix = 1;
 			break;
+		case OPT_RFC3164:
+			syslogfp = syslog_rfc3164;
+			break;
+		case OPT_RFC5424:
+			syslogfp = syslog_rfc5424;
+			if (optarg)
+				parse_rfc5424(&ctl, optarg);
+			break;
 #ifdef HAVE_LIBSYSTEMD
 		case OPT_JOURNALD:
 			if (optarg) {
@@ -456,10 +554,12 @@ int main(int argc, char **argv)
 #endif
 	if (server) {
 		ctl.fd = inet_socket(server, port, socket_type);
-		syslogfp = syslog_rfc3164;
+		if (!syslogfp)
+			syslogfp = syslog_rfc5424;
 	} else if (usock) {
 		ctl.fd = unix_socket(usock, socket_type);
-		syslogfp = syslog_rfc3164;
+		if (!syslogfp)
+			syslogfp = syslog_rfc5424;
 	} else {
 		openlog(ctl.tag ? ctl.tag : xgetlogin(), ctl.logflags, 0);
 		syslogfp = syslog_local;
-- 
2.0.2

