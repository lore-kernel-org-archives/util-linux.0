Return-Path: kzak@redhat.com
From: Karel Zak <kzak@redhat.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>
Subject: [PATCH 07/49] lib: cleanup setproctitle.c
Date: Mon, 17 Oct 2011 13:14:46 +0200
Message-Id: <1318850128-23458-8-git-send-email-kzak@redhat.com>
In-Reply-To: <1318850128-23458-1-git-send-email-kzak@redhat.com>
References: <20111017110210.GA22648@nb.net.home>
 <1318850128-23458-1-git-send-email-kzak@redhat.com>
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Karel Zak <kzak@redhat.com>
---
 include/setproctitle.h |   10 +++---
 lib/setproctitle.c     |   75 +++++++++++++-----------------------------------
 2 files changed, 25 insertions(+), 60 deletions(-)

diff --git a/include/setproctitle.h b/include/setproctitle.h
index d57abda..70a9efa 100644
--- a/include/setproctitle.h
+++ b/include/setproctitle.h
@@ -1,7 +1,7 @@
+#ifndef UTIL_LINUX_SETPROCTITLE_H
+#define UTIL_LINUX_SETPROCTITLE_H
+
+extern void initproctitle (int argc, char **argv);
+extern void setproctitle (const char *prog, const char *txt);
 
-void initproctitle (int argc, char **argv);
-#if 0
-void setproctitle (const char *fmt, ...);
-#else
-void setproctitle (const char *prog, const char *txt);
 #endif
diff --git a/lib/setproctitle.c b/lib/setproctitle.c
index 319bc6a..4bcf8c8 100644
--- a/lib/setproctitle.c
+++ b/lib/setproctitle.c
@@ -1,36 +1,26 @@
-/* proctitle code - we know this to work only on linux... */
-
 /*
-**  SETPROCTITLE -- set process title for ps (from sendmail)
-**
-**      Parameters:
-**              fmt -- a printf style format string.
-**
-**      Returns:
-**              none.
-**
-**      Side Effects:
-**              Clobbers argv of our main procedure so ps(1) will
-**              display the title.
-*/
-
+ *  set process title for ps (from sendmail)
+ *
+ *  Clobbers argv of our main procedure so ps(1) will display the title.
+ */
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
 #include <stdarg.h>
+
 #include "setproctitle.h"
 
 #ifndef SPT_BUFSIZE
-#define SPT_BUFSIZE     2048
+# define SPT_BUFSIZE     2048
 #endif
 
-extern char** environ;
+extern char **environ;
 
-static char** argv0;
+static char **argv0;
 static int argv_lth;
 
-void
-initproctitle (int argc, char **argv) {
+void initproctitle (int argc, char **argv)
+{
 	int i;
 	char **envp = environ;
 
@@ -42,9 +32,11 @@ initproctitle (int argc, char **argv) {
 	 */
 	for (i = 0; envp[i] != NULL; i++)
 		continue;
+
 	environ = (char **) malloc(sizeof(char *) * (i + 1));
 	if (environ == NULL)
 		return;
+
 	for (i = 0; envp[i] != NULL; i++)
 		if ((environ[i] = strdup(envp[i])) == NULL)
 			return;
@@ -55,38 +47,12 @@ initproctitle (int argc, char **argv) {
 		argv_lth = envp[i-1] + strlen(envp[i-1]) - argv0[0];
 	else
 		argv_lth = argv0[argc-1] + strlen(argv0[argc-1]) - argv0[0];
-}	
-
-#if 0
-/* Nice code, but many places do not know about vsnprintf ... */
-void
-setproctitle (const char *fmt,...) {
-	int        i;
-	char       buf[SPT_BUFSIZE];
-	va_list    ap;
-
-	if (!argv0)
-		return;
-
-	va_start(ap, fmt);
-	(void) vsnprintf(buf, SPT_BUFSIZE, fmt, ap);
-	va_end(ap);
-
-	i = strlen (buf);
-	if (i > argv_lth - 2) {
-		i = argv_lth - 2;
-		buf[i] = '\0';
-	}
-	memset(argv0[0], '\0', argv_lth);       /* clear the memory area */
-	(void) strcpy (argv0[0], buf);
-
-	argv0[1] = NULL;
 }
-#else
-void
-setproctitle (const char *prog, const char *txt) {
-        int        i;
-        char       buf[SPT_BUFSIZE];
+
+void setproctitle (const char *prog, const char *txt)
+{
+        int i;
+        char buf[SPT_BUFSIZE];
 
         if (!argv0)
                 return;
@@ -94,16 +60,15 @@ setproctitle (const char *prog, const char *txt) {
 	if (strlen(prog) + strlen(txt) + 5 > SPT_BUFSIZE)
 		return;
 
-        (void) sprintf(buf, "%s -- %s", prog, txt);
+	sprintf(buf, "%s -- %s", prog, txt);
 
-        i = strlen (buf);
+        i = strlen(buf);
         if (i > argv_lth - 2) {
                 i = argv_lth - 2;
                 buf[i] = '\0';
         }
 	memset(argv0[0], '\0', argv_lth);       /* clear the memory area */
-        (void) strcpy (argv0[0], buf);
+        strcpy(argv0[0], buf);
 
         argv0[1] = NULL;
 }
-#endif
-- 
1.7.6.4
