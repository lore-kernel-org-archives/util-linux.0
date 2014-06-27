Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pa0-f52.google.com ([209.85.220.52]:64664 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbaF0FQ7 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jun 2014 01:16:59 -0400
Received: by mail-pa0-f52.google.com with SMTP id eu11so4131717pac.39
        for <util-linux@vger.kernel.org>; Thu, 26 Jun 2014 22:16:59 -0700 (PDT)
From: "Eric Rannaud" <e@nanocritical.com>
To: util-linux@vger.kernel.org
Cc: Karel Zak <kzak@redhat.com>, Eric Rannaud <e@nanocritical.com>
Subject: [PATCH 1/4] libmount: mnt_resolve_path: use strcmp() only if both are canonical
Date: Thu, 26 Jun 2014 22:17:16 -0700
Message-Id: <747e9f8de90dc1e906d2f84f3952a801e70ef3d0.1403845374.git.e@nanocritical.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Eric Rannaud <e@nanocritical.com>
---
 libmount/src/fs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index cae7ce648c31..949e718f4ca5 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -1434,7 +1434,7 @@ int mnt_fs_match_target(struct libmnt_fs *fs, const char *target,
 	if (!rc && cache) {
 		/* 2) - canonicalized and non-canonicalized */
 		char *cn = mnt_resolve_path(target, cache);
-		rc = (cn && strcmp(cn, fs->target) == 0);
+		rc = (cn && mnt_fs_streq_target(fs, cn));
 
 		/* 3) - canonicalized and canonicalized */
 		if (!rc && cn && !mnt_fs_is_kernel(fs)) {
-- 
2.0.1

