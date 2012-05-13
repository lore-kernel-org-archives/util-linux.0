Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:50763 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752199Ab2EMLoi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 13 May 2012 07:44:38 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 548B9A39FC
	for <util-linux@vger.kernel.org>; Sun, 13 May 2012 13:44:37 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/3] mkswap: use is_mounted() instead of check_mount()
Date: Sun, 13 May 2012 13:44:30 +0200
Message-Id: <1336909472-12277-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 disk-utils/Makefile.am |    1 +
 disk-utils/mkswap.c    |   26 ++------------------------
 2 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/disk-utils/Makefile.am b/disk-utils/Makefile.am
index 09dfa99..ecff70e 100644
--- a/disk-utils/Makefile.am
+++ b/disk-utils/Makefile.am
@@ -47,6 +47,7 @@ swaplabel_CFLAGS = $(AM_CFLAGS) $(uuid_cflags)
 
 mkswap_SOURCES = \
 	mkswap.c \
+	$(top_srcdir)/lib/ismounted.c \
 	$(top_srcdir)/lib/strutils.c \
 	$(top_srcdir)/lib/wholedisk.c \
 	$(utils_common)
diff --git a/disk-utils/mkswap.c b/disk-utils/mkswap.c
index 51a0c89..c7dedd7 100644
--- a/disk-utils/mkswap.c
+++ b/disk-utils/mkswap.c
@@ -58,6 +58,7 @@
 #include "xalloc.h"
 #include "c.h"
 #include "closestream.h"
+#include "ismounted.h"
 
 #ifdef HAVE_LIBUUID
 # include <uuid.h>
@@ -348,29 +349,6 @@ get_size(const char *file)
 	return size;
 }
 
-/*
- * Check to make certain that our new filesystem won't be created on
- * an already mounted partition.  Code adapted from mke2fs, Copyright
- * (C) 1994 Theodore Ts'o.  Also licensed under GPL.
- * (C) 2006 Karel Zak -- port to mkswap
- */
-static int
-check_mount(void)
-{
-	FILE *f;
-	struct mntent *mnt;
-
-	if ((f = setmntent (_PATH_MOUNTED, "r")) == NULL)
-		return 0;
-	while ((mnt = getmntent (f)) != NULL)
-		if (strcmp (device_name, mnt->mnt_fsname) == 0)
-			break;
-	endmntent (f);
-	if (!mnt)
-		return 0;
-	return 1;
-}
-
 #ifdef HAVE_LIBBLKID
 static blkid_probe
 new_prober(int fd)
@@ -625,7 +603,7 @@ main(int argc, char **argv) {
 		errx(EXIT_FAILURE, _("error: "
 			"will not try to make swapdevice on '%s'"),
 			device_name);
-	else if (check_mount())
+	else if (is_mounted(device_name))
 		errx(EXIT_FAILURE, _("error: "
 			"%s is mounted; will not make swapspace."),
 			device_name);
-- 
1.7.7

