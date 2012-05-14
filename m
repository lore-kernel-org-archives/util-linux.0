Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:37940 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754170Ab2ENHwI (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 14 May 2012 03:52:08 -0400
Received: from relay1.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 06879A3823
	for <util-linux@vger.kernel.org>; Mon, 14 May 2012 09:52:08 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 2/2] blkid: use tt_get_terminal_width() from lib/tt
Date: Mon, 14 May 2012 09:51:58 +0200
Message-Id: <1336981918-18123-2-git-send-email-petr.uzel@suse.cz>
In-Reply-To: <1336981918-18123-1-git-send-email-petr.uzel@suse.cz>
References: <1336981918-18123-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 misc-utils/Makefile.am |    4 +++-
 misc-utils/blkid.c     |   29 +++--------------------------
 2 files changed, 6 insertions(+), 27 deletions(-)

diff --git a/misc-utils/Makefile.am b/misc-utils/Makefile.am
index 9dd3583..daf6b80 100644
--- a/misc-utils/Makefile.am
+++ b/misc-utils/Makefile.am
@@ -103,8 +103,10 @@ sbin_PROGRAMS += blkid findfs wipefs
 dist_man_MANS += blkid.8 findfs.8 wipefs.8
 blkid_SOURCES = \
 	blkid.c \
+	$(top_srcdir)/lib/mbsalign.c \
 	$(top_srcdir)/lib/ismounted.c \
-	$(top_srcdir)/lib/strutils.c
+	$(top_srcdir)/lib/strutils.c \
+	$(top_srcdir)/lib/tt.c
 blkid_LDADD = $(ul_libblkid_la)
 blkid_CFLAGS = $(AM_CFLAGS) -I$(ul_libblkid_incdir)
 
diff --git a/misc-utils/blkid.c b/misc-utils/blkid.c
index 6a7991f..9be7054 100644
--- a/misc-utils/blkid.c
+++ b/misc-utils/blkid.c
@@ -41,6 +41,7 @@ extern int optind;
 #include <blkid.h>
 
 #include "ismounted.h"
+#include "tt.h"
 
 #define STRTOXX_EXIT_CODE	4		/* strtoxx_or_err() */
 #include "strutils.h"
@@ -124,30 +125,6 @@ static void safe_print(const char *cp, int len)
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
@@ -176,7 +153,7 @@ static void pretty_print_line(const char *device, const char *fs_type,
 	int len, w;
 
 	if (term_width < 0)
-		term_width = get_terminal_width();
+		term_width = tt_get_terminal_width();
 
 	if (term_width > 80) {
 		term_width -= 80;
@@ -212,7 +189,7 @@ static void pretty_print_dev(blkid_dev dev)
 	if (dev == NULL) {
 		pretty_print_line("device", "fs_type", "label",
 				  "mount point", "UUID");
-		for (len=get_terminal_width()-1; len > 0; len--)
+		for (len = tt_get_terminal_width()-1; len > 0; len--)
 			fputc('-', stdout);
 		fputc('\n', stdout);
 		return;
-- 
1.7.7

