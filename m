Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:58286 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751842AbdFVUnr (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 22 Jun 2017 16:43:47 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Li1hG-1eBDIR3Ugc-00n5aM for
 <util-linux@vger.kernel.org>; Thu, 22 Jun 2017 22:43:45 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] misc: fix optutils.h related exit codes
Date: Thu, 22 Jun 2017 22:43:44 +0200
Message-Id: <1498164224-13549-6-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
References: <1498164224-13549-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Found by:

  grep -L "OPTUTILS_EXIT_CODE" $(grep -l "err_exclusive_options" \
      $(git grep -l "_EX_\|FINDFS_\|BLKID_EXIT\|EX_USAGE" -- "*.c"))

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 sys-utils/umount.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sys-utils/umount.c b/sys-utils/umount.c
index 2dfb139..57140a6 100644
--- a/sys-utils/umount.c
+++ b/sys-utils/umount.c
@@ -32,7 +32,6 @@
 #include "nls.h"
 #include "c.h"
 #include "env.h"
-#include "optutils.h"
 #include "closestream.h"
 #include "pathnames.h"
 #include "canonicalize.h"
@@ -40,6 +39,9 @@
 #define XALLOC_EXIT_CODE MNT_EX_SYSERR
 #include "xalloc.h"
 
+#define OPTUTILS_EXIT_CODE MNT_EX_USAGE
+#include "optutils.h"
+
 static int table_parser_errcb(struct libmnt_table *tb __attribute__((__unused__)),
 			const char *filename, int line)
 {
-- 
1.8.5.6

