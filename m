Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:58484 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757512Ab2CETj3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 5 Mar 2012 14:39:29 -0500
Received: by mail-ey0-f174.google.com with SMTP id q12so1565228eaa.19
        for <util-linux@vger.kernel.org>; Mon, 05 Mar 2012 11:39:29 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 11/17] setpwnam: use xmkstemp() and lckpwdf()
Date: Mon,  5 Mar 2012 20:38:48 +0100
Message-Id: <1330976334-10751-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
References: <20120305123847.GD486@x2.net.home>
 <1330976334-10751-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Get rid private locking schema and use libc instead.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/Makefile.am |    3 ++-
 login-utils/setpwnam.c  |   52 ++++++++++++++++-------------------------------
 2 files changed, 20 insertions(+), 35 deletions(-)

diff --git a/login-utils/Makefile.am b/login-utils/Makefile.am
index 47274bf..7bd2ddb 100644
--- a/login-utils/Makefile.am
+++ b/login-utils/Makefile.am
@@ -42,7 +42,8 @@ chfn_chsh_common = \
 	islocal.h \
 	setpwnam.c \
 	setpwnam.h \
-	$(top_srcdir)/lib/env.c
+	$(top_srcdir)/lib/env.c \
+	$(top_srcdir)/lib/fileutils.c
 login_SOURCES = \
 	login.c \
 	logindefs.c \
diff --git a/login-utils/setpwnam.c b/login-utils/setpwnam.c
index 0e0c047..97fd822 100644
--- a/login-utils/setpwnam.c
+++ b/login-utils/setpwnam.c
@@ -47,6 +47,7 @@
 #include <fcntl.h>
 #include <paths.h>
 #include <pwd.h>
+#include <shadow.h>
 #include <signal.h>
 #include <stdbool.h>
 #include <stdio.h>
@@ -58,6 +59,7 @@
 #include <unistd.h>
 
 #include "c.h"
+#include "fileutils.h"
 #include "setpwnam.h"
 
 static void pw_init(void);
@@ -71,47 +73,26 @@ static void pw_init(void);
 int setpwnam(struct passwd *pwd)
 {
 	FILE *fp = NULL, *pwf = NULL;
-	int x, save_errno, fd, ret;
+	int save_errno;
 	int found;
-	int oldumask;
 	int namelen;
 	int buflen = 256;
 	int contlen, rc;
 	char *linebuf = NULL;
-
-	oldumask = umask(0);	/* Create with exact permissions */
+	char *tmpname = NULL;
 
 	pw_init();
 
-	/* sanity check */
-	for (x = 0; x < 3; x++) {
-		if (x > 0)
-			sleep(1);
-		fd = open(PTMPTMP_FILE, O_WRONLY | O_CREAT | O_EXCL, 0644);
-		if (fd == -1) {
-			umask(oldumask);
-			return -1;
-		}
-		ret = link(PTMPTMP_FILE, PTMP_FILE);
-		unlink(PTMPTMP_FILE);
-		if (ret == -1)
-			close(fd);
-		else
-			break;
-	}
-	umask(oldumask);
-	if (ret == -1)
+	if ((fp = xmkstemp(&tmpname)) == NULL)
 		return -1;
 
 	/* ptmp should be owned by root.root or root.wheel */
-	if (chown(PTMP_FILE, (uid_t) 0, (gid_t) 0) < 0)
-		return -1;
-
-	/* open ptmp for writing and passwd for reading */
-	fp = fdopen(fd, "w");
-	if (!fp)
+	if (fchown(fileno(fp), (uid_t) 0, (gid_t) 0) < 0)
 		goto fail;
 
+	/* acquire exclusive lock */
+	if (lckpwdf() < 0)
+		goto fail;
 	pwf = fopen(PASSWD_FILE, "r");
 	if (!pwf)
 		goto fail;
@@ -164,8 +145,6 @@ int setpwnam(struct passwd *pwd)
 	if (rc < 0)
 		goto fail;
 
-	close(fd);
-	fd = -1;
 	fclose(pwf);	/* I don't think I want to know if this failed */
 	pwf = NULL;
 
@@ -178,22 +157,27 @@ int setpwnam(struct passwd *pwd)
 	unlink(PASSWD_FILE ".OLD");
 	/* we don't care if we can't create the backup file */
 	ignore_result(link(PASSWD_FILE, PASSWD_FILE ".OLD"));
+	/* xmkstemp is too restrictive by default for passwd file */
+	if (fchmod(fileno(fp), 0644) < 0)
+		goto fail;
 	/* we DO care if we can't rename to the passwd file */
-	if (rename(PTMP_FILE, PASSWD_FILE) < 0)
+	if (rename(tmpname, PASSWD_FILE) < 0)
 		goto fail;
 	/* finally:  success */
+	ulckpwdf();
 	return 0;
 
  fail:
 	save_errno = errno;
+	ulckpwdf();
 	if (fp != NULL)
 		fclose(fp);
+	if (tmpname != NULL)
+		unlink(tmpname);
+	free(tmpname);
 	if (pwf != NULL)
 		fclose(pwf);
-	if (fd >= 0)
-		close(fd);
 	free(linebuf);
-	unlink(PTMP_FILE);
 	errno = save_errno;
 	return -1;
 }
-- 
1.7.9.2

