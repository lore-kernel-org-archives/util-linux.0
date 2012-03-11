Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-yw0-f46.google.com ([209.85.213.46]:61793 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752404Ab2CKEyS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 10 Mar 2012 23:54:18 -0500
Received: by yhmm54 with SMTP id m54so1748318yhm.19
        for <util-linux@vger.kernel.org>; Sat, 10 Mar 2012 20:54:18 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] login: add USER to initial environment
Date: Sat, 10 Mar 2012 23:54:14 -0500
Message-Id: <1331441654-27958-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add this value from the passwd struct to the environment, as it is
expected by shells, and generally useful to users.

This also clarifies a poorly worded sentence in the vicinity of the
manpage change.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 login-utils/login.1 |    5 +++--
 login-utils/login.c |    1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/login-utils/login.1 b/login-utils/login.1
index 26cd951..cb80241 100644
--- a/login-utils/login.1
+++ b/login-utils/login.1
@@ -40,10 +40,11 @@ for more information.
 The user and group ID will be set according to their values in the
 .I /etc/passwd
 file. There is one exception if the user ID is zero: in this case,
-only the primary group ID of the account is set. This should prevent
-that the system adminitrator cannot login in case of network problems.
+only the primary group ID of the account is set. This should allow
+the system adminitrator to login even in case of network problems.
 The value for
 .BR $HOME ,
+.BR $USER ,
 .BR $SHELL ,
 .BR $PATH ,
 .BR $LOGNAME ,
diff --git a/login-utils/login.c b/login-utils/login.c
index 4f448f8..6c3b6f7 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -1142,6 +1142,7 @@ static void init_environ(struct login_context *cxt)
 	}
 
 	setenv("HOME", pwd->pw_dir, 0);	/* legal to override */
+	setenv("USER", pwd->pw_name, 1);
 	setenv("SHELL", pwd->pw_shell, 1);
 	setenv("TERM", termenv, 1);
 
-- 
1.7.9.3

