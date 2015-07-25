Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews08.kpnxchange.com ([213.75.39.13]:56167 "EHLO
	cpsmtpb-ews08.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754963AbbGYPT2 (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 25 Jul 2015 11:19:28 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/5] cfdisk: when moving inside the menu, always redraw it completely
Date: Sat, 25 Jul 2015 17:18:18 +0200
Message-Id: <1437837498-23833-5-git-send-email-bensberg@justemail.net>
In-Reply-To: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
References: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To restore it in case it was partially overwritten by the info line.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |   18 +-----------------
 1 files changed, 1 insertions(+), 17 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index bf865d9..7dc7e65 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1436,9 +1436,6 @@ static int ui_draw_extra(struct cfdisk *cf)
 
 static void ui_menu_goto(struct cfdisk *cf, int where)
 {
-	struct cfdisk_menuitem *d;
-	size_t old;
-
 	/* stop and begin/end for vertical menus */
 	if (cf->menu->vertical) {
 		if (where < 0)
@@ -1455,22 +1452,9 @@ static void ui_menu_goto(struct cfdisk *cf, int where)
 	if ((size_t) where == cf->menu->idx)
 		return;
 
-	ui_clean_info();
-
-	old = cf->menu->idx;
 	cf->menu->idx = where;
 
-	if (!menuitem_on_page(cf, old)) {
-		ui_draw_menu(cf);
-		return;
-	}
-
-	d = menu_get_menuitem(cf, old);
-	ui_draw_menuitem(cf, d, old);
-
-	d = menu_get_menuitem(cf, where);
-	ui_draw_menuitem(cf, d, where);
-
+	ui_draw_menu(cf);
 }
 
 static int ui_menu_move(struct cfdisk *cf, int key)
-- 
1.7.0.4

