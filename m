Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:33727 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750834AbbJCSbN (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Oct 2015 14:31:13 -0400
Received: by wiclk2 with SMTP id lk2so71339353wic.0
        for <util-linux@vger.kernel.org>; Sat, 03 Oct 2015 11:31:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/4] blkid, uuidd, uuidgen: assume getopt.h and getopt.h are available
Date: Sat,  3 Oct 2015 19:31:05 +0100
Message-Id: <1443897067-6005-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
References: <1443897067-6005-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

These headers are in use allover this project without issues.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/blkid.c   | 6 ------
 misc-utils/uuidd.c   | 8 --------
 misc-utils/uuidgen.c | 8 --------
 3 files changed, 22 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index bbe7b62..c0be457 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -17,13 +17,7 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
-#ifdef HAVE_GETOPT_H
 #include <getopt.h>
-#else
-extern int getopt(int argc, char * const argv[], const char *optstring);
-extern char *optarg;
-extern int optind;
-#endif
 
 #define OUTPUT_VALUE_ONLY	(1 << 1)
 #define OUTPUT_DEVICE_ONLY	(1 << 2)
diff --git a/misc-utils/uuidd.c b/misc-utils/uuidd.c
index 76f5e41..e19be52 100644
--- a/misc-utils/uuidd.c
+++ b/misc-utils/uuidd.c
@@ -9,9 +9,7 @@
  * %End-Header%
  */
 #include <stdio.h>
-#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
-#endif
 #include <unistd.h>
 #include <inttypes.h>
 #include <errno.h>
@@ -23,13 +21,7 @@
 #include <fcntl.h>
 #include <signal.h>
 #include <string.h>
-#ifdef HAVE_GETOPT_H
 #include <getopt.h>
-#else
-extern int getopt(int argc, char * const argv[], const char *optstring);
-extern char *optarg;
-extern int optind;
-#endif
 
 #include "uuid.h"
 #include "uuidd.h"
diff --git a/misc-utils/uuidgen.c b/misc-utils/uuidgen.c
index 54c5773..40b00ff 100644
--- a/misc-utils/uuidgen.c
+++ b/misc-utils/uuidgen.c
@@ -10,16 +10,8 @@
  */
 
 #include <stdio.h>
-#ifdef HAVE_STDLIB_H
 #include <stdlib.h>
-#endif
-#ifdef HAVE_GETOPT_H
 #include <getopt.h>
-#else
-extern int getopt(int argc, char * const argv[], const char *optstring);
-extern char *optarg;
-extern int optind;
-#endif
 
 #include "uuid.h"
 #include "nls.h"
-- 
2.6.0

