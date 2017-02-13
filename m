Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f193.google.com ([209.85.128.193]:34118 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751298AbdBMWGq (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Feb 2017 17:06:46 -0500
Received: by mail-wr0-f193.google.com with SMTP id c4so339441wrd.1
        for <util-linux@vger.kernel.org>; Mon, 13 Feb 2017 14:06:46 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/7] cfdisk: avoid use of VLA in combination with sizeof() [smatch scan]
Date: Mon, 13 Feb 2017 22:06:35 +0000
Message-Id: <20170213220641.1395-2-kerolasa@iki.fi>
In-Reply-To: <20170213220641.1395-1-kerolasa@iki.fi>
References: <20170213220641.1395-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

disk-utils/cfdisk.c:1066:29: error: cannot size expression

One should use sizeof() only when variable size can be known at time of
compilation.  That is not the case with variable length arrays.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/cfdisk.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 281d66c78..ce49a791c 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1044,9 +1044,10 @@ static void ui_draw_menuitem(struct cfdisk *cf,
 			     struct cfdisk_menuitem *d,
 			     size_t idx)
 {
-	char buf[80 * MB_CUR_MAX], *ptr = buf;
+	char *buf, *ptr;
 	const char *name;
 	size_t width;
+	const size_t buf_sz = 80 * MB_CUR_MAX;
 	int ln, cl, vert = cf->menu->vertical;
 
 	if (!menuitem_on_page(cf, idx))
@@ -1054,6 +1055,7 @@ static void ui_draw_menuitem(struct cfdisk *cf,
 	ln = menuitem_get_line(cf, idx);
 	cl = menuitem_get_column(cf, idx);
 
+	ptr = buf = xmalloc(buf_sz);
 	/* string width */
 	if (vert) {
 		width = cf->menu->width + MENU_V_SPADDING;
@@ -1063,7 +1065,7 @@ static void ui_draw_menuitem(struct cfdisk *cf,
 		width = MENU_H_SPADDING + cf->menu->width + MENU_H_SPADDING;
 
 	name = _(d->name);
-	mbsalign(name, ptr, sizeof(buf), &width,
+	mbsalign(name, ptr, buf_sz, &width,
 			vert ? MBS_ALIGN_LEFT : MBS_ALIGN_CENTER,
 			0);
 
@@ -1082,6 +1084,7 @@ static void ui_draw_menuitem(struct cfdisk *cf,
 		mvprintw(ln, cl, "%s", buf);
 	else
 		mvprintw(ln, cl, "%s%s%s", MENU_H_PRESTR, buf, MENU_H_POSTSTR);
+	free(buf);
 
 	if (cf->menu->idx == idx) {
 		standend();
-- 
2.11.1

