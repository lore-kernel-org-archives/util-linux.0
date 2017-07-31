Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:37672 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751126AbdGaTzS (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 31 Jul 2017 15:55:18 -0400
Received: by mail-wm0-f65.google.com with SMTP id t138so83701wmt.4
        for <util-linux@vger.kernel.org>; Mon, 31 Jul 2017 12:55:17 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/9] chfn, chsh: merge auth.h, islocal.h and libuser.h to ch-common.h
Date: Mon, 31 Jul 2017 20:55:00 +0100
Message-Id: <20170731195508.11661-2-kerolasa@iki.fi>
In-Reply-To: <20170731195508.11661-1-kerolasa@iki.fi>
References: <20170731195508.11661-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Merging header files is fine.  Merging sources files ch-common.c is
bad idea due linking needs, and differences in licences.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/Makemodule.am |  7 ++-----
 login-utils/auth.c        |  2 +-
 login-utils/auth.h        | 13 -------------
 login-utils/ch-common.h   | 17 +++++++++++++++++
 login-utils/chfn.c        |  4 ----
 login-utils/chsh.c        |  4 ----
 login-utils/islocal.c     |  2 +-
 login-utils/islocal.h     |  1 -
 login-utils/libuser.c     |  3 +--
 login-utils/libuser.h     | 14 --------------
 10 files changed, 22 insertions(+), 45 deletions(-)
 delete mode 100644 login-utils/auth.h
 delete mode 100644 login-utils/islocal.h
 delete mode 100644 login-utils/libuser.h

diff --git a/login-utils/Makemodule.am b/login-utils/Makemodule.am
index 67a0c98ec..2cc91b658 100644
--- a/login-utils/Makemodule.am
+++ b/login-utils/Makemodule.am
@@ -90,20 +90,17 @@ if HAVE_LINUXPAM
 chfn_chsh_ldadd += -lpam_misc
 endif
 chfn_chsh_sources += \
-	login-utils/auth.c \
-	login-utils/auth.h
+	login-utils/auth.c
 endif # CHFN_CHSH_PASSWORD
 
 if HAVE_USER
 chfn_chsh_ldflags += $(LIBUSER_LIBS)
 chfn_chsh_cflags += $(LIBUSER_CFLAGS)
 chfn_chsh_sources+= \
-	login-utils/libuser.c \
-	login-utils/libuser.h
+	login-utils/libuser.c
 else
 chfn_chsh_sources += \
 	login-utils/islocal.c \
-	login-utils/islocal.h \
 	login-utils/setpwnam.c \
 	login-utils/setpwnam.h
 endif
diff --git a/login-utils/auth.c b/login-utils/auth.c
index aaf6c536b..68d4ea3b0 100644
--- a/login-utils/auth.c
+++ b/login-utils/auth.c
@@ -7,7 +7,7 @@
  *   there is no warranty.
  *
  */
-#include "auth.h"
+#include "ch-common.h"
 #include "pamfail.h"
 
 int auth_pam(const char *service_name, uid_t uid, const char *username)
diff --git a/login-utils/auth.h b/login-utils/auth.h
deleted file mode 100644
index bf7c36924..000000000
--- a/login-utils/auth.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/*
- *   auth.h -- PAM authorization code, common between chsh and chfn
- *   (c) 2012 by Cody Maloney <cmaloney@theoreticalchaos.com>
- *
- *   this program is free software.  you can redistribute it and
- *   modify it under the terms of the gnu general public license.
- *   there is no warranty.
- *
- */
-
-#include <sys/types.h>
-
-extern int auth_pam(const char *service_name, uid_t uid, const char *username);
diff --git a/login-utils/ch-common.h b/login-utils/ch-common.h
index 7f70e50e1..e2b402cc2 100644
--- a/login-utils/ch-common.h
+++ b/login-utils/ch-common.h
@@ -1,6 +1,23 @@
 #ifndef UTIL_LINUX_CH_COMMON_H
 #define UTIL_LINUX_CH_COMMON_H
 
