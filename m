Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews01.kpnxchange.com ([213.75.39.4]:50582 "EHLO
	cpsmtpb-ews01.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751558AbaF2PuP (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sun, 29 Jun 2014 11:50:15 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/7] textual: improve the columns information of lslogins
Date: Sun, 29 Jun 2014 17:49:40 +0200
Message-Id: <1404056983-10119-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
References: <1404056983-10119-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some fixes for typos, whitespace and wordings.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 login-utils/lslogins.c |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 09cded7..4ade02c 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -216,13 +216,13 @@ static struct lslogins_coldesc coldescs[] =
 {
 	[COL_USER]          = { "USER",		N_("user name"), N_("Username"), 0.1, SCOLS_FL_NOEXTREMES },
 	[COL_UID]           = { "UID",		N_("user ID"), "UID", 1, SCOLS_FL_RIGHT},
-	[COL_PWDEMPTY]      = { "PWD-EMPTY",	N_("password not requiured"), N_("Password no required"), 1, SCOLS_FL_RIGHT },
+	[COL_PWDEMPTY]      = { "PWD-EMPTY",	N_("password not required"), N_("Password not required"), 1, SCOLS_FL_RIGHT },
 	[COL_PWDDENY]       = { "PWD-DENY",	N_("login by password disabled"), N_("Login by password disabled"), 1, SCOLS_FL_RIGHT },
 	[COL_PWDLOCK]       = { "PWD-LOCK",	N_("password defined, but locked"), N_("Password is locked"), 1, SCOLS_FL_RIGHT },
 	[COL_NOLOGIN]       = { "NOLOGIN",	N_("log in disabled by nologin(8) or pam_nologin(8)"), N_("No login"), 1, SCOLS_FL_RIGHT },
-	[COL_GROUP]          = { "GROUP",	N_("primary group name"), N_("Primary group"), 0.1 },
-	[COL_GID]          = { "GID",		N_("primary group ID"), "GID", 1, SCOLS_FL_RIGHT },
-	[COL_SGROUPS]         = { "SUPP-GROUPS",	N_("supplementary group names"), N_("Supplementary groups"), 0.1 },
+	[COL_GROUP]         = { "GROUP",	N_("primary group name"), N_("Primary group"), 0.1 },
+	[COL_GID]           = { "GID",		N_("primary group ID"), "GID", 1, SCOLS_FL_RIGHT },
+	[COL_SGROUPS]       = { "SUPP-GROUPS",	N_("supplementary group names"), N_("Supplementary groups"), 0.1 },
 	[COL_SGIDS]         = { "SUPP-GIDS",    N_("supplementary group IDs"), N_("Supplementary group IDs"), 0.1 },
 	[COL_HOME]          = { "HOMEDIR",	N_("home directory"), N_("Home directory"), 0.1 },
 	[COL_SHELL]         = { "SHELL",	N_("login shell"), N_("Shell"), 0.1 },
@@ -236,10 +236,10 @@ static struct lslogins_coldesc coldescs[] =
 	[COL_PWD_WARN]      = { "PWD-WARN",	N_("days user is warned of password expiration"), N_("Password expiration warn interval"), 0.1, SCOLS_FL_RIGHT },
 	[COL_PWD_EXPIR]     = { "PWD-EXPIR",	N_("password expiration date"), N_("Password expiration"), 0.1, SCOLS_FL_RIGHT },
 	[COL_PWD_CTIME]     = { "PWD-CHANGE",	N_("date of last password change"), N_("Password changed"), 0.1, SCOLS_FL_RIGHT},
-	[COL_PWD_CTIME_MIN] = { "PWD-MIN",	N_("number of days required between changes"), N_("Minimal change time"), 0.1, SCOLS_FL_RIGHT },
-	[COL_PWD_CTIME_MAX] = { "PWD-MAX",	N_("max number of days a password may remain unchanged"), N_("Maximal change time"), 0.1, SCOLS_FL_RIGHT },
+	[COL_PWD_CTIME_MIN] = { "PWD-MIN",	N_("number of days required between changes"), N_("Minimum change time"), 0.1, SCOLS_FL_RIGHT },
+	[COL_PWD_CTIME_MAX] = { "PWD-MAX",	N_("max number of days a password may remain unchanged"), N_("Maximum change time"), 0.1, SCOLS_FL_RIGHT },
 	[COL_SELINUX]       = { "CONTEXT",	N_("the user's security context"), N_("Selinux context"), 0.1 },
-	[COL_NPROCS]        = { "PROC",         N_("number of processes run by the user"), N_("Running process"), 1, SCOLS_FL_RIGHT },
+	[COL_NPROCS]        = { "PROC",         N_("number of processes run by the user"), N_("Running processes"), 1, SCOLS_FL_RIGHT },
 };
 
 struct lslogins_control {
-- 
1.7.0.4

