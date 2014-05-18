Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:60973 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbaEROFy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 18 May 2014 10:05:54 -0400
Received: by mail-we0-f170.google.com with SMTP id u57so4497550wes.1
        for <util-linux@vger.kernel.org>; Sun, 18 May 2014 07:05:53 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 01/17] setterm: clean up includes
Date: Sun, 18 May 2014 15:05:25 +0100
Message-Id: <1400421941-14244-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
References: <1400421941-14244-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Use klogctl(2) from sys/klog.h just like dmesg(1).  The rest is just
reordering, and indenting.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/setterm.c | 40 +++++++++++++++-------------------------
 1 file changed, 15 insertions(+), 25 deletions(-)

diff --git a/term-utils/setterm.c b/term-utils/setterm.c
index 7a3131f..e6385ac 100644
--- a/term-utils/setterm.c
+++ b/term-utils/setterm.c
@@ -92,48 +92,38 @@
  *   -store stores the terminal's current rendering options as the default
  *      values.  */
 
+#include <ctype.h>
+#include <errno.h>
+#include <fcntl.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <errno.h>
-#include <ctype.h>
-#include <unistd.h>
-#include <termios.h>
 #include <string.h>
-#include <fcntl.h>
+#include <sys/ioctl.h>
+#include <sys/klog.h>
+#include <sys/param.h>		/* for MAXPATHLEN */
+#include <sys/time.h>
+#include <termios.h>
+#include <unistd.h>
 
 #ifndef NCURSES_CONST
-#define NCURSES_CONST const	/* define before including term.h */
+# define NCURSES_CONST const	/* define before including term.h */
 #endif
 #ifdef HAVE_NCURSES_H
-#include <ncurses.h>
+# include <ncurses.h>
 #elif defined(HAVE_NCURSES_NCURSES_H)
-#include <ncurses/ncurses.h>
+# include <ncurses/ncurses.h>
 #endif
 /* must include after ncurses.h */
 #include <term.h>
 
-#include <sys/param.h>		/* for MAXPATHLEN */
-#include <sys/ioctl.h>
-#include <sys/time.h>
 #ifdef HAVE_LINUX_TIOCL_H
-#include <linux/tiocl.h>
+# include <linux/tiocl.h>
 #endif
 
 #include "c.h"
-#include "xalloc.h"
-#include "nls.h"
 #include "closestream.h"
-
-#if defined(__GNU_LIBRARY__) && __GNU_LIBRARY__ < 5
-#ifndef __alpha__
-# include <linux/unistd.h>
-#define __NR_klogctl __NR_syslog
-_syscall3(int, klogctl, int, type, char*, buf, int, len);
-#else /* __alpha__ */
-#define klogctl syslog
-#endif
-#endif
-extern int klogctl(int type, char *buf, int len);
+#include "nls.h"
+#include "xalloc.h"
 
 /* Constants. */
 
-- 
1.9.2

