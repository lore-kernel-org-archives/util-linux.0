Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f174.google.com ([74.125.82.174]:57030 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753716Ab2JHHJA (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:09:00 -0400
Received: by mail-we0-f174.google.com with SMTP id t9so2368146wey.19
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:08:59 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 09/14] pg: do not turn off warnigns artificially
Date: Mon,  8 Oct 2012 08:08:15 +0100
Message-Id: <1349680100-18120-10-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Compiler warnings often mean something, fiddling with them is not good
practise.  Besides the 'proglem' removed macro tried to 'fix' does not
even occur when compiling with modern gcc.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/pg.c | 21 ---------------------
 1 file changed, 21 deletions(-)

diff --git a/text-utils/pg.c b/text-utils/pg.c
index dedcfb9..3d278bf 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -70,11 +70,6 @@
 #define CMDBUF		255		/* size of command buffer */
 #define	TABSIZE		8		/* spaces consumed by tab character */
 
-/*
- * Avoid the message "`var' might be clobbered by `longjmp' or `vfork'"
- */
-#define	CLOBBGRD(a)	(void)(&(a));
-
 #define	cuc(c)		((c) & 0377)
 
 enum { FORWARD = 1, BACKWARD = 2 };	/* search direction */
@@ -986,22 +981,6 @@ pgfile(FILE *f, const char *name)
 	 */
 	FILE *fbuf, *find, *save;
 
-	/* silence compiler - it may warn about longjmp() */
-	CLOBBGRD(line);
-	CLOBBGRD(fline);
-	CLOBBGRD(bline);
-	CLOBBGRD(oldline);
-	CLOBBGRD(eofline);
-	CLOBBGRD(dline);
-	CLOBBGRD(ttycols);
-	CLOBBGRD(search);
-	CLOBBGRD(searchcount);
-	CLOBBGRD(seekeof);
-	CLOBBGRD(eof);
-	CLOBBGRD(fpos);
-	CLOBBGRD(nobuf);
-	CLOBBGRD(fbuf);
-
 	if (ontty == 0) {
 		/*
 		 * Just copy stdin to stdout.
-- 
1.7.12.2

