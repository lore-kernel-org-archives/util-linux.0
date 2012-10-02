Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f170.google.com ([209.85.212.170]:34088 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752858Ab2JBUP3 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Oct 2012 16:15:29 -0400
Received: by mail-wi0-f170.google.com with SMTP id hm2so1273662wib.1
        for <util-linux@vger.kernel.org>; Tue, 02 Oct 2012 13:15:27 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 3/3] pg: check numeric user inputs
Date: Tue,  2 Oct 2012 21:15:18 +0100
Message-Id: <1349208918-11946-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349208918-11946-1-git-send-email-kerolasa@iki.fi>
References: <1349208918-11946-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/Makemodule.am | 4 ++--
 text-utils/pg.c          | 5 +++--
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/text-utils/Makemodule.am b/text-utils/Makemodule.am
index 23185eaa..f2c10eb 100644
--- a/text-utils/Makemodule.am
+++ b/text-utils/Makemodule.am
@@ -59,11 +59,11 @@ pg_SOURCES = text-utils/pg.c
 
 if HAVE_TINFO
 more_LDADD = $(LDADD) -ltinfo
-pg_LDADD = $(LDADD) -ltinfo @NCURSES_LIBS@
+pg_LDADD = $(LDADD) libcommon.la -ltinfo @NCURSES_LIBS@
 ul_LDADD = $(LDADD) -ltinfo
 else
 more_LDADD = $(LDADD) @NCURSES_LIBS@
-pg_LDADD = $(LDADD) @NCURSES_LIBS@
+pg_LDADD = $(LDADD) libcommon.la @NCURSES_LIBS@
 ul_LDADD = $(LDADD) @NCURSES_LIBS@
 endif
 
diff --git a/text-utils/pg.c b/text-utils/pg.c
index 9ade866..c4a86ca 100644
--- a/text-utils/pg.c
+++ b/text-utils/pg.c
@@ -64,6 +64,7 @@
 #include "widechar.h"
 #include "all-io.h"
 #include "closestream.h"
+#include "strutils.h"
 
 #define	READBUF		LINE_MAX	/* size of input buffer */
 #define CMDBUF		255		/* size of command buffer */
@@ -1623,7 +1624,7 @@ main(int argc, char **argv)
 				goto endargs;
 			case '1': case '2': case '3': case '4': case '5':
 			case '6': case '7': case '8': case '9': case '0':
-				pagelen = atoi(argv[arg] + i);
+				pagelen = strtol_or_err(argv[arg] + 1, _("failed to parse argument"));
 				havepagelen = 1;
 				goto nextarg;
 			case 'c':
@@ -1687,7 +1688,7 @@ endargs:
 			/*NOTREACHED*/
 		case '1': case '2': case '3': case '4': case '5':
 		case '6': case '7': case '8': case '9': case '0':
-			startline = atoi(argv[arg] + 1);
+			startline = strtol_or_err(argv[arg] + 1, _("failed to parse argument"));
 			break;
 		case '/':
 			searchfor = argv[arg] + 2;
-- 
1.7.12.2

