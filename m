Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:56402 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752241AbcBZDDg (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 25 Feb 2016 22:03:36 -0500
Received: from tenfore.ga-group.nl ([95.114.239.233]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0LrrRi-1Zn8Rs1qXe-013ifl for
 <util-linux@vger.kernel.org>; Fri, 26 Feb 2016 04:03:34 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/14] libsmartcols: fix uninitialized variable
Date: Fri, 26 Feb 2016 04:03:27 +0100
Message-Id: <1456455812-19453-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
References: <1456455812-19453-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This got broken in 2a750b4c.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 libsmartcols/src/table_print.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libsmartcols/src/table_print.c b/libsmartcols/src/table_print.c
index d1dcb65..510386e 100644
--- a/libsmartcols/src/table_print.c
+++ b/libsmartcols/src/table_print.c
@@ -1281,7 +1281,7 @@ static int initialize_printting(struct libscols_table *tb, struct libscols_buffe
 
 		scols_reset_iter(&itr, SCOLS_ITER_FORWARD);
 
-		while (rc == 0 && scols_table_next_column(tb, &itr, &cl) == 0) {
+		while (scols_table_next_column(tb, &itr, &cl) == 0) {
 			if (scols_column_is_hidden(cl))
 				continue;
 			extra_bufsz += strlen(scols_cell_get_data(&cl->header));	/* data */
-- 
1.8.4.5

