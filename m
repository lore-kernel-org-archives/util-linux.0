Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f53.google.com ([209.85.160.53]:44163 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbaF0FRE (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jun 2014 01:17:04 -0400
Received: by mail-pb0-f53.google.com with SMTP id uo5so4091489pbc.12
        for <util-linux@vger.kernel.org>; Thu, 26 Jun 2014 22:17:03 -0700 (PDT)
From: "Eric Rannaud" <e@nanocritical.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Eric Rannaud <e@nanocritical.com>
Subject: [PATCH 2/4] libmount: mnt_resolve_path: don't canonicalize fs->target for swap
Date: Thu, 26 Jun 2014 22:17:17 -0700
Message-Id: <bc63685a3d056044034ee5c78119313498ad46b1.1403845374.git.e@nanocritical.com>
In-Reply-To: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
References: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
In-Reply-To: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
References: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This is how mnt_table_find_target() does it. It makes sense because
@fs->target is "none" for swap and is never a sensible match for a
user-specified target.

Signed-off-by: Eric Rannaud <e@nanocritical.com>
---
 libmount/src/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index 949e718f4ca5..21ef0f7479fd 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -1437,7 +1437,7 @@ int mnt_fs_match_target(struct libmnt_fs *fs, const char *target,
 		rc = (cn && mnt_fs_streq_target(fs, cn));
 
 		/* 3) - canonicalized and canonicalized */
-		if (!rc && cn && !mnt_fs_is_kernel(fs)) {
+		if (!rc && cn && !mnt_fs_is_kernel(fs) && !mnt_fs_is_swaparea(fs)) {
 			char *tcn = mnt_resolve_path(fs->target, cache);
 			rc = (tcn && strcmp(cn, tcn) == 0);
 		}
-- 
2.0.1

