Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:35999 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1162705Ab3DEURa (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 5 Apr 2013 16:17:30 -0400
Received: by mail-wi0-f173.google.com with SMTP id ez12so962138wid.6
        for <util-linux@vger.kernel.org>; Fri, 05 Apr 2013 13:17:29 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] logger: allow to log using tcp transport protocol
Date: Fri,  5 Apr 2013 21:17:24 +0100
Message-Id: <1365193044-14783-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This commit fixes error in usage() text, which claimed TCP is default
transport protocol.  That was not true, and neither it should be.  The
syslog messages has traditionally sent using UDP.

For the logger remains using UDP as first transport, but if it fails a
TCP connection is attempted.  If an user wishes remote logging can be
forced to use either UDP or TCP.  The service port for UDP is familiar
'syslog', for TCP the port 'syslog-conn' seems like reasonable default.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.1 |  37 ++++++++++-----
 misc-utils/logger.c | 130 +++++++++++++++++++++++++++++++++-------------------
 2 files changed, 108 insertions(+), 59 deletions(-)

diff --git a/misc-utils/logger.1 b/misc-utils/logger.1
index d863ac3..09ecdc4 100644
--- a/misc-utils/logger.1
+++ b/misc-utils/logger.1
@@ -33,7 +33,7 @@
 .\"
 .\" Section on valid facility and level strings added by
 .\" and1000@debian.org, 26 Oct 1997.
-.TH LOGGER "1" "September 2011" "util-linux" "User Commands"
+.TH LOGGER "1" "April 2013" "util-linux" "User Commands"
 .SH NAME
 logger \- a shell command interface to the syslog(3) system log module
 .SH SYNOPSIS
@@ -47,8 +47,31 @@ interface to the
 system log module.
 .SH OPTIONS
 .TP
+\fB\-n\fR, \fB\-\-server\fR \fIserver\fR
+Write to the specified remote syslog
+.I server
+instead of to the builtin syslog routines.  Unless
+.B \-\-udp
+or
+.B \-\-tcp
+is specified the logger will first try to use UDP, but if it fails a TCP
+connection is attempted.
+.TP
 \fB\-d\fR, \fB\-\-udp\fR
-Use datagram (UDP) instead of the default stream connection (TCP).
+Use datagram (UDP) only.  By default the connection is tried to
+.I syslog
+port defined in /etc/services, which is often
+.IR 514 .
+.TP
+\fB\-T\fR, \fB\-\-tcp\fR
+Use stream (TCP) only.  By default the connection is tried to
+.I syslog-conn
+port defined in /etc/services, which is often
+.IR 601 .
+.TP
+\fB\-P\fR, \fB\-\-port\fR \fIport\fR
+Use the specified
+.IR port .
 .TP
 \fB\-i\fR, \fB\-\-id\fR
 Log the process ID of the logger process with each line.
@@ -61,16 +84,6 @@ This option cannot be combined with a command-line message.
 \fB\-h\fR, \fB\-\-help\fR
 Display a help text and exit.
 .TP
-\fB\-n\fR, \fB\-\-server\fR \fIserver\fR
-Write to the specified remote syslog
-.I server
-using UDP instead of to the builtin syslog routines.
-.TP
-\fB\-P\fR, \fB\-\-port\fR \fIport\fR
-Use the specified UDP
-.IR port .
-The default port number is 514.
-.TP
 \fB\-p\fR, \fB\-\-priority\fR \fIpriority\fR
 Enter the message into the log with the specified
 .IR priority  .
diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index a6fafc1..393f112 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -58,6 +58,12 @@
 #define	SYSLOG_NAMES
 #include <syslog.h>
 
+enum {
+	TYPE_UDP = (1 << 1),
+	TYPE_TCP = (1 << 2),
+	ALL_TYPES = TYPE_UDP | TYPE_TCP
+};
+
 static int decode(char *name, CODE *codetab)
 {
 	register CODE *c;
@@ -96,9 +102,9 @@ static int pencode(char *s)
 }
 
 static int
