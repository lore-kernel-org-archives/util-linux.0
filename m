Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f48.google.com ([74.125.82.48]:36807 "EHLO
	mail-wg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754489AbaLVLrX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 22 Dec 2014 06:47:23 -0500
Received: by mail-wg0-f48.google.com with SMTP id y19so6418571wgg.21
        for <util-linux@vger.kernel.org>; Mon, 22 Dec 2014 03:47:22 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/14] chfn, chsh: share illegal_passwd_chars() function
Date: Mon, 22 Dec 2014 11:47:05 +0000
Message-Id: <1419248837-4619-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
References: <1419248837-4619-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/Makemodule.am |  4 +++-
 login-utils/ch-common.c   | 34 ++++++++++++++++++++++++++++++++++
 login-utils/ch-common.h   |  6 ++++++
 login-utils/chfn.c        | 16 +++++-----------
 login-utils/chsh.c        | 18 +++++-------------
 5 files changed, 53 insertions(+), 25 deletions(-)
 create mode 100644 login-utils/ch-common.c
 create mode 100644 login-utils/ch-common.h

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index e1f88c3..f9c0977 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -83,7 +83,9 @@ dist_man_MANS += \
 	login-utils/chfn.1 \
 	login-utils/chsh.1
 
-chfn_chsh_sources =
+chfn_chsh_sources = \
+	login-utils/ch-common.h \
+	login-utils/ch-common.c
 chfn_chsh_cflags = $(SUID_CFLAGS) $(AM_CFLAGS)
 chfn_chsh_ldflags = $(SUID_LDFLAGS) $(AM_LDFLAGS)
 chfn_chsh_ldadd = libcommon.la
diff --git a/login-utils/ch-common.c b/login-utils/ch-common.c
new file mode 100644
index 0000000..34b09f3
--- /dev/null
+++ b/login-utils/ch-common.c
@@ -0,0 +1,34 @@
+/*
+ * chfn and chsh shared functions
+ *
+ * this program is free software.  you can redistribute it and
+ * modify it under the terms of the gnu general public license.
+ * there is no warranty.
+ */
+
+#include <ctype.h>
+#include <string.h>
+
+#include "c.h"
+#include "nls.h"
+
+#include "ch-common.h"
+
+/*
+ *  illegal_passwd_chars () -
+ *	check whether a string contains illegal characters
+ */
+int illegal_passwd_chars(const char *str)
+{
+	const char illegal[] = ",:=\"\n";
+	const size_t len = strlen(str);
+	size_t i;
+
+	if (strpbrk(str, illegal))
+		return 1;
+	for (i = 0; i < len; i++) {
+		if (iscntrl(str[i]))
+			return 1;
+	}
+	return 0;
+}
diff --git a/login-utils/ch-common.h b/login-utils/ch-common.h
new file mode 100644
index 0000000..7f70e50
--- /dev/null
+++ b/login-utils/ch-common.h
@@ -0,0 +1,6 @@
+#ifndef UTIL_LINUX_CH_COMMON_H
+#define UTIL_LINUX_CH_COMMON_H
+
+extern int illegal_passwd_chars(const char *str);
+
+#endif	/* UTIL_LINUX_CH_COMMON */
diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 15f897c..2f1b70d 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -42,6 +42,8 @@
 #include "xalloc.h"
 #include "logindefs.h"
 
+#include "ch-common.h"
+
 #ifdef HAVE_LIBSELINUX
 # include <selinux/selinux.h>
 # include <selinux/av_permissions.h>
@@ -106,23 +108,15 @@ static void __attribute__((__noreturn__)) usage(FILE *fp)
  */
 static int check_gecos_string(const char *msg, char *gecos)
 {
-	unsigned int i, c;
 	const size_t len = strlen(gecos);
 
 	if (MAX_FIELD_SIZE < len) {
 		warnx(_("field %s is too long"), msg);
 		return -1;
 	}
-	for (i = 0; i < len; i++) {
-		c = gecos[i];
-		if (c == ',' || c == ':' || c == '=' || c == '"' || c == '\n') {
-			warnx(_("%s: '%c' is not allowed"), msg, c);
-			return -1;
-		}
-		if (iscntrl(c)) {
-			warnx(_("%s: control characters are not allowed"), msg);
-			return -1;
-		}
+	if (illegal_passwd_chars(gecos)) {
+		warnx(_("%s: has illegal characters"), gecos);
+		return -1;
 	}
 	return 0;
 }
diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 1327614..2245f41 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -42,6 +42,8 @@
 #include "setpwnam.h"
 #include "xalloc.h"
 
+#include "ch-common.h"
+
 #ifdef HAVE_LIBSELINUX
 # include <selinux/selinux.h>
 # include <selinux/av_permissions.h>
@@ -205,8 +207,6 @@ static char *prompt(char *question, char *def_val)
  */
 static int check_shell(char *shell)
 {
-	unsigned int i, c;
-
 	if (!shell)
 		return -1;
 
@@ -222,17 +222,9 @@ static int check_shell(char *shell)
 		printf(_("\"%s\" is not executable"), shell);
 		return -1;
 	}
-	/* keep /etc/passwd clean. */
-	for (i = 0; i < strlen(shell); i++) {
-		c = shell[i];
-		if (c == ',' || c == ':' || c == '=' || c == '"' || c == '\n') {
-			warnx(_("'%c' is not allowed"), c);
-			return -1;
-		}
-		if (iscntrl(c)) {
-			warnx(_("control characters are not allowed"));
-			return -1;
-		}
+	if (illegal_passwd_chars(shell)) {
+		warnx(_("%s: has illegal characters"), shell);
+		return -1;
 	}
 #ifdef ONLY_LISTED_SHELLS
 	if (!get_shell_list(shell)) {
-- 
2.2.1

