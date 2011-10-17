Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 08/49] login: cleanup begin of the login.c file
Date: Mon, 17 Oct 2011 13:14:47 +0200
Message-Id: <1318850128-23458-9-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 login-utils/login.c |   27 ++++++++++-----------------
 1 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/login-utils/login.c b/login-utils/login.c
index 8ef12af..1bbcddd 100644
--- a/login-utils/login.c
+++ b/login-utils/login.c
@@ -49,6 +49,7 @@
 #include <sys/sysmacros.h>
 #include <linux/major.h>
 #include <netdb.h>
+#include <lastlog.h>
 #include <security/pam_appl.h>
 #include <security/pam_misc.h>
 #ifdef HAVE_LIBAUDIT
@@ -58,32 +59,19 @@
 #include <crypt.h>
 #endif
 
+#include "c.h"
+#include "setproctitle.h"
 #include "pathnames.h"
 #include "login.h"
 #include "strutils.h"
 #include "nls.h"
 #include "xalloc.h"
-#include "c.h"
 
 #define PAM_MAX_LOGIN_TRIES	3
 #define is_pam_failure(_rc)	((_rc) != PAM_SUCCESS)
 
-#include <lastlog.h>
-
 #define SLEEP_EXIT_TIMEOUT 5
 
-#include "setproctitle.h"
-
-#ifndef HAVE_SECURITY_PAM_MISC_H
-static void getloginname (void);
-static void checknologin (void);
-static int rootterm (char *ttyn);
-#endif
-static void timedout (int);
-static void sigint (int);
-static void motd (void);
-static void dolastlog (int quiet);
-
 #ifdef USE_TTY_GROUP
 #  define TTY_MODE 0620
 #else
@@ -100,12 +88,12 @@ static void dolastlog (int quiet);
  * This bounds the time given to login.  Not a define so it can
  * be patched on machines where it's too small.
  */
-int     timeout = 60;
+int timeout = 60;
 
 struct passwd *pwd;
 
 static struct passwd pwdcopy;
-char    hostaddress[16];	/* used in checktty.c */
+char hostaddress[16];	/* used in checktty.c */
 sa_family_t hostfamily;		/* used in checktty.c */
 char	*hostname;		/* idem */
 static char	*username, *tty_name, *tty_number;
@@ -113,6 +101,11 @@ static char	thishost[100];
 static int	failures = 1;
 static pid_t	pid;
 
+static void timedout (int);
+static void sigint (int);
+static void motd (void);
+static void dolastlog (int quiet);
+
 /* Nice and simple code provided by Linus Torvalds 16-Feb-93 */
 /* Nonblocking stuff by Maciej W. Rozycki, macro@ds2.pg.gda.pl, 1999.
    He writes: "Login performs open() on a tty in a blocking mode.
-- 
1.7.6.4
