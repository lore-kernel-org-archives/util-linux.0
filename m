Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:54872 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751202AbdFVUnr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Jun 2017 16:43:47 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lz0aC-1dt8DJ0KRM-014Czo for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 22:43:45 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/5] lib: fix strutils.h, remove STRTOXX_EXIT_CODE
Date: Thu, 22 Jun 2017 22:43:41 +0200
Message-Id: <1498164224-13549-3-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
References: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

As discussed on the mailing list. We fix all places
where the non-working define STRTOXX_EXIT_CODE was used.

Regarding tunelp, also see 7e3c80a7.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 disk-utils/fsck.c  | 3 +--
 include/strutils.h | 7 ++-----
 lib/strutils.c     | 6 ++++++
 misc-utils/blkid.c | 3 ++-
 sys-utils/tunelp.c | 7 ++++---
 5 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/disk-utils/fsck.c b/disk-utils/fsck.c
index 5a418fc..e310fc3 100644
--- a/disk-utils/fsck.c
+++ b/disk-utils/fsck.c
@@ -54,8 +54,6 @@
 #include "c.h"
 #include "fileutils.h"
 #include "monotonic.h"
-
-#define STRTOXX_EXIT_CODE	FSCK_EX_USAGE
 #include "strutils.h"
 
 #define XALLOC_EXIT_CODE	FSCK_EX_ERROR
@@ -1599,6 +1597,7 @@ int main(int argc, char *argv[])
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	strutils_set_exitcode(FSCK_EX_USAGE);
 	mnt_init_debug(0);		/* init libmount debug mask */
 	mntcache = mnt_new_cache();	/* no fatal error if failed */
 
diff --git a/include/strutils.h b/include/strutils.h
index 28c1b5e..be1ba67 100644
--- a/include/strutils.h
+++ b/include/strutils.h
@@ -9,11 +9,8 @@
 #include <stdio.h>
 #include <errno.h>
 
-/* default strtoxx_or_err() exit code */
-#ifndef STRTOXX_EXIT_CODE
-# define STRTOXX_EXIT_CODE EXIT_FAILURE
-#endif
-
+/* initialize a custom exit code for all *_or_err functions */
+extern void strutils_set_exitcode(int exit_code);
 
 extern int parse_size(const char *str, uintmax_t *res, int *power);
 extern int strtosize(const char *str, uintmax_t *res);
diff --git a/lib/strutils.c b/lib/strutils.c
index 45127b5..74d2e5a 100644
--- a/lib/strutils.c
+++ b/lib/strutils.c
@@ -17,6 +17,12 @@
 #include "strutils.h"
 #include "bitops.h"
 
+static int STRTOXX_EXIT_CODE = EXIT_FAILURE;
+
+void strutils_set_exitcode(int ex) {
+	STRTOXX_EXIT_CODE = ex;
+}
+
 static int do_scale_by_power (uintmax_t *x, int base, int power)
 {
 	while (power--) {
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 1dc8f40..73731f0 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -34,7 +34,6 @@
 
 #include "ismounted.h"
 
-#define STRTOXX_EXIT_CODE	BLKID_EXIT_OTHER	/* strtoxx_or_err() */
 #include "strutils.h"
 #define OPTUTILS_EXIT_CODE	BLKID_EXIT_OTHER	/* exclusive_option() */
 #include "optutils.h"
@@ -691,6 +690,8 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	strutils_set_exitcode(BLKID_EXIT_OTHER);
+
 	while ((c = getopt_long (argc, argv,
 			    "c:dghilL:n:ko:O:ps:S:t:u:U:w:Vv", longopts, NULL)) != -1) {
 
diff --git a/sys-utils/tunelp.c b/sys-utils/tunelp.c
index 89afff1..2749dd1 100644
--- a/sys-utils/tunelp.c
+++ b/sys-utils/tunelp.c
@@ -72,13 +72,12 @@
 #include "lp.h"
 #include "nls.h"
 #include "closestream.h"
+#include "strutils.h"
 
 #define EXIT_LP_MALLOC		2
-#define STRTOXX_EXIT_CODE	3
+#define EXIT_LP_BADVAL		3
 #define EXIT_LP_IO_ERR		4
 
-#include "strutils.h"
-
 #define XALLOC_EXIT_CODE EXIT_LP_MALLOC
 #include "xalloc.h"
 
@@ -147,6 +146,8 @@ int main(int argc, char **argv)
 	textdomain(PACKAGE);
 	atexit(close_stdout);
 
+	strutils_set_exitcode(EXIT_LP_BADVAL);
+
 	if (argc < 2)
 		print_usage(stderr);
 
-- 
1.8.5.6

