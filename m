Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f177.google.com ([209.85.212.177]:49845 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbaGMUZU (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 13 Jul 2014 16:25:20 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so1570025wib.16
        for <util-linux@vger.kernel.org>; Sun, 13 Jul 2014 13:25:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 05/14] cfdisk: add braces to ensure operation order
Date: Sun, 13 Jul 2014 21:24:44 +0100
Message-Id: <1405283093-28182-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
References: <1405283093-28182-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/cfdisk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index b79579e..fb089f5 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -636,7 +636,7 @@ static void resize_on_signal(int dummy __attribute__((__unused__)))
 static void menu_refresh_size(struct cfdisk *cf)
 {
 	if (cf->menu && cf->menu->nitems)
-		cf->menu->page_sz = cf->menu->nitems / (LINES - 4) ? LINES - 4 : 0;
+		cf->menu->page_sz = (cf->menu->nitems / (LINES - 4)) ? LINES - 4 : 0;
 }
 
 static void menu_update_ignore(struct cfdisk *cf)
-- 
2.0.1

