Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f43.google.com ([74.125.82.43]:41784 "EHLO
	mail-wg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752102AbaLNRpW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 14 Dec 2014 12:45:22 -0500
Received: by mail-wg0-f43.google.com with SMTP id l18so12961413wgh.2
        for <util-linux@vger.kernel.org>; Sun, 14 Dec 2014 09:45:21 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 07/16] lslogins: use hardcoded paths from pathnames.h
Date: Sun, 14 Dec 2014 17:44:03 +0000
Message-Id: <1418579052-29386-8-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
References: <1418579052-29386-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/pathnames.h    | 1 +
 login-utils/lslogins.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index 1cc4e15..0d21b98 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -38,6 +38,7 @@
 #endif
 #define	_PATH_MOTDFILE		"/etc/motd"
 #define	_PATH_NOLOGIN		"/etc/nologin"
+#define	_PATH_VAR_NOLOGIN	"/var/run/nologin"
 
 #define _PATH_LOGIN		"/bin/login"
 #define _PATH_INITTAB		"/etc/inittab"
diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 14a0749..85ae8f5 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -688,8 +688,8 @@ static struct lslogins_user *get_user_info(struct lslogins_control *ctl, const c
 			if (strstr(pwd->pw_shell, "nologin"))
 				user->nologin = 1;
 			else if (pwd->pw_uid)
-				user->nologin = access("/etc/nologin", F_OK) == 0 ||
-						access("/var/run/nologin", F_OK) == 0;
+				user->nologin = access(_PATH_NOLOGIN, F_OK) == 0 ||
+						access(_PATH_VAR_NOLOGIN, F_OK) == 0;
 			break;
 		case COL_PWD_WARN:
 			if (shadow && shadow->sp_warn >= 0)
-- 
2.1.3

