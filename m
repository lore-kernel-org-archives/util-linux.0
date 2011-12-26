Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f53.google.com ([209.85.216.53]:42854 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab1LZWK1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 26 Dec 2011 17:10:27 -0500
Received: by qadb15 with SMTP id b15so7406026qad.19
        for <util-linux@vger.kernel.org>; Mon, 26 Dec 2011 14:10:26 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/2] libmount/tab: always trust the source of a pseudofs
Date: Mon, 26 Dec 2011 17:10:22 -0500
Message-Id: <1324937423-15766-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Since nodev FSs have no backing block device, it's unreasonable to try
and resolve the source back to a path on the filesystem. Always trust
the source of the FS given in /etc/fstab to avoid remounting the device
when a directory of the same name exists in the current working
directory.

Example reproduction:

  # mkdir /foo
  # echo 'foo  /foo  tmpfs  defaults  0  0' >> /etc/fstab
  # mount -a
  # cd /root; mkdir foo
  # mount -a
  # mount | grep /foo
  foo on /foo type tmpfs (rw,relatime)
  /root/foo on /foo type tmpfs (rw,relatime)

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 libmount/src/tab.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/libmount/src/tab.c b/libmount/src/tab.c
index 2bc49e3..da3677f 100644
--- a/libmount/src/tab.c
+++ b/libmount/src/tab.c
@@ -45,6 +45,7 @@
 
 #include "mountP.h"
 #include "strutils.h"
+#include "utils.h"
 
 /**
  * mnt_new_table:
@@ -841,6 +842,8 @@ int mnt_table_is_fs_mounted(struct libmnt_table *tb, struct libmnt_fs *fstab_fs)
 	src_fs = mnt_table_get_fs_root(tb, fstab_fs, flags, &root);
 	if (src_fs)
 		src = mnt_fs_get_srcpath(src_fs);
+	else if (mnt_fstype_is_pseudofs(mnt_fs_get_fstype(fstab_fs)))
+		src = mnt_fs_get_source(fstab_fs);
 	else
 		src = mnt_resolve_spec(mnt_fs_get_source(fstab_fs), tb->cache);
 
-- 
1.7.8.1

