Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38382 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751070AbbFXIPc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 24 Jun 2015 04:15:32 -0400
Received: by wibdq8 with SMTP id dq8so38721685wib.1
        for <util-linux@vger.kernel.org>; Wed, 24 Jun 2015 01:15:31 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 03/12] mkfs.minix: use is_mounted() from libcommon
Date: Wed, 24 Jun 2015 09:15:10 +0100
Message-Id: <1435133719-2971-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
References: <1435133719-2971-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 9e4212f..a198e5a 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -77,6 +77,7 @@
 #include "strutils.h"
 #include "all-io.h"
 #include "closestream.h"
+#include "ismounted.h"
 
 #define MINIX_ROOT_INO 1
 #define MINIX_BAD_INO 2
@@ -152,28 +153,6 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	exit(out == stderr ? MKFS_EX_USAGE : MKFS_EX_OK);
 }
 
-/*
- * Check to make certain that our new filesystem won't be created on
- * an already mounted partition.  Code adapted from mke2fs, Copyright
- * (C) 1994 Theodore Ts'o.  Also licensed under GPL.
- */
-static void check_mount(void) {
-	FILE * f;
-	struct mntent * mnt;
-
-	if ((f = setmntent (_PATH_MOUNTED, "r")) == NULL)
-		return;
-	while ((mnt = getmntent (f)) != NULL)
-		if (strcmp (device_name, mnt->mnt_fsname) == 0)
-			break;
-	endmntent (f);
-	if (!mnt)
-		return;
-
-	errx(MKFS_EX_ERROR, _("%s is mounted; will not make a filesystem here!"),
-			device_name);
-}
-
 static void super_set_state(void)
 {
 	switch (fs_version) {
@@ -743,7 +722,9 @@ int main(int argc, char ** argv) {
 	if (!device_name) {
 		usage(stderr);
 	}
-	check_mount();		/* is it already mounted? */
+	if (is_mounted(device_name))
+		errx(MKFS_EX_ERROR, _("%s is mounted; will not make a filesystem here!"),
+			device_name);
 	tmp = root_block;
 	if (fs_version == 3) {
 		*(uint32_t *)tmp = 1;
-- 
2.4.4

