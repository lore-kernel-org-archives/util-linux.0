Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35417 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932249AbcGCVYP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 3 Jul 2016 17:24:15 -0400
Received: by mail-wm0-f66.google.com with SMTP id a66so17541468wme.2
        for <util-linux@vger.kernel.org>; Sun, 03 Jul 2016 14:24:14 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/15] write: improve function and variable names
Date: Sun,  3 Jul 2016 22:23:51 +0100
Message-Id: <20160703212358.1218-9-kerolasa@iki.fi>
In-Reply-To: <20160703212358.1218-1-kerolasa@iki.fi>
References: <20160703212358.1218-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 73 ++++++++++++++++++++++++++----------------------------
 1 file changed, 35 insertions(+), 38 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 2557f33..6bf15dd 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -95,10 +95,10 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 }
 
 /*
- * term_chk - check that a terminal exists, and get the message bit
+ * check_tty - check that a terminal exists, and get the message bit
  *     and the access time
  */
-static int term_chk(char *tty, int *msgsokP, time_t * atimeP, int showerror)
+static int check_tty(char *tty, int *tty_writeable, time_t *tty_atime, int showerror)
 {
 	struct stat s;
 	char path[PATH_MAX];
@@ -112,19 +112,19 @@ static int term_chk(char *tty, int *msgsokP, time_t * atimeP, int showerror)
 		return 1;
 	}
 	if (getuid() == 0)	/* root can always write */
-		*msgsokP = 1;
+		*tty_writeable = 1;
 	else
-		*msgsokP = (s.st_mode & S_IWGRP) && (getegid() == s.st_gid);
-	if (atimeP)
-		*atimeP = s.st_atime;
+		*tty_writeable = (s.st_mode & S_IWGRP) && (getegid() == s.st_gid);
+	if (tty_atime)
+		*tty_atime = s.st_atime;
 	return 0;
 }
 
 /*
- * utmp_chk - checks that the given user is actually logged in on
+ * check_utmp - checks that the given user is actually logged in on
  *     the given tty
  */
