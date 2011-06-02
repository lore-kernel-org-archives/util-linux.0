Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ew0-f46.google.com ([209.85.215.46]:58036 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab1FBTSF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 2 Jun 2011 15:18:05 -0400
Received: by ewy4 with SMTP id 4so421738ewy.19
        for <util-linux@vger.kernel.org>; Thu, 02 Jun 2011 12:18:04 -0700 (PDT)
From: Francesco Cosoleto <cosoleto@gmail.com>
To: util-linux@vger.kernel.org
Cc: Francesco Cosoleto <cosoleto@gmail.com>
Subject: [PATCH] fstrim, setarch: replace error() with err()
Date: Thu,  2 Jun 2011 21:17:57 +0200
Message-Id: <1307042277-8282-1-git-send-email-cosoleto@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This should improve a bit the portability as error() is a GNU extension and
util-linux provides fallbacks for err.h functions.

Fix compilation with icc, broken due to a reference to `__builtin_va_arg_pack'
in error.h using the -gcc default option.

Signed-off-by: Francesco Cosoleto <cosoleto@gmail.com>
---
 sys-utils/fstrim.c  |   10 +++-------
 sys-utils/setarch.c |   17 ++++++++---------
 2 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index d4fb0c3..fd113ae 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -32,8 +32,6 @@
 #include <fcntl.h>
 #include <limits.h>
 #include <getopt.h>
-#include <error.h>
-#include <errno.h>
 
 #include <sys/ioctl.h>
 #include <sys/stat.h>
@@ -141,11 +139,9 @@ int main(int argc, char **argv)
 	if (fd < 0)
 		err(EXIT_FAILURE, _("%s: open failed"), path);
 
-	if (ioctl(fd, FITRIM, &range)) {
-		int errsv = errno;
-		close(fd);
-		error(EXIT_FAILURE, errsv, _("%s: FITRIM ioctl failed"), path);
-	}
+	if (ioctl(fd, FITRIM, &range))
+		err(EXIT_FAILURE, _("%s: FITRIM ioctl failed"), path);
+
 	if (verbose)
 		printf(_("%s: %" PRIu64 " bytes was trimmed\n"),
 						path, range.len);
diff --git a/sys-utils/setarch.c b/sys-utils/setarch.c
index 76f743f..5f187a7 100644
--- a/sys-utils/setarch.c
+++ b/sys-utils/setarch.c
@@ -30,12 +30,11 @@
 #include <stdio.h>
 #include <string.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <error.h>
 #include <getopt.h>
 #include <limits.h>
 #include <sys/utsname.h>
 #include "nls.h"
+#include "c.h"
 
 #define set_pers(pers) ((long)syscall(SYS_personality, pers))
 
@@ -212,7 +211,7 @@ int set_arch(const char *pers, unsigned long options)
 	break;
 
   if(transitions[i].perval < 0)
-    error(EXIT_FAILURE, 0, _("%s: Unrecognized architecture"), pers);
+    errx(EXIT_FAILURE, _("%s: Unrecognized architecture"), pers);
 
   pers_value = transitions[i].perval | options;
   res = set_pers(pers_value);
@@ -228,7 +227,7 @@ int set_arch(const char *pers, unsigned long options)
 	   && strcmp(un.machine, "i586")
 	   && strcmp(un.machine, "i686")
 	   && strcmp(un.machine, "athlon")))
-      error(EXIT_FAILURE, 0, _("%s: Unrecognized architecture"), pers);
+      errx(EXIT_FAILURE, _("%s: Unrecognized architecture"), pers);
   }
 
   return 0;
@@ -262,9 +261,9 @@ int main(int argc, char *argv[])
   #if defined(__sparc64__) || defined(__sparc__)
    if (!strcmp(p, "sparc32bash")) {
        if (set_arch(p, 0L))
-           error(EXIT_FAILURE, errno, _("Failed to set personality to %s"), p);
+           err(EXIT_FAILURE, _("Failed to set personality to %s"), p);
        execl("/bin/bash", NULL);
-       error(EXIT_FAILURE, errno, "/bin/bash");
+       err(EXIT_FAILURE, "/bin/bash");
    }
   #endif
 
@@ -315,14 +314,14 @@ int main(int argc, char *argv[])
   argv += optind;
 
   if (set_arch(p, options))
-    error(EXIT_FAILURE, errno, _("Failed to set personality to %s"), p);
+    err(EXIT_FAILURE, _("Failed to set personality to %s"), p);
 
   if (!argc) {
     execl("/bin/sh", "-sh", NULL);
-    error(EXIT_FAILURE, errno, "/bin/sh");
+    err(EXIT_FAILURE, "/bin/sh");
   }
 
   execvp(argv[0], argv);
-  error(EXIT_FAILURE, errno, "%s", argv[0]);
+  err(EXIT_FAILURE, "%s", argv[0]);
   return EXIT_FAILURE;
 }
-- 
1.7.3.4

