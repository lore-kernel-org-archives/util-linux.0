Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 34/49] login: host{name,address} initialization refactoring
Date: Mon, 17 Oct 2011 13:15:13 +0200
Message-Id: <1318850128-23458-35-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   83 ++++++++++++++++++++++++++------------------------
 1 files changed, 43 insertions(+), 40 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index fba8fdd..5f5313f 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1039,13 +1039,50 @@ static void init_environ(struct login_context *cxt)
 		putenv(env[i]);
 }
 
+/*
+ * Called for -h option, initialize cxt->{hostname,hostaddress}
+ */
+static void init_remote_info(struct login_context *cxt, char *remotehost)
+{
+	char host[MAXHOSTNAMELEN + 1];
+	char *domain = NULL, *p;
+	struct addrinfo hints, *info = NULL;
+
+	cxt->remote = 1;
+
+	if (gethostname(host, sizeof(host)) == 0)
+		domain = strchr(host, '.');
+
+	if (domain && (p = strchr(remotehost, '.')) && strcasecmp(p, domain) == 0)
+		*p = '\0';
+
+	cxt->hostname = xstrdup(remotehost);
+
+	memset(&hints, 0, sizeof(hints));
+	hints.ai_flags = AI_ADDRCONFIG;
+	cxt->hostaddress[0] = 0;
+
+	if (getaddrinfo(cxt->hostname, NULL, &hints, &info) == 0 && info) {
+		if (info->ai_family == AF_INET) {
+			struct sockaddr_in *sa =
+				    (struct sockaddr_in *) info->ai_addr;
+
+			memcpy(cxt->hostaddress, &(sa->sin_addr), sizeof(sa->sin_addr));
+
+		} else if (info->ai_family == AF_INET6) {
+			struct sockaddr_in6 *sa =
+				     (struct sockaddr_in6 *) info->ai_addr;
+
+			memcpy(cxt->hostaddress, &(sa->sin6_addr), sizeof(sa->sin6_addr));
+		}
+		freeaddrinfo(info);
+	}
+}
+
 int main(int argc, char **argv)
 {
 	int c;
-	char *p;
 	int cnt;
-	char *domain;
-	char tbuf[PATH_MAX + 2];
 	char *childArgv[10];
 	char *buff;
 	int childArgc = 0;
@@ -1078,9 +1115,6 @@ int main(int argc, char **argv)
 	 * -h is used by other servers to pass the name of the remote
 	 *    host to login so that it may be placed in utmp and wtmp
 	 */
-	gethostname(tbuf, sizeof(tbuf));
-	domain = strchr(tbuf, '.');
-
 	while ((c = getopt(argc, argv, "fh:p")) != -1)
 		switch (c) {
 		case 'f':
@@ -1093,40 +1127,7 @@ int main(int argc, char **argv)
 					_("login: -h for super-user only.\n"));
 				exit(EXIT_FAILURE);
 			}
-			cxt.remote = 1;
-			if (domain && (p = strchr(optarg, '.')) &&
-			    strcasecmp(p, domain) == 0)
-				*p = 0;
-
-			cxt.hostname = xstrdup(optarg);
-			{
-				struct addrinfo hints, *info = NULL;
-
-				memset(&hints, 0, sizeof(hints));
-				hints.ai_flags = AI_ADDRCONFIG;
-
-				cxt.hostaddress[0] = 0;
-
-				if (getaddrinfo(cxt.hostname, NULL, &hints, &info)
-				    == 0 && info) {
-					if (info->ai_family == AF_INET) {
-						struct sockaddr_in *sa =
-						    (struct sockaddr_in *)info->
-						    ai_addr;
-						memcpy(cxt.hostaddress,
-						       &(sa->sin_addr),
-						       sizeof(sa->sin_addr));
-					} else if (info->ai_family == AF_INET6) {
-						struct sockaddr_in6 *sa =
-						    (struct sockaddr_in6 *)
-						    info->ai_addr;
-						memcpy(cxt.hostaddress,
-						       &(sa->sin6_addr),
-						       sizeof(sa->sin6_addr));
-					}
-					freeaddrinfo(info);
-				}
-			}
+			init_remote_info(&cxt, optarg);
 			break;
 
 		case 'p':
@@ -1294,6 +1295,8 @@ int main(int argc, char **argv)
 		childArgv[childArgc++] = "-c";
 		childArgv[childArgc++] = buff;
 	} else {
+		char tbuf[PATH_MAX + 2], *p;
+
 		tbuf[0] = '-';
 		xstrncpy(tbuf + 1, ((p = strrchr(pwd->pw_shell, '/')) ?
 				    p + 1 : pwd->pw_shell), sizeof(tbuf) - 1);
-- 
1.7.6.4
