Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42327 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750758Ab2AQBR5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 16 Jan 2012 20:17:57 -0500
Received: by qadc10 with SMTP id c10so497305qad.19
        for <util-linux@vger.kernel.org>; Mon, 16 Jan 2012 17:17:57 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] mount: avoid canonicalizing pseudofs paths
Date: Mon, 16 Jan 2012 20:17:55 -0500
Message-Id: <1326763075-11690-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This fixes a display bug in the new mount wherein a psuedofs existing in
$PWD by name will be resolved and shown as a real mount point.

  $ cd /tmp; mkdir nfsd; mount | grep nfsd
  /tmp/nfsd on /proc/fs/nfsd type nfsd (rw,relatime)

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/mount.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 81ccb41..0964828 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -146,13 +146,14 @@ static void print_all(struct libmnt_context *cxt, char *pattern, int show_label)
 		const char *type = mnt_fs_get_fstype(fs);
 		const char *src = mnt_fs_get_source(fs);
 		const char *optstr = mnt_fs_get_options(fs);
-		char *xsrc;
+		char *xsrc = NULL;
 
 		if (type && pattern && !mnt_match_fstype(type, pattern))
 			continue;
 
-		xsrc = mnt_pretty_path(src, cache);
-		printf ("%s on %s", xsrc, mnt_fs_get_target(fs));
+		if (!mnt_fs_is_pseudofs(fs))
+			xsrc = mnt_pretty_path(src, cache);
+		printf ("%s on %s", xsrc ? xsrc : src, mnt_fs_get_target(fs));
 		if (type)
 			printf (" type %s", type);
 		if (optstr)
-- 
1.7.8.3

