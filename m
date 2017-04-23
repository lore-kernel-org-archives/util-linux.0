Return-Path: util-linux-owner@vger.kernel.org
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49931 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1427384AbdDWAlD (ORCPT
        <rfc822;util-linux@vger.kernel.org>);
        Sat, 22 Apr 2017 20:41:03 -0400
From: Patrick Steinhardt <ps@pks.im>
To: util-linux@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH] switch_root: unlink files without _DIRENT_HAVE_D_TYPE
Date: Sun, 23 Apr 2017 02:33:04 +0200
Message-Id: <89de54c7029bebc3cbb9d5eaee67c5d38873985a.1492907475.git.ps@pks.im>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When _DIRENT_HAVE_D_TYPE is not defined, we need to always fstat the
directory entry in order to determine whether it is a directory or not.
If we determine that the file is indeed a directory on the same device,
we proceed to recursively remove its contents as well. Otherwise, we
simply skip removing the entry altogether.

This logic is not entirely correct though. Note that we actually skip
deletion of the entry if it is either not a directory or if it is not on
the same device. The second condition is obviously correct here, as we
do not want to delete files on other mounts here. But skipping deletion
of the entry itself if it is not a directory is wrong.

When _DIRENT_HAVE_D_TYPE is defined, this condition should never be
triggered, as we have already determined that the entry is a directory.
But if it is not, we will always do the fstat and check. Because of
this, we will now skip deletion of all files which are not directories,
which is wrong.

Fix the issue by disentangling both conditions. We now first check
whether we are still on the same device - if not, we skip recursive
deletion as well as deletion of the directory entry. Afterwards, we
check whether it is a directory - if so, we do delete its contents
recursively. And finally, we will now unlink the entry disregarding
whether it is a directory or not.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 sys-utils/switch_root.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index 6f5468fca..2b42ddf85 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -94,8 +94,12 @@ static int recursiveRemove(int fd)
 				continue;
 			}
 
-			/* remove subdirectories if device is same as dir */
-			if (S_ISDIR(sb.st_mode) && sb.st_dev == rb.st_dev) {
+			/* skip if device is not the same */
+			if (sb.st_dev != rb.st_dev)
+				continue;
+
+			/* remove subdirectories */
+			if (S_ISDIR(sb.st_mode)) {
 				int cfd;
 
 				cfd = openat(dfd, d->d_name, O_RDONLY);
@@ -104,8 +108,7 @@ static int recursiveRemove(int fd)
 					close(cfd);
 				}
 				isdir = 1;
-			} else
-				continue;
+			}
 		}
 
 		if (unlinkat(dfd, d->d_name, isdir ? AT_REMOVEDIR : 0))
-- 
2.12.2

