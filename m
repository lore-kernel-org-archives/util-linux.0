Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:46802 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab1LZWK2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 Dec 2011 17:10:28 -0500
Received: by qadc12 with SMTP id c12so6392376qad.19
        for <util-linux@vger.kernel.org>; Mon, 26 Dec 2011 14:10:28 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/2] libmount/context: avoid resolving pseudofs source on update
Date: Mon, 26 Dec 2011 17:10:23 -0500
Message-Id: <1324937423-15766-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1324937423-15766-1-git-send-email-dreisner@archlinux.org>
References: <1324937423-15766-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Similar to the previous commit, when mounting a pseudofs, trust the
source of the fs, as it cannot be matched to backing device on the
filesystem.

Similar situation, but slightly different bug:

  # mkdir /foo /root/foo
  # echo 'foo  /foo  tmpfs  defaults  0  0' >> /etc/fstab
  # cd /root
  # mount -a
  # mount | grep /foo
  /root/foo on /foo type tmpfs (rw,relatime)

This fixes the pure libmount based mount utility, but the legacy mount
tool will still fail to handle this properly.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
Two things:

- Since this touched a different file than the previous commit, I thought it best
to keep them separate. Karel, if you disagree, I'm happy to rebase for you.

- Legacy mount has defeated me. Uggh.

 libmount/src/context.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/libmount/src/context.c b/libmount/src/context.c
index c61a144..ea372ce 100644
--- a/libmount/src/context.c
+++ b/libmount/src/context.c
@@ -32,6 +32,7 @@
  */
 
 #include "mountP.h"
+#include "utils.h"
 
 #include <sys/wait.h>
 
@@ -1105,7 +1106,8 @@ int mnt_context_prepare_srcpath(struct libmnt_context *cxt)
 		/*
 		 * Source is PATH (canonicalize)
 		 */
-		path = mnt_resolve_path(src, cache);
+		if (!mnt_fstype_is_pseudofs(mnt_fs_get_fstype(cxt->fs)))
+			path = mnt_resolve_path(src, cache);
 		if (path && strcmp(path, src))
 			rc = mnt_fs_set_source(cxt->fs, path);
 	 }
-- 
1.7.8.1

