Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:46847 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab2HTKGW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 20 Aug 2012 06:06:22 -0400
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] findmnt: use st.st_bavail for available column
Date: Mon, 20 Aug 2012 06:06:17 -0400
Message-Id: <1345457177-4072-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This matches more closely with what 'df -h' reports as space available.
Any remaining discrepancy between these 2 tools is a result of precision
and choices in rounding.

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
 misc-utils/findmnt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/findmnt.c b/misc-utils/findmnt.c
index db40323..853fae0 100644
--- a/misc-utils/findmnt.c
+++ b/misc-utils/findmnt.c
@@ -374,7 +374,7 @@ static const char *get_vfs_attr(struct libmnt_fs *fs, int sizetype)
 		vfs_attr = buf.f_frsize * buf.f_blocks;
 		break;
 	case COL_AVAIL:
-		vfs_attr = buf.f_frsize * buf.f_bfree;
+		vfs_attr = buf.f_frsize * buf.f_bavail;
 		break;
 	case COL_USED:
 		vfs_attr = buf.f_frsize * (buf.f_blocks - buf.f_bfree);
-- 
1.7.11.5

