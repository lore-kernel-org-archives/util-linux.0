Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pd0-f179.google.com ([209.85.192.179]:64525 "EHLO
	mail-pd0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754681Ab3IYPce (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Sep 2013 11:32:34 -0400
Received: by mail-pd0-f179.google.com with SMTP id v10so6202193pde.24
        for <util-linux@vger.kernel.org>; Wed, 25 Sep 2013 08:32:34 -0700 (PDT)
From: Namhyung Kim <namhyung@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/4] libmount: Remove stale comment on mnt_context_mount()
Date: Thu, 26 Sep 2013 00:32:06 +0900
Message-Id: <1380123126-3030-4-git-send-email-namhyung@gmail.com>
In-Reply-To: <1380123126-3030-1-git-send-email-namhyung@gmail.com>
References: <1380123126-3030-1-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The commit f9906424 ("libmount: add post-mount checks to detect ro/rw")
added necessary check so the comment is not valid anymore.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 libmount/src/context_mount.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index d6691eb..3215aef 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -973,11 +973,6 @@ int mnt_context_mount(struct libmnt_context *cxt)
 		rc = mnt_context_prepare_update(cxt);
 	if (!rc)
 		rc = mnt_context_do_mount(cxt);
-
-	/* TODO: if mtab update is expected then check if the
-	 * target is really mounted read-write to avoid 'ro' in
-	 * mtab and 'rw' in /proc/mounts.
-	 */
 	if (!rc)
 		rc = mnt_context_update_tabs(cxt);
 	return rc;
-- 
1.7.9.2

