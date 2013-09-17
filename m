Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:57896 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753933Ab3IQVLK (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 17 Sep 2013 17:11:10 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] libmount/utils: use memmove when overlap possible
Date: Tue, 17 Sep 2013 17:05:09 -0400
Message-Id: <1379451909-23800-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When unmounting some mountpoints as an unprivileged user (via the
'user' option in fstab), the umount fails. Debug output of 'umount
/opt' reveals:

17760: libmount: CXT: [0x22890e0]: do umount
17760: libmount: UTILS: moving to /opt parent
17760: libmount: CXT: current directory moved to / [last_component='opt']
17760: libmount: CXT: [0x22890e0]: umount(2) [target='pt', flags=0x00000000]

valgrind shows the problem:

==23544== Source and destination overlap in memcpy(0x58d1370, 0x58d1371, 4)
==23544==    at 0x4C2BBC3: memcpy@@GLIBC_2.14 (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==23544==    by 0x4E537C3: mnt_chdir_to_parent (utils.c:168)
==23544==    by 0x4E45E4C: mnt_context_do_umount (context_umount.c:601)
==23544==    by 0x4E46513: mnt_context_umount (context_umount.c:855)
==23544==    by 0x403476: umount_one (umount.c:299)
==23544==    by 0x402B34: main (umount.c:629)
==23544==

ref: https://bugs.archlinux.org/task/36968
Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 libmount/src/utils.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 9f99241..3cab936 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -165,7 +165,7 @@ int mnt_chdir_to_parent(const char *target, char **filename)
 		if (!last || !*last)
 			memcpy(*filename, ".", 2);
 		else
-			memcpy(*filename, last, strlen(last) + 1);
+			memmove(*filename, last, strlen(last) + 1);
 	} else
 		free(buf);
 	return 0;
-- 
1.8.4

