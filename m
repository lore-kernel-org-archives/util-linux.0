Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f169.google.com ([74.125.82.169]:54739 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756913AbaGVWB2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:28 -0400
Received: by mail-we0-f169.google.com with SMTP id u56so289786wes.14
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:26 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Kodiak Firesmith <ksf@sei.cmu.edu>
Subject: [PATCH 06/10] logger: add function pointer to choose how logging is done
Date: Tue, 22 Jul 2014 23:00:55 +0100
Message-Id: <1406066459-4816-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This change paves way to adding support for both RFC 3164 and RFC 5424
syslog protocols.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 102 +++++++++++++++++++++++++++-------------------------
 1 file changed, 53 insertions(+), 49 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 5506022..d49bb19 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -77,6 +77,13 @@ enum {
 	OPT_JOURNALD
 };
 
+struct logger_ctl {
+	int fd;
+	int logflags;
+	int pri;
+	char *tag;
+};
+
 static char *get_prio_prefix(char *msg, int *prio)
 {
 	int p;
@@ -268,29 +275,34 @@ static char *xgetlogin()
 	return cp;
 }
 
-static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
+static void syslog_rfc3164(struct logger_ctl *ctl, char *msg)
 {
 	char buf[1000], pid[30], *cp, *tp;
 	time_t now;
 
-	if (fd < 0)
+	if (ctl->fd < 0)
 		return;
-	if (logflags & LOG_PID)
+	if (ctl->logflags & LOG_PID)
 		snprintf(pid, sizeof(pid), "[%d]", getpid());
 	else
 		pid[0] = 0;
-	if (tag)
-		cp = tag;
+	if (ctl->tag)
+		cp = ctl->tag;
 	else
 		cp = xgetlogin();
 	time(&now);
 	tp = ctime(&now) + 4;
 	snprintf(buf, sizeof(buf), "<%d>%.15s %.200s%s: %.400s",
-		 pri, tp, cp, pid, msg);
-	if (write_all(fd, buf, strlen(buf) + 1) < 0)
+		 ctl->pri, tp, cp, pid, msg);
+	if (write_all(ctl->fd, buf, strlen(buf) + 1) < 0)
 		warn(_("write failed"));
 }
 
+static void syslog_local(struct logger_ctl *ctl, char *msg)
+{
+	syslog(ctl->pri, "%s", msg);
+}
+
 static void __attribute__ ((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
@@ -328,12 +340,18 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
  */
 int main(int argc, char **argv)
 {
-	int ch, logflags, pri, prio_prefix;
-	char *tag, buf[1024];
+	struct logger_ctl ctl = {
+		.fd = -1,
+		.logflags = 0,
+		.pri = LOG_NOTICE,
+		.tag = NULL,
+	};
+	int ch, prio_prefix;
+	char buf[1024];
 	char *usock = NULL;
 	char *server = NULL;
 	char *port = NULL;
-	int LogSock = -1, socket_type = ALL_TYPES;
+	int socket_type = ALL_TYPES;
 #ifdef HAVE_LIBSYSTEMD
 	FILE *jfd = NULL;
 #endif
@@ -356,16 +374,13 @@ int main(int argc, char **argv)
 #endif
 		{ NULL,		0, 0, 0 }
 	};
+	void (*syslogfp)(struct logger_ctl *ctl, char *msg);
 
 	setlocale(LC_ALL, "");
 	bindtextdomain(PACKAGE, LOCALEDIR);
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
-	tag = NULL;
-	pri = LOG_NOTICE;
-	logflags = 0;
-	prio_prefix = 0;
 	while ((ch = getopt_long(argc, argv, "f:ip:st:u:dTn:P:Vh",
 					    longopts, NULL)) != -1) {
 		switch (ch) {
@@ -375,16 +390,16 @@ int main(int argc, char **argv)
 				    optarg);
 			break;
 		case 'i':		/* log process id also */
-			logflags |= LOG_PID;
+			ctl.logflags |= LOG_PID;
 			break;
 		case 'p':		/* priority */
-			pri = pencode(optarg);
+			ctl.pri = pencode(optarg);
 			break;
 		case 's':		/* log to standard error */
-			logflags |= LOG_PERROR;
+			ctl.logflags |= LOG_PERROR;
 			break;
 		case 't':		/* tag */
-			tag = optarg;
+			ctl.tag = optarg;
 			break;
 		case 'u':		/* unix socket */
 			usock = optarg;
@@ -439,12 +454,16 @@ int main(int argc, char **argv)
 		return EXIT_SUCCESS;
 	}
 #endif
-	if (server)
-		LogSock = inet_socket(server, port, socket_type);
-	else if (usock)
-		LogSock = unix_socket(usock, socket_type);
-	else
-		openlog(tag ? tag : xgetlogin(), logflags, 0);
+	if (server) {
+		ctl.fd = inet_socket(server, port, socket_type);
+		syslogfp = syslog_rfc3164;
+	} else if (usock) {
+		ctl.fd = unix_socket(usock, socket_type);
+		syslogfp = syslog_rfc3164;
+	} else {
+		openlog(ctl.tag ? ctl.tag : xgetlogin(), ctl.logflags, 0);
+		syslogfp = syslog_local;
+	}
 
 	/* log input line if appropriate */
 	if (argc > 0) {
@@ -454,20 +473,12 @@ int main(int argc, char **argv)
 		for (p = buf, endp = buf + sizeof(buf) - 2; *argv;) {
 			len = strlen(*argv);
 			if (p + len > endp && p > buf) {
-				if (!usock && !server)
-					syslog(pri, "%s", buf);
-				else
-					mysyslog(LogSock, logflags, pri, tag,
-						 buf);
+				syslogfp(&ctl, buf);
 				p = buf;
 			}
-			if (len > sizeof(buf) - 1) {
-				if (!usock && !server)
-					syslog(pri, "%s", *argv++);
-				else
-					mysyslog(LogSock, logflags, pri, tag,
-						 *argv++);
-			} else {
+			if (len > sizeof(buf) - 1)
+				syslogfp(&ctl, *argv++);
+			else {
 				if (p != buf)
 					*p++ = ' ';
 				memmove(p, *argv++, len);
@@ -475,14 +486,11 @@ int main(int argc, char **argv)
 			}
 		}
 		if (p != buf) {
-			if (!usock && !server)
-				syslog(pri, "%s", buf);
-			else
-				mysyslog(LogSock, logflags, pri, tag, buf);
+			syslogfp(&ctl, buf);
 		}
 	} else {
 		char *msg;
-		int default_priority = pri;
+		int default_priority = ctl.pri;
 		while (fgets(buf, sizeof(buf), stdin) != NULL) {
 			/* glibc is buggy and adds an additional newline,
 			   so we have to remove it here until glibc is fixed */
@@ -492,20 +500,16 @@ int main(int argc, char **argv)
 				buf[len - 1] = '\0';
 
 			msg = buf;
-			pri = default_priority;
+			ctl.pri = default_priority;
 			if (prio_prefix && msg[0] == '<')
-				msg = get_prio_prefix(msg, &pri);
-
-			if (!usock && !server)
-				syslog(pri, "%s", msg);
-			else
-				mysyslog(LogSock, logflags, pri, tag, msg);
+				msg = get_prio_prefix(msg, &ctl.pri);
+			syslogfp(&ctl, msg);
 		}
 	}
 	if (!usock && !server)
 		closelog();
 	else
-		close(LogSock);
+		close(ctl.fd);
 
 	return EXIT_SUCCESS;
 }
-- 
2.0.2

