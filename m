Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f177.google.com ([74.125.82.177]:47817 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751449AbaGZPJT (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jul 2014 11:09:19 -0400
Received: by mail-we0-f177.google.com with SMTP id w62so5392187wes.22
        for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 08:09:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] logger: tidy up main() by adding small functions and ctl data
Date: Sat, 26 Jul 2014 16:09:11 +0100
Message-Id: <1406387352-32044-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add logger_open(), logger_command_line(), logger_stdin(), and
logger_close() functions, and move all remaining option argument
assignments to control structure.

Proposed-by: Karel Zak <kzak@redhat.com>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 164 ++++++++++++++++++++++++++++++----------------------
 1 file changed, 95 insertions(+), 69 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index ed45f93..b324782 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -81,7 +81,12 @@ struct logger_ctl {
 	int fd;
 	int logflags;
 	int pri;
+	int prio_prefix;
 	char *tag;
+	char *unix_socket;
+	char *server;
+	char *port;
+	int socket_type;
 	void (*syslogfp)(struct logger_ctl *ctl, char *msg);
 };
 
@@ -304,6 +309,77 @@ static void syslog_local(struct logger_ctl *ctl, char *msg)
 	syslog(ctl->pri, "%s", msg);
 }
 
+static void logger_open(struct logger_ctl *ctl)
+{
+	if (ctl->server) {
+		ctl->fd = inet_socket(ctl->server, ctl->port, ctl->socket_type);
+		ctl->syslogfp = syslog_rfc3164;
+		return;
+	}
+	if (ctl->unix_socket) {
+		ctl->fd = unix_socket(ctl->unix_socket, ctl->socket_type);
+		ctl->syslogfp = syslog_rfc3164;
+		return;
+	}
+	openlog(ctl->tag ? ctl->tag : xgetlogin(), ctl->logflags, 0);
+	ctl->syslogfp = syslog_local;
+}
+
+static void logger_command_line(struct logger_ctl *ctl, char **argv)
+{
+	char buf[4096];
+	char *p = buf;
+	const char *endp = buf + sizeof(buf) - 2;
+	size_t len;
+
+	while (*argv) {
+		len = strlen(*argv);
+		if (endp < p + len && p != buf) {
+			ctl->syslogfp(ctl, buf);
+			p = buf;
+		}
+		if (sizeof(buf) - 1 < len) {
+			ctl->syslogfp(ctl, *argv++);
+			continue;
+		}
+		if (p != buf)
+			*p++ = ' ';
+		memmove(p, *argv++, len);
+		*(p += len) = '\0';
+	}
+	if (p != buf)
+		ctl->syslogfp(ctl, buf);
+}
+
+static void logger_stdin(struct logger_ctl *ctl)
+{
+	char *msg;
+	int default_priority = ctl->pri;
+	char buf[1024];
+
+	while (fgets(buf, sizeof(buf), stdin) != NULL) {
+		int len = strlen(buf);
+
+		/* some glibc versions are buggy, they add an additional
+		 * newline which is removed here.  */
+		if (0 < len && buf[len - 1] == '\n')
+			buf[len - 1] = '\0';
+		msg = buf;
+		ctl->pri = default_priority;
+		if (ctl->prio_prefix && msg[0] == '<')
+			msg = get_prio_prefix(msg, &ctl->pri);
+		ctl->syslogfp(ctl, msg);
+	}
+}
+
+static void logger_close(struct logger_ctl *ctl)
+{
+	if (!ctl->unix_socket && !ctl->server)
+		closelog();
+	else
+		close(ctl->fd);
+}
+
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
@@ -345,14 +421,14 @@ int main(int argc, char **argv)
 		.fd = -1,
 		.logflags = 0,
 		.pri = LOG_NOTICE,
+		.prio_prefix = 0,
 		.tag = NULL,
+		.unix_socket = NULL,
+		.server = NULL,
+		.port = NULL,
+		.socket_type = ALL_TYPES
 	};
