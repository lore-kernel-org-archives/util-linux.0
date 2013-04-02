Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:49330 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762152Ab3DBTng (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:36 -0400
Received: by mail-wg0-f47.google.com with SMTP id y10so835631wgg.26
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi, Karel Zak <kzak@redhat.com>
Subject: [PATCH 13/13] logger: make local sockets to try both stream and datagram
Date: Tue,  2 Apr 2013 20:42:57 +0100
Message-Id: <1364931777-2645-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When journald, from systemd, is in use logger gave following error.

$ logger --socket /dev/log test logger: connect /dev/log: Protocol wrong
type for socket

The journald supports only AF_DGRAM, and nothing else.  Support for
AF_STREAM sockets was dropped because it messed up message ordering.

>From an users point of view necessity to add --udp (UNIX(TM) Datagram
Protocol?) option when talking to syslog via unix socket felt confusing
and wrong.  The command should know what is the socket type, and silently
use the correct one, unless the type is explicitely defined.

CC: Karel Zak <kzak@redhat.com>
Adviced-by: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 30e8fa4..a6fafc1 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -58,8 +58,6 @@
 #define	SYSLOG_NAMES
 #include <syslog.h>
 
-static int optd = 0;
-
 static int decode(char *name, CODE *codetab)
 {
 	register CODE *c;
@@ -98,23 +96,33 @@ static int pencode(char *s)
 }
 
 static int
-myopenlog(const char *sock) {
-       int fd;
-       static struct sockaddr_un s_addr; /* AF_UNIX address of local logger */
-
-       if (strlen(sock) >= sizeof(s_addr.sun_path))
-	       errx(EXIT_FAILURE, _("openlog %s: pathname too long"), sock);
+myopenlog(const char *sock, int optd)
+{
+	int fd;
+	static struct sockaddr_un s_addr;	/* AF_UNIX address of local logger */
 
-       s_addr.sun_family = AF_UNIX;
-       (void)strcpy(s_addr.sun_path, sock);
+	if (strlen(sock) >= sizeof(s_addr.sun_path))
+		errx(EXIT_FAILURE, _("openlog %s: pathname too long"), sock);
 
-       if ((fd = socket(AF_UNIX, optd ? SOCK_DGRAM : SOCK_STREAM, 0)) == -1)
-	       err(EXIT_FAILURE, _("socket %s"), sock);
+	s_addr.sun_family = AF_UNIX;
+	(void)strcpy(s_addr.sun_path, sock);
 
-       if (connect(fd, (struct sockaddr *) &s_addr, sizeof(s_addr)) == -1)
-	       err(EXIT_FAILURE, _("connect %s"), sock);
+	if (optd == 0) {
+		if ((fd = socket(AF_UNIX, SOCK_STREAM, 0)) == -1)
+			goto udp_socket;
+		if (connect(fd, (struct sockaddr *)&s_addr, sizeof(s_addr)) == -1) {
+			close(fd);
+			goto udp_socket;
+		}
+	} else {
+ udp_socket:
+		if ((fd = socket(AF_UNIX, SOCK_DGRAM, 0)) == -1)
+			err(EXIT_FAILURE, _("socket %s"), sock);
+		if (connect(fd, (struct sockaddr *)&s_addr, sizeof(s_addr)) == -1)
+			err(EXIT_FAILURE, _("connect %s"), sock);
+	}
 
-       return fd;
+	return fd;
 }
 
 static int
@@ -202,7 +210,7 @@ main(int argc, char **argv) {
 	char *usock = NULL;
 	char *udpserver = NULL;
 	char *udpport = NULL;
-	int LogSock = -1;
+	int LogSock = -1, optd = 0;
 
 	static const struct option longopts[] = {
 		{ "id",		no_argument,	    0, 'i' },
@@ -279,7 +287,7 @@ main(int argc, char **argv) {
 	else if (udpserver)
 		LogSock = udpopenlog(udpserver,udpport);
 	else
-		LogSock = myopenlog(usock);
+		LogSock = myopenlog(usock, optd);
 
 	/* log input line if appropriate */
 	if (argc > 0) {
-- 
1.8.2

