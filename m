Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:39673 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754355Ab2JNUVj (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Oct 2012 16:21:39 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2680278wey.19
        for <util-linux@vger.kernel.org>; Sun, 14 Oct 2012 13:21:38 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 16/19] logger: replace gethostbyname() with getaddrinfo()
Date: Sun, 14 Oct 2012 21:21:07 +0100
Message-Id: <1350246070-10544-17-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
References: <1350246070-10544-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The gethostbyname() is legacy function which may be withdrawn in a
future.

Reference: http://pubs.opengroup.org/onlinepubs/009695399/functions/gethostbyname.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 6f9edc2..ecdbfe3 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -59,7 +59,6 @@
 #include <syslog.h>
 
 static int optd = 0;
-static uint16_t udpport = 514;
 
 static int decode(char *name, CODE *codetab)
 {
@@ -119,24 +118,25 @@ myopenlog(const char *sock) {
 }
 
 static int
-udpopenlog(const char *servername, uint16_t port) {
-	int fd;
-	struct sockaddr_in s_addr;
-	struct hostent *serverhost;
-
-	if ((serverhost = gethostbyname(servername)) == NULL )
-		errx(EXIT_FAILURE, _("unable to resolve '%s'"), servername);
-
-	if ((fd = socket(AF_INET, SOCK_DGRAM , 0)) == -1)
+udpopenlog(const char *servername, const char *port) {
+	int fd, errcode;
+	struct addrinfo hints, *res;
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_socktype = SOCK_DGRAM;
+	hints.ai_family = AF_UNSPEC;
+
+	errcode = getaddrinfo(servername, port, &hints, &res);
+	if (errcode != 0)
+		errx(EXIT_FAILURE, _("getaddrinfo %s:%s: %s"), servername, port,
+		     gai_strerror(errcode));
+	if ((fd = socket(res->ai_family, res->ai_socktype, res->ai_protocol)) == -1)
 		err(EXIT_FAILURE, _("socket"));
 
-	memcpy(&s_addr.sin_addr, serverhost->h_addr, serverhost->h_length);
-        s_addr.sin_family=AF_INET;
-        s_addr.sin_port=htons(port);
-
-        if (connect(fd, (struct sockaddr *) &s_addr, sizeof(s_addr)) == -1)
+	if (connect(fd, res->ai_addr, res->ai_addrlen) == -1)
 		err(EXIT_FAILURE, _("connect"));
 
+	freeaddrinfo(res);
 	return fd;
 }
 static void
@@ -201,6 +201,7 @@ main(int argc, char **argv) {
 	char *tag, buf[1024];
 	char *usock = NULL;
 	char *udpserver = NULL;
+	char *udpport = NULL;
 	int LogSock = -1;
 
 	static const struct option longopts[] = {
@@ -257,8 +258,7 @@ main(int argc, char **argv) {
 			udpserver = optarg;
 			break;
 		case 'P':		/* change udp port */
-			udpport = strtou16_or_err(optarg,
-						_("invalid port number argument"));
+			udpport = optarg;
 			break;
 		case 'V':
 			printf(_("%s from %s\n"), program_invocation_short_name,
-- 
1.7.12.2

