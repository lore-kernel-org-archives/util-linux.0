Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:46740 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932226AbaDBOt1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 2 Apr 2014 10:49:27 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] switch_root: verify initramfs by f_type, not devno
Date: Wed,  2 Apr 2014 10:41:30 -0400
Message-Id: <1396449690-4215-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

As of linux 3.14, the initramfs device will have both major and
minor 0, causing our paranoia check to fail. Make this version agnostic
by checking the filesystem type, rather than a device number.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
This is essentially what busybox's switch_root does. I don't think there's much
value in checking the devno at all, as it seems to be a needless restriction.
Let's just allow deleting anything that looks like non-persistent storage.

 sys-utils/switch_root.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index 1222fb1..dac946f 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -23,6 +23,7 @@
 #include <sys/mount.h>
 #include <sys/types.h>
 #include <sys/stat.h>
+#include <sys/statfs.h>
 #include <sys/param.h>
 #include <fcntl.h>
 #include <stdio.h>
@@ -36,6 +37,7 @@
 #include "c.h"
 #include "nls.h"
 #include "closestream.h"
+#include "statfs_magic.h"
 
 #ifndef MS_MOVE
 #define MS_MOVE 8192
@@ -177,12 +179,12 @@ static int switchroot(const char *newroot)
 	if (cfd >= 0) {
 		pid = fork();
 		if (pid <= 0) {
-			if (fstat(cfd, &sb) == 0) {
-				if (sb.st_dev == makedev(0, 1))
-					recursiveRemove(cfd);
-				else
-					warn(_("old root filesystem is not an initramfs"));
-			}
+			struct statfs stfs;
+			if (fstatfs(cfd, &stfs) == 0 &&
+			    (stfs.f_type == STATFS_RAMFS_MAGIC || stfs.f_type == STATFS_TMPFS_MAGIC))
+				recursiveRemove(cfd);
+			else
+				warn(_("old root filesystem is not an initramfs"));
 
 			if (pid == 0)
 				exit(EXIT_SUCCESS);
-- 
1.9.1

