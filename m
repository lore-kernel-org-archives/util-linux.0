Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35965 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbcGCVYU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:20 -0400
Received: by mail-wm0-f67.google.com with SMTP id c82so17535600wme.3
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 12/15] write: improve coding style
Date: Sun,  3 Jul 2016 22:23:55 +0100
Message-Id: <20160703212358.1218-13-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 71 +++++++++++++++++++++++++++---------------------------
 1 file changed, 35 insertions(+), 36 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 517bd88..4300489 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -45,19 +45,19 @@
  *
  */
 
-#include <stdio.h>
-#include <unistd.h>
-#include <utmp.h>
 #include <errno.h>
-#include <time.h>
+#include <getopt.h>
+#include <paths.h>
 #include <pwd.h>
-#include <string.h>
-#include <stdlib.h>
 #include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
 #include <sys/param.h>
 #include <sys/stat.h>
-#include <paths.h>
-#include <getopt.h>
+#include <time.h>
+#include <unistd.h>
+#include <utmp.h>
 
 #include "c.h"
 #include "carefulputc.h"
@@ -76,7 +76,7 @@ struct write_control {
 	char dst_tty[PATH_MAX];
 };
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out)
+static void __attribute__((__noreturn__)) usage(FILE *out)
 {
 	fputs(USAGE_HEADER, out);
 	fprintf(out,
@@ -103,7 +103,7 @@ static int check_tty(char *tty, int *tty_writeable, time_t *tty_atime, int showe
 	struct stat s;
 	char path[PATH_MAX];
 
-	if (strlen(tty) + 6 > sizeof(path))
+	if (sizeof(path) < strlen(tty) + 6)
 		return 1;
 	sprintf(path, "/dev/%s", tty);
 	if (stat(path, &s) < 0) {
@@ -165,27 +165,28 @@ static void search_utmp(struct write_control *ctl)
 	setutent();
 
 	while ((u = getutent())) {
-		if (strncmp(ctl->dst_login, u->ut_user, sizeof(u->ut_user)) == 0) {
-			num_ttys++;
-			if (check_tty(u->ut_line, &tty_writeable, &tty_atime, 0))
-				/* bad term? skip */
-				continue;
-			if (ctl->src_uid && !tty_writeable)
-				/* skip ttys with msgs off */
-				continue;
-			if (strcmp(u->ut_line, ctl->src_tty) == 0) {
-				user_is_me = 1;
-				/* don't write to yourself */
-				continue;
-			}
-			if (u->ut_type != USER_PROCESS)
-				/* it's not a valid entry */
-				continue;
-			valid_ttys++;
-			if (tty_atime > best_atime) {
-				best_atime = tty_atime;
-				xstrncpy(ctl->dst_tty, u->ut_line, sizeof(ctl->dst_tty));
-			}
+		if (strncmp(ctl->dst_login, u->ut_user, sizeof(u->ut_user)) != 0)
+			continue;
+		num_ttys++;
+		if (check_tty(u->ut_line, &tty_writeable, &tty_atime, 0))
+			/* bad term? skip */
+			continue;
+		if (ctl->src_uid && !tty_writeable)
+			/* skip ttys with msgs off */
+			continue;
+		if (strcmp(u->ut_line, ctl->src_tty) == 0) {
+			user_is_me = 1;
+			/* don't write to yourself */
+			continue;
+		}
+		if (u->ut_type != USER_PROCESS)
+			/* it's not a valid entry */
+			continue;
+		valid_ttys++;
+		if (best_atime < tty_atime) {
+			best_atime = tty_atime;
+			xstrncpy(ctl->dst_tty, u->ut_line,
+				 sizeof(ctl->dst_tty));
 		}
 	}
 
@@ -199,11 +200,10 @@ static void search_utmp(struct write_control *ctl)
 			return;
 		}
 		errx(EXIT_FAILURE, _("%s has messages disabled"), ctl->dst_login);
-	} else if (valid_ttys > 1) {
+	}
+	if (1 < valid_ttys)
 		warnx(_("%s is logged in more than once; writing to %s"),
 		      ctl->dst_login, ctl->dst_tty);
-	}
-
 }
 
 /*
@@ -251,7 +251,7 @@ static void do_write(const struct write_control *ctl)
 	if ((login = getlogin()) == NULL)
 		login = pwuid;
 
-	if (strlen(ctl->dst_tty) + 6 > sizeof(path))
+	if (sizeof(path) < strlen(ctl->dst_tty) + 6)
 		errx(EXIT_FAILURE, _("tty path %s too long"), ctl->dst_tty);
 	snprintf(path, sizeof(path), "/dev/%s", ctl->dst_tty);
 	if ((freopen(path, "w", stdout)) == NULL)
@@ -330,7 +330,6 @@ int main(int argc, char **argv)
 		if (!(ctl.src_tty = ttyname(src_fd)))
 			errx(EXIT_FAILURE,
 			     _("can't find your tty's name"));
-
 		/*
 		 * We may have /dev/ttyN but also /dev/pts/xx. Below,
 		 * check_tty() will put "/dev/" in front, so remove that
-- 
2.9.0