+#include <sys/types.h>
+
 extern int illegal_passwd_chars(const char *str);
+extern int is_local(const char *user);
+
+/*
+ *   Utilize libuser to set a user attribute
+ *   (c) 2012 by Cody Maloney <cmaloney@theoreticalchaos.com>
+ */
+
+extern int set_value_libuser(const char *service_name, const char *username,
+                        uid_t uid, const char *attr, const char *val);
+
+/*
+ *   PAM authorization code, common between chsh and chfn
+ *   (c) 2012 by Cody Maloney <cmaloney@theoreticalchaos.com>
+ */
+extern int auth_pam(const char *service_name, uid_t uid, const char *username);
 
 #endif	/* UTIL_LINUX_CH_COMMON */
diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index c5312fa0c..d7d0d03f2 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -35,7 +35,6 @@
 #include "c.h"
 #include "env.h"
 #include "closestream.h"
-#include "islocal.h"
 #include "nls.h"
 #include "setpwnam.h"
 #include "strutils.h"
@@ -51,9 +50,6 @@
 
 #ifdef HAVE_LIBUSER
 # include <libuser/user.h>
-# include "libuser.h"
-#elif CHFN_CHSH_PASSWORD
-# include "auth.h"
 #endif
 
 #ifdef HAVE_LIBREADLINE
diff --git a/login-utils/chsh.c b/login-utils/chsh.c
index 4721c870e..cdbfbc405 100644
--- a/login-utils/chsh.c
+++ b/login-utils/chsh.c
@@ -35,7 +35,6 @@
 #include "c.h"
 #include "env.h"
 #include "closestream.h"
-#include "islocal.h"
 #include "nls.h"
 #include "pathnames.h"
 #include "setpwnam.h"
@@ -52,9 +51,6 @@
 
 #ifdef HAVE_LIBUSER
 # include <libuser/user.h>
-# include "libuser.h"
-#elif CHFN_CHSH_PASSWORD
-# include "auth.h"
 #endif
 
 #ifdef HAVE_LIBREADLINE
diff --git a/login-utils/islocal.c b/login-utils/islocal.c
index 7c4e775c1..5bfe61982 100644
--- a/login-utils/islocal.c
+++ b/login-utils/islocal.c
@@ -23,7 +23,7 @@
 #include <stdlib.h>
 
 #include "closestream.h"
-#include "islocal.h"
+#include "ch-common.h"
 #include "nls.h"
 #include "pathnames.h"
 
diff --git a/login-utils/islocal.h b/login-utils/islocal.h
deleted file mode 100644
index 2c5879906..000000000
--- a/login-utils/islocal.h
+++ /dev/null
@@ -1 +0,0 @@
-extern int is_local(const char *user);
diff --git a/login-utils/libuser.c b/login-utils/libuser.c
index b11fadc1c..65538d7d4 100644
--- a/login-utils/libuser.c
+++ b/login-utils/libuser.c
@@ -8,13 +8,12 @@
  *
  */
 
-#include "libuser.h"
+#include "ch-common.h"
 
 #include <grp.h>
 #include <libuser/user.h>
 #include <unistd.h>
 
-#include "auth.h"
 #include "c.h"
 #include "nls.h"
 
diff --git a/login-utils/libuser.h b/login-utils/libuser.h
deleted file mode 100644
index 7454b997e..000000000
--- a/login-utils/libuser.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/*
- *   libuser.h -- Utilize libuser to set a user attribute
- *   (c) 2012 by Cody Maloney <cmaloney@theoreticalchaos.com>
- *
- *   this program is free software.  you can redistribute it and
- *   modify it under the terms of the gnu general public license.
- *   there is no warranty.
- *
- */
-
-#include <sys/types.h>
-
-extern int set_value_libuser(const char *service_name, const char *username,
-			uid_t uid, const char *attr, const char *val);
-- 
2.13.3

