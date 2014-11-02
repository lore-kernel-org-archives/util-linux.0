Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f47.google.com ([74.125.82.47]:33429 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751093AbaKBU0u (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 2 Nov 2014 15:26:50 -0500
Received: by mail-wg0-f47.google.com with SMTP id a1so9790026wgh.20
        for <util-linux@vger.kernel.org>; Sun, 02 Nov 2014 12:26:48 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/8] swapoff: make LABEL= and UUID= work when turning off swap files
Date: Sun,  2 Nov 2014 20:26:24 +0000
Message-Id: <1414959991-8369-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
References: <1414959991-8369-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Before this commit the swapoff was unable to find swap files by UUID or
LABEL.  For example if one had:

$ swapon --show=name,uuid,label
NAME      UUID                                 LABEL
/swapfile bf6237f4-db89-4761-a1a3-275cfc68b114 xyzzy

then turning off the swap had issues:

$ swapoff -U bf6237f4-db89-4761-a1a3-275cfc68b114
swapoff: cannot find the device for bf6237f4-db89-4761-a1a3-275cfc68b114
$ swapoff -L xyzzy
swapoff: cannot find the device for xyzzy

This version of the swapoff is also capable to turn off multiple swap
devices that share the same UUID or LABEL.  Earlier only the first found
match was turned off.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/Makemodule.am | 13 ++++++++++---
 sys-utils/swapoff.c     | 34 +++++++++++++++++++++++-----------
 2 files changed, 33 insertions(+), 14 deletions(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index f540d38..b256fda 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -279,9 +279,16 @@ swapon_LDADD = $(LDADD) \
 swapoff_SOURCES = \
 	sys-utils/swapoff.c \
 	sys-utils/swapon-common.c \
-	sys-utils/swapon-common.h
-swapoff_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
-swapoff_LDADD = $(LDADD) libmount.la
+	sys-utils/swapon-common.h \
+	lib/swapprober.c \
+	include/swapprober.h
+swapoff_CFLAGS = $(AM_CFLAGS) \
+	-I$(ul_libblkid_incdir) \
+	-I$(ul_libmount_incdir)
+swapoff_LDADD = $(LDADD) \
+	libblkid.la \
+	libcommon.la \
+	libmount.la
 endif
 
 if BUILD_LSCPU
diff --git a/sys-utils/swapoff.c b/sys-utils/swapoff.c
index 182ce95..20b9249 100644
--- a/sys-utils/swapoff.c
+++ b/sys-utils/swapoff.c
@@ -9,6 +9,7 @@
 #include "nls.h"
 #include "c.h"
 #include "closestream.h"
+#include "swapprober.h"
 
 #include "swapon-common.h"
 
@@ -49,16 +50,27 @@ static int do_swapoff(const char *orig_special, int quiet, int canonic)
 	return -1;
 }
 
-static int swapoff_by_label(const char *label, int quiet)
+static int swapoff_by(const char *type, const char *request, int quiet)
 {
-	const char *special = mnt_resolve_tag("LABEL", label, mntcache);
-	return special ? do_swapoff(special, quiet, CANONIC) : cannot_find(label);
-}
+	struct libmnt_table *tb = get_swaps();
+	struct libmnt_iter *itr = mnt_new_iter(MNT_ITER_BACKWARD);
+	struct libmnt_fs *fs;
+	int ret = 0, notfound = -1;
 
-static int swapoff_by_uuid(const char *uuid, int quiet)
-{
-	const char *special = mnt_resolve_tag("UUID", uuid, mntcache);
-	return special ? do_swapoff(special, quiet, CANONIC) : cannot_find(uuid);
+	while (tb && mnt_table_find_next_fs(tb, itr, match_swap, NULL, &fs) == 0) {
+		const char *dev = mnt_fs_get_source(fs);
+		blkid_probe pr;
+		const char *data;
+
+		pr = get_swap_prober(dev);
+		blkid_probe_lookup_value(pr, type, &data, NULL);
+		if (data && !strcmp(request, data)) {
+			notfound = 0;
+			ret |= do_swapoff(dev, quiet, CANONIC);
+		}
+	}
+	ret += notfound;
+	return !ret ? 0 : cannot_find(request);
 }
 
 static void __attribute__ ((__noreturn__)) usage(FILE * out)
@@ -118,7 +130,7 @@ static int swapoff_all(void)
 
 	while (tb && mnt_table_find_next_fs(tb, itr, match_swap, NULL, &fs) == 0) {
 		if (!is_active_swap(mnt_fs_get_source(fs)))
-			do_swapoff(mnt_fs_get_source(fs), QUIET, !CANONIC);
+			do_swapoff(mnt_fs_get_source(fs), QUIET, CANONIC);
 	}
 
 	mnt_free_iter(itr);
@@ -178,10 +190,10 @@ int main(int argc, char *argv[])
 	mntcache = mnt_new_cache();
 
 	for (i = 0; i < numof_labels(); i++)
-		status |= swapoff_by_label(get_label(i), !QUIET);
+		status |= swapoff_by("LABEL", get_label(i), !QUIET);
 
 	for (i = 0; i < numof_uuids(); i++)
-		status |= swapoff_by_uuid(get_uuid(i), !QUIET);
+		status |= swapoff_by("UUID", get_uuid(i), !QUIET);
 
 	while (*argv != NULL)
 		status |= do_swapoff(*argv++, !QUIET, !CANONIC);
-- 
2.1.3

