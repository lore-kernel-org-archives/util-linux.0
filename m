Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:38910 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751543AbcEWVCQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 23 May 2016 17:02:16 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id BFC43340817
	for <util-linux@vger.kernel.org>; Mon, 23 May 2016 21:02:14 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux@vger.kernel.org
Subject: [PATCH] cal: drop trailing blank line
Date: Mon, 23 May 2016 17:02:12 -0400
Message-Id: <1464037332-21996-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

There's no history to be found behind this, and the comment in the
code indicates no one else knows, and it makes me angry :).

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 misc-utils/cal.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/misc-utils/cal.c b/misc-utils/cal.c
index 3e20530..479c967 100644
--- a/misc-utils/cal.c
+++ b/misc-utils/cal.c
@@ -767,9 +767,6 @@ static void yearly(const struct cal_control *ctl)
 		my_putstring("\n\n");
 	}
 	monthly(ctl);
-
-	/* Is empty line at the end year output really needed? */
-	my_putstring("\n");
 }
 
 /*
-- 
2.8.2

