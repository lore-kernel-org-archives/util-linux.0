Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35046 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754121AbcEORAe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 15 May 2016 13:00:34 -0400
Received: by mail-wm0-f65.google.com with SMTP id e201so13379508wme.2
        for <util-linux@vger.kernel.org>; Sun, 15 May 2016 10:00:33 -0700 (PDT)
Date: Sun, 15 May 2016 18:00:25 +0100 (BST)
From: Sami Kerola <kerolasa@iki.fi>
To: Karel Zak <kzak@redhat.com>
cc: util-linux@vger.kernel.org
Subject: Re: [PATCH 07/12] write: add control structure to clarify what is
 going on
In-Reply-To: <20160511083804.4sia7k6wfetw4auo@ws.net.home>
Message-ID: <alpine.LNX.2.20.1605151751430.592@imuri>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi> <1462829248-6935-8-git-send-email-kerolasa@iki.fi> <20160511083804.4sia7k6wfetw4auo@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, 11 May 2016, Karel Zak wrote:

> On Mon, May 09, 2016 at 10:27:23PM +0100, Sami Kerola wrote:
> > @@ -339,39 +347,42 @@ int main(int argc, char **argv)
> >  		 * term_chk() will put "/dev/" in front, so remove that
> >  		 * part.
> >  		 */
> > -		if (!strncmp(mytty, "/dev/", 5))
> > -			mytty += 5;
> > -		if (term_chk(mytty, &msgsok, NULL, 1))
> > +		if (!strncmp(ctl.src_tty, "/dev/", 5))
> > +			memmove(ctl.src_tty, ctl.src_tty + 5, strlen(ctl.src_tty + 5) + 1);
> > +		if (term_chk(ctl.src_tty, &msgsok, NULL, 1))
> 
> The patch promises that it replaces variables with control struct, but
> here it does something more. Don't do that. There is no memmove() in
> the original code. 

Fair enough. The memmove() is removed from

https://github.com/kerolasa/lelux-utiliteetit/commit/d49f877b7e6d6c28c6e89372f8828f13c115577f

> Please, if you want to optimize the code than do it in another patch.

And what comes to these "/dev/" strings I rethought what would be better. 
That resulted to new change.

https://github.com/kerolasa/lelux-utiliteetit/commit/57b1531faf120aa136064aff2b6e2e0a23c2ba21

-- snip
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 14 May 2016 19:39:37 +0100
Subject: [PATCH 14/15] write: stop removing and adding /dev/ in front of tty string

Add both path and tty name representations of tty's to control structure,
that point to same string beginning from different depths.  This way there
is no need to removing and adding /dev/ in front of tty string all the time,
and use of get_terminal_name() from ttyutils.c is possible.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/Makemodule.am |  1 +
 term-utils/write.c       | 81 +++++++++++++++++++++++-------------------------
 2 files changed, 40 insertions(+), 42 deletions(-)

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
index 351a455..6900752 100644
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
-static int check_tty(char *tty, int *mesg_allowed, time_t *tty_atime, int showerror)
+static int check_tty(const char *tty, int *mesg_allowed, time_t *tty_atime, int showerror)
 {
 	struct stat s;
-	char path[PATH_MAX];
 
-	if (strlen(tty) + 6 > sizeof(path))
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
 		*mesg_allowed = 1;
 	else {
 		if (getegid() != s.st_gid) {
-			warnx(_("effective gid does not match group of %s"), path);
+			warnx(_("effective gid does not match group of %s"), tty);
 			return 1;
 		}
 		*mesg_allowed = s.st_mode & S_IWGRP;
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
 	int num_ttys = 0, valid_ttys = 0, mesg_allowed = 0, user_is_me = 0;
+	char path[PATH_MAX];
 
 	utmpname(_PATH_UTMP);
 	setutent();
@@ -172,13 +172,14 @@ static void search_utmp(struct write_control *ctl)
 	while ((u = getutent())) {
 		if (strncmp(ctl->dst_login, u->ut_user, sizeof(u->ut_user)) == 0) {
 			num_ttys++;
-			if (check_tty(u->ut_line, &mesg_allowed, &tty_atime, 0))
+			sprintf(path, "/dev/%s", u->ut_line);
+			if (check_tty(path, &mesg_allowed, &tty_atime, 0))
 				/* bad term? skip */
 				continue;
 			if (ctl->src_uid && !mesg_allowed)
 				/* skip ttys with msgs off */
 				continue;
-			if (strcmp(u->ut_line, ctl->src_tty) == 0) {
+			if (strcmp(u->ut_line, ctl->src_tty_name) == 0) {
 				user_is_me = 1;
 				/* don't write to yourself */
 				continue;
@@ -189,7 +190,9 @@ static void search_utmp(struct write_control *ctl)
 			valid_ttys++;
 			if (tty_atime > best_atime) {
 				best_atime = tty_atime;
-				xstrncpy(ctl->dst_tty, u->ut_line, sizeof(ctl->dst_tty));
+				free(ctl->dst_tty_path);
+				ctl->dst_tty_path = xstrdup(path);
+				ctl->dst_tty_name = ctl->dst_tty_path + 5;
 			}
 		}
 	}
@@ -200,14 +203,17 @@ static void search_utmp(struct write_control *ctl)
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
 	if (valid_ttys > 1)
 		warnx(_("%s is logged in more than once; writing to %s"),
-		      ctl->dst_login, ctl->dst_tty);
+		      ctl->dst_login, ctl->dst_tty_name);
 }
 
 /*
@@ -246,7 +252,7 @@ static void do_write(const struct write_control *ctl)
 	struct passwd *pwd;
 	time_t now;
 	struct tm *tm;
-	char path[PATH_MAX], *host, line[512];
+	char *host, line[512];
 	struct sigaction sigact;
 
 	/* Determine our login name(s) before the we reopen() stdout */
@@ -257,11 +263,8 @@ static void do_write(const struct write_control *ctl)
 	if ((login = getlogin()) == NULL)
 		login = pwuid;
 
-	if (strlen(ctl->dst_tty) + 6 > sizeof(path))
-		errx(EXIT_FAILURE, _("tty path %s too long"), ctl->dst_tty);
-	snprintf(path, sizeof(path), "/dev/%s", ctl->dst_tty);
-	if ((freopen(path, "w", stdout)) == NULL)
-		err(EXIT_FAILURE, "%s", path);
+	if ((freopen(ctl->dst_tty_path, "w", stdout)) == NULL)
+		err(EXIT_FAILURE, "%s", ctl->dst_tty_path);
 
 	sigact.sa_handler = signal_handler;
 	sigemptyset(&sigact.sa_mask);
@@ -280,10 +283,10 @@ static void do_write(const struct write_control *ctl)
 	printf("\r\n\a\a\a");
 	if (strcmp(login, pwuid))
 		printf(_("Message from %s@%s (as %s) on %s at %s ..."),
-		       login, host, pwuid, ctl->src_tty, time_stamp);
+		       login, host, pwuid, ctl->src_tty_name, time_stamp);
 	else
 		printf(_("Message from %s@%s on %s at %s ..."),
-		       login, host, ctl->src_tty, time_stamp);
+		       login, host, ctl->src_tty_name, time_stamp);
 	free(host);
 	printf("\r\n");
 
