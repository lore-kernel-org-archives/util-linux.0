Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:60982 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751193AbdFVUnq (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Jun 2017 16:43:46 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lwoiq-1dqvI83itE-016Puy for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 22:43:44 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/5] misc: fix some broken exit codes
Date: Thu, 22 Jun 2017 22:43:40 +0200
Message-Id: <1498164224-13549-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
References: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

These tools have special exit codes. They got changed mistakenly.

See:
  findfs       0e1fa6b6
  fsck         658c0891
  fsck.cramfs  922ec175
  mkfs.cramfs  16154b1f
  tunelp       2ab428f6

FIXME: STRTOXX_EXIT_CODE doesn't work as it should.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.c        | 2 +-
 disk-utils/fsck.cramfs.c | 2 +-
 disk-utils/mkfs.cramfs.c | 2 +-
 misc-utils/findfs.c      | 4 ++--
 sys-utils/tunelp.c       | 5 ++++-
 5 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index cb1b212..5a418fc 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -55,7 +55,7 @@
 #include "fileutils.h"
 #include "monotonic.h"
 
-#define STRTOXX_EXIT_CODE	FSCK_EX_ERROR
+#define STRTOXX_EXIT_CODE	FSCK_EX_USAGE
 #include "strutils.h"
 
 #define XALLOC_EXIT_CODE	FSCK_EX_ERROR
diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 63033d6..952f153 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -671,7 +671,7 @@ int main(int argc, char **argv)
 			break;
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
-			return EXIT_SUCCESS;
+			return FSCK_EX_OK;
 		case 'x':
 			opt_extract = 1;
 			if(optarg)
diff --git a/disk-utils/mkfs.cramfs.c b/disk-utils/mkfs.cramfs.c
index 77b4467..041c6d7 100644
--- a/disk-utils/mkfs.cramfs.c
+++ b/disk-utils/mkfs.cramfs.c
@@ -910,5 +910,5 @@ int main(int argc, char **argv)
 	    (warn_namelen|warn_skip|warn_size|warn_uid|warn_gid|warn_dev))
 		exit(MKFS_EX_ERROR);
 
-	return EXIT_SUCCESS;
+	return MKFS_EX_OK;
 }
diff --git a/misc-utils/findfs.c b/misc-utils/findfs.c
index 7935232..7d2d803 100644
--- a/misc-utils/findfs.c
+++ b/misc-utils/findfs.c
@@ -63,11 +63,11 @@ int main(int argc, char **argv)
 		switch (c) {
 		case 'V':
 			printf(UTIL_LINUX_VERSION);
-			return EXIT_SUCCESS;
+			return FINDFS_SUCCESS;
 		case 'h':
 			usage(FINDFS_SUCCESS);
 		default:
-			errtryhelp(EXIT_FAILURE);
+			errtryhelp(FINDFS_USAGE_ERROR);
 		}
 
 	dev = blkid_evaluate_tag(argv[1], NULL, NULL);
diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index 8cfbe80..89afff1 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -71,14 +71,17 @@
 
 #include "lp.h"
 #include "nls.h"
-#include "xalloc.h"
 #include "closestream.h"
 
+#define EXIT_LP_MALLOC		2
 #define STRTOXX_EXIT_CODE	3
 #define EXIT_LP_IO_ERR		4
 
 #include "strutils.h"
 
+#define XALLOC_EXIT_CODE EXIT_LP_MALLOC
+#include "xalloc.h"
+
 struct command {
 	long op;
 	long val;
-- 
1.8.5.6

