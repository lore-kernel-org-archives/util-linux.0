Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 29/49] login: env initialization refactoring
Date: Mon, 17 Oct 2011 13:15:08 +0200
Message-Id: <1318850128-23458-30-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   98 +++++++++++++++++++++++----------------------------
 1 files changed, 44 insertions(+), 54 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 1011206..c875181 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -110,7 +110,8 @@ struct login_context {
 	int		quiet;		/* 1 is hush file exists */
 
 	unsigned int	remote:1,	/* login -h */
-			noauth:1;	/* login -f */
+			noauth:1,	/* login -f */
+			keep_env:1;	/* login -p */
 };
 
 /*
@@ -921,16 +922,54 @@ static void fork_session(struct login_context *cxt)
 	signal(SIGINT, SIG_DFL);
 }
 
+/*
+ * Initialize $TERM, $HOME, ...
+ */
+static void init_environ(struct login_context *cxt)
+{
+	struct passwd *pwd = cxt->pwd;
+	char *termenv = NULL, **env;
+	char tmp[PATH_MAX];
+	int len, i;
+
+	termenv = getenv("TERM");
+	termenv = termenv ? strdup(termenv) : "dumb";
+
+	/* destroy environment unless user has requested preservation (-p) */
+	if (!cxt->keep_env) {
+		environ = (char **) malloc(sizeof(char *));
+		memset(environ, 0, sizeof(char *));
+	}
+
+	setenv("HOME", pwd->pw_dir, 0);	/* legal to override */
+	setenv("PATH", pwd->pw_uid ? _PATH_DEFPATH : _PATH_DEFPATH_ROOT, 1);
+	setenv("SHELL", pwd->pw_shell, 1);
+	setenv("TERM", termenv, 1);
+
+	/* mailx will give a funny error msg if you forget this one */
+	len = snprintf(tmp, sizeof(tmp), "%s/%s", _PATH_MAILDIR, pwd->pw_name);
+	if (len > 0 && (size_t) len + 1 <= sizeof(tmp))
+		setenv("MAIL", tmp, 0);
+
+	/* LOGNAME is not documented in login(1) but HP-UX 6.5 does it. We'll
+	 * not allow modifying it.
+	 */
+	setenv("LOGNAME", pwd->pw_name, 1);
+
+	env = pam_getenvlist(cxt->pamh);
+	for (i = 0; env && env[i]; i++)
+		putenv(env[i]);
+}
+
 int main(int argc, char **argv)
 {
 	extern int optind;
 	extern char *optarg, **environ;
 	register int ch;
 	register char *p;
-	int pflag, cnt;
+	int cnt;
 	char *domain;
 	char tbuf[PATH_MAX + 2];
-	char *termenv;
 	char *childArgv[10];
 	char *buff;
 	int childArgc = 0;
@@ -966,8 +1005,6 @@ int main(int argc, char **argv)
 	gethostname(tbuf, sizeof(tbuf));
 	domain = strchr(tbuf, '.');
 
-	pflag = 0;
-
 	while ((ch = getopt(argc, argv, "fh:p")) != -1)
 		switch (ch) {
 		case 'f':
@@ -1017,7 +1054,7 @@ int main(int argc, char **argv)
 			break;
 
 		case 'p':
-			pflag = 1;
+			cxt.keep_env = 1;
 			break;
 
 		case '?':
@@ -1119,55 +1156,8 @@ int main(int argc, char **argv)
 	if (*pwd->pw_shell == '\0')
 		pwd->pw_shell = _PATH_BSHELL;
 
-	/* preserve TERM even without -p flag */
-	{
-		char *ep;
-
-		if (!((ep = getenv("TERM")) && (termenv = strdup(ep))))
-			termenv = "dumb";
-	}
-
-	/* destroy environment unless user has requested preservation */
-	if (!pflag) {
-		environ = (char **)malloc(sizeof(char *));
-		memset(environ, 0, sizeof(char *));
-	}
-
-	setenv("HOME", pwd->pw_dir, 0);	/* legal to override */
-	if (pwd->pw_uid)
-		setenv("PATH", _PATH_DEFPATH, 1);
-	else
-		setenv("PATH", _PATH_DEFPATH_ROOT, 1);
-
-	setenv("SHELL", pwd->pw_shell, 1);
-	setenv("TERM", termenv, 1);
+	init_environ(&cxt);
 
-	/* mailx will give a funny error msg if you forget this one */
-	{
-		char tmp[PATH_MAX];
-		/* avoid snprintf */
-		if (sizeof(_PATH_MAILDIR) + strlen(pwd->pw_name) + 1 < PATH_MAX) {
-			sprintf(tmp, "%s/%s", _PATH_MAILDIR, pwd->pw_name);
-			setenv("MAIL", tmp, 0);
-		}
-	}
-
-	/* LOGNAME is not documented in login(1) but
-	   HP-UX 6.5 does it. We'll not allow modifying it.
-	 */
-	setenv("LOGNAME", pwd->pw_name, 1);
-
-	{
-		int i;
-		char **env = pam_getenvlist(cxt.pamh);
-
-		if (env != NULL) {
-			for (i = 0; env[i]; i++) {
-				putenv(env[i]);
-				/* D(("env[%d] = %s", i,env[i])); */
-			}
-		}
-	}
 
 	setproctitle("login", cxt.username);
 
-- 
1.7.6.4