@@ -332,25 +335,17 @@ int main(int argc, char **argv)
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
-		if (check_tty(ctl.src_tty, &mesg_allowed, NULL, 1))
+	if (src_fd != -1 ||
+	    get_terminal_name(src_fd, &ctl.src_tty_path, &ctl.src_tty_name,
+				 NULL) < 0) {
+		if (check_tty(ctl.src_tty_path, &mesg_allowed, NULL, 1))
 			exit(EXIT_FAILURE);
 		if (!mesg_allowed)
 			errx(EXIT_FAILURE,
 			     _("you have write permission turned off"));
 		mesg_allowed = 0;
 	} else
-		ctl.src_tty = "<no tty>";
+		ctl.src_tty_name = "<no tty>";
 
 	ctl.src_uid = getuid();
 
@@ -364,23 +359,25 @@ int main(int argc, char **argv)
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
-		if (check_tty(ctl.dst_tty, &mesg_allowed, NULL, 1))
+			     ctl.dst_login, ctl.dst_tty_name);
+		if (check_tty(ctl.dst_tty_path, &mesg_allowed, NULL, 1))
 			exit(EXIT_FAILURE);
 		if (ctl.src_uid && !mesg_allowed)
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
2.8.2
-- snip

> and btw: we have lib/ttyutils.c: get_terminal_name(), it seems usable
> for this use-case, but...
> 
> > -		if (!strncmp(argv[2], "/dev/", 5))
> > -			argv[2] += 5;
> > -		if (utmp_chk(argv[1], argv[2]))
> > +		ctl.dst_login = argv[1];
> > +		xstrncpy(ctl.dst_tty, argv[2], sizeof(ctl.dst_tty));
> > +		if (!strncmp(ctl.dst_tty, "/dev/", 5))
> > +			memmove(ctl.dst_tty, ctl.dst_tty + 5, strlen(ctl.dst_tty + 5) + 1);
> 
> ... maybe we need xttyname() to return a name (no path) and in
> allocated string for programs where we call ttyname() more times.

The get_terminal_name() seems pretty suitable for write(1) without 
major changes. That said I end up proposing a small change to it.

https://github.com/kerolasa/lelux-utiliteetit/commit/554bfbe07c03bd2cf12910ee53be258dcb95c82e

-- snip
From: Sami Kerola <kerolasa@iki.fi>
Date: Sat, 14 May 2016 19:50:41 +0100
Subject: [PATCH 15/15] lib: try to find tty in get_terminal_name()

Try to use all standard terminal input/output file descriptors to find tty
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
index 1a1d8bc..d3ec196 100644
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
index 6432693..a1176de 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -356,7 +356,7 @@ static void init_tty(struct login_context *cxt)
 
 	cxt->tty_mode = (mode_t) getlogindefs_num("TTYPERM", TTY_MODE);
 
-	get_terminal_name(0, &cxt->tty_path, &cxt->tty_name, &cxt->tty_number);
+	get_terminal_name(&cxt->tty_path, &cxt->tty_name, &cxt->tty_number);
 
 	/*
 	 * In case login is suid it was possible to use a hardlink as stdin
diff --git a/login-utils/su-common.c b/login-utils/su-common.c
index fe6d0c8..483243f 100644
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
index 6900752..3580f57 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -300,7 +300,7 @@ static void do_write(const struct write_control *ctl)
 
 int main(int argc, char **argv)
 {
-	int mesg_allowed = 0, src_fd, c;
+	int mesg_allowed = 0, c;
 	struct write_control ctl = { 0 };
 
 	static const struct option longopts[] = {
@@ -325,19 +325,9 @@ int main(int argc, char **argv)
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
-	if (src_fd != -1 ||
-	    get_terminal_name(src_fd, &ctl.src_tty_path, &ctl.src_tty_name,
+	if (get_terminal_name(&ctl.src_tty_path, &ctl.src_tty_name,
 				 NULL) < 0) {
+		/* check that sender has write enabled */
 		if (check_tty(ctl.src_tty_path, &mesg_allowed, NULL, 1))
 			exit(EXIT_FAILURE);
 		if (!mesg_allowed)
-- 
2.8.2
-- snip

-- 
Sami Kerola
http://www.iki.fi/kerolasa/
