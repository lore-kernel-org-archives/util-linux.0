Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 47/49] login: add -H option for compatibility with Suse
Date: Mon, 17 Oct 2011 13:15:26 +0200
Message-Id: <1318850128-23458-48-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Note that our login(1) uses hostname without domain, so:

	"foo login: "

this is compatible with the default agetty(8) behavior.

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.1 |   10 +++++++-
 login-utils/login.c |   66 +++++++++++++++++++++++++++++++++++++++++++-------
 2 files changed, 65 insertions(+), 11 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 948177c..1f4aa69 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -11,6 +11,8 @@ login \- begin session on the system
 .BR \-h
 .IR host
 ] [
+.BR \-H
+] [
 .BR \-f
 .IR username
 |
@@ -113,7 +115,13 @@ necessary to create a proper PAM config files (e.g.
 and 
 .I /etc/pam.d/remote
 ).
-
+.TP
+.B \-H
+Used by other servers (i.e.,
+.BR telnetd (8))
+to tell
+.B login
+that printing the hostname should be suppressed in the login: prompt.
 
 .SH CONFIG FILE ITEMS
 .B login
diff --git a/login-utils/login.c b/login-utils/login.c
index 74f5736..2d9a847 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -106,13 +106,16 @@ struct login_context {
 	char		vcsan[VCS_PATH_MAX];
 #endif
 
-	char		*hostname;
-	char		hostaddress[16];
+	char		thishost[MAXHOSTNAMELEN + 1];	/* this machine */
+	char		*thisdomain;			/* this machine domain */
+	char		*hostname;			/* remote machine */
+	char		hostaddress[16];		/* remote address */
 
 	pid_t		pid;
 	int		quiet;		/* 1 is hush file exists */
 
 	unsigned int	remote:1,	/* login -h */
+			nohost:1,	/* login -H */
 			noauth:1,	/* login -f */
 			keep_env:1;	/* login -p */
 };
@@ -181,6 +184,25 @@ static void sleepexit(int eval)
 	exit(eval);
 }
 
+const char *get_thishost(struct login_context *cxt, const char **domain)
+{
+	if (!*cxt->thishost) {
+		if (gethostname(cxt->thishost, sizeof(cxt->thishost))) {
+			if (domain)
+				*domain = NULL;
+			return NULL;
+		}
+		cxt->thishost[sizeof(cxt->thishost) -1] = '\0';
+		cxt->thisdomain = strchr(cxt->thishost, '.');
+		if (cxt->thisdomain)
+			*cxt->thisdomain++ = '\0';
+	}
+
+	if (domain)
+		*domain = cxt->thisdomain;
+	return cxt->thishost;
+}
+
 /*
  * Output the /etc/motd file
  *
@@ -663,6 +685,26 @@ static int loginpam_err(pam_handle_t *pamh, int retcode)
 
 }
 
+/*
+ * Composes "<host> login: " string; or returns "login: " is -H is given
+ */
+static const char *loginpam_get_prompt(struct login_context *cxt)
+{
+	const char *host;
+	char *prompt, *dflt_prompt = _("login: ");
+	size_t sz;
+
+	if (cxt->nohost || !(host = get_thishost(cxt, NULL)))
+		return dflt_prompt;
+
+	sz = strlen(host) + 1 + strlen(dflt_prompt) + 1;
+
+	prompt = xmalloc(sz);
+	snprintf(prompt, sz, "%s %s", host, dflt_prompt);
+
+	return prompt;
+}
+
 static pam_handle_t *init_loginpam(struct login_context *cxt)
 {
 	pam_handle_t *pamh = NULL;
@@ -697,7 +739,7 @@ static pam_handle_t *init_loginpam(struct login_context *cxt)
 	 * the "login: " prompt gets localized. Unfortunately, PAM doesn't have
 	 * an interface to specify the "Password: " string (yet).
 	 */
-	rc = pam_set_item(pamh, PAM_USER_PROMPT, _("login: "));
+	rc = pam_set_item(pamh, PAM_USER_PROMPT, loginpam_get_prompt(cxt));
 	if (is_pam_failure(rc))
 		loginpam_err(pamh, rc);
 
@@ -1093,16 +1135,16 @@ static void init_environ(struct login_context *cxt)
  */
 static void init_remote_info(struct login_context *cxt, char *remotehost)
 {
-	char host[MAXHOSTNAMELEN + 1];
-	char *domain = NULL, *p;
+	const char *domain;
+	char *p;
 	struct addrinfo hints, *info = NULL;
 
 	cxt->remote = 1;
 
-	if (gethostname(host, sizeof(host)) == 0)
-		domain = strchr(host, '.');
+	get_thishost(cxt, &domain);
 
-	if (domain && (p = strchr(remotehost, '.')) && strcasecmp(p, domain) == 0)
+	if (domain && (p = strchr(remotehost, '.')) &&
+	    strcasecmp(p + 1, domain) == 0)
 		*p = '\0';
 
 	cxt->hostname = xstrdup(remotehost);
@@ -1167,12 +1209,16 @@ int main(int argc, char **argv)
 	 * -h is used by other servers to pass the name of the remote
 	 *    host to login so that it may be placed in utmp and wtmp
 	 */
-	while ((c = getopt(argc, argv, "fh:p")) != -1)
+	while ((c = getopt(argc, argv, "fHh:p")) != -1)
 		switch (c) {
 		case 'f':
 			cxt.noauth = 1;
 			break;
 
+		case 'H':
+			cxt.nohost = 1;
+			break;
+
 		case 'h':
 			if (getuid()) {
 				fprintf(stderr,
@@ -1188,7 +1234,7 @@ int main(int argc, char **argv)
 
 		case '?':
 		default:
-			fprintf(stderr, _("usage: login [-fp] [username]\n"));
+			fprintf(stderr, _("usage: login [ -p ] [ -h host ] [ -H ] [ -f username | username ]\n"));
 			exit(EXIT_FAILURE);
 		}
 	argc -= optind;
-- 
1.7.6.4
