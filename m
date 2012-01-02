Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qw0-f53.google.com ([209.85.216.53]:50378 "EHLO
	mail-qw0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470Ab2ABOtp (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 2 Jan 2012 09:49:45 -0500
Received: by qadb15 with SMTP id b15so10352884qad.19
        for <util-linux@vger.kernel.org>; Mon, 02 Jan 2012 06:49:45 -0800 (PST)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] libmount/fs: fix typo in function name
Date: Mon,  2 Jan 2012 09:49:42 -0500
Message-Id: <1325515782-14402-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Build broken in c70d9d7.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 libmount/src/fs.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index 43faa05..a28e66c 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -470,7 +470,7 @@ int mnt_fs_is_swaparea(struct libmnt_fs *fs)
  *
  * Returns: 1 if the filesystem is a pseudo fs type (proc, cgroups)
  */
-int mnt_fs_is_pseudo(struct libmnt_fs *fs)
+int mnt_fs_is_pseudofs(struct libmnt_fs *fs)
 {
 	return mnt_fs_get_flags(fs) & MNT_FS_PSEUDO;
 }
-- 
1.7.8.1

