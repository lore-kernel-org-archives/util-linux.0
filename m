Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:33928 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S939062AbdAEWdo (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 5 Jan 2017 17:33:44 -0500
Received: by mail-wm0-f67.google.com with SMTP id c85so843022wmi.1
        for <util-linux@vger.kernel.org>; Thu, 05 Jan 2017 14:33:44 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] newgrp: use libc explicit_bzero() when it is available
Date: Thu,  5 Jan 2017 22:33:40 +0000
Message-Id: <20170105223340.2721-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This currently new function will be part of glibc 2.25.

Reference: https://sourceware.org/git/?p=glibc.git;a=commit;h=ea1bd74defcf9d5291d14972e63105168ca9eb4f
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 configure.ac         | 1 +
 login-utils/newgrp.c | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/configure.ac b/configure.ac
index 796364f71..c50f07a47 100644
--- a/configure.ac
+++ b/configure.ac
@@ -379,6 +379,7 @@ AC_CHECK_FUNCS([ \
 	__secure_getenv \
 	err \
 	errx \
+	explicit_bzero \
 	fsync \
 	utimensat \
 	getdomainname \
diff --git a/login-utils/newgrp.c b/login-utils/newgrp.c
index 367333ec3..63a45cd6a 100644
--- a/login-utils/newgrp.c
+++ b/login-utils/newgrp.c
@@ -60,6 +60,7 @@ static char *xgetpass(FILE *input, const char *prompt)
 	return pass;
 }
 
+#ifndef HAVE_EXPLICIT_BZERO
 /* Ensure memory is set to value c without compiler optimization getting
  * into way that could happen with memset(3). */
 static int xmemset_s(void *v, size_t sz, const int c)
@@ -72,6 +73,7 @@ static int xmemset_s(void *v, size_t sz, const int c)
 		*p++ = c;
 	return 0;
 }
+#endif
 
 /* try to read password from gshadow */
 static char *get_gshadow_pwd(const char *groupname)
@@ -148,7 +150,11 @@ static int allow_setgid(const struct passwd *pe, const struct group *ge)
 	if (pwd && *pwd && (xpwd = xgetpass(stdin, _("Password: ")))) {
 		char *cbuf = crypt(xpwd, pwd);
 
+#ifdef HAVE_EXPLICIT_BZERO
+		explicit_bzero(xpwd, strlen(xpwd));
+#else
 		xmemset_s(xpwd, strlen(xpwd), 0);
+#endif
 		free(xpwd);
 		if (!cbuf)
 			warn(_("crypt failed"));
-- 
2.11.0

