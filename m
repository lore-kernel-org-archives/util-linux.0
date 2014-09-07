Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:44482 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbaIGMnR (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Sep 2014 08:43:17 -0400
Received: by mail-wi0-f173.google.com with SMTP id cc10so1369995wib.6
        for <util-linux@vger.kernel.org>; Sun, 07 Sep 2014 05:43:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/17] lib: avoid use of obsolete getpass() function
Date: Sun,  7 Sep 2014 13:42:51 +0100
Message-Id: <1410093785-17537-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
References: <1410093785-17537-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reference: http://man7.org/linux/man-pages/man3/getpass.3.html
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/xgetpass.h |  2 +-
 lib/xgetpass.c     | 56 +++++++++++++++++++++++++-----------------------------
 2 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/include/xgetpass.h b/include/xgetpass.h
index b5a3c87..622ba8c 100644
--- a/include/xgetpass.h
+++ b/include/xgetpass.h
@@ -1,6 +1,6 @@
 #ifndef UTIL_LINUX_XGETPASS_H
 #define UTIL_LINUX_XGETPASS_H
 
-extern char *xgetpass(int pfd, const char *prompt);
+extern char *xgetpass(FILE *input, const char *prompt);
 
 #endif /* UTIL_LINUX_XGETPASS_H */
diff --git a/lib/xgetpass.c b/lib/xgetpass.c
index ba20894..9c7d431 100644
--- a/lib/xgetpass.c
+++ b/lib/xgetpass.c
@@ -5,42 +5,38 @@
  * Public domain.
  */
 
+#include <err.h>
 #include <stdio.h>
-#include <string.h>
 #include <stdlib.h>
+#include <termios.h>
 #include <unistd.h>
-#include <sys/ioctl.h>
-#include <sys/stat.h>
 
-#include "c.h"
-#include "xgetpass.h"
-
-char *xgetpass(int pfd, const char *prompt)
+char *xgetpass(FILE *input, const char *prompt)
 {
 	char *pass = NULL;
-	int len = 0, i;
-
-        if (pfd < 0) /* terminal */
-		return getpass(prompt);
-
-	for (i=0; ; i++) {
-		if (i >= len-1) {
-			char *tmppass = pass;
-			len += 128;
-
-			pass = realloc(tmppass, len);
-			if (!pass) {
-				pass = tmppass; /* the old buffer hasn't changed */
-				break;
-			}
-		}
-		if (pass && (read(pfd, pass + i, 1) != 1 ||
-			     pass[i] == '\n' || pass[i] == 0))
-			break;
+	struct termios saved, no_echo;
+	const int fd = fileno(input);
+	size_t dummy = 0;
+	ssize_t len;
+
+	fputs(prompt, stdout);
+	if (isatty(fd)) {
+		/* disable echo */
+		tcgetattr(fd, &saved);
+		no_echo = saved;
+		no_echo.c_lflag &= ~ECHO;
+		no_echo.c_lflag |= ECHONL;
+		if (tcsetattr(fd, TCSANOW, &no_echo))
+			err(EXIT_FAILURE, "could not set terminal attributes");
 	}
-
-	if (pass)
-		pass[i] = '\0';
+	len = getline(&pass, &dummy, input);
+	if (len < 0)
+		warn("could not getline");
+	if (*(pass + len - 1) == '\n')
+		*(pass + len - 1) = '\0';
+	if (isatty(fd))
+		/* restore terminal */
+		if (tcsetattr(fd, TCSANOW, &saved))
+			err(EXIT_FAILURE, "could not set terminal attributes");
 	return pass;
 }
-
-- 
2.1.0

