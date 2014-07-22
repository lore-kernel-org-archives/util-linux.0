Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f182.google.com ([74.125.82.182]:60580 "EHLO
	mail-we0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756331AbaGVWBQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 22 Jul 2014 18:01:16 -0400
Received: by mail-we0-f182.google.com with SMTP id k48so283346wev.27
        for <util-linux@vger.kernel.org>; Tue, 22 Jul 2014 15:01:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/10] logger: do not rely only getlogin(3) telling who ran the command
Date: Tue, 22 Jul 2014 23:00:52 +0100
Message-Id: <1406066459-4816-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
References: <1406066459-4816-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The getlogin(3) is known not to always work, and when that happens it is
reasonable to try determine user of name by looking process owner and
passwd information.

Reference: http://man7.org/linux/man-pages/man3/getlogin.3.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/logger.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/misc-utils/logger.c b/misc-utils/logger.c
index 204511d..65e468c 100644
--- a/misc-utils/logger.c
+++ b/misc-utils/logger.c
@@ -50,6 +50,7 @@
 #include <arpa/inet.h>
 #include <netdb.h>
 #include <getopt.h>
+#include <pwd.h>
 
 #include "all-io.h"
 #include "c.h"
@@ -257,6 +258,16 @@ static int journald_entry(FILE *fp)
 }
 #endif
 
+static char *xgetlogin()
+{
+	char *cp;
+	struct passwd *pw;
+
+	if (!(cp = getlogin()) || !*cp)
+		cp = (pw = getpwuid(geteuid()))? pw->pw_name : "<someone>";
+	return cp;
+}
+
 static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
 {
 	char buf[1000], pid[30], *cp, *tp;
@@ -269,11 +280,8 @@ static void mysyslog(int fd, int logflags, int pri, char *tag, char *msg)
 			pid[0] = 0;
 		if (tag)
 			cp = tag;
-		else {
-			cp = getlogin();
-			if (!cp)
-				cp = "<someone>";
-		}
+		else
+			cp = xgetlogin();
 		time(&now);
 		tp = ctime(&now) + 4;
 
@@ -438,7 +446,7 @@ int main(int argc, char **argv)
 	else if (usock)
 		LogSock = unix_socket(usock, socket_type);
 	else
-		openlog(tag ? tag : getlogin(), logflags, 0);
+		openlog(tag ? tag : xgetlogin(), logflags, 0);
 
 	/* log input line if appropriate */
 	if (argc > 0) {
-- 
2.0.2

