Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33319 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752595AbcEIV1s (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:48 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so22517963wme.0
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:47 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/12] write: add control structure to clarify what is going on
Date: Mon,  9 May 2016 22:27:23 +0100
Message-Id: <1462829248-6935-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is done purely to improve readability of the source code.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 97 ++++++++++++++++++++++++++++++------------------------
 1 file changed, 54 insertions(+), 43 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 021e943..cdcc0af 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -68,6 +68,14 @@
 
 static sig_atomic_t signal_received = 0;
 
+struct write_control {
+	uid_t src_uid;
+	char *src_login;
+	char *src_tty;
+	char *dst_login;
+	char dst_tty[PATH_MAX];
+};
+
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
@@ -116,7 +124,7 @@ static int term_chk(char *tty, int *msgsokP, time_t * atimeP, int showerror)
  * utmp_chk - checks that the given user is actually logged in on
  *     the given tty
  */
-static int utmp_chk(char *user, char *tty)
+static int utmp_chk(const struct write_control *ctl)
 {
 	struct utmp u;
 	struct utmp *uptr;
@@ -127,8 +135,8 @@ static int utmp_chk(char *user, char *tty)
 
 	while ((uptr = getutent())) {
 		memcpy(&u, uptr, sizeof(u));
-		if (strncmp(user, u.ut_user, sizeof(u.ut_user)) == 0 &&
-		    strncmp(tty, u.ut_line, sizeof(u.ut_line)) == 0) {
+		if (strncmp(ctl->dst_login, u.ut_user, sizeof(u.ut_user)) == 0 &&
+		    strncmp(ctl->dst_tty, u.ut_line, sizeof(u.ut_line)) == 0) {
 			res = 0;
 			break;
 		}
@@ -149,7 +157,7 @@ static int utmp_chk(char *user, char *tty)
  * Special case for writing to yourself - ignore the terminal you're
  * writing from, unless that's the only terminal with messages enabled.
  */
-static void search_utmp(char *user, char *tty, char *mytty, uid_t myuid)
+static void search_utmp(struct write_control *ctl)
 {
 	struct utmp u;
 	struct utmp *uptr;
@@ -165,16 +173,16 @@ static void search_utmp(char *user, char *tty, char *mytty, uid_t myuid)
 	user_is_me = 0;
 	while ((uptr = getutent())) {
 		memcpy(&u, uptr, sizeof(u));
-		if (strncmp(user, u.ut_user, sizeof(u.ut_user)) == 0) {
+		if (strncmp(ctl->dst_login, u.ut_user, sizeof(u.ut_user)) == 0) {
 			++nloggedttys;
 			xstrncpy(atty, u.ut_line, sizeof(atty));
 			if (term_chk(atty, &msgsok, &atime, 0))
 				/* bad term? skip */
 				continue;
-			if (myuid && !msgsok)
+			if (ctl->src_uid && !msgsok)
 				/* skip ttys with msgs off */
 				continue;
-			if (strcmp(atty, mytty) == 0) {
+			if (strcmp(atty, ctl->src_tty) == 0) {
 				user_is_me = 1;
 				/* don't write to yourself */
 				continue;
@@ -185,25 +193,26 @@ static void search_utmp(char *user, char *tty, char *mytty, uid_t myuid)
 			++nttys;
 			if (atime > bestatime) {
 				bestatime = atime;
-				strcpy(tty, atty);
+				xstrncpy(ctl->dst_tty, atty, sizeof(ctl->dst_tty));
 			}
 		}
 	}
 
 	endutent();
 	if (nloggedttys == 0)
-		errx(EXIT_FAILURE, _("%s is not logged in"), user);
+		errx(EXIT_FAILURE, _("%s is not logged in"), ctl->dst_login);
 	if (nttys == 0) {
 		if (user_is_me) {
 			/* ok, so write to yourself! */
-			strcpy(tty, mytty);
+			xstrncpy(ctl->dst_tty, ctl->src_tty, sizeof(ctl->dst_tty));
 			return;
 		}
-		errx(EXIT_FAILURE, _("%s has messages disabled"), user);
+		errx(EXIT_FAILURE, _("%s has messages disabled"), ctl->dst_login);
 	} else if (nttys > 1) {
 		warnx(_("%s is logged in more than once; writing to %s"),
-		      user, tty);
+		      ctl->dst_login, ctl->dst_tty);
 	}
+
 }
 
 /*
@@ -237,7 +246,7 @@ static void wr_fputs(char *s)
 /*
  * do_write - actually make the connection
  */
-static void do_write(char *tty, char *mytty, uid_t myuid)
+static void do_write(const struct write_control *ctl)
 {
 	char *login, *pwuid, *nows;
 	struct passwd *pwd;
@@ -246,16 +255,16 @@ static void do_write(char *tty, char *mytty, uid_t myuid)
 	struct sigaction sigact;
 
 	/* Determine our login name(s) before the we reopen() stdout */
-	if ((pwd = getpwuid(myuid)) != NULL)
+	if ((pwd = getpwuid(ctl->src_uid)) != NULL)
 		pwuid = pwd->pw_name;
 	else
 		pwuid = "???";
 	if ((login = getlogin()) == NULL)
 		login = pwuid;
 
-	if (strlen(tty) + 6 > sizeof(path))
-		errx(EXIT_FAILURE, _("tty path %s too long"), tty);
-	snprintf(path, sizeof(path), "/dev/%s", tty);
+	if (strlen(ctl->dst_tty) + 6 > sizeof(path))
+		errx(EXIT_FAILURE, _("tty path %s too long"), ctl->dst_tty);
+	snprintf(path, sizeof(path), "/dev/%s", ctl->dst_tty);
 	if ((freopen(path, "w", stdout)) == NULL)
 		err(EXIT_FAILURE, "%s", path);
 
@@ -276,10 +285,10 @@ static void do_write(char *tty, char *mytty, uid_t myuid)
 	printf("\r\n\007\007\007");
 	if (strcmp(login, pwuid))
 		printf(_("Message from %s@%s (as %s) on %s at %s ..."),
-		       login, host, pwuid, mytty, nows + 11);
+		       login, host, pwuid, ctl->src_tty, nows + 11);
 	else
 		printf(_("Message from %s@%s on %s at %s ..."),
-		       login, host, mytty, nows + 11);
+		       login, host, ctl->src_tty, nows + 11);
 	free(host);
 	printf("\r\n");
 
@@ -293,9 +302,8 @@ static void do_write(char *tty, char *mytty, uid_t myuid)
 
 int main(int argc, char **argv)
 {
-	uid_t myuid;
-	int msgsok = 0, myttyfd, c;
-	char tty[PATH_MAX], *mytty;
+	int msgsok = 0, src_fd, c;
+	struct write_control ctl = { 0 };
 
 	static const struct option longopts[] = {
 		{"version", no_argument, NULL, 'V'},
@@ -321,16 +329,16 @@ int main(int argc, char **argv)
 
 	/* check that sender has write enabled */
 	if (isatty(STDIN_FILENO))
-		myttyfd = STDIN_FILENO;
+		src_fd = STDIN_FILENO;
 	else if (isatty(STDOUT_FILENO))
-		myttyfd = STDOUT_FILENO;
+		src_fd = STDOUT_FILENO;
 	else if (isatty(STDERR_FILENO))
-		myttyfd = STDERR_FILENO;
+		src_fd = STDERR_FILENO;
 	else
-		myttyfd = -1;
+		src_fd = -1;
 
-	if (myttyfd != -1) {
-		if (!(mytty = ttyname(myttyfd)))
+	if (src_fd != -1) {
+		if (!(ctl.src_tty = ttyname(src_fd)))
 			errx(EXIT_FAILURE,
 			     _("can't find your tty's name"));
 
@@ -339,39 +347,42 @@ int main(int argc, char **argv)
 		 * term_chk() will put "/dev/" in front, so remove that
 		 * part.
 		 */
-		if (!strncmp(mytty, "/dev/", 5))
-			mytty += 5;
-		if (term_chk(mytty, &msgsok, NULL, 1))
+		if (!strncmp(ctl.src_tty, "/dev/", 5))
+			memmove(ctl.src_tty, ctl.src_tty + 5, strlen(ctl.src_tty + 5) + 1);
+		if (term_chk(ctl.src_tty, &msgsok, NULL, 1))
 			exit(EXIT_FAILURE);
 		if (!msgsok)
 			errx(EXIT_FAILURE,
 			     _("you have write permission turned off"));
 		msgsok = 0;
 	} else
-		mytty = "<no tty>";
+		ctl.src_tty = "<no tty>";
 
-	myuid = getuid();
+	ctl.src_uid = getuid();
 
 	/* check args */
 	switch (argc) {
 	case 2:
-		search_utmp(argv[1], tty, mytty, myuid);
-		do_write(tty, mytty, myuid);
+		ctl.dst_login = argv[1];
+		search_utmp(&ctl);
+		do_write(&ctl);
 		break;
 	case 3:
-		if (!strncmp(argv[2], "/dev/", 5))
-			argv[2] += 5;
-		if (utmp_chk(argv[1], argv[2]))
+		ctl.dst_login = argv[1];
+		xstrncpy(ctl.dst_tty, argv[2], sizeof(ctl.dst_tty));
+		if (!strncmp(ctl.dst_tty, "/dev/", 5))
+			memmove(ctl.dst_tty, ctl.dst_tty + 5, strlen(ctl.dst_tty + 5) + 1);
+		if (utmp_chk(&ctl))
 			errx(EXIT_FAILURE,
 			     _("%s is not logged in on %s"),
-			     argv[1], argv[2]);
-		if (term_chk(argv[2], &msgsok, NULL, 1))
+			     ctl.dst_login, ctl.dst_tty);
+		if (term_chk(ctl.dst_tty, &msgsok, NULL, 1))
 			exit(EXIT_FAILURE);
-		if (myuid && !msgsok)
+		if (ctl.src_uid && !msgsok)
 			errx(EXIT_FAILURE,
 			     _("%s has messages disabled on %s"),
-			     argv[1], argv[2]);
-		do_write(argv[2], mytty, myuid);
+			     ctl.dst_login, ctl.dst_tty);
+		do_write(&ctl);
 		break;
 	default:
 		usage(stderr);
-- 
2.8.2

