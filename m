Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:39861 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752214Ab1LZXr2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 Dec 2011 18:47:28 -0500
Received: by qadc12 with SMTP id c12so6432047qad.19
        for <util-linux@vger.kernel.org>; Mon, 26 Dec 2011 15:47:27 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] mount: don't canonicalize the source of a pseudofs
Date: Mon, 26 Dec 2011 18:47:24 -0500
Message-Id: <1324943244-27332-1-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1324937423-15766-1-git-send-email-dreisner@archlinux.org>
References: <1324937423-15766-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

In line with previous patches, the source of a pseudofs is strictly
semantic; do not attempt to resolve it to a filesystem path.

As a side effect of this, nspec needs to be initialized to NULL since
it may not be assigned null by spec_to_devname when the FS is deemed
a pseudofs.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
This wasn't as evil as I thought, after all...

 mount/mount.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/mount/mount.c b/mount/mount.c
index 9b444c4..49d49f6 100644
--- a/mount/mount.c
+++ b/mount/mount.c
@@ -2016,7 +2016,7 @@ is_existing_file (const char *s) {
 static int
 mount_one (const char *spec, const char *node, const char *types,
 	   const char *fstabopts, char *cmdlineopts, int freq, int pass) {
-	const char *nspec;
+	const char *nspec = NULL;
 	char *opts;
 
 	/* Substitute values in opts, if required */
@@ -2046,7 +2046,8 @@ mount_one (const char *spec, const char *node, const char *types,
 			      strncmp(types, "nfs", 3) &&
 			      strncmp(types, "cifs", 4) &&
 			      strncmp(types, "smbfs", 5))) {
-		nspec = spec_to_devname(spec);
+		if (!is_pseudo_fs(types))
+			nspec = spec_to_devname(spec);
 		if (nspec)
 			spec = nspec;
 	}
-- 
1.7.8.1

