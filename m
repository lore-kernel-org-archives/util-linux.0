Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:34091 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbcGCVYX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:23 -0400
Received: by mail-wm0-f67.google.com with SMTP id 187so17570038wmz.1
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 14/15] write: stop removing and adding /dev/ in front of tty string
Date: Sun,  3 Jul 2016 22:23:57 +0100
Message-Id: <20160703212358.1218-15-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add both path and tty name representations of tty's to control structure,
that point to same string beginning from different depths.  This way there
is no need to removing and adding /dev/ in front of tty string all the time.

Secondly this change makes it possible to use of get_terminal_name() from
ttyutils.c.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/Makemodule.am |  1 +
 term-utils/write.c       | 81 +++++++++++++++++++++++-------------------------
 2 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/term-utils/Makemodule.am b/term-utils/Makemodule.am
index 8ddb068..1b7c5fc 100644
--- a/term-utils/Makemodule.am
+++ b/term-utils/Makemodule.am
@@ -93,6 +93,7 @@ dist_man_MANS += term-utils/write.1
 write_SOURCES = term-utils/write.c
 write_CFLAGS = $(SUID_CFLAGS) $(AM_CFLAGS)
 write_LDFLAGS = $(SUID_LDFLAGS) $(AM_LDFLAGS)
+write_LDADD = $(LDADD) libcommon.la
 
 if USE_TTY_GROUP
 if MAKEINSTALL_DO_CHOWN
diff --git a/term-utils/write.c b/term-utils/write.c
index 7aae796..a014d95 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -64,6 +64,7 @@
 #include "closestream.h"
 #include "nls.h"
 #include "strutils.h"
+#include "ttyutils.h"
 #include "xalloc.h"
 
 static sig_atomic_t signal_received = 0;
@@ -71,9 +72,11 @@ static sig_atomic_t signal_received = 0;
 struct write_control {
 	uid_t src_uid;
 	const char *src_login;
-	char *src_tty;
+	const char *src_tty_path;
+	const char *src_tty_name;
 	const char *dst_login;
-	char dst_tty[PATH_MAX];
+	char *dst_tty_path;
+	const char *dst_tty_name;
 };
 
 static void __attribute__((__noreturn__)) usage(FILE *out)
@@ -98,24 +101,20 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
  * check_tty - check that a terminal exists, and get the message bit
  *     and the access time
  */
