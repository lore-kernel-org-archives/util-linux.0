Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:57708 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751124AbaGZKxN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 26 Jul 2014 06:53:13 -0400
Received: by mail-wg0-f51.google.com with SMTP id b13so5137555wgh.10
        for <util-linux@vger.kernel.org>; Sat, 26 Jul 2014 03:53:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] swaplabel: move swapon-common to include directory
Date: Sat, 26 Jul 2014 11:53:06 +0100
Message-Id: <1406371986-16508-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This fixes the following compiler warning.

disk-utils/swaplabel.c:175:2: warning: implicit declaration of function
'get_swap_prober' [-Wimplicit-function-declaration]

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/swaplabel.c    |  1 +
 include/swapon-common.h   | 28 ++++++++++++++++++++++++++++
 sys-utils/swapon-common.h | 28 ----------------------------
 3 files changed, 29 insertions(+), 28 deletions(-)
 create mode 100644 include/swapon-common.h
 delete mode 100644 sys-utils/swapon-common.h

diff --git a/disk-utils/swaplabel.c b/disk-utils/swaplabel.c
index 809c365..a7cccc4 100644
--- a/disk-utils/swaplabel.c
+++ b/disk-utils/swaplabel.c
@@ -29,6 +29,7 @@
 #include "closestream.h"
 #include "all-io.h"
 #include "swapheader.h"
+#include "swapon-common.h"
 #include "strutils.h"
 #include "nls.h"
 
diff --git a/include/swapon-common.h b/include/swapon-common.h
new file mode 100644
index 0000000..da58e19
--- /dev/null
+++ b/include/swapon-common.h
@@ -0,0 +1,28 @@
+#ifndef UTIL_LINUX_SWAPON_COMMON_H
+#define UTIL_LINUX_SWAPON_COMMON_H
+
+#include <blkid.h>
+#include <libmount.h>
+
+extern struct libmnt_cache *mntcache;
+
+extern struct libmnt_table *get_fstab(void);
+extern struct libmnt_table *get_swaps(void);
+extern void free_tables(void);
+
+extern int match_swap(struct libmnt_fs *fs, void *data);
+extern int is_active_swap(const char *filename);
+
+extern int cannot_find(const char *special);
+
+extern void add_label(const char *label);
+extern const char *get_label(size_t i);
+extern size_t numof_labels(void);
+
+extern void add_uuid(const char *uuid);
+extern const char *get_uuid(size_t i);
+extern size_t numof_uuids(void);
+
+blkid_probe get_swap_prober(const char *devname);
+
+#endif /* UTIL_LINUX_SWAPON_COMMON_H */
diff --git a/sys-utils/swapon-common.h b/sys-utils/swapon-common.h
deleted file mode 100644
index da58e19..0000000
--- a/sys-utils/swapon-common.h
+++ /dev/null
@@ -1,28 +0,0 @@
-#ifndef UTIL_LINUX_SWAPON_COMMON_H
-#define UTIL_LINUX_SWAPON_COMMON_H
-
-#include <blkid.h>
-#include <libmount.h>
-
-extern struct libmnt_cache *mntcache;
-
-extern struct libmnt_table *get_fstab(void);
-extern struct libmnt_table *get_swaps(void);
-extern void free_tables(void);
-
-extern int match_swap(struct libmnt_fs *fs, void *data);
-extern int is_active_swap(const char *filename);
-
-extern int cannot_find(const char *special);
-
-extern void add_label(const char *label);
-extern const char *get_label(size_t i);
-extern size_t numof_labels(void);
-
-extern void add_uuid(const char *uuid);
-extern const char *get_uuid(size_t i);
-extern size_t numof_uuids(void);
-
-blkid_probe get_swap_prober(const char *devname);
-
-#endif /* UTIL_LINUX_SWAPON_COMMON_H */
-- 
2.0.3