-myopenlog(const char *sock, int optd)
+myopenlog(const char *sock, const int socket_type)
 {
-	int fd;
+	int fd, i, st = -1;
 	static struct sockaddr_un s_addr;	/* AF_UNIX address of local logger */
 
 	if (strlen(sock) >= sizeof(s_addr.sun_path))
@@ -107,46 +113,72 @@ myopenlog(const char *sock, int optd)
 	s_addr.sun_family = AF_UNIX;
 	(void)strcpy(s_addr.sun_path, sock);
 
-	if (optd == 0) {
-		if ((fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1)
-			goto udp_socket;
+	for (i = 2; i; i--) {
+		if (i == 2 && socket_type & TYPE_UDP)
+			st = SOCK_DGRAM;
+		if (i == 1 && socket_type & TYPE_TCP)
+			st = SOCK_STREAM;
+		if (st == -1 || (fd = socket(AF_UNIX, st, 0)) == -1)
+			continue;
 		if (connect(fd, (struct sockaddr *)&s_addr, sizeof(s_addr)) == -1) {
 			close(fd);
-			goto udp_socket;
+			continue;
 		}
-	} else {
- udp_socket:
-		if ((fd = socket(AF_UNIX, SOCK_DGRAM, 0)) == -1)
-			err(EXIT_FAILURE, _("socket %s"), sock);
-		if (connect(fd, (struct sockaddr *)&s_addr, sizeof(s_addr)) == -1)
-			err(EXIT_FAILURE, _("connect %s"), sock);
+		break;
 	}
 
+	if (i == 0)
+		err(EXIT_FAILURE, _("socket %s"), sock);
+
 	return fd;
 }
 
 static int
-udpopenlog(const char *servername, const char *port) {
-	int fd, errcode;
+inet_socket(const char *servername, const char *port, const int socket_type)
+{
+	int fd, errcode, i;
 	struct addrinfo hints, *res;
+	const char *p = port;
+
+	for (i = 2; i; i--) {
+		memset(&hints, 0, sizeof(hints));
+		if (i == 2 && socket_type & TYPE_UDP) {
+			hints.ai_socktype = SOCK_DGRAM;
+			if (port == NULL)
+				p = "syslog";
+		}
+		if (i == 1 && socket_type & TYPE_TCP) {
+			hints.ai_socktype = SOCK_STREAM;
+			if (port == NULL)
+				p = "syslog-conn";
+		}
+		if (hints.ai_socktype == 0)
+			continue;
+		hints.ai_family = AF_UNSPEC;
+		errcode = getaddrinfo(servername, p, &hints, &res);
+		if (errcode != 0)
+			errx(EXIT_FAILURE, _("getaddrinfo %s:%s: %s"),
+			     servername, p, gai_strerror(errcode));
+		if ((fd = socket(res->ai_family, res->ai_socktype, res->ai_protocol)) == -1) {
+			freeaddrinfo(res);
+			continue;
+		}
+		if (connect(fd, res->ai_addr, res->ai_addrlen) == -1) {
+			freeaddrinfo(res);
+			close(fd);
+			continue;
+		}
 
-	memset(&hints, 0, sizeof(hints));
-	hints.ai_socktype = SOCK_DGRAM;
-	hints.ai_family = AF_UNSPEC;
-
-	errcode = getaddrinfo(servername, port, &hints, &res);
-	if (errcode != 0)
-		errx(EXIT_FAILURE, _("getaddrinfo %s:%s: %s"), servername, port,
-		     gai_strerror(errcode));
-	if ((fd = socket(res->ai_family, res->ai_socktype, res->ai_protocol)) == -1)
-		err(EXIT_FAILURE, _("socket"));
+		freeaddrinfo(res);
+		break;
+	}
 
-	if (connect(fd, res->ai_addr, res->ai_addrlen) == -1)
-		err(EXIT_FAILURE, _("connect"));
+	if (i == 0)
+		errx(EXIT_FAILURE, _("failed to connect %s port %s"), servername, p);
 
-	freeaddrinfo(res);
 	return fd;
 }
+
 static void
 mysyslog(int fd, int logflags, int pri, char *tag, char *msg) {
        char buf[1000], pid[30], *cp, *tp;
@@ -182,7 +214,8 @@ static void __attribute__ ((__noreturn__)) usage(FILE *out)
 	      _(" %s [options] [message]\n"), program_invocation_short_name);
 
 	fputs(_("\nOptions:\n"), out);
-	fputs(_(" -d, --udp             use UDP (TCP is default)\n"
+	fputs(_(" -T, --tcp             use TCP only\n"), out);
+	fputs(_(" -d, --udp             use UDP only\n"
 		" -i, --id              log the process ID too\n"
 		" -f, --file <file>     log the contents of this file\n"
 		" -h, --help            display this help text and exit\n"), out);
@@ -208,9 +241,9 @@ main(int argc, char **argv) {
 	int ch, logflags, pri;
 	char *tag, buf[1024];
 	char *usock = NULL;
-	char *udpserver = NULL;
-	char *udpport = NULL;
-	int LogSock = -1, optd = 0;
+	char *server = NULL;
+	char *port = NULL;
+	int LogSock = -1, socket_type = ALL_TYPES;
 
 	static const struct option longopts[] = {
 		{ "id",		no_argument,	    0, 'i' },
@@ -220,6 +253,7 @@ main(int argc, char **argv) {
 		{ "tag",	required_argument,  0, 't' },
 		{ "socket",	required_argument,  0, 'u' },
 		{ "udp",	no_argument,	    0, 'd' },
+		{ "tcp",	no_argument,	    0, 'T' },
 		{ "server",	required_argument,  0, 'n' },
 		{ "port",	required_argument,  0, 'P' },
 		{ "version",	no_argument,	    0, 'V' },
@@ -235,7 +269,7 @@ main(int argc, char **argv) {
 	tag = NULL;
 	pri = LOG_NOTICE;
 	logflags = 0;
-	while ((ch = getopt_long(argc, argv, "f:ip:st:u:dn:P:Vh",
+	while ((ch = getopt_long(argc, argv, "f:ip:st:u:dTn:P:Vh",
 					    longopts, NULL)) != -1) {
 		switch((char)ch) {
 		case 'f':		/* file to log */
@@ -259,14 +293,16 @@ main(int argc, char **argv) {
 			usock = optarg;
 			break;
 		case 'd':
-			optd = 1;	/* use datagrams */
+			socket_type = TYPE_UDP;
+			break;
+		case 'T':
+			socket_type = TYPE_TCP;
 			break;
-		case 'n':		/* udp socket */
-			optd = 1;	/* use datagrams because udp */
-			udpserver = optarg;
+		case 'n':
+			server = optarg;
 			break;
-		case 'P':		/* change udp port */
-			udpport = optarg;
+		case 'P':
+			port = optarg;
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
@@ -282,12 +318,12 @@ main(int argc, char **argv) {
 	argv += optind;
 
 	/* setup for logging */
-	if (!usock && !udpserver)
+	if (!usock && !server)
 		openlog(tag ? tag : getlogin(), logflags, 0);
-	else if (udpserver)
-		LogSock = udpopenlog(udpserver,udpport);
+	else if (server)
+		LogSock = inet_socket(server, port, socket_type);
 	else
-		LogSock = myopenlog(usock, optd);
+		LogSock = myopenlog(usock, socket_type);
 
 	/* log input line if appropriate */
 	if (argc > 0) {
@@ -297,14 +333,14 @@ main(int argc, char **argv) {
 		for (p = buf, endp = buf + sizeof(buf) - 2; *argv;) {
 			len = strlen(*argv);
 			if (p + len > endp && p > buf) {
-			    if (!usock && !udpserver)
+			    if (!usock && !server)
 				syslog(pri, "%s", buf);
 			    else
 				mysyslog(LogSock, logflags, pri, tag, buf);
 				p = buf;
 			}
 			if (len > sizeof(buf) - 1) {
-			    if (!usock && !udpserver)
+			    if (!usock && !server)
 				syslog(pri, "%s", *argv++);
 			    else
 				mysyslog(LogSock, logflags, pri, tag, *argv++);
@@ -316,7 +352,7 @@ main(int argc, char **argv) {
 			}
 		}
 		if (p != buf) {
-		    if (!usock && !udpserver)
+		    if (!usock && !server)
 			syslog(pri, "%s", buf);
 		    else
 			mysyslog(LogSock, logflags, pri, tag, buf);
@@ -330,13 +366,13 @@ main(int argc, char **argv) {
 		    if (len > 0 && buf[len - 1] == '\n')
 			    buf[len - 1] = '\0';
 
-		    if (!usock && !udpserver)
+		    if (!usock && !server)
 			syslog(pri, "%s", buf);
 		    else
 			mysyslog(LogSock, logflags, pri, tag, buf);
 		}
 	}
-	if (!usock && !udpserver)
+	if (!usock && !server)
 		closelog();
 	else
 		close(LogSock);
-- 
1.8.2

