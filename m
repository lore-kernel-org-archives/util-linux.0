Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38879 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751176AbdGaTzT (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 15:55:19 -0400
Received: by mail-wr0-f195.google.com with SMTP id g32so15162907wrd.5
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 12:55:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/9] include: move pamfail.h to auth.c
Date: Mon, 31 Jul 2017 20:55:01 +0100
Message-Id: <20170731195508.11661-3-kerolasa@iki.fi>
In-Reply-To: <20170731195508.11661-1-kerolasa@iki.fi>
References: <20170731195508.11661-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This removes one small header file, and makes inline function to static to
only file it is used in.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/Makemodule.am |  1 -
 include/pamfail.h     | 26 --------------------------
 login-utils/auth.c    | 19 ++++++++++++++++++-
 3 files changed, 18 insertions(+), 28 deletions(-)
 delete mode 100644 include/pamfail.h

diff --git a/include/Makemodule.am b/include/Makemodule.am
index 237400b05..e9b1e3021 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -33,7 +33,6 @@ dist_noinst_HEADERS += \
 	include/nls.h \
 	include/optutils.h \
 	include/pager.h \
-	include/pamfail.h \
 	include/partx.h \
 	include/path.h \
 	include/pathnames.h \
diff --git a/include/pamfail.h b/include/pamfail.h
deleted file mode 100644
index bb83b9404..000000000
--- a/include/pamfail.h
+++ /dev/null
@@ -1,26 +0,0 @@
-/*
- * No copyright is claimed.  This code is in the public domain; do with
- * it what you wish.
- *
- * Written by Karel Zak <kzak@redhat.com>
- */
-#ifndef UTIL_LINUX_PAMFAIL_H
-#include <security/pam_appl.h>
-#ifdef HAVE_SECURITY_PAM_MISC_H
-# include <security/pam_misc.h>
-#elif defined(HAVE_SECURITY_OPENPAM_H)
-# include <security/openpam.h>
-#endif
-#include "c.h"
-
-static inline int
-pam_fail_check(pam_handle_t *pamh, int retcode)
-{
-	if (retcode == PAM_SUCCESS)
-		return 0;
-	warnx("%s", pam_strerror(pamh, retcode));
-	pam_end(pamh, retcode);
-	return 1;
-}
-
-#endif /* UTIL_LINUX_PAMFAIL_H */
diff --git a/login-utils/auth.c b/login-utils/auth.c
index 68d4ea3b0..efbd5e8cb 100644
--- a/login-utils/auth.c
+++ b/login-utils/auth.c
@@ -7,8 +7,25 @@
  *   there is no warranty.
  *
  */
+
+#include <security/pam_appl.h>
+#ifdef HAVE_SECURITY_PAM_MISC_H
+# include <security/pam_misc.h>
+#elif defined(HAVE_SECURITY_OPENPAM_H)
+# include <security/openpam.h>
+#endif
+
+#include "c.h"
 #include "ch-common.h"
-#include "pamfail.h"
+
+static int pam_fail_check(pam_handle_t *pamh, int retcode)
+{
+	if (retcode == PAM_SUCCESS)
+		return 0;
+	warnx("%s", pam_strerror(pamh, retcode));
+	pam_end(pamh, retcode);
+	return 1;
+}
 
 int auth_pam(const char *service_name, uid_t uid, const char *username)
 {
-- 
2.13.3

