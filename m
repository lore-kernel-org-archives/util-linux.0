Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:64925 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751224AbdFVUnr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Jun 2017 16:43:47 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MIhDo-1dLw1x2ZR2-002Ge0 for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 22:43:45 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/5] misc: fix xalloc.h related exit codes
Date: Thu, 22 Jun 2017 22:43:43 +0200
Message-Id: <1498164224-13549-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
References: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Found by:

grep -L "XALLOC_EXIT_CODE" $(grep -l "xalloc\.h" \
    $(git grep -l "_EX_\|FINDFS_\|BLKID_EXIT\|EX_USAGE" -- "*.c"))

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/mkfs.minix.c | 2 ++
 misc-utils/blkid.c      | 2 ++
 sys-utils/hwclock.c     | 1 +
 sys-utils/mount.c       | 4 +++-
 sys-utils/umount.c      | 2 ++
 5 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index 96d36b0..98a6266 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -77,6 +77,8 @@
 #include "all-io.h"
 #include "closestream.h"
 #include "ismounted.h"
+
+#define XALLOC_EXIT_CODE MKFS_EX_ERROR
 #include "xalloc.h"
 
 #define MINIX_ROOT_INO 1
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 73731f0..3e6f1ce 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -42,6 +42,8 @@
 
 #include "nls.h"
 #include "ttyutils.h"
+
+#define XALLOC_EXIT_CODE    BLKID_EXIT_OTHER    /* x.*alloc(), xstrndup() */
 #include "xalloc.h"
 
 struct blkid_control {
diff --git a/sys-utils/hwclock.c b/sys-utils/hwclock.c
index 325106a..5c34144 100644
--- a/sys-utils/hwclock.c
+++ b/sys-utils/hwclock.c
@@ -71,6 +71,7 @@
 #include <unistd.h>
 
 #define OPTUTILS_EXIT_CODE EX_USAGE
+#define XALLOC_EXIT_CODE EX_OSERR
 
 #include "c.h"
 #include "closestream.h"
diff --git a/sys-utils/mount.c b/sys-utils/mount.c
index 0f7fa90..ffe294e 100644
--- a/sys-utils/mount.c
+++ b/sys-utils/mount.c
@@ -36,10 +36,12 @@
 #include "c.h"
 #include "env.h"
 #include "strutils.h"
-#include "xalloc.h"
 #include "closestream.h"
 #include "canonicalize.h"
 
+#define XALLOC_EXIT_CODE MNT_EX_SYSERR
+#include "xalloc.h"
+
 #define OPTUTILS_EXIT_CODE MNT_EX_USAGE
 #include "optutils.h"
 
diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index ed8fd4f..2dfb139 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -36,6 +36,8 @@
 #include "closestream.h"
 #include "pathnames.h"
 #include "canonicalize.h"
+
+#define XALLOC_EXIT_CODE MNT_EX_SYSERR
 #include "xalloc.h"
 
 static int table_parser_errcb(struct libmnt_table *tb __attribute__((__unused__)),
-- 
1.8.5.6

