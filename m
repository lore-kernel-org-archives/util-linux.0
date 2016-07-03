Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33466 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbcGCVYZ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:25 -0400
Received: by mail-wm0-f66.google.com with SMTP id r201so17540800wme.0
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:24 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 15/15] lib: try to find tty in get_terminal_name()
Date: Sun,  3 Jul 2016 22:23:58 +0100
Message-Id: <20160703212358.1218-16-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Try all standard terminal input/output file descriptors when finding tty
name in get_germinal_name().  This should make all invocations of the
function as robust as they can get.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/ttyutils.h      |  2 +-
 lib/ttyutils.c          | 15 +++++++++++++--
 login-utils/login.c     |  2 +-
 login-utils/su-common.c |  4 ++--
 term-utils/write.c      | 16 +++-------------
 5 files changed, 20 insertions(+), 19 deletions(-)

diff --git a/include/ttyutils.h b/include/ttyutils.h
index 200e9a5..7278d36 100644
--- a/include/ttyutils.h
+++ b/include/ttyutils.h
@@ -51,7 +51,7 @@ struct chardata {
 	} while (0)
 
 extern int get_terminal_width(int default_width);
-extern int get_terminal_name(int fd, const char **path, const char **name,
+extern int get_terminal_name(const char **path, const char **name,
 			     const char **number);
 
 #define UL_TTY_KEEPCFLAGS	(1 << 1)
diff --git a/lib/ttyutils.c b/lib/ttyutils.c
index 4e62c20..06dd800 100644
--- a/lib/ttyutils.c
+++ b/lib/ttyutils.c
@@ -5,6 +5,7 @@
  * Written by Karel Zak <kzak@redhat.com>
  */
 #include <ctype.h>
+#include <unistd.h>
 
 #include "c.h"
 #include "ttyutils.h"
@@ -42,13 +43,14 @@ int get_terminal_width(int default_width)
 	return width > 0 ? width : default_width;
 }
 
-int get_terminal_name(int fd,
-		      const char **path,
+int get_terminal_name(const char **path,
 		      const char **name,
 		      const char **number)
 {
 	const char *tty;
 	const char *p;
+	int fd;
+
 
 	if (name)
 		*name = NULL;
@@ -57,6 +59,15 @@ int get_terminal_name(int fd,
 	if (number)
 		*number = NULL;
 
+	if (isatty(STDIN_FILENO))
+		fd = STDIN_FILENO;
+	else if (isatty(STDOUT_FILENO))
+		fd = STDOUT_FILENO;
+	else if (isatty(STDERR_FILENO))
+		fd = STDERR_FILENO;
+	else
+		return -1;
+
 	tty = ttyname(fd);
 	if (!tty)
 		return -1;
diff --git a/login-utils/login.c b/login-utils/login.c
index 4d71f54..7501f6d 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -356,7 +356,7 @@ static void init_tty(struct login_context *cxt)
 
 	cxt->tty_mode = (mode_t) getlogindefs_num("TTYPERM", TTY_MODE);
 
-	get_terminal_name(0, &cxt->tty_path, &cxt->tty_name, &cxt->tty_number);
+	get_terminal_name(&cxt->tty_path, &cxt->tty_name, &cxt->tty_number);
 
 	/*
 	 * In case login is suid it was possible to use a hardlink as stdin
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index 78a734c..1776b6b 100644
--- a/login-utils/su-common.c
+++ b/login-utils/su-common.c
@@ -165,7 +165,7 @@ log_syslog(struct passwd const *pw, bool successful)
       old_user = pwd ? pwd->pw_name : "";
     }
 
-  if (get_terminal_name(STDERR_FILENO, NULL, &tty, NULL) != 0 || !tty)
+  if (get_terminal_name(NULL, &tty, NULL) != 0 || !tty)
     tty = "none";
 
   openlog (program_invocation_short_name, 0 , LOG_AUTH);
@@ -192,7 +192,7 @@ static void log_btmp(struct passwd const *pw)
 		pw && pw->pw_name ? pw->pw_name : "(unknown)",
 		sizeof(ut.ut_user));
 
-	get_terminal_name(STDERR_FILENO, NULL, &tty_name, &tty_num);
+	get_terminal_name(NULL, &tty_name, &tty_num);
 	if (tty_num)
 		xstrncpy(ut.ut_id, tty_num, sizeof(ut.ut_id));
 	if (tty_name)
diff --git a/term-utils/write.c b/term-utils/write.c
index a014d95..c6d440d 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -298,7 +298,7 @@ static void do_write(const struct write_control *ctl)
 
 int main(int argc, char **argv)
 {
-	int tty_writeable = 0, src_fd, c;
+	int tty_writeable = 0, c;
 	struct write_control ctl = { 0 };
 
 	static const struct option longopts[] = {
@@ -323,18 +323,8 @@ int main(int argc, char **argv)
 			usage(stderr);
 		}
 
-	/* check that sender has write enabled */
-	if (isatty(STDIN_FILENO))
-		src_fd = STDIN_FILENO;
-	else if (isatty(STDOUT_FILENO))
-		src_fd = STDOUT_FILENO;
-	else if (isatty(STDERR_FILENO))
-		src_fd = STDERR_FILENO;
-	else
-		src_fd = -1;
-
-	if (src_fd != -1 &&
-	    get_terminal_name(src_fd, &ctl.src_tty_path, &ctl.src_tty_name, NULL) == 0) {
+	if (get_terminal_name(&ctl.src_tty_path, &ctl.src_tty_name, NULL) == 0) {
+		/* check that sender has write enabled */
 		if (check_tty(ctl.src_tty_path, &tty_writeable, NULL, 1))
 			exit(EXIT_FAILURE);
 		if (!tty_writeable)
-- 
2.9.0

