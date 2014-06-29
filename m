Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f176.google.com ([209.85.212.176]:34864 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072AbaF2SMV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 29 Jun 2014 14:12:21 -0400
Received: by mail-wi0-f176.google.com with SMTP id n3so4949705wiv.3
        for <util-linux@vger.kernel.org>; Sun, 29 Jun 2014 11:12:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] swapon: align --summary fields
Date: Sun, 29 Jun 2014 19:12:13 +0100
Message-Id: <1404065533-7557-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This commit makes  partitions and files to have remaining three columns
aligned.  Below print out demonstrates earlier misalignment.

$ swapon -s
Filename                                Type            Size    Used    Priority
/dev/sda2                               partition       4194300 0       3
/home/src/util-linux/newswap            file    496     0       -1

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 8c36b2c..53cd6f9 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -209,7 +209,7 @@ static int display_summary(void)
 	printf(_("%s\t\t\t\tType\t\tSize\tUsed\tPriority\n"), _("Filename"));
 
 	while (mnt_table_next_fs(st, itr, &fs) == 0) {
-		printf("%-39s\t%s\t%jd\t%jd\t%d\n",
+		printf("%-39s\t%-8s\t%jd\t%jd\t%d\n",
 			mnt_fs_get_source(fs),
 			mnt_fs_get_swaptype(fs),
 			mnt_fs_get_size(fs),
-- 
2.0.1

