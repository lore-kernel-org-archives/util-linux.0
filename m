Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:47171 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752034AbbBVOmH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 22 Feb 2015 09:42:07 -0500
Received: by mail-wg0-f53.google.com with SMTP id a1so21133152wgh.12
        for <util-linux@vger.kernel.org>; Sun, 22 Feb 2015 06:42:06 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 10/16] rpmatch: use symbolic value when evaluation return codes
Date: Sun, 22 Feb 2015 14:41:40 +0000
Message-Id: <1424616106-580-11-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
References: <1424616106-580-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fdisk.c      | 2 +-
 disk-utils/fsck.minix.c | 6 +++---
 disk-utils/sfdisk.c     | 2 +-
 include/rpmatch.h       | 4 ++++
 login-utils/vipw.c      | 2 +-
 term-utils/mesg.c       | 6 +++---
 6 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 8a0bfd5..815f3f3 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -347,7 +347,7 @@ int ask_callback(struct fdisk_context *cxt, struct fdisk_ask *ask,
 			if (rc)
 				break;
 			x = rpmatch(buf);
-			if (x == 1 || x == 0) {
+			if (x == RPMATCH_YES || x == RPMATCH_NO) {
 				fdisk_ask_yesno_set_result(ask, x);
 				break;
 			}
diff --git a/disk-utils/fsck.minix.c b/disk-utils/fsck.minix.c
index ac2dc47..52b001b 100644
--- a/disk-utils/fsck.minix.c
+++ b/disk-utils/fsck.minix.c
@@ -269,11 +269,11 @@ ask(const char *string, int def) {
 	ignore_result( fgets(input, YESNO_LENGTH, stdin) );
 	resp = rpmatch(input);
 	switch (resp) {
-	case -1:
+	case RPMATCH_INVALID:
 		/* def = def */
 		break;
-	case 0:
-	case 1:
+	case RPMATCH_NO:
+	case RPMATCH_YES:
 		def = resp;
 		break;
 	default:
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index b7d4480..bce94e5 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -167,7 +167,7 @@ static int ask_callback(struct fdisk_context *cxt,
 			if (rc)
 				break;
 			x = rpmatch(buf);
-			if (x == 1 || x == 0) {
+			if (x == RPMATCH_YES || x == RPMATCH_NO) {
 				fdisk_ask_yesno_set_result(ask, x);
 				break;
 			}
diff --git a/include/rpmatch.h b/include/rpmatch.h
index d62634b..f64d52e 100644
--- a/include/rpmatch.h
+++ b/include/rpmatch.h
@@ -6,4 +6,8 @@
 	(*r == 'y' || *r == 'Y' ? 1 : *r == 'n' || *r == 'N' ? 0 : -1)
 #endif
 
+#define RPMATCH_YES	 1
+#define RPMATCH_NO	 0
+#define RPMATCH_INVALID	-1
+
 #endif /* UTIL_LINUX_RPMATCH_H */
diff --git a/login-utils/vipw.c b/login-utils/vipw.c
index 668f4d8..9fb2550 100644
--- a/login-utils/vipw.c
+++ b/login-utils/vipw.c
@@ -352,7 +352,7 @@ int main(int argc, char *argv[])
 		printf(_("Would you like to edit %s now [y/n]? "), orig_file);
 
 		if (fgets(response, sizeof(response), stdin)) {
-			if (rpmatch(response) == 1)
+			if (rpmatch(response) == RPMATCH_YES)
 				edit_file(1);
 		}
 	}
diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index 3cb1d24..77d89c7 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -137,7 +137,7 @@ int main(int argc, char *argv[])
 	}
 
 	switch (rpmatch(argv[0])) {
-	case 1:
+	case RPMATCH_YES:
 #ifdef USE_TTY_GROUP
 		if (chmod(tty, sb.st_mode | S_IWGRP) < 0)
 #else
@@ -147,13 +147,13 @@ int main(int argc, char *argv[])
 		if (verbose)
 			puts(_("write access to your terminal is allowed"));
 		return IS_ALLOWED;
-	case 0:
+	case RPMATCH_NO:
 		if (chmod(tty, sb.st_mode & ~(S_IWGRP|S_IWOTH)) < 0)
 			 err(MESG_EXIT_FAILURE, _("change %s mode failed"), tty);
 		if (verbose)
 			puts(_("write access to your terminal is denied"));
 		return IS_NOT_ALLOWED;
-        case -1:
+	case RPMATCH_INVALID:
 		warnx(_("invalid argument: %s"), argv[0]);
 		usage(stderr);
         default:
-- 
2.3.0

