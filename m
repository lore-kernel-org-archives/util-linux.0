Return-Path: util-linux-owner@vger.kernel.org
Received: from mx1.redhat.com ([209.132.183.28]:59491 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750828AbaKFMBf (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 6 Nov 2014 07:01:35 -0500
Date: Thu, 6 Nov 2014 13:01:26 +0100
From: Karel Zak <kzak@redhat.com>
To: Natanael Copa <ncopa@alpinelinux.org>, util-linux@vger.kernel.org
Subject: Re: [PATCH] switch_root: use typeof() instead of __SWORD_TYPE
Message-ID: <20141106120126.GC6880@x2.net.home>
References: <1414573745-15664-1-git-send-email-ncopa@alpinelinux.org>
 <20141029193752.GA32734@vapier.wh0rd.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20141029193752.GA32734@vapier.wh0rd.info>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

On Wed, Oct 29, 2014 at 03:37:52PM -0400, Mike Frysinger wrote:
> On 29 Oct 2014 09:09, Natanael Copa wrote:
> > +			    (stfs.f_type == (typeof(stfs.f_type))STATFS_RAMFS_MAGIC ||
> > +			     stfs.f_type == (typeof(stfs.f_type))STATFS_TMPFS_MAGIC))
> 
> typeof is a gcc extension and really should be __typeof__.  ignoring irony of 
> replacing on unportable behavior with another ;).

:-)

I have applied the patch below, please review. It is not perfect, but I
hope good enough for usual cases (gcc, clang).

    Karel


>From 8f806bb1ea30f15db7ca36d1cfa79349f8115302 Mon Sep 17 00:00:00 2001
From: Karel Zak <kzak@redhat.com>
Date: Thu, 6 Nov 2014 12:50:27 +0100
Subject: [PATCH] switch_root: improve statfs->f_type portability

__SWORD_TYPE is not available everywhere, for example it's not defined
by musl libc. It also seems that __SWORD_TYPE is not used for f_type
on some architectures (s390x).

Reported-by: Natanael Copa <ncopa@alpinelinux.org>
Signed-off-by: Karel Zak <kzak@redhat.com>
---
 include/statfs_magic.h  | 11 +++++++++++
 sys-utils/switch_root.c |  4 ++--
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/include/statfs_magic.h b/include/statfs_magic.h
index b5fde1a..d27be1c 100644
--- a/include/statfs_magic.h
+++ b/include/statfs_magic.h
@@ -1,6 +1,17 @@
 #ifndef UTIL_LINUX_STATFS_MAGIC_H
 #define UTIL_LINUX_STATFS_MAGIC_H
 
+#include <sys/statfs.h>
+
+/*
+ * If possible then don't depend on internal libc __SWORD_TYPE type.
+ */
+#ifdef __GNUC__
+typedef __typeof__( ((struct statfs *)0)->f_type )	ul_statfs_ftype_t;
+#else
+typedef __SWORD_TYPE	ul_statfs_ftype_t;
+#endif
+
 /*
  *  Unfortunately, Linux kernel hedeader file <linux/magic.h> is incomplete
  *  mess and kernel returns by statfs f_type many numbers that are nowhere
diff --git a/sys-utils/switch_root.c b/sys-utils/switch_root.c
index 6822a5d..c6a2eff 100644
--- a/sys-utils/switch_root.c
+++ b/sys-utils/switch_root.c
@@ -181,8 +181,8 @@ static int switchroot(const char *newroot)
 		if (pid <= 0) {
 			struct statfs stfs;
 			if (fstatfs(cfd, &stfs) == 0 &&
-			    (stfs.f_type == (__SWORD_TYPE)STATFS_RAMFS_MAGIC ||
-			     stfs.f_type == (__SWORD_TYPE)STATFS_TMPFS_MAGIC))
+			    (stfs.f_type == (ul_statfs_ftype_t) STATFS_RAMFS_MAGIC ||
+			     stfs.f_type == (ul_statfs_ftype_t) STATFS_TMPFS_MAGIC))
 				recursiveRemove(cfd);
 			else
 				warn(_("old root filesystem is not an initramfs"));
-- 
1.9.3



-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com
