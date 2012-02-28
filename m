Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:48599 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753524Ab2B1Qpt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:49 -0500
Received: by mail-vx0-f174.google.com with SMTP id p1so2644946vcq.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:49 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 13/13] sulogin: add i18n strings
Date: Tue, 28 Feb 2012 11:45:21 -0500
Message-Id: <1330447521-886-14-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.c |   26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 6cb075c..bed1fd3 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -241,7 +241,7 @@ static struct passwd *getrootpwent(int try_manually)
 	 *	or not found, return.
 	 */
 	if (p == NULL) {
-		fprintf(stderr, "%s: no entry for root\n", _PATH_PASSWD);
+		fprintf(stderr, _("%s: no entry for root\n"), _PATH_PASSWD);
 		return &pwd;
 	}
 	if (valid(pwd.pw_passwd))
@@ -253,7 +253,7 @@ static struct passwd *getrootpwent(int try_manually)
 	 */
 	strcpy(pwd.pw_passwd, "");
 	if ((fp = fopen(_PATH_SHADOW_PASSWD, "r")) == NULL) {
-		fprintf(stderr, "%s: root password garbled\n", _PATH_PASSWD);
+		fprintf(stderr, _("%s: root password garbled\n"), _PATH_PASSWD);
 		return &pwd;
 	}
 	while ((p = fgets(sline, 256, fp)) != NULL) {
@@ -270,11 +270,11 @@ static struct passwd *getrootpwent(int try_manually)
 	 *	NULL it, and return.
 	 */
 	if (p == NULL) {
-		fprintf(stderr, "%s: no entry for root\n", _PATH_SHADOW_PASSWD);
+		fprintf(stderr, _("%s: no entry for root\n"), _PATH_SHADOW_PASSWD);
 		strcpy(pwd.pw_passwd, "");
 	}
 	if (!valid(pwd.pw_passwd)) {
-		fprintf(stderr, "%s: root password garbled\n", _PATH_SHADOW_PASSWD);
+		fprintf(stderr, _("%s: root password garbled\n"), _PATH_SHADOW_PASSWD);
 		strcpy(pwd.pw_passwd, "");
 	}
 	return &pwd;
@@ -293,10 +293,10 @@ static char *getpasswd(char *crypted)
 	size_t i;
 
 	if (crypted[0])
-		printf("Give root password for maintenance\n");
+		printf(_("Give root password for maintenance\n"));
 	else
-		printf("Press enter for maintenance");
-	printf("(or type Control-D to continue): ");
+		printf(_("Press enter for maintenance"));
+	printf(_("(or type Control-D to continue): "));
 	fflush(stdout);
 
 	tcgetattr(0, &old);
@@ -384,7 +384,7 @@ static void sushell(struct passwd *pwd)
 		if (getseuserbyname("root", &seuser, &level) == 0) {
 			if (get_default_context_with_level(seuser, level, 0, &scon) == 0) {
 				if (setexeccon(scon) != 0)
-					fprintf(stderr, "setexeccon failed\n");
+					fprintf(stderr, _("setexeccon failed\n"));
 				freecon(scon);
 			}
 		}
@@ -409,7 +409,7 @@ static void usage(FILE *out)
 	fprintf(out, USAGE_OPTIONS);
 	fprintf(out, _(
 			" -p        start a login shell\n"
-			" -t SEC    set max time to wait for a password (default: no limit)\n"
+			" -t SEC    max time to wait for a password (default: no limit)\n"
 			" -e        examine shadow files directly if getpwnam(3) fails\n"
 			" -h        display this help message\n"));
 
@@ -452,7 +452,8 @@ int main(int argc, char **argv)
 	}
 
 	if (geteuid() != 0) {
-		fprintf(stderr, "sulogin: only root can run sulogin.\n");
+		fprintf(stderr, _("%s: only root can run this program.\n"),
+				program_invocation_short_name);
 		exit(1);
 	}
 
@@ -528,7 +529,8 @@ int main(int argc, char **argv)
 	 *	Get the root password.
 	 */
 	if ((pwd = getrootpwent(opt_e)) == NULL) {
-		fprintf(stderr, "sulogin: cannot open password database!\n");
+		fprintf(stderr, _("%s: cannot open password database.\n"),
+				program_invocation_short_name);
 		sleep(2);
 	}
 
@@ -544,7 +546,7 @@ int main(int argc, char **argv)
 		mask_signal(SIGQUIT, SIG_IGN, &saved_sigquit);
 		mask_signal(SIGTSTP, SIG_IGN, &saved_sigtstp);
 		mask_signal(SIGINT,  SIG_IGN, &saved_sigint);
-		printf("Login incorrect.\n");
+		printf(_("Login incorrect\n"));
 	}
 
 	/*
-- 
1.7.9.2

