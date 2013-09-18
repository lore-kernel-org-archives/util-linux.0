Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:52279 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751344Ab3IROPc (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 18 Sep 2013 10:15:32 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] libmount/context_umount: free username after check
Date: Wed, 18 Sep 2013 10:15:29 -0400
Message-Id: <1379513729-15563-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Leak reported by valgrind:

==14226== 7 bytes in 1 blocks are definitely lost in loss record 1 of 1
==14226==    at 0x4C2757B: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==14226==    by 0x5534839: strdup (in /usr/lib/libc-2.18.so)
==14226==    by 0x4E53FE0: mnt_get_username (utils.c:560)
==14226==    by 0x4E456A5: mnt_context_prepare_umount (context_umount.c:413)
==14226==    by 0x4E464F7: mnt_context_umount (context_umount.c:851)
==14226==    by 0x403476: umount_one (umount.c:299)
==14226==    by 0x402B34: main (umount.c:629)

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 libmount/src/context_umount.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/libmount/src/context_umount.c b/libmount/src/context_umount.c
index 2e912c0..766adfd 100644
--- a/libmount/src/context_umount.c
+++ b/libmount/src/context_umount.c
@@ -423,6 +423,8 @@ static int evaluate_permissions(struct libmnt_context *cxt)
 		if (optstr && !mnt_optstr_get_option(optstr,
 					"user", &mtab_user, &sz) && sz)
 			ok = !strncmp(curr_user, mtab_user, sz);
+
+		free(curr_user);
 	}
 
 	if (ok) {
-- 
1.8.4

