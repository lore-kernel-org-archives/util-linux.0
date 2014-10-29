Return-Path: util-linux-owner@vger.kernel.org
Received: from mail.alpinelinux.org ([74.117.189.114]:48474 "EHLO
	mail.alpinelinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756181AbaJ2JJS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 29 Oct 2014 05:09:18 -0400
From: Natanael Copa <ncopa@alpinelinux.org>
To: util-linux@vger.kernel.org
Cc: Natanael Copa <ncopa@alpinelinux.org>
Subject: [PATCH] switch_root: use typeof() instead of __SWORD_TYPE
Date: Wed, 29 Oct 2014 09:09:05 +0000
Message-Id: <1414573745-15664-1-git-send-email-ncopa@alpinelinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Identifiers prefixed with __ are normally for internal use and should
normally not be used outside libc.

This fixes the following compile error with musl libc:
sys-utils/switch_root.c:184:25: error: '__SWORD_TYPE' undeclared (first use in this function)
        (stfs.f_type == (__SWORD_TYPE)STATFS_RAMFS_MAGIC ||
                         ^

Also, statfs(2) man page is also wrong on some systems, because f_type
is not __SWORD_TYPE on some architecures.

The following program:

int main(int argc, char**argv)
{
        struct statfs s;
        statfs(argv[1], &s);

	printf("sizeof(f_type) = %d\n", sizeof(s.f_type));
	printf("sizeof(__SWORD_TYPE) = %d\n", sizeof(__SWORD_TYPE));
	printf("sizeof(long) = %d\n", sizeof(long));
	printf("sizeof(int) = %d\n", sizeof(int));
	if (sizeof(s.f_type) == sizeof(int)) {
		printf("f_type = 0x%x\n", s.f_type);
	} else {
                printf("f_type = 0x%lx\n", s.f_type);
	}
        return 0;
}

executed on s390x gives for a btrfs:

sizeof(f_type) = 4
sizeof(__SWORD_TYPE) = 8
sizeof(long) = 8
sizeof(int) = 4
f_type = 0x9123683e

Signed-off-by: Natanael Copa <ncopa@alpinelinux.org>
---
This is similar to what they did in systemd:
http://cgit.freedesktop.org/systemd/systemd/commit/?id=bdd29249a882e599e5e365536372d08dee398cd4

 sys-utils/switch_root.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index 6822a5d..3fbecdd 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -181,8 +181,8 @@ static int switchroot(const char *newroot)
 		if (pid <= 0) {
 			struct statfs stfs;
 			if (fstatfs(cfd, &stfs) == 0 &&
-			    (stfs.f_type == (__SWORD_TYPE)STATFS_RAMFS_MAGIC ||
-			     stfs.f_type == (__SWORD_TYPE)STATFS_TMPFS_MAGIC))
+			    (stfs.f_type == (typeof(stfs.f_type))STATFS_RAMFS_MAGIC ||
+			     stfs.f_type == (typeof(stfs.f_type))STATFS_TMPFS_MAGIC))
 				recursiveRemove(cfd);
 			else
 				warn(_("old root filesystem is not an initramfs"));
-- 
2.1.2

