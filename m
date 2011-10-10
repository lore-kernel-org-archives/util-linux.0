Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:62515 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804Ab1JJXOB (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 10 Oct 2011 19:14:01 -0400
Received: by vcbgb30 with SMTP id gb30so1124138vcb.19
        for <util-linux@vger.kernel.org>; Mon, 10 Oct 2011 16:14:01 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/2] mountpoint: refactor exit path
Date: Mon, 10 Oct 2011 19:14:15 -0400
Message-Id: <1318288456-22940-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There's only one condition for which we declare success, but many for
failure. Initialize rc as failure and set to success on this single
condition. In all cases, jump to a label to exit instead of exiting
immediately. This will be used later on to ease cleanup of any heap
allocations.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
v2: use warn{,x} instead of err{,x} to avoid leaks.

 sys-utils/mountpoint.c |   19 +++++++++++--------
 1 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index 1297d82..e075b83 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -105,7 +105,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 int main(int argc, char **argv)
 {
-	int c, fs_devno = 0, dev_devno = 0, rc = 0;
+	int c, fs_devno = 0, dev_devno = 0, rc = EXIT_FAILURE;
 	char *spec;
 	struct stat st;
 
@@ -151,8 +151,8 @@ int main(int argc, char **argv)
 
 	if (stat(spec, &st)) {
 		if (!quiet)
-			err(EXIT_FAILURE, "%s", spec);
-		return EXIT_FAILURE;
+			warn("%s", spec);
+		goto finish;
 	}
 	if (dev_devno)
 		rc = print_devno(spec, &st);
@@ -161,20 +161,23 @@ int main(int argc, char **argv)
 
 		if (!S_ISDIR(st.st_mode)) {
 			if (!quiet)
-				errx(EXIT_FAILURE, _("%s: not a directory"), spec);
-			return EXIT_FAILURE;
+				warnx(_("%s: not a directory"), spec);
+			goto finish;
 		}
 		src = dir_to_device(spec);
 		if (src == (dev_t)-1) {
 			if (!quiet)
 				printf(_("%s is not a mountpoint\n"), spec);
-			return EXIT_FAILURE;
+			goto finish;
 		}
 		if (fs_devno)
 			printf("%u:%u\n", major(src), minor(src));
-		else if (!quiet)
+		else if (!quiet) {
 			printf(_("%s is a mountpoint\n"), spec);
+			rc = EXIT_SUCCESS;
+		}
 	}
 
-	return rc ? EXIT_FAILURE : EXIT_SUCCESS;
+finish:
+	return rc;
 }
-- 
1.7.7

