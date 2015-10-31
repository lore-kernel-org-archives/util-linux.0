Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f52.google.com ([74.125.82.52]:33744 "EHLO
	mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbJaTVq (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:46 -0400
Received: by wmeg8 with SMTP id g8so32616279wme.0
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:45 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/12] mesg: fix multiple races
Date: Sat, 31 Oct 2015 19:21:23 +0000
Message-Id: <1446319284-24778-12-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/mesg.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index 77d89c7..f959e1f 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -59,6 +59,7 @@
 #include "nls.h"
 #include "c.h"
 #include "rpmatch.h"
+#include "fileutils.h"
 
 /* exit codes */
 
@@ -90,7 +91,7 @@ int main(int argc, char *argv[])
 {
 	struct stat sb;
 	char *tty;
-	int ch, verbose = FALSE;
+	int ch, fd, verbose = FALSE, ret;
 
 	static const struct option longopts[] = {
 		{ "verbose",    no_argument,       0, 'v' },
@@ -123,11 +124,15 @@ int main(int argc, char *argv[])
 
 	if ((tty = ttyname(STDERR_FILENO)) == NULL)
 		err(MESG_EXIT_FAILURE, _("ttyname failed"));
-
-	if (stat(tty, &sb) < 0)
+	if ((fd = open(tty, O_RDONLY)) < 0)
+		err(MESG_EXIT_FAILURE, _("cannot open %s"), tty);
+	if (!is_same_inode(fd, tty))
+		err(MESG_EXIT_FAILURE, _("TOCTOU exploitation detected"));
+	if (fstat(fd, &sb))
 		err(MESG_EXIT_FAILURE, _("stat of %s failed"), tty);
 
 	if (!*argv) {
+		close(fd);
 		if (sb.st_mode & (S_IWGRP | S_IWOTH)) {
 			puts(_("is y"));
 			return IS_ALLOWED;
@@ -139,24 +144,28 @@ int main(int argc, char *argv[])
 	switch (rpmatch(argv[0])) {
 	case RPMATCH_YES:
 #ifdef USE_TTY_GROUP
-		if (chmod(tty, sb.st_mode | S_IWGRP) < 0)
+		if (fchmod(fd, sb.st_mode | S_IWGRP) < 0)
 #else
-		if (chmod(tty, sb.st_mode | S_IWGRP | S_IWOTH) < 0)
+		if (fchmod(fd, sb.st_mode | S_IWGRP | S_IWOTH) < 0)
 #endif
 			err(MESG_EXIT_FAILURE, _("change %s mode failed"), tty);
 		if (verbose)
 			puts(_("write access to your terminal is allowed"));
-		return IS_ALLOWED;
+		ret = IS_ALLOWED;
+		break;
 	case RPMATCH_NO:
-		if (chmod(tty, sb.st_mode & ~(S_IWGRP|S_IWOTH)) < 0)
+		if (fchmod(fd, sb.st_mode & ~(S_IWGRP|S_IWOTH)) < 0)
 			 err(MESG_EXIT_FAILURE, _("change %s mode failed"), tty);
 		if (verbose)
 			puts(_("write access to your terminal is denied"));
-		return IS_NOT_ALLOWED;
+		ret = IS_NOT_ALLOWED;
+		break;
 	case RPMATCH_INVALID:
 		warnx(_("invalid argument: %s"), argv[0]);
 		usage(stderr);
         default:
                 abort();
 	}
+	close(fd);
+	return ret;
 }
-- 
2.6.2

