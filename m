Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:60810 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750832Ab2ETAjY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 19 May 2012 20:39:24 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH 1/3] findmnt: reference correct manual section
Date: Sat, 19 May 2012 20:39:19 -0400
Message-Id: <1337474361-22429-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/findmnt.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 1d34696..9005483 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -1005,7 +1005,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	for (i = 0; i < FINDMNT_NCOLUMNS; i++)
 		fprintf(out, " %11s  %s\n", infos[i].name, _(infos[i].help));
 
-	fprintf(out, USAGE_MAN_TAIL("findmnt(1)"));
+	fprintf(out, USAGE_MAN_TAIL("findmnt(8)"));
 
 	exit(out == stderr ? EXIT_FAILURE : EXIT_SUCCESS);
 }
-- 
1.7.10.2

