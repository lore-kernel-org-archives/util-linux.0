Return-Path: util-linux-owner@vger.kernel.org
Received: from vostochny.stro.at ([78.47.22.85]:37129 "EHLO vostochny.stro.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751494Ab1GaKqj (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 31 Jul 2011 06:46:39 -0400
From: maximilian attems <max@stro.at>
To: util-linux@vger.kernel.org
Cc: maximilian attems <max@stro.at>
Subject: [PATCH 1/3] c.h: move up declaration of program_invocation_short_name before usage
Date: Sun, 31 Jul 2011 12:47:19 +0200
Message-Id: <1312109241-13590-1-git-send-email-max@stro.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

fixes:
../include/c.h: In function ‘errmsg’:
../include/c.h:111:26: error: ‘program_invocation_short_name’ undeclared
(first use in this function)
../include/c.h:111:26: note: each undeclared identifier is reported only
once for each function it appears in

Signed-off-by: maximilian attems <max@stro.at>
---
 include/c.h |   70 +++++++++++++++++++++++++++++-----------------------------
 1 files changed, 35 insertions(+), 35 deletions(-)

diff --git a/include/c.h b/include/c.h
index 70f403c..79581ae 100644
--- a/include/c.h
+++ b/include/c.h
@@ -103,6 +103,41 @@
 	_max1 > _max2 ? _max1 : _max2; })
 #endif
 
+#ifndef HAVE_PROGRAM_INVOCATION_SHORT_NAME
+# ifdef HAVE___PROGNAME
+extern char *__progname;
+#  define program_invocation_short_name __progname
+# else
+#  ifdef HAVE_GETEXECNAME
+#   include <stdlib.h>
+#   define program_invocation_short_name \
+		prog_inv_sh_nm_from_file(getexecname(), 0)
+#  else
+#   define program_invocation_short_name \
+		prog_inv_sh_nm_from_file(__FILE__, 1)
+#  endif
+static char prog_inv_sh_nm_buf[256];
+static inline char *
+prog_inv_sh_nm_from_file(char *f, char stripext)
+{
+	char *t;
+
+	if ((t = strrchr(f, '/')) != NULL)
+		t++;
+	else
+		t = f;
+
+	strncpy(prog_inv_sh_nm_buf, t, sizeof(prog_inv_sh_nm_buf) - 1);
+	prog_inv_sh_nm_buf[sizeof(prog_inv_sh_nm_buf) - 1] = '\0';
+
+	if (stripext && (t = strrchr(prog_inv_sh_nm_buf, '.')) != NULL)
+		*t = '\0';
+
+	return prog_inv_sh_nm_buf;
+}
+# endif
+#endif
+
 
 #ifndef HAVE_ERR_H
 static inline void
@@ -160,41 +195,6 @@ static inline int dirfd(DIR *d)
 }
 #endif
 
-#ifndef HAVE_PROGRAM_INVOCATION_SHORT_NAME
-# ifdef HAVE___PROGNAME
-extern char *__progname;
-#  define program_invocation_short_name __progname
-# else
-#  ifdef HAVE_GETEXECNAME
-#   include <stdlib.h>
-#   define program_invocation_short_name \
-		prog_inv_sh_nm_from_file(getexecname(), 0)
-#  else
-#   define program_invocation_short_name \
-		prog_inv_sh_nm_from_file(__FILE__, 1)
-#  endif
-static char prog_inv_sh_nm_buf[256];
-static inline char *
-prog_inv_sh_nm_from_file(char *f, char stripext)
-{
-	char *t;
-
-	if ((t = strrchr(f, '/')) != NULL)
-		t++;
-	else
-		t = f;
-
-	strncpy(prog_inv_sh_nm_buf, t, sizeof(prog_inv_sh_nm_buf) - 1);
-	prog_inv_sh_nm_buf[sizeof(prog_inv_sh_nm_buf) - 1] = '\0';
-
-	if (stripext && (t = strrchr(prog_inv_sh_nm_buf, '.')) != NULL)
-		*t = '\0';
-
-	return prog_inv_sh_nm_buf;
-}
-# endif
-#endif
-
 /*
  * Fallback defines for old versions of glibc
  */
-- 
1.7.5.4

