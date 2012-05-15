Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:55390 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758394Ab2EOItT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 04:49:19 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 998D38FE2D
	for <util-linux@vger.kernel.org>; Tue, 15 May 2012 10:49:18 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 3/4] lib,include: move get_terminal_width() to ttyutils.h
Date: Tue, 15 May 2012 10:49:03 +0200
Message-Id: <1337071744-7056-3-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
References: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 include/ttyutils.h |   29 +++++++++++++++++++++++++++++
 lib/tt.c           |   28 +---------------------------
 2 files changed, 30 insertions(+), 27 deletions(-)

diff --git a/include/ttyutils.h b/include/ttyutils.h
index f638aa0..15809e8 100644
--- a/include/ttyutils.h
+++ b/include/ttyutils.h
@@ -1,7 +1,11 @@
 #ifndef UTIL_LINUX_TTYUTILS_H
 #define UTIL_LINUX_TTYUTILS_H
 
+#include <stdlib.h>
 #include <termios.h>
+#ifdef HAVE_SYS_IOCTL_H
+#include <sys/ioctl.h>
+#endif
 
 #define UL_TTY_KEEPCFLAGS	(1 << 1)
 #define UL_TTY_UTF8		(1 << 2)
@@ -74,4 +78,29 @@ static inline void reset_virtual_console(struct termios *tp, int flags)
 	tp->c_cc[VEOL2]    = _POSIX_VDISABLE;
 }
 
+static inline int get_terminal_width(void)
+{
+#ifdef TIOCGSIZE
+	struct ttysize	t_win;
+#endif
+#ifdef TIOCGWINSZ
+	struct winsize	w_win;
+#endif
+        const char	*cp;
+
+#ifdef TIOCGSIZE
+	if (ioctl (0, TIOCGSIZE, &t_win) == 0)
+		return t_win.ts_cols;
+#endif
+#ifdef TIOCGWINSZ
+	if (ioctl (0, TIOCGWINSZ, &w_win) == 0)
+		return w_win.ws_col;
+#endif
+        cp = getenv("COLUMNS");
+	if (cp)
+		return strtol(cp, NULL, 10);
+	return 0;
+}
+
+
 #endif /* UTIL_LINUX_TTYUTILS_H */
diff --git a/lib/tt.c b/lib/tt.c
index 1b5fbac..fe471d0 100644
--- a/lib/tt.c
+++ b/lib/tt.c
@@ -16,15 +16,13 @@
 #include <string.h>
 #include <termios.h>
 #include <ctype.h>
-#ifdef HAVE_SYS_IOCTL_H
-#include <sys/ioctl.h>
-#endif
 
 #include "c.h"
 #include "nls.h"
 #include "widechar.h"
 #include "tt.h"
 #include "mbsalign.h"
+#include "ttyutils.h"
 
 struct tt_symbols {
 	const char *branch;
@@ -253,30 +251,6 @@ int tt_line_set_data(struct tt_line *ln, int colnum, const char *data)
 	return 0;
 }
 
-static int get_terminal_width(void)
-{
-#ifdef TIOCGSIZE
-	struct ttysize	t_win;
-#endif
-#ifdef TIOCGWINSZ
-	struct winsize	w_win;
-#endif
-        const char	*cp;
-
-#ifdef TIOCGSIZE
-	if (ioctl (0, TIOCGSIZE, &t_win) == 0)
-		return t_win.ts_cols;
-#endif
-#ifdef TIOCGWINSZ
-	if (ioctl (0, TIOCGWINSZ, &w_win) == 0)
-		return w_win.ws_col;
-#endif
-        cp = getenv("COLUMNS");
-	if (cp)
-		return strtol(cp, NULL, 10);
-	return 0;
-}
-
 int tt_line_set_userdata(struct tt_line *ln, void *data)
 {
 	if (!ln)
-- 
1.7.7

