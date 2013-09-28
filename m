Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:40095 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755084Ab3I1WWt (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 28 Sep 2013 18:22:49 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] findmnt: always allocate memory for cell value
Date: Sat, 28 Sep 2013 18:22:43 -0400
Message-Id: <1380406963-32202-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Since b3386c83fe77, findmnt's output uses TT_FL_FREEDATA, which causes
a crash here when string literal is returned instead of a heap address.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/findmnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index 8861b09..91cc935 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -469,7 +469,7 @@ static char *get_vfs_attr(struct libmnt_fs *fs, int sizetype)
 		break;
 	case COL_USEPERC:
 		if (buf.f_blocks == 0)
-			return "-";
+			return xstrdup("-");
 
 		xasprintf(&sizestr, "%.0f%%",
 				(double)(buf.f_blocks - buf.f_bfree) /
-- 
1.8.4

