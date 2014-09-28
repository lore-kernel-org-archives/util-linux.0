Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f181.google.com ([74.125.82.181]:61448 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753442AbaI1TxL (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 28 Sep 2014 15:53:11 -0400
Received: by mail-we0-f181.google.com with SMTP id u57so415554wes.12
        for <util-linux@vger.kernel.org>; Sun, 28 Sep 2014 12:53:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 22/23] lslogins: use more narrow layout when initializing struct members
Date: Sun, 28 Sep 2014 20:51:55 +0100
Message-Id: <1411933916-30576-23-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
References: <1411933916-30576-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is more readable for normal size (24x80) terminals, and has
advantage to make each of the field members to be version controlled in
separate lines.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/lslogins.c | 210 +++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 170 insertions(+), 40 deletions(-)

diff --git a/login-utils/lslogins.c b/login-utils/lslogins.c
index 44c389e..4e62994 100644
--- a/login-utils/lslogins.c
+++ b/login-utils/lslogins.c
@@ -59,18 +59,6 @@
 #include "readutmp.h"
 #include "procutils.h"
 
-/*
- * column description
- */
-struct lslogins_coldesc {
-	const char *name;
-	const char *help;
-	const char *pretty_name;
-
-	double whint;	/* width hint */
-	long flag;
-};
-
 static int lslogins_flag;
 
 #define UL_UID_MIN 1000
@@ -212,34 +200,176 @@ static const char *const pretty_status[] = {
 
 #define get_status(x)	(outmode == OUT_PRETTY ? pretty_status[(x)] : status[(x)])
 
-static const struct lslogins_coldesc coldescs[] =
-{
-	[COL_USER]          = { "USER",		N_("user name"), N_("Username"), 0.1, SCOLS_FL_NOEXTREMES },
-	[COL_UID]           = { "UID",		N_("user ID"), "UID", 1, SCOLS_FL_RIGHT},
-	[COL_PWDEMPTY]      = { "PWD-EMPTY",	N_("password not required"), N_("Password not required"), 1, SCOLS_FL_RIGHT },
-	[COL_PWDDENY]       = { "PWD-DENY",	N_("login by password disabled"), N_("Login by password disabled"), 1, SCOLS_FL_RIGHT },
-	[COL_PWDLOCK]       = { "PWD-LOCK",	N_("password defined, but locked"), N_("Password is locked"), 1, SCOLS_FL_RIGHT },
-	[COL_NOLOGIN]       = { "NOLOGIN",	N_("log in disabled by nologin(8) or pam_nologin(8)"), N_("No login"), 1, SCOLS_FL_RIGHT },
-	[COL_GROUP]         = { "GROUP",	N_("primary group name"), N_("Primary group"), 0.1, SCOLS_FL_DEFAULT },
-	[COL_GID]           = { "GID",		N_("primary group ID"), "GID", 1, SCOLS_FL_RIGHT },
-	[COL_SGROUPS]       = { "SUPP-GROUPS",	N_("supplementary group names"), N_("Supplementary groups"), 0.1, SCOLS_FL_DEFAULT },
-	[COL_SGIDS]         = { "SUPP-GIDS",    N_("supplementary group IDs"), N_("Supplementary group IDs"), 0.1, SCOLS_FL_DEFAULT },
-	[COL_HOME]          = { "HOMEDIR",	N_("home directory"), N_("Home directory"), 0.1, SCOLS_FL_DEFAULT },
-	[COL_SHELL]         = { "SHELL",	N_("login shell"), N_("Shell"), 0.1, SCOLS_FL_DEFAULT },
-	[COL_GECOS]         = { "GECOS",	N_("full user name"), N_("Gecos field"), 0.1, SCOLS_FL_TRUNC },
-	[COL_LAST_LOGIN]    = { "LAST-LOGIN",	N_("date of last login"), N_("Last login"), 0.1, SCOLS_FL_RIGHT },
-	[COL_LAST_TTY]      = { "LAST-TTY",	N_("last tty used"), N_("Last terminal"), 0.05, SCOLS_FL_DEFAULT },
-	[COL_LAST_HOSTNAME] = { "LAST-HOSTNAME",N_("hostname during the last session"), N_("Last hostname"), 0.1, SCOLS_FL_DEFAULT},
-	[COL_FAILED_LOGIN]  = { "FAILED-LOGIN",	N_("date of last failed login"), N_("Failed login"), 0.1, SCOLS_FL_DEFAULT },
-	[COL_FAILED_TTY]    = { "FAILED-TTY",	N_("where did the login fail?"), N_("Failed login terminal"), 0.05, SCOLS_FL_DEFAULT },
-	[COL_HUSH_STATUS]   = { "HUSHED",	N_("user's hush settings"), N_("Hushed"), 1, SCOLS_FL_RIGHT },
-	[COL_PWD_WARN]      = { "PWD-WARN",	N_("days user is warned of password expiration"), N_("Password expiration warn interval"), 0.1, SCOLS_FL_RIGHT },
-	[COL_PWD_EXPIR]     = { "PWD-EXPIR",	N_("password expiration date"), N_("Password expiration"), 0.1, SCOLS_FL_RIGHT },
-	[COL_PWD_CTIME]     = { "PWD-CHANGE",	N_("date of last password change"), N_("Password changed"), 0.1, SCOLS_FL_RIGHT},
-	[COL_PWD_CTIME_MIN] = { "PWD-MIN",	N_("number of days required between changes"), N_("Minimum change time"), 0.1, SCOLS_FL_RIGHT },
-	[COL_PWD_CTIME_MAX] = { "PWD-MAX",	N_("max number of days a password may remain unchanged"), N_("Maximum change time"), 0.1, SCOLS_FL_RIGHT },
-	[COL_SELINUX]       = { "CONTEXT",	N_("the user's security context"), N_("Selinux context"), 0.1, SCOLS_FL_DEFAULT },
-	[COL_NPROCS]        = { "PROC",         N_("number of processes run by the user"), N_("Running processes"), 1, SCOLS_FL_RIGHT },
+/*
+ * column description
+ */
+struct lslogins_coldesc {
+	const char *name;
+	const char *help;
+	const char *pretty_name;
+
+	double whint;	/* width hint */
+	long flag;
+};
+
+static const struct lslogins_coldesc
+    coldescs[] = {
+	[COL_USER] =
+	    {"USER",
+	     N_("user name"),
+	     N_("Username"),
+	     0.1,
+	     SCOLS_FL_NOEXTREMES},
+	[COL_UID] =
+	    {"UID",
+	     N_("user ID"),
+	     "UID",
+	     1,
+	     SCOLS_FL_RIGHT},
+	[COL_PWDEMPTY] =
+	    {"PWD-EMPTY",
+	     N_("password not required"),
+	     N_("Password not required"),
+	     1,
+	     SCOLS_FL_RIGHT},
+	[COL_PWDDENY] =
+	    {"PWD-DENY",
+	     N_("login by password disabled"),
+	     N_("Login by password disabled"),
+	     1,
+	     SCOLS_FL_RIGHT},
+	[COL_PWDLOCK] =
+	    {"PWD-LOCK",
+	     N_("password defined, but locked"),
+	     N_("Password is locked"),
+	     1,
+	     SCOLS_FL_RIGHT},
+	[COL_NOLOGIN] =
+	    {"NOLOGIN",
+	     N_("log in disabled by nologin(8) or pam_nologin(8)"),
+	     N_("No login"),
+	     1,
+	     SCOLS_FL_RIGHT},
+	[COL_GROUP] =
+	    {"GROUP",
+	     N_("primary group name"),
+	     N_("Primary group"),
+	     0.1,
+	     SCOLS_FL_DEFAULT},
+	[COL_GID] =
+	    {"GID",
+	     N_("primary group ID"),
+	     "GID",
+	     1,
+	     SCOLS_FL_RIGHT},
+	[COL_SGROUPS] =
+	    {"SUPP-GROUPS",
+	     N_("supplementary group names"),
+	     N_("Supplementary groups"),
+	     0.1,
+	     SCOLS_FL_DEFAULT},
+	[COL_SGIDS] =
+	    {"SUPP-GIDS",
+	     N_("supplementary group IDs"),
+	     N_("Supplementary group IDs"),
+	     0.1,
+	     SCOLS_FL_DEFAULT},
+	[COL_HOME] =
+	    {"HOMEDIR",
+	     N_("home directory"),
+	     N_("Home directory"),
+	     0.1,
+	     SCOLS_FL_DEFAULT},
+	[COL_SHELL] =
+	    {"SHELL",
+	     N_("login shell"),
+	     N_("Shell"),
+	     0.1,
+	     SCOLS_FL_DEFAULT},
+	[COL_GECOS] =
+	    {"GECOS",
+	     N_("full user name"),
+	     N_("Gecos field"),
+	     0.1,
+	     SCOLS_FL_TRUNC},
+	[COL_LAST_LOGIN] =
+	    {"LAST-LOGIN",
+	     N_("date of last login"),
+	     N_("Last login"),
+	     0.1,
+	     SCOLS_FL_RIGHT},
+	[COL_LAST_TTY] =
+	    {"LAST-TTY",
+	     N_("last tty used"),
+	     N_("Last terminal"),
+	     0.05,
+	     SCOLS_FL_DEFAULT},
+	[COL_LAST_HOSTNAME] =
+	    {"LAST-HOSTNAME",
+	     N_("hostname during the last session"),
+	     N_("Last hostname"),
+	     0.1,
+	     SCOLS_FL_DEFAULT},
+	[COL_FAILED_LOGIN] =
+	    {"FAILED-LOGIN",
+	     N_("date of last failed login"),
+	     N_("Failed login"),
+	     0.1,
+	     SCOLS_FL_DEFAULT},
+	[COL_FAILED_TTY] =
+	    {"FAILED-TTY",
+	     N_("where did the login fail?"),
+	     N_("Failed login terminal"),
+	     0.05,
+	     SCOLS_FL_DEFAULT},
+	[COL_HUSH_STATUS] =
+	    {"HUSHED",
+	     N_("user's hush settings"),
+	     N_("Hushed"),
+	     1,
+	     SCOLS_FL_RIGHT},
+	[COL_PWD_WARN] =
+	    {"PWD-WARN",
+	     N_("days user is warned of password expiration"),
+	     N_("Password expiration warn interval"),
+	     0.1,
+	     SCOLS_FL_RIGHT},
+	[COL_PWD_EXPIR] =
+	    {"PWD-EXPIR",
+	     N_("password expiration date"),
+	     N_("Password expiration"),
+	     0.1,
+	     SCOLS_FL_RIGHT},
+	[COL_PWD_CTIME] =
+	    {"PWD-CHANGE",
+	     N_("date of last password change"),
+	     N_("Password changed"),
+	     0.1,
+	     SCOLS_FL_RIGHT},
+	[COL_PWD_CTIME_MIN] =
+	    {"PWD-MIN",
+	     N_("number of days required between changes"),
+	     N_("Minimum change time"),
+	     0.1,
+	     SCOLS_FL_RIGHT},
+	[COL_PWD_CTIME_MAX] =
+	    {"PWD-MAX",
+	     N_("max number of days a password may remain unchanged"),
+	     N_("Maximum change time"),
+	     0.1,
+	     SCOLS_FL_RIGHT},
+	[COL_SELINUX] =
+	    {"CONTEXT",
+	     N_("the user's security context"),
+	     N_("Selinux context"),
+	     0.1,
+	     SCOLS_FL_DEFAULT},
+	[COL_NPROCS] =
+	    {"PROC",
+	     N_("number of processes run by the user"),
+	     N_("Running processes"),
+	     1,
+	     SCOLS_FL_RIGHT},
 };
 
 struct lslogins_control {
-- 
2.1.1

