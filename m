Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38021 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222Ab2GYTPx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:15:53 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr14so1133220wib.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:15:53 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/19] sulogin: fix shadow declaration
Date: Wed, 25 Jul 2012 21:15:24 +0200
Message-Id: <1343243745-1172-7-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

login-utils/sulogin.c:337:8: warning: declaration of 'sushell' shadows a global declaration [-Wshadow]
login-utils/sulogin.c:332:13: warning: shadowed declaration is here [-Wshadow]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/sulogin.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/login-utils/sulogin.c b/login-utils/sulogin.c
index 7ac493b..d7d44b6 100644
--- a/login-utils/sulogin.c
+++ b/login-utils/sulogin.c
@@ -334,7 +334,7 @@ static void sushell(struct passwd *pwd)
 	char shell[PATH_MAX];
 	char home[PATH_MAX];
 	char *p;
-	char *sushell;
+	char *su_shell;
 
 	/*
 	 * Set directory and shell.
@@ -348,17 +348,17 @@ static void sushell(struct passwd *pwd)
 	}
 
 	if ((p = getenv("SUSHELL")) != NULL)
-		sushell = p;
+		su_shell = p;
 	else if ((p = getenv("sushell")) != NULL)
-		sushell = p;
+		su_shell = p;
 	else {
 		if (pwd->pw_shell[0])
-			sushell = pwd->pw_shell;
+			su_shell = pwd->pw_shell;
 		else
-			sushell = "/bin/sh";
+			su_shell = "/bin/sh";
 	}
-	if ((p = strrchr(sushell, '/')) == NULL)
-		p = sushell;
+	if ((p = strrchr(su_shell, '/')) == NULL)
+		p = su_shell;
 	else
 		p++;
 
@@ -378,7 +378,7 @@ static void sushell(struct passwd *pwd)
 	/*
 	 * Try to execute a shell.
 	 */
-	setenv("SHELL", sushell, 1);
+	setenv("SHELL", su_shell, 1);
 	unmask_signal(SIGINT, &saved_sigint);
 	unmask_signal(SIGTSTP, &saved_sigtstp);
 	unmask_signal(SIGQUIT, &saved_sigquit);
@@ -399,8 +399,8 @@ static void sushell(struct passwd *pwd)
 		free(level);
 	}
 #endif
-	execl(sushell, shell, NULL);
-	warn(_("%s: exec failed"), sushell);
+	execl(su_shell, shell, NULL);
+	warn(_("%s: exec failed"), su_shell);
 
 	setenv("SHELL", "/bin/sh", 1);
 	execl("/bin/sh", profile ? "-sh" : "sh", NULL);
-- 
1.7.11.3

