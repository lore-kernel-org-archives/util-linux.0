Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:55394 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758241Ab2EOItX (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 15 May 2012 04:49:23 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 364D98FD0F
	for <util-linux@vger.kernel.org>; Tue, 15 May 2012 10:49:23 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 4/4] blkid: use get_terminal_width() from ttyutils.h
Date: Tue, 15 May 2012 10:49:04 +0200
Message-Id: <1337071744-7056-4-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
References: <1337071744-7056-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/blkid.c |   29 +----------------------------
 1 files changed, 1 insertions(+), 28 deletions(-)

diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 6a7991f..aec3528 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -16,11 +16,7 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <termios.h>
 #include <errno.h>
-#ifdef HAVE_SYS_IOCTL_H
-#include <sys/ioctl.h>
-#endif
 #ifdef HAVE_GETOPT_H
 #include <getopt.h>
 #else
@@ -45,6 +41,7 @@ extern int optind;
 #define STRTOXX_EXIT_CODE	4		/* strtoxx_or_err() */
 #include "strutils.h"
 #include "closestream.h"
+#include "ttyutils.h"
 
 const char *progname = "blkid";
 
@@ -124,30 +121,6 @@ static void safe_print(const char *cp, int len)
 	}
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
-		return (t_win.ts_cols);
-#endif
-#ifdef TIOCGWINSZ
-	if (ioctl (0, TIOCGWINSZ, &w_win) == 0)
-		return (w_win.ws_col);
-#endif
-        cp = getenv("COLUMNS");
-	if (cp)
-		return strtol(cp, NULL, 10);
-	return 80;
-}
-
 static int pretty_print_word(const char *str, int max_len,
 			     int left_len, int overflow_nl)
 {
-- 
1.7.7

