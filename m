Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-vw0-f46.google.com ([209.85.212.46]:45841 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751487Ab1JIPLz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 9 Oct 2011 11:11:55 -0400
Received: by vws1 with SMTP id 1so4091412vws.19
        for <util-linux@vger.kernel.org>; Sun, 09 Oct 2011 08:11:54 -0700 (PDT)
From: Dave Reisner <d@falconindy.com>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 2/2] mountpoint: support symbolic and relative paths
Date: Sun,  9 Oct 2011 11:12:05 -0400
Message-Id: <1318173125-16156-2-git-send-email-dreisner@archlinux.org>
In-Reply-To: <1318173125-16156-1-git-send-email-dreisner@archlinux.org>
References: <1318173125-16156-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use our own canonicalize library to resolve a provided path before
checking if its a mountpoint.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
Unless I've missed something, this should bring u-l's mountpoint to feature
parity with sysvinit's.

 sys-utils/Makefile.am  |    1 +
 sys-utils/mountpoint.c |    5 ++++-
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/sys-utils/Makefile.am b/sys-utils/Makefile.am
index 8059ee6..34108da 100644
--- a/sys-utils/Makefile.am
+++ b/sys-utils/Makefile.am
@@ -44,6 +44,7 @@ flock_SOURCES = flock.c $(top_srcdir)/lib/strutils.c
 
 if BUILD_MOUNTPOINT
 bin_PROGRAMS += mountpoint
+mountpoint_SOURCES = mountpoint.c $(top_srcdir)/lib/canonicalize.c
 mountpoint_LDADD = $(ul_libmount_la)
 mountpoint_CFLAGS = $(AM_CFLAGS) -I$(ul_libmount_incdir)
 dist_man_MANS += mountpoint.1
diff --git a/sys-utils/mountpoint.c b/sys-utils/mountpoint.c
index e021c70..204f061 100644
--- a/sys-utils/mountpoint.c
+++ b/sys-utils/mountpoint.c
@@ -37,6 +37,7 @@
 #include "nls.h"
 #include "xalloc.h"
 #include "c.h"
+#include "canonicalize.h"
 
 static int quiet;
 
@@ -147,7 +148,8 @@ int main(int argc, char **argv)
 	if (optind + 1 != argc)
 		usage(stderr);
 
-	spec = argv[optind++];
+	/* resolve relative paths to absolute */
+	spec = canonicalize_path(argv[optind++]);
 
 	if (stat(spec, &st)) {
 		if (!quiet)
@@ -179,5 +181,6 @@ int main(int argc, char **argv)
 	}
 
 finish:
+	free(spec);
 	return rc;
 }
-- 
1.7.7

