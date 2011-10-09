Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vx0-f174.google.com ([209.85.220.174]:41176 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab1JIPLx (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Oct 2011 11:11:53 -0400
Received: by vcbgb30 with SMTP id gb30so184255vcb.19
        for <util-linux@vger.kernel.org>; Sun, 09 Oct 2011 08:11:52 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/2] mountpoint: refactor exit path
Date: Sun,  9 Oct 2011 11:12:04 -0400
Message-Id: <1318173125-16156-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There's only one condition for which we declare success, but many for
failure. Initialize rc as failure and set to success on this single
condition. In all cases, jump to a label to exit instead of exiting
immediately. This will be used later on to ease cleanup of any heap
allocations.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/mountpoint.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index 1297d82..e021c70 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -105,7 +105,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 int main(int argc, char **argv)
 {
-	int c, fs_devno = 0, dev_devno = 0, rc = 0;
+	int c, fs_devno = 0, dev_devno = 0, rc = EXIT_FAILURE;
 	char *spec;
 	struct stat st;
 
@@ -152,7 +152,7 @@ int main(int argc, char **argv)
 	if (stat(spec, &st)) {
 		if (!quiet)
 			err(EXIT_FAILURE, "%s", spec);
-		return EXIT_FAILURE;
+		goto finish;
 	}
 	if (dev_devno)
 		rc = print_devno(spec, &st);
@@ -162,19 +162,22 @@ int main(int argc, char **argv)
 		if (!S_ISDIR(st.st_mode)) {
 			if (!quiet)
 				errx(EXIT_FAILURE, _("%s: not a directory"), spec);
-			return EXIT_FAILURE;
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

