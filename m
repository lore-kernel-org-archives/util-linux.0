Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34517 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752239AbcEIV1p (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 9 May 2016 17:27:45 -0400
Received: by mail-wm0-f65.google.com with SMTP id n129so22482431wmn.1
        for <util-linux@vger.kernel.org>; Mon, 09 May 2016 14:27:39 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/12] write: get rid of function prototypes
Date: Mon,  9 May 2016 22:27:18 +0100
Message-Id: <1462829248-6935-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
References: <1462829248-6935-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Marking functions static and writing them in order where functions are
introduced before use is enough.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/write.c | 273 ++++++++++++++++++++++++++---------------------------
 1 file changed, 132 insertions(+), 141 deletions(-)

diff --git a/term-utils/write.c b/term-utils/write.c
index 42f279b..e8532f6 100644
--- a/term-utils/write.c
+++ b/term-utils/write.c
@@ -65,14 +65,6 @@
 #include "nls.h"
 #include "xalloc.h"
 
-static void __attribute__ ((__noreturn__)) usage(FILE * out);
-void search_utmp(char *, char *, char *, uid_t);
-void do_write(char *, char *, uid_t);
-void wr_fputs(char *);
-static void __attribute__ ((__noreturn__)) done(int);
-int term_chk(char *, int *, time_t *, int);
-int utmp_chk(char *, char *);
-
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
 {
 	fputs(USAGE_HEADER, out);
@@ -91,104 +83,36 @@ static void __attribute__ ((__noreturn__)) usage(FILE * out)
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
 
-int main(int argc, char **argv)
+/*
+ * term_chk - check that a terminal exists, and get the message bit
+ *     and the access time
+ */
+static int term_chk(char *tty, int *msgsokP, time_t * atimeP, int showerror)
 {
-	time_t atime;
-	uid_t myuid;
-	int msgsok = 0, myttyfd, c;
-	char tty[PATH_MAX], *mytty;
-
-	static const struct option longopts[] = {
-		{"version", no_argument, NULL, 'V'},
-		{"help", no_argument, NULL, 'h'},
-		{NULL, 0, NULL, 0}
-	};
-
-	setlocale(LC_ALL, "");
-	bindtextdomain(PACKAGE, LOCALEDIR);
-	textdomain(PACKAGE);
-	atexit(close_stdout);
-
-	while ((c = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
-		switch (c) {
-		case 'V':
-			printf(UTIL_LINUX_VERSION);
-			return EXIT_SUCCESS;
-		case 'h':
-			usage(stdout);
-		default:
-			usage(stderr);
-		}
-
-	/* check that sender has write enabled */
-	if (isatty(fileno(stdin)))
-		myttyfd = fileno(stdin);
-	else if (isatty(fileno(stdout)))
-		myttyfd = fileno(stdout);
-	else if (isatty(fileno(stderr)))
-		myttyfd = fileno(stderr);
-	else
-		myttyfd = -1;
-
-	if (myttyfd != -1) {
-		if (!(mytty = ttyname(myttyfd)))
-			errx(EXIT_FAILURE,
-			     _("can't find your tty's name"));
-
-		/*
-		 * We may have /dev/ttyN but also /dev/pts/xx. Below,
-		 * term_chk() will put "/dev/" in front, so remove that
-		 * part.
-		 */
-		if (!strncmp(mytty, "/dev/", 5))
-			mytty += 5;
-		if (term_chk(mytty, &msgsok, &atime, 1))
-			exit(EXIT_FAILURE);
-		if (!msgsok)
-			errx(EXIT_FAILURE,
-			     _("you have write permission turned off"));
-		msgsok = 0;
-	} else
-		mytty = "<no tty>";
-
-	myuid = getuid();
+	struct stat s;
+	char path[PATH_MAX];
 
-	/* check args */
-	switch (argc) {
-	case 2:
-		search_utmp(argv[1], tty, mytty, myuid);
-		do_write(tty, mytty, myuid);
-		break;
-	case 3:
-		if (!strncmp(argv[2], "/dev/", 5))
-			argv[2] += 5;
-		if (utmp_chk(argv[1], argv[2]))
-			errx(EXIT_FAILURE,
-			     _("%s is not logged in on %s"),
-			     argv[1], argv[2]);
-		if (term_chk(argv[2], &msgsok, &atime, 1))
-			exit(EXIT_FAILURE);
-		if (myuid && !msgsok)
-			errx(EXIT_FAILURE,
-			     _("%s has messages disabled on %s"),
-			     argv[1], argv[2]);
-		do_write(argv[2], mytty, myuid);
-		break;
-	default:
-		usage(stderr);
+	if (strlen(tty) + 6 > sizeof(path))
+		return 1;
+	sprintf(path, "/dev/%s", tty);
+	if (stat(path, &s) < 0) {
+		if (showerror)
+			warn("%s", path);
+		return 1;
 	}
-
-	done(0);
-	/* NOTREACHED */
-	return EXIT_FAILURE;
+	if (getuid() == 0)	/* root can always write */
+		*msgsokP = 1;
+	else
+		*msgsokP = (s.st_mode & S_IWGRP) && (getegid() == s.st_gid);
+	*atimeP = s.st_atime;
+	return 0;
 }
 
-
 /*
  * utmp_chk - checks that the given user is actually logged in on
  *     the given tty
  */
-int utmp_chk(char *user, char *tty)
+static int utmp_chk(char *user, char *tty)
 {
 	struct utmp u;
 	struct utmp *uptr;
@@ -221,7 +145,7 @@ int utmp_chk(char *user, char *tty)
  * Special case for writing to yourself - ignore the terminal you're
  * writing from, unless that's the only terminal with messages enabled.
  */
-void search_utmp(char *user, char *tty, char *mytty, uid_t myuid)
+static void search_utmp(char *user, char *tty, char *mytty, uid_t myuid)
 {
 	struct utmp u;
 	struct utmp *uptr;
@@ -280,34 +204,39 @@ void search_utmp(char *user, char *tty, char *mytty, uid_t myuid)
 }
 
 /*
- * term_chk - check that a terminal exists, and get the message bit
- *     and the access time
+ * done - cleanup and exit
  */
-int term_chk(char *tty, int *msgsokP, time_t * atimeP, int showerror)
+static void __attribute__ ((__noreturn__))
+    done(int dummy __attribute__ ((__unused__)))
 {
-	struct stat s;
-	char path[PATH_MAX];
+	printf("EOF\r\n");
+	_exit(EXIT_SUCCESS);
+}
 
-	if (strlen(tty) + 6 > sizeof(path))
-		return 1;
-	sprintf(path, "/dev/%s", tty);
-	if (stat(path, &s) < 0) {
-		if (showerror)
-			warn("%s", path);
-		return 1;
+/*
+ * wr_fputs - like fputs(), but makes control characters visible and
+ *     turns \n into \r\n.
+ */
+static void wr_fputs(char *s)
+{
+	char c;
+
+#define	PUTC(c)	if (fputc_careful(c, stdout, '^') == EOF) \
+    err(EXIT_FAILURE, _("carefulputc failed"));
+	while (*s) {
+		c = *s++;
+		if (c == '\n')
+			PUTC('\r');
+		PUTC(c);
 	}
-	if (getuid() == 0)	/* root can always write */
-		*msgsokP = 1;
-	else
-		*msgsokP = (s.st_mode & S_IWGRP) && (getegid() == s.st_gid);
-	*atimeP = s.st_atime;
-	return 0;
+	return;
+#undef PUTC
 }
 
 /*
  * do_write - actually make the connection
  */
-void do_write(char *tty, char *mytty, uid_t myuid)
+static void do_write(char *tty, char *mytty, uid_t myuid)
 {
 	char *login, *pwuid, *nows;
 	struct passwd *pwd;
@@ -353,32 +282,94 @@ void do_write(char *tty, char *mytty, uid_t myuid)
 		wr_fputs(line);
 }
 
-/*
- * done - cleanup and exit
- */
-static void __attribute__ ((__noreturn__))
-    done(int dummy __attribute__ ((__unused__)))
+int main(int argc, char **argv)
 {
-	printf("EOF\r\n");
-	_exit(EXIT_SUCCESS);
-}
+	time_t atime;
+	uid_t myuid;
+	int msgsok = 0, myttyfd, c;
+	char tty[PATH_MAX], *mytty;
 
-/*
- * wr_fputs - like fputs(), but makes control characters visible and
- *     turns \n into \r\n.
- */
-void wr_fputs(char *s)
-{
-	char c;
+	static const struct option longopts[] = {
+		{"version", no_argument, NULL, 'V'},
+		{"help", no_argument, NULL, 'h'},
+		{NULL, 0, NULL, 0}
+	};
 
-#define	PUTC(c)	if (fputc_careful(c, stdout, '^') == EOF) \
-    err(EXIT_FAILURE, _("carefulputc failed"));
-	while (*s) {
-		c = *s++;
-		if (c == '\n')
-			PUTC('\r');
-		PUTC(c);
+	setlocale(LC_ALL, "");
+	bindtextdomain(PACKAGE, LOCALEDIR);
+	textdomain(PACKAGE);
+	atexit(close_stdout);
+
+	while ((c = getopt_long(argc, argv, "Vh", longopts, NULL)) != -1)
+		switch (c) {
+		case 'V':
+			printf(UTIL_LINUX_VERSION);
+			return EXIT_SUCCESS;
+		case 'h':
+			usage(stdout);
+		default:
+			usage(stderr);
+		}
+
+	/* check that sender has write enabled */
+	if (isatty(fileno(stdin)))
+		myttyfd = fileno(stdin);
+	else if (isatty(fileno(stdout)))
+		myttyfd = fileno(stdout);
+	else if (isatty(fileno(stderr)))
+		myttyfd = fileno(stderr);
+	else
+		myttyfd = -1;
+
+	if (myttyfd != -1) {
+		if (!(mytty = ttyname(myttyfd)))
+			errx(EXIT_FAILURE,
+			     _("can't find your tty's name"));
+
+		/*
+		 * We may have /dev/ttyN but also /dev/pts/xx. Below,
+		 * term_chk() will put "/dev/" in front, so remove that
+		 * part.
+		 */
+		if (!strncmp(mytty, "/dev/", 5))
+			mytty += 5;
+		if (term_chk(mytty, &msgsok, &atime, 1))
+			exit(EXIT_FAILURE);
+		if (!msgsok)
+			errx(EXIT_FAILURE,
+			     _("you have write permission turned off"));
+		msgsok = 0;
+	} else
+		mytty = "<no tty>";
+
+	myuid = getuid();
+
+	/* check args */
+	switch (argc) {
+	case 2:
+		search_utmp(argv[1], tty, mytty, myuid);
+		do_write(tty, mytty, myuid);
+		break;
+	case 3:
+		if (!strncmp(argv[2], "/dev/", 5))
+			argv[2] += 5;
+		if (utmp_chk(argv[1], argv[2]))
+			errx(EXIT_FAILURE,
+			     _("%s is not logged in on %s"),
+			     argv[1], argv[2]);
+		if (term_chk(argv[2], &msgsok, &atime, 1))
+			exit(EXIT_FAILURE);
+		if (myuid && !msgsok)
+			errx(EXIT_FAILURE,
+			     _("%s has messages disabled on %s"),
+			     argv[1], argv[2]);
+		do_write(argv[2], mytty, myuid);
+		break;
+	default:
+		usage(stderr);
 	}
-	return;
-#undef PUTC
+
+	done(0);
+	/* NOTREACHED */
+	return EXIT_FAILURE;
 }
-- 
2.8.2

