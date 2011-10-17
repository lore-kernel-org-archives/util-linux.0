Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 30/49] login: use xalloc.h
Date: Mon, 17 Oct 2011 13:15:09 +0200
Message-Id: <1318850128-23458-31-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   17 +++++------------
 1 files changed, 5 insertions(+), 12 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index c875181..d87a632 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -515,7 +515,6 @@ static struct passwd *get_passwd_entry(const char *username,
 {
 	struct passwd *res = NULL;
 	size_t sz;
-	char *tmp;
 	int x;
 
 	if (!pwdbuf || !username)
@@ -527,13 +526,7 @@ static struct passwd *get_passwd_entry(const char *username,
 #endif
 		sz = 16384;
 
-	tmp = realloc(*pwdbuf, sz);
-	if (!tmp) {
-		free(*pwdbuf);
-		*pwdbuf = NULL;
-		return NULL;
-	}
-	*pwdbuf = tmp;
+	*pwdbuf = xrealloc(*pwdbuf, sz);
 
 	x = getpwnam_r(username, pwd, *pwdbuf, sz, &res);
 	if (!res) {
@@ -933,11 +926,11 @@ static void init_environ(struct login_context *cxt)
 	int len, i;
 
 	termenv = getenv("TERM");
-	termenv = termenv ? strdup(termenv) : "dumb";
+	termenv = termenv ? xstrdup(termenv) : "dumb";
 
 	/* destroy environment unless user has requested preservation (-p) */
 	if (!cxt->keep_env) {
-		environ = (char **) malloc(sizeof(char *));
+		environ = (char **) xmalloc(sizeof(char *));
 		memset(environ, 0, sizeof(char *));
 	}
 
@@ -1022,7 +1015,7 @@ int main(int argc, char **argv)
 			    strcasecmp(p, domain) == 0)
 				*p = 0;
 
-			cxt.hostname = strdup(optarg);
+			cxt.hostname = xstrdup(optarg);
 			{
 				struct addrinfo hints, *info = NULL;
 
@@ -1067,7 +1060,7 @@ int main(int argc, char **argv)
 
 	if (*argv) {
 		char *p = *argv;
-		cxt.username = strdup(p);
+		cxt.username = xstrdup(p);
 
 		/* wipe name - some people mistype their password here */
 		/* (of course we are too late, but perhaps this helps a little ..) */
-- 
1.7.6.4
