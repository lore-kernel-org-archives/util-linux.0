Return-Path: util-linux-owner@vger.kernel.org
Received: from mail2.student.tuwien.ac.at ([193.170.74.22]:54081 "EHLO
	mail2.student.tuwien.ac.at" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755240Ab1BJTDU convert rfc822-to-8bit
	(ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 10 Feb 2011 14:03:20 -0500
Message-Id: <201102101802.p1AI2Dp0009456@mail2.student.tuwien.ac.at>
Date: Thu, 10 Feb 2011 19:02:05 +0100
From: Stefan Tauner <stefan.tauner@student.tuwien.ac.at>
To: util-linux@vger.kernel.org
Cc: Stefan Tauner <stefan.tauner@student.tuwien.ac.at>
Subject: [PATCH] try to 'remount,ro' once if the kernel ignores the ro
 request for bind mounts
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Hello,

the linux kernel ignores (some?) options when they are used in bind
mounts. Because of this 'mount' issues a warning if bind mounting with
the ro option results in a writable mount (since 2009).
>From my point of view this is an error in the kernel because it does
not report that and should be fixed. Nevertheless since mount already
checks for this failure it is not a big change to just retry with the
MS_REMOUNT flag added, which normally should succeed. If not we can
still warn as before. This would allow using "bind,ro" in /etc/fstab.
The patch below implements that.

(please cc me)

Signed-off-by: Stefan Tauner <stefan.tauner@student.tuwien.ac.at>
---
 mount/mount.c |   14 +++++++++-----
 1 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/mount/mount.c b/mount/mount.c
index f5b3521..28a05f9 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -1655,14 +1655,18 @@ try_mount_one (const char *spec0, const char *node0, const char *types0,
   }
 
   /* Kernel allows to use MS_RDONLY for bind mounts, but the read-only request
-   * could be silently ignored. Check it to avoid 'ro' in mtab and 'rw' in
-   * /proc/mounts.
+   * could be silently ignored. Check that and retry with MS_REMOUNT once. If it
+   * is still rw honor it to avoid 'ro' in mtab and 'rw' in /proc/mounts.
    */
   if (!fake && mnt5_res == 0 &&
       (flags & MS_BIND) && (flags & MS_RDONLY) && !is_readonly(node)) {
-
-      printf(_("mount: warning: %s seems to be mounted read-write.\n"), node);
-      flags &= ~MS_RDONLY;
+      if (!(flags & MS_REMOUNT)) {
+        flags |= MS_REMOUNT;
+        goto mount_retry;
+      } else {
+        printf(_("mount: warning: %s seems to be mounted read-write.\n"), node);
+        flags &= ~MS_RDONLY;
+      }
   }
 
   /* Kernel can silently add MS_RDONLY flag when mounting file system that
-- 
Kind regards/Mit freundlichen Grüßen, Stefan Tauner
