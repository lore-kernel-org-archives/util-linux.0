Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:53934 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767AbcBZDIn (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:08:43 -0500
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Daniel Trebbien <dtrebbien@gmail.com>
Subject: [PATCH 14/14] lib: include strutils.h for mempcpy()
Date: Fri, 26 Feb 2016 04:08:38 +0100
Message-Id: <1456456118-19584-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
 <1456456118-19584-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

We have that mempcpy fallback since 2013 (02887b73) but forgot to
include it.

This fixes a segfault of cal(1) on FreeBSD and OSX.

Compiler warning was:
lib/mbsalign.c:468:14: warning: implicit declaration of function 'mempcpy' is invalid in C99 [-Wimplicit-function-declaration]
      dest = mempcpy (dest, str_to_print, min (n_used_bytes, space_left));
             ^
lib/mbsalign.c:468:12: warning: incompatible integer to pointer conversion assigning to 'char *' from 'int' [-Wint-conversion]
      dest = mempcpy (dest, str_to_print, min (n_used_bytes, space_left));

CC: Daniel Trebbien <dtrebbien@gmail.com>
Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 lib/mbsalign.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/mbsalign.c b/lib/mbsalign.c
index 2a8de2f..f9babba 100644
--- a/lib/mbsalign.c
+++ b/lib/mbsalign.c
@@ -27,6 +27,7 @@
 
 #include "c.h"
 #include "mbsalign.h"
+#include "strutils.h"
 #include "widechar.h"
 
 #ifdef HAVE_WIDECHAR
-- 
1.8.4.5

