Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ey0-f174.google.com ([209.85.215.174]:51289 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185Ab1EXU5G (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 24 May 2011 16:57:06 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so2400784eyx.19
        for <util-linux@vger.kernel.org>; Tue, 24 May 2011 13:57:06 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/13] col: check with strtol_or_err option argument
Date: Tue, 24 May 2011 22:56:39 +0200
Message-Id: <1306270604-6154-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1306270604-6154-1-git-send-email-kerolasa@iki.fi>
References: <1306270604-6154-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/Makefile.am |    2 ++
 text-utils/col.c       |    8 ++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/text-utils/Makefile.am b/text-utils/Makefile.am
index 513f1c3..8700889 100644
--- a/text-utils/Makefile.am
+++ b/text-utils/Makefile.am
@@ -4,6 +4,8 @@ EXTRA_DIST = README.clear README.col
 
 usrbin_exec_PROGRAMS = col colcrt colrm column hexdump rev line tailf
 
+col_SOURCES = col.c $(top_srcdir)/lib/strutils.c
+
 hexdump_SOURCES = hexdump.c conv.c display.c hexsyntax.c parse.c \
 		  hexdump.h $(top_srcdir)/lib/strutils.c
 
diff --git a/text-utils/col.c b/text-utils/col.c
index 0740687..cdf0036 100644
--- a/text-utils/col.c
+++ b/text-utils/col.c
@@ -55,6 +55,7 @@
 #include "nls.h"
 #include "xalloc.h"
 #include "widechar.h"
+#include "strutils.h"
 
 #define	BS	'\b'		/* backspace */
 #define	TAB	'\t'		/* tab */
@@ -155,6 +156,7 @@ int main(int argc, char **argv)
 	int this_line;			/* line l points to */
 	int nflushd_lines;		/* number of lines that were flushed */
 	int adjust, opt, warned;
+	unsigned long tmplong;
 	int ret = EXIT_SUCCESS;
 
 	static const struct option longopts[] = {
@@ -189,8 +191,10 @@ int main(int argc, char **argv)
 			compress_spaces = 1;
 			break;
 		case 'l':		/* buffered line count */
-			if ((max_bufd_lines = atoi(optarg)) <= 0)
-				errx(EXIT_FAILURE, _("bad -l argument %s."), optarg);
+			tmplong = strtoul_or_err(optarg, _("bad -l argument"));
+			if ((INT_MAX / 2) < tmplong)
+				errx(EXIT_FAILURE, _("argument %lu is too large"), tmplong);
+			max_bufd_lines = (int) tmplong;
 			break;
 		case 'p':
 			pass_unknown_seqs = 1;
-- 
1.7.5.2

