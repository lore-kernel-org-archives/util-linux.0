Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:62060 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757518Ab2CETje (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:34 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so1565217eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:33 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/17] pathnames: clean up various user database paths
Date: Mon,  5 Mar 2012 20:38:50 +0100
Message-Id: <1330976334-10751-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/pathnames.h            |   17 ++++-------------
 login-utils/setpwnam.h         |    2 +-
 tests/expected/paths/built-in  |    8 --------
 tests/helpers/test_pathnames.c |    8 --------
 4 files changed, 5 insertions(+), 30 deletions(-)

diff --git a/include/pathnames.h b/include/pathnames.h
index 6c00d9f..70c6ecf 100644
--- a/include/pathnames.h
+++ b/include/pathnames.h
@@ -51,23 +51,14 @@
 /* used in login-utils/shutdown.c */
 
 /* used in login-utils/setpwnam.h and login-utils/islocal.c */
-#define _PATH_PASSWD            "/etc/passwd"
+#define _PATH_PASSWD		"/etc/passwd"
 
-/* used in login-utils/newgrp */
+/* used in login-utils/newgrp and login-utils/setpwnam.h*/
 #define _PATH_GSHADOW		"/etc/gshadow"
 
 /* used in login-utils/setpwnam.h */
-#define _PATH_PTMP              "/etc/ptmp"
-#define _PATH_PTMPTMP           "/etc/ptmptmp"
-#define _PATH_GROUP             "/etc/group"
-#define _PATH_GTMP              "/etc/gtmp"
-#define _PATH_GTMPTMP           "/etc/gtmptmp"
-#define _PATH_SHADOW_PASSWD     "/etc/shadow"
-#define _PATH_SHADOW_PTMP       "/etc/sptmp"
-#define _PATH_SHADOW_PTMPTMP    "/etc/sptmptmp"
-#define _PATH_SHADOW_GROUP      "/etc/gshadow"
-#define _PATH_SHADOW_GTMP       "/etc/sgtmp"
-#define _PATH_SHADOW_GTMPTMP    "/etc/sgtmptmp"
+#define _PATH_GROUP		"/etc/group"
+#define _PATH_SHADOW_PASSWD	"/etc/shadow"
 #define _PATH_SHELLS		"/etc/shells"
 
 /* used in term-utils/agetty.c */
diff --git a/login-utils/setpwnam.h b/login-utils/setpwnam.h
index 6a4dbb7..7d69445 100644
--- a/login-utils/setpwnam.h
+++ b/login-utils/setpwnam.h
@@ -18,7 +18,7 @@
 # define PASSWD_FILE	_PATH_PASSWD
 # define GROUP_FILE	_PATH_GROUP
 # define SHADOW_FILE	_PATH_SHADOW_PASSWD
-# define SGROUP_FILE	_PATH_SHADOW_GROUP
+# define SGROUP_FILE	_PATH_GSHADOW
 #else
 # define PASSWD_FILE	"/tmp/passwd"
 # define GROUP_FILE	"/tmp/group"
diff --git a/tests/expected/paths/built-in b/tests/expected/paths/built-in
index 51372de..836eff5 100644
--- a/tests/expected/paths/built-in
+++ b/tests/expected/paths/built-in
@@ -19,17 +19,9 @@
         _PATH_UMOUNT /bin/umount
         _PATH_PASSWD /etc/passwd
        _PATH_GSHADOW /etc/gshadow
-          _PATH_PTMP /etc/ptmp
-       _PATH_PTMPTMP /etc/ptmptmp
          _PATH_GROUP /etc/group
-          _PATH_GTMP /etc/gtmp
-       _PATH_GTMPTMP /etc/gtmptmp
  _PATH_SHADOW_PASSWD /etc/shadow
-   _PATH_SHADOW_PTMP /etc/sptmp
-_PATH_SHADOW_PTMPTMP /etc/sptmptmp
   _PATH_SHADOW_GROUP /etc/gshadow
-   _PATH_SHADOW_GTMP /etc/sgtmp
-_PATH_SHADOW_GTMPTMP /etc/sgtmptmp
          _PATH_WORDS /usr/share/dict/words
      _PATH_WORDS_ALT /usr/share/dict/web2
         _PATH_UMOUNT /bin/umount
diff --git a/tests/helpers/test_pathnames.c b/tests/helpers/test_pathnames.c
index 0270938..962fe5a 100644
--- a/tests/helpers/test_pathnames.c
+++ b/tests/helpers/test_pathnames.c
@@ -52,17 +52,9 @@ struct hlpPath paths[] =
 	DEF_HLPPATH(_PATH_UMOUNT),
 	DEF_HLPPATH(_PATH_PASSWD),
 	DEF_HLPPATH(_PATH_GSHADOW),
-	DEF_HLPPATH(_PATH_PTMP),
-	DEF_HLPPATH(_PATH_PTMPTMP),
 	DEF_HLPPATH(_PATH_GROUP),
-	DEF_HLPPATH(_PATH_GTMP),
-	DEF_HLPPATH(_PATH_GTMPTMP),
 	DEF_HLPPATH(_PATH_SHADOW_PASSWD),
-	DEF_HLPPATH(_PATH_SHADOW_PTMP),
-	DEF_HLPPATH(_PATH_SHADOW_PTMPTMP),
 	DEF_HLPPATH(_PATH_SHADOW_GROUP),
-	DEF_HLPPATH(_PATH_SHADOW_GTMP),
-	DEF_HLPPATH(_PATH_SHADOW_GTMPTMP),
 	DEF_HLPPATH(_PATH_WORDS),
 	DEF_HLPPATH(_PATH_WORDS_ALT),
 	DEF_HLPPATH(_PATH_UMOUNT),
-- 
1.7.9.2