-static int check_tty(char *tty, int *tty_writeable, time_t *tty_atime, int showerror)
+static int check_tty(const char *tty, int *tty_writeable, time_t *tty_atime, int showerror)
 {
 	struct stat s;
-	char path[PATH_MAX];
 
-	if (sizeof(path) < strlen(tty) + 6)
-		return 1;
-	sprintf(path, "/dev/%s", tty);
-	if (stat(path, &s) < 0) {
+	if (stat(tty, &s) < 0) {
 		if (showerror)
-			warn("%s", path);
+			warn("%s", tty);
 		return 1;
 	}
 	if (getuid() == 0)	/* root can always write */
 		*tty_writeable = 1;
 	else {
 		if (getegid() != s.st_gid) {
-			warnx(_("effective gid does not match group of %s"), path);
+			warnx(_("effective gid does not match group of %s"), tty);
 			return 1;
 		}
 		*tty_writeable = s.st_mode & S_IWGRP;
@@ -139,7 +138,7 @@ static int check_utmp(const struct write_control *ctl)
 
 	while ((u = getutent())) {
 		if (strncmp(ctl->dst_login, u->ut_user, sizeof(u->ut_user)) == 0 &&
-		    strncmp(ctl->dst_tty, u->ut_line, sizeof(u->ut_line)) == 0) {
+		    strncmp(ctl->dst_tty_name, u->ut_line, sizeof(u->ut_line)) == 0) {
 			res = 0;
 			break;
 		}
@@ -165,6 +164,7 @@ static void search_utmp(struct write_control *ctl)
 	struct utmp *u;
 	time_t best_atime = 0, tty_atime;
 	int num_ttys = 0, valid_ttys = 0, tty_writeable = 0, user_is_me = 0;
+	char path[UT_LINESIZE + 6];
 
 	utmpname(_PATH_UTMP);
 	setutent();
@@ -173,13 +173,14 @@ static void search_utmp(struct write_control *ctl)
 		if (strncmp(ctl->dst_login, u->ut_user, sizeof(u->ut_user)) != 0)
 			continue;
 		num_ttys++;
-		if (check_tty(u->ut_line, &tty_writeable, &tty_atime, 0))
+		sprintf(path, "/dev/%s", u->ut_line);
+		if (check_tty(path, &tty_writeable, &tty_atime, 0))
 			/* bad term? skip */
 			continue;
 		if (ctl->src_uid && !tty_writeable)
 			/* skip ttys with msgs off */
 			continue;
-		if (strcmp(u->ut_line, ctl->src_tty) == 0) {
+		if (strcmp(u->ut_line, ctl->src_tty_name) == 0) {
 			user_is_me = 1;
 			/* don't write to yourself */
 			continue;
@@ -190,8 +191,9 @@ static void search_utmp(struct write_control *ctl)
 		valid_ttys++;
 		if (best_atime < tty_atime) {
 			best_atime = tty_atime;
-			xstrncpy(ctl->dst_tty, u->ut_line,
-				 sizeof(ctl->dst_tty));
+			free(ctl->dst_tty_path);
+			ctl->dst_tty_path = xstrdup(path);
+			ctl->dst_tty_name = ctl->dst_tty_path + 5;
 		}
 	}
 
@@ -201,14 +203,17 @@ static void search_utmp(struct write_control *ctl)
 	if (valid_ttys == 0) {
 		if (user_is_me) {
 			/* ok, so write to yourself! */
-			xstrncpy(ctl->dst_tty, ctl->src_tty, sizeof(ctl->dst_tty));
+			if (!ctl->src_tty_path)
+				errx(EXIT_FAILURE, _("can't find your tty's name"));
+			ctl->dst_tty_path = xstrdup(ctl->src_tty_path);
+			ctl->dst_tty_name = ctl->dst_tty_path + 5;
 			return;
 		}
 		errx(EXIT_FAILURE, _("%s has messages disabled"), ctl->dst_login);
 	}
 	if (1 < valid_ttys)
 		warnx(_("%s is logged in more than once; writing to %s"),
-		      ctl->dst_login, ctl->dst_tty);
+		      ctl->dst_login, ctl->dst_tty_name);
 }
 
 /*
@@ -245,7 +250,7 @@ static void do_write(const struct write_control *ctl)
 	struct passwd *pwd;
 	time_t now;
 	struct tm *tm;
-	char path[PATH_MAX], *host, line[512];
+	char *host, line[512];
 	struct sigaction sigact;
 
 	/* Determine our login name(s) before the we reopen() stdout */
@@ -256,11 +261,8 @@ static void do_write(const struct write_control *ctl)
 	if ((login = getlogin()) == NULL)
 		login = pwuid;
 
-	if (sizeof(path) < strlen(ctl->dst_tty) + 6)
-		errx(EXIT_FAILURE, _("tty path %s too long"), ctl->dst_tty);
-	snprintf(path, sizeof(path), "/dev/%s", ctl->dst_tty);
-	if ((freopen(path, "w", stdout)) == NULL)
-		err(EXIT_FAILURE, "%s", path);
+	if ((freopen(ctl->dst_tty_path, "w", stdout)) == NULL)
+		err(EXIT_FAILURE, "%s", ctl->dst_tty_path);
 
 	sigact.sa_handler = signal_handler;
 	sigemptyset(&sigact.sa_mask);
@@ -279,10 +281,10 @@ static void do_write(const struct write_control *ctl)
 	printf("\r\n\a\a\a");
 	if (strcmp(login, pwuid))
 		printf(_("Message from %s@%s (as %s) on %s at %s ..."),
-		       login, host, pwuid, ctl->src_tty, timestamp);
+		       login, host, pwuid, ctl->src_tty_name, timestamp);
 	else
 		printf(_("Message from %s@%s on %s at %s ..."),
-		       login, host, ctl->src_tty, timestamp);
+		       login, host, ctl->src_tty_name, timestamp);
 	free(host);
 	printf("\r\n");
 
@@ -331,25 +333,16 @@ int main(int argc, char **argv)
 	else
 		src_fd = -1;
 
-	if (src_fd != -1) {
-		if (!(ctl.src_tty = ttyname(src_fd)))
-			errx(EXIT_FAILURE,
-			     _("can't find your tty's name"));
-		/*
-		 * We may have /dev/ttyN but also /dev/pts/xx. Below,
-		 * check_tty() will put "/dev/" in front, so remove that
-		 * part.
-		 */
-		if (!strncmp(ctl.src_tty, "/dev/", 5))
-			ctl.src_tty += 5;
-		if (check_tty(ctl.src_tty, &tty_writeable, NULL, 1))
+	if (src_fd != -1 &&
+	    get_terminal_name(src_fd, &ctl.src_tty_path, &ctl.src_tty_name, NULL) == 0) {
+		if (check_tty(ctl.src_tty_path, &tty_writeable, NULL, 1))
 			exit(EXIT_FAILURE);
 		if (!tty_writeable)
 			errx(EXIT_FAILURE,
 			     _("you have write permission turned off"));
 		tty_writeable = 0;
 	} else
-		ctl.src_tty = "<no tty>";
+		ctl.src_tty_name = "<no tty>";
 
 	ctl.src_uid = getuid();
 
@@ -363,23 +356,25 @@ int main(int argc, char **argv)
 	case 3:
 		ctl.dst_login = argv[1];
 		if (!strncmp(argv[2], "/dev/", 5))
-			xstrncpy(ctl.dst_tty, argv[2] + 5, sizeof(ctl.dst_tty));
+			ctl.dst_tty_path = xstrdup(argv[2]);
 		else
-			xstrncpy(ctl.dst_tty, argv[2], sizeof(ctl.dst_tty));
+			xasprintf(&ctl.dst_tty_path, "/dev/%s", argv[2]);
+		ctl.dst_tty_name = ctl.dst_tty_path + 5;
 		if (check_utmp(&ctl))
 			errx(EXIT_FAILURE,
 			     _("%s is not logged in on %s"),
-			     ctl.dst_login, ctl.dst_tty);
-		if (check_tty(ctl.dst_tty, &tty_writeable, NULL, 1))
+			     ctl.dst_login, ctl.dst_tty_name);
+		if (check_tty(ctl.dst_tty_path, &tty_writeable, NULL, 1))
 			exit(EXIT_FAILURE);
 		if (ctl.src_uid && !tty_writeable)
 			errx(EXIT_FAILURE,
 			     _("%s has messages disabled on %s"),
-			     ctl.dst_login, ctl.dst_tty);
+			     ctl.dst_login, ctl.dst_tty_name);
 		do_write(&ctl);
 		break;
 	default:
 		usage(stderr);
 	}
+	free(ctl.dst_tty_path);
 	return EXIT_SUCCESS;
 }
-- 
2.9.0

