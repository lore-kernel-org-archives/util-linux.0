Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:33189 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964951Ab2B1Qpo (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 28 Feb 2012 11:45:44 -0500
Received: by mail-vw0-f46.google.com with SMTP id ff1so1997660vbb.19
        for <util-linux@vger.kernel.org>; Tue, 28 Feb 2012 08:45:44 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 10/13] sulogin: use pathnames.h for file locations
Date: Tue, 28 Feb 2012 11:45:18 -0500
Message-Id: <1330447521-886-11-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
References: <1330447521-886-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This covers /etc/shadow and /etc/passwd. We don't have a define for
/bin/sh -- just replace the macro with the hardcoded string as done
elsewhere.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/sulogin.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 451bca4..17ad044 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -51,9 +51,7 @@
 #  include <selinux/get_context_list.h>
 #endif
 
-#define F_PASSWD	"/etc/passwd"
-#define F_SHADOW	"/etc/shadow"
-#define BINSH		"/bin/sh"
+#include "pathnames.h"
 
 static int timeout;
 static int profile;
@@ -214,8 +212,8 @@ static struct passwd *getrootpwent(int try_manually)
 	pwd.pw_uid = 0;
 	pwd.pw_gid = 0;
 
-	if ((fp = fopen(F_PASSWD, "r")) == NULL) {
-		perror(F_PASSWD);
+	if ((fp = fopen(_PATH_PASSWD, "r")) == NULL) {
+		perror(_PATH_PASSWD);
 		return &pwd;
 	}
 
@@ -242,7 +240,7 @@ static struct passwd *getrootpwent(int try_manually)
 	 *	or not found, return.
 	 */
 	if (p == NULL) {
-		fprintf(stderr, "%s: no entry for root\n", F_PASSWD);
+		fprintf(stderr, "%s: no entry for root\n", _PATH_PASSWD);
 		return &pwd;
 	}
 	if (valid(pwd.pw_passwd))
@@ -253,8 +251,8 @@ static struct passwd *getrootpwent(int try_manually)
 	 *	shadow password, try it.
 	 */
 	strcpy(pwd.pw_passwd, "");
-	if ((fp = fopen(F_SHADOW, "r")) == NULL) {
-		fprintf(stderr, "%s: root password garbled\n", F_PASSWD);
+	if ((fp = fopen(_PATH_SHADOW_PASSWD, "r")) == NULL) {
+		fprintf(stderr, "%s: root password garbled\n", _PATH_PASSWD);
 		return &pwd;
 	}
 	while ((p = fgets(sline, 256, fp)) != NULL) {
@@ -271,11 +269,11 @@ static struct passwd *getrootpwent(int try_manually)
 	 *	NULL it, and return.
 	 */
 	if (p == NULL) {
-		fprintf(stderr, "%s: no entry for root\n", F_SHADOW);
+		fprintf(stderr, "%s: no entry for root\n", _PATH_SHADOW_PASSWD);
 		strcpy(pwd.pw_passwd, "");
 	}
 	if (!valid(pwd.pw_passwd)) {
-		fprintf(stderr, "%s: root password garbled\n", F_SHADOW);
+		fprintf(stderr, "%s: root password garbled\n", _PATH_SHADOW_PASSWD);
 		strcpy(pwd.pw_passwd, "");
 	}
 	return &pwd;
@@ -352,7 +350,7 @@ static void sushell(struct passwd *pwd)
 		if (pwd->pw_shell[0])
 			sushell = pwd->pw_shell;
 		else
-			sushell = BINSH;
+			sushell = "/bin/sh";
 	}
 	if ((p = strrchr(sushell, '/')) == NULL)
 		p = sushell;
@@ -396,9 +394,9 @@ static void sushell(struct passwd *pwd)
 	execl(sushell, shell, NULL);
 	perror(sushell);
 
-	setenv("SHELL", BINSH, 1);
-	execl(BINSH, profile ? "-sh" : "sh", NULL);
-	perror(BINSH);
+	setenv("SHELL", "/bin/sh", 1);
+	execl("/bin/sh", profile ? "-sh" : "sh", NULL);
+	perror("/bin/sh");
 }
 
 static void usage(void)
-- 
1.7.9.2