-static int utmp_chk(const struct write_control *ctl)
+static int check_utmp(const struct write_control *ctl)
 {
 	struct utmp u;
 	struct utmp *uptr;
@@ -161,25 +161,22 @@ static void search_utmp(struct write_control *ctl)
 {
 	struct utmp u;
 	struct utmp *uptr;
-	time_t bestatime, atime;
-	int nloggedttys, nttys, msgsok = 0, user_is_me;
+	time_t best_atime = 0, tty_atime;
+	int num_ttys = 0, valid_ttys = 0, tty_writeable = 0, user_is_me = 0;
 	char atty[sizeof(u.ut_line) + 1];
 
 	utmpname(_PATH_UTMP);
 	setutent();
 
-	nloggedttys = nttys = 0;
-	bestatime = 0;
-	user_is_me = 0;
 	while ((uptr = getutent())) {
 		memcpy(&u, uptr, sizeof(u));
 		if (strncmp(ctl->dst_login, u.ut_user, sizeof(u.ut_user)) == 0) {
-			++nloggedttys;
+			num_ttys++;
 			xstrncpy(atty, u.ut_line, sizeof(atty));
-			if (term_chk(atty, &msgsok, &atime, 0))
+			if (check_tty(atty, &tty_writeable, &tty_atime, 0))
 				/* bad term? skip */
 				continue;
-			if (ctl->src_uid && !msgsok)
+			if (ctl->src_uid && !tty_writeable)
 				/* skip ttys with msgs off */
 				continue;
 			if (strcmp(atty, ctl->src_tty) == 0) {
@@ -190,25 +187,25 @@ static void search_utmp(struct write_control *ctl)
 			if (u.ut_type != USER_PROCESS)
 				/* it's not a valid entry */
 				continue;
-			++nttys;
-			if (atime > bestatime) {
-				bestatime = atime;
+			valid_ttys++;
+			if (tty_atime > best_atime) {
+				best_atime = tty_atime;
 				xstrncpy(ctl->dst_tty, atty, sizeof(ctl->dst_tty));
 			}
 		}
 	}
 
 	endutent();
-	if (nloggedttys == 0)
+	if (num_ttys == 0)
 		errx(EXIT_FAILURE, _("%s is not logged in"), ctl->dst_login);
-	if (nttys == 0) {
+	if (valid_ttys == 0) {
 		if (user_is_me) {
 			/* ok, so write to yourself! */
 			xstrncpy(ctl->dst_tty, ctl->src_tty, sizeof(ctl->dst_tty));
 			return;
 		}
 		errx(EXIT_FAILURE, _("%s has messages disabled"), ctl->dst_login);
-	} else if (nttys > 1) {
+	} else if (valid_ttys > 1) {
 		warnx(_("%s is logged in more than once; writing to %s"),
 		      ctl->dst_login, ctl->dst_tty);
 	}
@@ -224,10 +221,10 @@ static void signal_handler(int signo)
 }
 
 /*
- * wr_fputs - like fputs(), but makes control characters visible and
+ * write_line - like fputs(), but makes control characters visible and
  *     turns \n into \r\n.
  */
-static void wr_fputs(char *s)
+static void write_line(char *s)
 {
 	char c;
 
@@ -248,7 +245,7 @@ static void wr_fputs(char *s)
  */
 static void do_write(const struct write_control *ctl)
 {
-	char *login, *pwuid, *nows;
+	char *login, *pwuid, *time_stamp;
 	struct passwd *pwd;
 	time_t now;
 	char path[PATH_MAX], *host, line[512];
@@ -280,29 +277,29 @@ static void do_write(const struct write_control *ctl)
 		host = xstrdup("???");
 
 	now = time((time_t *) NULL);
-	nows = ctime(&now);
-	nows[16] = '\0';
+	time_stamp = ctime(&now);
+	time_stamp[16] = '\0';
 	printf("\r\n\007\007\007");
 	if (strcmp(login, pwuid))
 		printf(_("Message from %s@%s (as %s) on %s at %s ..."),
-		       login, host, pwuid, ctl->src_tty, nows + 11);
+		       login, host, pwuid, ctl->src_tty, time_stamp + 11);
 	else
 		printf(_("Message from %s@%s on %s at %s ..."),
-		       login, host, ctl->src_tty, nows + 11);
+		       login, host, ctl->src_tty, time_stamp + 11);
 	free(host);
 	printf("\r\n");
 
 	while (fgets(line, sizeof(line), stdin) != NULL) {
 		if (signal_received)
 			break;
-		wr_fputs(line);
+		write_line(line);
 	}
 	printf("EOF\r\n");
 }
 
 int main(int argc, char **argv)
 {
-	int msgsok = 0, src_fd, c;
+	int tty_writeable = 0, src_fd, c;
 	struct write_control ctl = { 0 };
 
 	static const struct option longopts[] = {
@@ -344,17 +341,17 @@ int main(int argc, char **argv)
 
 		/*
 		 * We may have /dev/ttyN but also /dev/pts/xx. Below,
-		 * term_chk() will put "/dev/" in front, so remove that
+		 * check_tty() will put "/dev/" in front, so remove that
 		 * part.
 		 */
 		if (!strncmp(ctl.src_tty, "/dev/", 5))
 			ctl.src_tty += 5;
-		if (term_chk(ctl.src_tty, &msgsok, NULL, 1))
+		if (check_tty(ctl.src_tty, &tty_writeable, NULL, 1))
 			exit(EXIT_FAILURE);
-		if (!msgsok)
+		if (!tty_writeable)
 			errx(EXIT_FAILURE,
 			     _("you have write permission turned off"));
-		msgsok = 0;
+		tty_writeable = 0;
 	} else
 		ctl.src_tty = "<no tty>";
 
@@ -373,13 +370,13 @@ int main(int argc, char **argv)
 			xstrncpy(ctl.dst_tty, argv[2] + 5, sizeof(ctl.dst_tty));
 		else
 			xstrncpy(ctl.dst_tty, argv[2], sizeof(ctl.dst_tty));
-		if (utmp_chk(&ctl))
+		if (check_utmp(&ctl))
 			errx(EXIT_FAILURE,
 			     _("%s is not logged in on %s"),
 			     ctl.dst_login, ctl.dst_tty);
-		if (term_chk(ctl.dst_tty, &msgsok, NULL, 1))
+		if (check_tty(ctl.dst_tty, &tty_writeable, NULL, 1))
 			exit(EXIT_FAILURE);
-		if (ctl.src_uid && !msgsok)
+		if (ctl.src_uid && !tty_writeable)
 			errx(EXIT_FAILURE,
 			     _("%s has messages disabled on %s"),
 			     ctl.dst_login, ctl.dst_tty);
-- 
2.9.0