-	int ch, prio_prefix;
-	char buf[1024];
-	char *usock = NULL;
-	char *server = NULL;
-	char *port = NULL;
-	int socket_type = ALL_TYPES;
+	int ch;
 #ifdef HAVE_LIBSYSTEMD
 	FILE *jfd = NULL;
 #endif
@@ -402,19 +478,19 @@ int main(int argc, char **argv)
 			ctl.tag = optarg;
 			break;
 		case 'u':		/* unix socket */
-			usock = optarg;
+			ctl.unix_socket = optarg;
 			break;
 		case 'd':
-			socket_type = TYPE_UDP;
+			ctl.socket_type = TYPE_UDP;
 			break;
 		case 'T':
-			socket_type = TYPE_TCP;
+			ctl.socket_type = TYPE_TCP;
 			break;
 		case 'n':
-			server = optarg;
+			ctl.server = optarg;
 			break;
 		case 'P':
-			port = optarg;
+			ctl.port = optarg;
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -422,7 +498,7 @@ int main(int argc, char **argv)
 		case 'h':
 			usage(stdout);
 		case OPT_PRIO_PREFIX:
-			prio_prefix = 1;
+			ctl.prio_prefix = 1;
 			break;
 #ifdef HAVE_LIBSYSTEMD
 		case OPT_JOURNALD:
@@ -442,8 +518,6 @@ int main(int argc, char **argv)
 	}
 	argc -= optind;
 	argv += optind;
-
-	/* setup for logging */
 #ifdef HAVE_LIBSYSTEMD
 	if (jfd) {
 		int ret = journald_entry(jfd);
@@ -454,61 +528,13 @@ int main(int argc, char **argv)
 		return EXIT_SUCCESS;
 	}
 #endif
-	if (server) {
-		ctl.fd = inet_socket(server, port, socket_type);
-		ctl.syslogfp = syslog_rfc3164;
-	} else if (usock) {
-		ctl.fd = unix_socket(usock, socket_type);
-		ctl.syslogfp = syslog_rfc3164;
-	} else {
-		openlog(ctl.tag ? ctl.tag : xgetlogin(), ctl.logflags, 0);
-		ctl.syslogfp = syslog_local;
-	}
-
-	/* log input line if appropriate */
-	if (argc > 0) {
-		register char *p, *endp;
-		size_t len;
-
-		for (p = buf, endp = buf + sizeof(buf) - 2; *argv;) {
-			len = strlen(*argv);
-			if (p + len > endp && p > buf) {
-				ctl.syslogfp(&ctl, buf);
-				p = buf;
-			}
-			if (len > sizeof(buf) - 1)
-				ctl.syslogfp(&ctl, *argv++);
-			else {
-				if (p != buf)
-					*p++ = ' ';
-				memmove(p, *argv++, len);
-				*(p += len) = '\0';
-			}
-		}
-		if (p != buf)
-			ctl.syslogfp(&ctl, buf);
-	} else {
-		char *msg;
-		int default_priority = ctl.pri;
-		while (fgets(buf, sizeof(buf), stdin) != NULL) {
-			/* glibc is buggy and adds an additional newline,
-			   so we have to remove it here until glibc is fixed */
-			int len = strlen(buf);
-
-			if (len > 0 && buf[len - 1] == '\n')
-				buf[len - 1] = '\0';
-
-			msg = buf;
-			ctl.pri = default_priority;
-			if (prio_prefix && msg[0] == '<')
-				msg = get_prio_prefix(msg, &ctl.pri);
-			ctl.syslogfp(&ctl, msg);
-		}
-	}
-	if (!usock && !server)
-		closelog();
+	logger_open(&ctl);
+	if (0 < argc)
+		logger_command_line(&ctl, argv);
 	else
-		close(ctl.fd);
-
+		/* Note. --file <arg> reopens stdin making the below
+		 * function to be used for file inputs. */
+		logger_stdin(&ctl);
+	logger_close(&ctl);
 	return EXIT_SUCCESS;
 }
-- 
2.0.3

