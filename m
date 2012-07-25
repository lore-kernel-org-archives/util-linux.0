Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:36641 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751150Ab2GYTQM (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Jul 2012 15:16:12 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so1069033wgb.1
        for <util-linux@vger.kernel.org>; Wed, 25 Jul 2012 12:16:11 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/5] wdctl: fix conflicting types on old systems
Date: Wed, 25 Jul 2012 21:15:43 +0200
Message-Id: <1343243745-1172-26-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
References: <1343243745-1172-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The program wants the userland version of declaration(s), not the
kernel one.  Problem occured with glibc-devel-2.5-34.

/usr/include/stdint.h:41: error: conflicting types for 'int64_t'
/usr/include/linux/types.h:98: error: previous declaration of 'int64_t' was here
/usr/include/stdint.h:56: error: conflicting types for 'uint64_t'
/usr/include/linux/types.h:96: error: previous declaration of 'uint64_t' was here
In file included from /usr/include/stdlib.h:438,
                 from ./include/c.h:13,
                 from sys-utils/wdctl.c:30:

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/wdctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/wdctl.c b/sys-utils/wdctl.c
index ebe55b4..d5ca50c 100644
--- a/sys-utils/wdctl.c
+++ b/sys-utils/wdctl.c
@@ -18,13 +18,13 @@
  * with this program; if not, write to the Free Software Foundation, Inc.,
  * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
-#include <linux/watchdog.h>
 #include <sys/ioctl.h>
 #include <getopt.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <signal.h>
 #include <assert.h>
+#include <linux/watchdog.h>
 
 #include "nls.h"
 #include "c.h"
-- 
1.7.11.3

