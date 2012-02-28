Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33189 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qpe (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:34 -0500
Received: by vbbff1 with SMTP id ff1so1997660vbb.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:33 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 04/13] sulogin: whitespace fixes
Date: Tue, 28 Feb 2012 11:45:12 -0500
Message-Id: <1330447521-886-5-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use a code style more inline with the rest of the project.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.c |  124 ++++++++++++++++++++++++++++---------------------
 1 file changed, 71 insertions(+), 53 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 969fc52..a444af1 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -75,8 +75,7 @@ static void (*saved_sigquit) = SIG_DFL;
  *	Fix the tty modes and set reasonable defaults.
  *	(I'm not sure if this is needed under Linux, but..)
  */
-static
-void fixtty(void)
+static void fixtty(void)
 {
 	struct termios tty;
 	int serial;
@@ -157,25 +156,29 @@ void alrm_handler(int sig)
  *	password is checked for traditional-style DES and
  *	FreeBSD-style MD5 encryption.
  */
-static
-int valid(const char *pass)
+static int valid(const char *pass)
 {
 	const char *s;
 	char id[5];
 	size_t len;
 	off_t off;
 
-	if (pass[0] == 0) return 1;
+	if (pass[0] == 0)
+		return 1;
 #if CHECK_MD5
-	if (pass[0] != '$') goto check_des;
+	if (pass[0] != '$')
+		goto check_des;
 
 	/*
 	 *	up to 4 bytes for the signature e.g. $1$
 	 */
-	for(s = pass+1; *s && *s != '$'; s++)
-		;
-	if (*s++ != '$') return 0;
-	if ((off = (off_t)(s-pass)) > 4 || off < 3) return 0;
+	for (s = pass+1; *s && *s != '$'; s++);
+
+	if (*s++ != '$')
+		return 0;
+
+	if ((off = (off_t)(s-pass)) > 4 || off < 3)
+		return 0;
 
 	memset(id, '\0', sizeof(id));
 	strncpy(id, pass, off);
@@ -183,26 +186,33 @@ int valid(const char *pass)
 	/*
 	 *	up to 16 bytes for the salt
 	 */
-	for(; *s && *s != '$'; s++)
-		;
-	if (*s++ != '$') return 0;
-	if ((off_t)(s-pass) > 16) return 0;
+	for (; *s && *s != '$'; s++);
+
+	if (*s++ != '$')
+		return 0;
+
+	if ((off_t)(s-pass) > 16)
+		return 0;
+
 	len = strlen(s);
 
 	/*
 	 *	the MD5 hash (128 bits or 16 bytes) encoded in base64 = 22 bytes
 	 */
-	if ((strcmp(id, "$1$") == 0) && (len < 22 || len > 24)) return 0;
+	if ((strcmp(id, "$1$") == 0) && (len < 22 || len > 24))
+		return 0;
 
 	/*
 	 *	the SHA-256 hash 43 bytes
 	 */
-	if ((strcmp(id, "$5$") == 0) && (len < 42 || len > 44)) return 0;
+	if ((strcmp(id, "$5$") == 0) && (len < 42 || len > 44))
+		return 0;
 
 	/*
 	 *      the SHA-512 hash 86 bytes
 	 */
-	if ((strcmp(id, "$6$") == 0) && (len < 85 || len > 87)) return 0;
+	if ((strcmp(id, "$6$") == 0) && (len < 85 || len > 87))
+		return 0;
 
 	/*
 	 *	e.g. Blowfish hash
@@ -211,12 +221,15 @@ int valid(const char *pass)
 check_des:
 #endif
 #if CHECK_DES
-	if (strlen(pass) != 13) return 0;
+	if (strlen(pass) != 13)
+		return 0;
+
 	for (s = pass; *s; s++) {
 		if ((*s < '0' || *s > '9') &&
 		    (*s < 'a' || *s > 'z') &&
 		    (*s < 'A' || *s > 'Z') &&
-		    *s != '.' && *s != '/') return 0;
+		    *s != '.' && *s != '/')
+			return 0;
 	}
 #endif
 	return 1;
@@ -225,17 +238,16 @@ check_des:
 /*
  *	Set a variable if the value is not NULL.
  */
-static
-void set(char **var, char *val)
+static void set(char **var, char *val)
 {
-	if (val) *var = val;
+	if (val)
+		*var = val;
 }
 
 /*
  *	Get the root password entry.
  */
-static
-struct passwd *getrootpwent(int try_manually)
+static struct passwd *getrootpwent(int try_manually)
 {
 	static struct passwd pwd;
 	struct passwd *pw;
@@ -253,7 +265,8 @@ struct passwd *getrootpwent(int try_manually)
 	    !strcmp(pw->pw_passwd, "x") &&
 	    (spw = getspnam("root")))
 		pw->pw_passwd = spw->sp_pwdp;
-	if (pw || !try_manually) return pw;
+	if (pw || !try_manually)
+		return pw;
 
 	/*
 	 *	If we come here, we could not retrieve the root
@@ -276,13 +289,13 @@ struct passwd *getrootpwent(int try_manually)
 	/*
 	 *	Find root in the password file.
 	 */
-	while((p = fgets(line, 256, fp)) != NULL) {
+	while ((p = fgets(line, 256, fp)) != NULL) {
 		if (strncmp(line, "root:", 5) != 0)
 			continue;
 		p += 5;
 		set(&pwd.pw_passwd, strsep(&p, ":"));
-		(void)strsep(&p, ":");
-		(void)strsep(&p, ":");
+		strsep(&p, ":");
+		strsep(&p, ":");
 		set(&pwd.pw_gecos, strsep(&p, ":"));
 		set(&pwd.pw_dir, strsep(&p, ":"));
 		set(&pwd.pw_shell, strsep(&p, "\n"));
@@ -299,7 +312,8 @@ struct passwd *getrootpwent(int try_manually)
 		fprintf(stderr, "%s: no entry for root\n", F_PASSWD);
 		return &pwd;
 	}
-	if (valid(pwd.pw_passwd)) return &pwd;
+	if (valid(pwd.pw_passwd))
+		return &pwd;
 
 	/*
 	 *	The password is invalid. If there is a
@@ -310,7 +324,7 @@ struct passwd *getrootpwent(int try_manually)
 		fprintf(stderr, "%s: root password garbled\n", F_PASSWD);
 		return &pwd;
 	}
-	while((p = fgets(sline, 256, fp)) != NULL) {
+	while ((p = fgets(sline, 256, fp)) != NULL) {
 		if (strncmp(sline, "root:", 5) != 0)
 			continue;
 		p += 5;
@@ -329,7 +343,8 @@ struct passwd *getrootpwent(int try_manually)
 	}
 	if (!valid(pwd.pw_passwd)) {
 		fprintf(stderr, "%s: root password garbled\n", F_SHADOW);
-		strcpy(pwd.pw_passwd, ""); }
+		strcpy(pwd.pw_passwd, "");
+	}
 	return &pwd;
 }
 
@@ -337,8 +352,7 @@ struct passwd *getrootpwent(int try_manually)
  *	Ask for the password. Note that there is no
  *	default timeout as we normally skip this during boot.
  */
-static
-char *getpasswd(char *crypted)
+static char *getpasswd(char *crypted)
 {
 	struct sigaction sa;
 	struct termios old, tty;
@@ -370,12 +384,13 @@ char *getpasswd(char *crypted)
 	sa.sa_handler = alrm_handler;
 	sa.sa_flags = 0;
 	sigaction(SIGALRM, &sa, NULL);
-	if (timeout) alarm(timeout);
+	if (timeout)
+		alarm(timeout);
 
 	if (read(0, pass, sizeof(pass) - 1) <= 0)
 		ret = NULL;
 	else {
-		for(i = 0; i < (int)sizeof(pass) && pass[i]; i++)
+		for (i = 0; i < (int)sizeof(pass) && pass[i]; i++)
 			if (pass[i] == '\r' || pass[i] == '\n') {
 				pass[i] = 0;
 				break;
@@ -391,8 +406,7 @@ char *getpasswd(char *crypted)
 /*
  *	Password was OK, execute a shell.
  */
-static
-void sushell(struct passwd *pwd)
+static void sushell(struct passwd *pwd)
 {
 	char shell[128];
 	char home[128];
@@ -402,7 +416,7 @@ void sushell(struct passwd *pwd)
 	/*
 	 *	Set directory and shell.
 	 */
-	(void)chdir(pwd->pw_dir);
+	chdir(pwd->pw_dir);
 	if ((p = getenv("SUSHELL")) != NULL)
 		sushell = p;
 	else if ((p = getenv("sushell")) != NULL)
@@ -438,15 +452,16 @@ void sushell(struct passwd *pwd)
 	signal(SIGQUIT, saved_sigquit);
 #ifdef WITH_SELINUX
 	if (is_selinux_enabled() > 0) {
-	  security_context_t scon=NULL;
-	  char *seuser=NULL;
-	  char *level=NULL;
-	  if (getseuserbyname("root", &seuser, &level) == 0)
-		  if (get_default_context_with_level(seuser, level, 0, &scon) == 0) {
-			  if (setexeccon(scon) != 0) 
-				  fprintf(stderr, "setexeccon faile\n");
-			  freecon(scon);
-		  }
+		security_context_t scon=NULL;
+		char *seuser=NULL;
+		char *level=NULL;
+		if (getseuserbyname("root", &seuser, &level) == 0) {
+			if (get_default_context_with_level(seuser, level, 0, &scon) == 0) {
+				if (setexeccon(scon) != 0)
+					fprintf(stderr, "setexeccon failed\n");
+				freecon(scon);
+			}
+		}
 		free(seuser);
 		free(level);
 	}
@@ -465,8 +480,7 @@ void sushell(struct passwd *pwd)
 	perror(STATICSH);
 }
 
-static
-void usage(void)
+static void usage(void)
 {
 	fprintf(stderr, "Usage: sulogin [-e] [-p] [-t timeout] [tty device]\n");
 }
@@ -484,7 +498,8 @@ int main(int argc, char **argv)
 	 *	See if we have a timeout flag.
 	 */
 	opterr = 0;
-	while((c = getopt(argc, argv, "ept:")) != EOF) switch(c) {
+	while ((c = getopt(argc, argv, "ept:")) != EOF) {
+		switch(c) {
 		case 't':
 			timeout = atoi(optarg);
 			break;
@@ -498,6 +513,7 @@ int main(int argc, char **argv)
 			usage();
 			/* Do not exit! */
 			break;
+		}
 	}
 
 	if (geteuid() != 0) {
@@ -511,7 +527,8 @@ int main(int argc, char **argv)
 	saved_sigint  = signal(SIGINT,  SIG_IGN);
 	saved_sigtstp = signal(SIGQUIT, SIG_IGN);
 	saved_sigquit = signal(SIGTSTP, SIG_IGN);
-	if (optind < argc) tty = argv[optind];
+	if (optind < argc)
+		tty = argv[optind];
 
 	if (tty || (tty = getenv("CONSOLE"))) {
 
@@ -587,8 +604,9 @@ int main(int argc, char **argv)
 	/*
 	 *	Ask for the password.
 	 */
-	while(pwd) {
-		if ((p = getpasswd(pwd->pw_passwd)) == NULL) break;
+	while (pwd) {
+		if ((p = getpasswd(pwd->pw_passwd)) == NULL)
+			break;
 		if (pwd->pw_passwd[0] == 0 ||
 		    strcmp(crypt(p, pwd->pw_passwd), pwd->pw_passwd) == 0)
 			sushell(pwd);
-- 
1.7.9.2

