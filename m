Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33208 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751086AbdBTWMu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 20 Feb 2017 17:12:50 -0500
Received: by mail-wm0-f65.google.com with SMTP id v77so16720123wmv.0
        for <util-linux@vger.kernel.org>; Mon, 20 Feb 2017 14:12:46 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] fdisk, sfdisk: avoid non-ANSI function declarations [smatch scan]
Date: Mon, 20 Feb 2017 22:12:42 +0000
Message-Id: <20170220221242.24130-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Adding _FUNCTION_DEF definition will exclude compatibility type definitions
that do include void key word in empty argument list.

/usr/include/readline/rltypedefs.h:35:23: warning: non-ANSI function
declaration of function 'Function'

These functions has been replaced by set of new ones in readline 4.2 (April
2001), and removed in 6.3 (February 2014).

Reference: https://cnswww.cns.cwru.edu/php/chet/readline/CHANGES
Rererence: https://blueslugs.com/blog/2016-10-23-updating-cppfunction-in-old-readline-consumers/
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fdisk.c  | 1 +
 disk-utils/sfdisk.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/disk-utils/fdisk.c b/disk-utils/fdisk.c
index 4ac58ee4d..f1cd3aa5a 100644
--- a/disk-utils/fdisk.c
+++ b/disk-utils/fdisk.c
@@ -23,6 +23,7 @@
 #include <limits.h>
 #include <libsmartcols.h>
 #ifdef HAVE_LIBREADLINE
+# define _FUNCTION_DEF
 # include <readline/readline.h>
 #endif
 
diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index f4f9b6b1a..b492b0cb5 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -33,6 +33,7 @@
 #include <fcntl.h>
 #include <libsmartcols.h>
 #ifdef HAVE_LIBREADLINE
+# define _FUNCTION_DEF
 # include <readline/readline.h>
 #endif
 #include <libgen.h>
-- 
2.11.1

