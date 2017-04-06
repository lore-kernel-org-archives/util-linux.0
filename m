Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:52135 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756699AbdDFH4M (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 6 Apr 2017 03:56:12 -0400
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Cc: Masatake YAMATO <yamato@redhat.com>
Subject: [PATCH 3/5] fincore: fix multiplication overflow
Date: Thu,  6 Apr 2017 09:56:03 +0200
Message-Id: <1491465365-7515-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
References: <1491465365-7515-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This failed on ppc64 with page size 64k.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 misc-utils/fincore.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/fincore.c b/misc-utils/fincore.c
index b867c2d..425f1bf 100644
--- a/misc-utils/fincore.c
+++ b/misc-utils/fincore.c
@@ -188,7 +188,7 @@ static int fincore_fd (struct fincore_control *ctl,
 		       off_t file_size,
 		       off_t *count_incore)
 {
-	size_t window_size = N_PAGES_IN_WINDOW * ctl->pagesize;
+	size_t window_size = (size_t)N_PAGES_IN_WINDOW * ctl->pagesize;
 	off_t  file_offset;
 	void  *window = NULL;
 	int rc = 0;
-- 
1.8.5.6

