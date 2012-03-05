Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f46.google.com ([74.125.83.46]:41695 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab2CETjW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:22 -0500
Received: by mail-ee0-f46.google.com with SMTP id c41so1625459eek.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:22 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/17] chsh: use pathnames.h for paths
Date: Mon,  5 Mar 2012 20:38:45 +0100
Message-Id: <1330976334-10751-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/pathnames.h |    1 +
 login-utils/chsh.c  |   22 +++++++++++-----------
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index 3547e8e..6c00d9f 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -68,6 +68,7 @@
 #define _PATH_SHADOW_GROUP      "/etc/gshadow"
 #define _PATH_SHADOW_GTMP       "/etc/sgtmp"
 #define _PATH_SHADOW_GTMPTMP    "/etc/sgtmptmp"
+#define _PATH_SHELLS		"/etc/shells"
 
 /* used in term-utils/agetty.c */
 #define _PATH_ISSUE		"/etc/issue"
diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 5481f7c..4f0615c 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -118,9 +118,9 @@ int main(int argc, char **argv)
 				     pw->pw_name);
 			}
 		}
-		if (setupDefaultContext("/etc/passwd") != 0)
+		if (setupDefaultContext(_PATH_PASSWD) != 0)
 			errx(EXIT_FAILURE,
-			     _("can't set default context for /etc/passwd"));
+			     _("can't set default context for %s"), _PATH_PASSWD);
 	}
 #endif
 
@@ -137,8 +137,8 @@ int main(int argc, char **argv)
 	}
 	if (uid != 0 && !get_shell_list(oldshell)) {
 		errno = EACCES;
-		err(EXIT_FAILURE, _("your shell is not in /etc/shells, "
-				    "shell change denied"));
+		err(EXIT_FAILURE, _("your shell is not in %s, "
+				    "shell change denied"), _PATH_SHELLS);
 	}
 
 	shell = info.shell;
@@ -316,18 +316,18 @@ static int check_shell(char *shell)
 	if (!get_shell_list(shell)) {
 		if (!getuid())
 			warnx(_
-			      ("Warning: \"%s\" is not listed in /etc/shells."),
-			      shell);
+			      ("Warning: \"%s\" is not listed in %s."),
+			      shell, _PATH_SHELLS);
 		else
 			errx(EXIT_FAILURE,
-			     _("\"%s\" is not listed in /etc/shells.\n"
-			       "Use %s -l to see list."), shell,
+			     _("\"%s\" is not listed in %s.\n"
+			       "Use %s -l to see list."), shell, _PATH_SHELLS,
 			     program_invocation_short_name);
 	}
 #else
 	if (!get_shell_list(shell)) {
-		warnx(_("\"%s\" is not listed in /etc/shells.\n"
-			"Use %s -l to see list."), shell,
+		warnx(_("\"%s\" is not listed in %s.\n"
+			"Use %s -l to see list."), shell, _PATH_SHELLS,
 		      program_invocation_short_name);
 	}
 #endif
@@ -347,7 +347,7 @@ static int get_shell_list(char *shell_name)
 	char buf[PATH_MAX];
 
 	found = false;
-	fp = fopen("/etc/shells", "r");
+	fp = fopen(_PATH_SHELLS, "r");
 	if (!fp) {
 		if (!shell_name)
 			warnx(_("No known shells."));
-- 
1.7.9.2

