Return-Path: util-linux-owner@vger.kernel.org
Received: from cpsmtpb-ews02.kpnxchange.com ([213.75.39.5]:51159 "EHLO
	cpsmtpb-ews02.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754963AbbGYPTQ (ORCPT
	<rfc822;util-linux@vger.kernel.org>);
	Sat, 25 Jul 2015 11:19:16 -0400
From: Benno Schulenberg <bensberg@justemail.net>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/5] cfdisk: keep the extra info block separate from menu and partitions
Date: Sat, 25 Jul 2015 17:18:17 +0200
Message-Id: <1437837498-23833-4-git-send-email-bensberg@justemail.net>
In-Reply-To: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
References: <1437837498-23833-1-git-send-email-bensberg@justemail.net>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

By adding a blank line between them.  Also, keep the top of the info
block in a fixed position close to the partition list, so that it is
clearer that it belongs to a partition and not to the menu.

Signed-off-by: Benno Schulenberg <bensberg@justemail.net>
---
 disk-utils/cfdisk.c |    7 ++-----
 1 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index ddec7f4..bf865d9 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1394,8 +1394,8 @@ static int ui_draw_extra(struct cfdisk *cf)
 	ndatalines = fdisk_table_get_nents(cf->table) + 1;
 
 	/* nents + header + one free line */
-	win_ex_start_line = TABLE_START_LINE + ndatalines;
-	win_height = MENU_START_LINE - win_ex_start_line;
+	win_ex_start_line = TABLE_START_LINE + ndatalines + 1;
+	win_height = MENU_START_LINE - win_ex_start_line - 1;
 	tblen = scols_table_get_nlines(ln->extra);
 
 	/* we can't get a single line of data under the partlist*/
@@ -1405,9 +1405,6 @@ static int ui_draw_extra(struct cfdisk *cf)
 	/* number of data lines + 2 for top/bottom lines */
 	win_height = win_height < tblen + 2 ? win_height : tblen + 2;
 
-	if ((size_t) win_ex_start_line + win_height + 1 < MENU_START_LINE)
-		win_ex_start_line = MENU_START_LINE - win_height;
-
 	win_ex = subwin(stdscr, win_height, ui_cols - 2, win_ex_start_line, 1);
 
 	scols_table_reduce_termwidth(ln->extra, 4);
-- 
1.7.0.4

