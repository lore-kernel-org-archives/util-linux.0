Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f182.google.com ([209.85.212.182]:50881 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbaI1TxJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:53:09 -0400
Received: by mail-wi0-f182.google.com with SMTP id ex7so316774wid.15
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:53:08 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 21/23] lslogins: add missing initializers to struct lslogins_coldesc
Date: Sun, 28 Sep 2014 20:51:54 +0100
Message-Id: <1411933916-30576-22-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 1e0eb5a..44c389e 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -220,25 +220,25 @@ static const struct lslogins_coldesc coldescs[] =
 	[COL_PWDDENY]       = { "PWD-DENY",	N_("login by password disabled"), N_("Login by password disabled"), 1, SCOLS_FL_RIGHT },
 	[COL_PWDLOCK]       = { "PWD-LOCK",	N_("password defined, but locked"), N_("Password is locked"), 1, SCOLS_FL_RIGHT },
 	[COL_NOLOGIN]       = { "NOLOGIN",	N_("log in disabled by nologin(8) or pam_nologin(8)"), N_("No login"), 1, SCOLS_FL_RIGHT },
-	[COL_GROUP]         = { "GROUP",	N_("primary group name"), N_("Primary group"), 0.1 },
+	[COL_GROUP]         = { "GROUP",	N_("primary group name"), N_("Primary group"), 0.1, SCOLS_FL_DEFAULT },
 	[COL_GID]           = { "GID",		N_("primary group ID"), "GID", 1, SCOLS_FL_RIGHT },
-	[COL_SGROUPS]       = { "SUPP-GROUPS",	N_("supplementary group names"), N_("Supplementary groups"), 0.1 },
-	[COL_SGIDS]         = { "SUPP-GIDS",    N_("supplementary group IDs"), N_("Supplementary group IDs"), 0.1 },
-	[COL_HOME]          = { "HOMEDIR",	N_("home directory"), N_("Home directory"), 0.1 },
-	[COL_SHELL]         = { "SHELL",	N_("login shell"), N_("Shell"), 0.1 },
+	[COL_SGROUPS]       = { "SUPP-GROUPS",	N_("supplementary group names"), N_("Supplementary groups"), 0.1, SCOLS_FL_DEFAULT },
+	[COL_SGIDS]         = { "SUPP-GIDS",    N_("supplementary group IDs"), N_("Supplementary group IDs"), 0.1, SCOLS_FL_DEFAULT },
+	[COL_HOME]          = { "HOMEDIR",	N_("home directory"), N_("Home directory"), 0.1, SCOLS_FL_DEFAULT },
+	[COL_SHELL]         = { "SHELL",	N_("login shell"), N_("Shell"), 0.1, SCOLS_FL_DEFAULT },
 	[COL_GECOS]         = { "GECOS",	N_("full user name"), N_("Gecos field"), 0.1, SCOLS_FL_TRUNC },
 	[COL_LAST_LOGIN]    = { "LAST-LOGIN",	N_("date of last login"), N_("Last login"), 0.1, SCOLS_FL_RIGHT },
-	[COL_LAST_TTY]      = { "LAST-TTY",	N_("last tty used"), N_("Last terminal"), 0.05 },
-	[COL_LAST_HOSTNAME] = { "LAST-HOSTNAME",N_("hostname during the last session"), N_("Last hostname"),  0.1},
-	[COL_FAILED_LOGIN]  = { "FAILED-LOGIN",	N_("date of last failed login"), N_("Failed login"), 0.1 },
-	[COL_FAILED_TTY]    = { "FAILED-TTY",	N_("where did the login fail?"), N_("Failed login terminal"), 0.05 },
+	[COL_LAST_TTY]      = { "LAST-TTY",	N_("last tty used"), N_("Last terminal"), 0.05, SCOLS_FL_DEFAULT },
+	[COL_LAST_HOSTNAME] = { "LAST-HOSTNAME",N_("hostname during the last session"), N_("Last hostname"), 0.1, SCOLS_FL_DEFAULT},
+	[COL_FAILED_LOGIN]  = { "FAILED-LOGIN",	N_("date of last failed login"), N_("Failed login"), 0.1, SCOLS_FL_DEFAULT },
+	[COL_FAILED_TTY]    = { "FAILED-TTY",	N_("where did the login fail?"), N_("Failed login terminal"), 0.05, SCOLS_FL_DEFAULT },
 	[COL_HUSH_STATUS]   = { "HUSHED",	N_("user's hush settings"), N_("Hushed"), 1, SCOLS_FL_RIGHT },
 	[COL_PWD_WARN]      = { "PWD-WARN",	N_("days user is warned of password expiration"), N_("Password expiration warn interval"), 0.1, SCOLS_FL_RIGHT },
 	[COL_PWD_EXPIR]     = { "PWD-EXPIR",	N_("password expiration date"), N_("Password expiration"), 0.1, SCOLS_FL_RIGHT },
 	[COL_PWD_CTIME]     = { "PWD-CHANGE",	N_("date of last password change"), N_("Password changed"), 0.1, SCOLS_FL_RIGHT},
 	[COL_PWD_CTIME_MIN] = { "PWD-MIN",	N_("number of days required between changes"), N_("Minimum change time"), 0.1, SCOLS_FL_RIGHT },
 	[COL_PWD_CTIME_MAX] = { "PWD-MAX",	N_("max number of days a password may remain unchanged"), N_("Maximum change time"), 0.1, SCOLS_FL_RIGHT },
-	[COL_SELINUX]       = { "CONTEXT",	N_("the user's security context"), N_("Selinux context"), 0.1 },
+	[COL_SELINUX]       = { "CONTEXT",	N_("the user's security context"), N_("Selinux context"), 0.1, SCOLS_FL_DEFAULT },
 	[COL_NPROCS]        = { "PROC",         N_("number of processes run by the user"), N_("Running processes"), 1, SCOLS_FL_RIGHT },
 };
 
-- 
2.1.1

