Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:60445 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754015Ab2CBDrG (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 1 Mar 2012 22:47:06 -0500
Received: by vbbff1 with SMTP id ff1so1153773vbb.19
        for <util-linux@vger.kernel.org>; Thu, 01 Mar 2012 19:47:04 -0800 (PST)
MIME-Version: 1.0
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/2] mountpoint: account for error from in mnt_fs_get_target
Date: Thu,  1 Mar 2012 22:46:59 -0500
Message-Id: <1330660020-32542-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

commit 04f087ec didn't take into consideration that mnt_fs_get_target()
could return an error, and would therefore show false positives, such
as:

$ mkdir foo; mountpoint foo
foo is a mountpoint

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 sys-utils/mountpoint.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index bd92667..a45cabd 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -45,6 +45,7 @@ static int dir_to_device(const char *spec, dev_t *dev)
 	struct libmnt_table *tb = mnt_new_table_from_file("/proc/self/mountinfo");
 	struct libmnt_fs *fs;
 	struct libmnt_cache *cache;
+	int rc = -1;
 
 	if (!tb) {
 		/*
@@ -82,12 +83,14 @@ static int dir_to_device(const char *spec, dev_t *dev)
 	mnt_table_set_cache(tb, cache);
 
 	fs = mnt_table_find_target(tb, spec, MNT_ITER_BACKWARD);
-	if (fs && mnt_fs_get_target(fs))
+	if (fs && mnt_fs_get_target(fs)) {
 		*dev = mnt_fs_get_devno(fs);
+		rc = 0;
+	}
 
 	mnt_free_table(tb);
 	mnt_free_cache(cache);
-	return 0;
+	return rc;
 }
 
 static int print_devno(const char *devname, struct stat *st)
-- 
1.7.9.2

