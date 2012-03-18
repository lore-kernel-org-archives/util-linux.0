Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qa0-f46.google.com ([209.85.216.46]:43383 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752372Ab2CRDgh (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Mar 2012 23:36:37 -0400
Received: by qaeb19 with SMTP id b19so306297qae.19
        for <util-linux@vger.kernel.org>; Sat, 17 Mar 2012 20:36:37 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/5] checkxalloc: nudge regex, fix newfound instances
Date: Sat, 17 Mar 2012 23:36:29 -0400
Message-Id: <1332041793-7919-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Using the -w flag with grep actually fought against us here, and hid
some instances where xalloc functions weren't used. Discard it in favor
of an explicit word boundary as a prefix to the function name, and
extend our requirements on the trailing side of the pattern.

This also fixes the few new instances that were overlooked because of
the regex's deficiency.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 fdisk/sfdisk.c       |    2 +-
 sys-utils/swapon.c   |    4 ++--
 tools/checkxalloc.sh |    2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fdisk/sfdisk.c b/fdisk/sfdisk.c
index 6267652..e766b04 100644
--- a/fdisk/sfdisk.c
+++ b/fdisk/sfdisk.c
@@ -304,7 +304,7 @@ restore_sectors(char *dev) {
 	error(_("partition restore file has wrong size - not restoring\n"));
 	goto err;
     }
-    if (!(ss0 = (char *)malloc(statbuf.st_size))) {
+    if (!(ss0 = xmalloc(statbuf.st_size))) {
 	error(_("out of memory?\n"));
 	goto err;
     }
diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index f17fad6..fe16169 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -197,7 +197,7 @@ read_proc_swaps(void) {
 			       *p = '\0';
 		}
 
-		q = realloc(swapFiles, (numSwaps+1) * sizeof(*swapFiles));
+		q = xrealloc(swapFiles, (numSwaps+1) * sizeof(*swapFiles));
 		if (q == NULL)
 			break;
 		swapFiles = q;
@@ -640,7 +640,7 @@ swapon_all(void) {
 		if (!streq(fstab->mnt_type, MNTTYPE_SWAP))
 			continue;
 
-		opts = strdup(fstab->mnt_opts);
+		opts = xstrdup(fstab->mnt_opts);
 
 		for (opt = strtok(opts, ","); opt != NULL;
 		     opt = strtok(NULL, ",")) {
diff --git a/tools/checkxalloc.sh b/tools/checkxalloc.sh
index 578340e..6634c82 100755
--- a/tools/checkxalloc.sh
+++ b/tools/checkxalloc.sh
@@ -10,7 +10,7 @@ cd "$(git rev-parse --show-toplevel)" || {
 }
 
 git grep -zl '#include "xalloc.h"' |
-  xargs -0 grep -nwE '[^x](([cm]|re)alloc|strdup)\('
+  xargs -0 grep -nE '\b(([cm]|re)alloc|strdup)[[:space:]]*\([^)]'
 
 result=$?
 
-- 
1.7.9.4

