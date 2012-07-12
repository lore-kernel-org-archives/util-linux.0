Return-Path: util-linux-owner@vger.kernel.org
Received: from cantor2.suse.de ([195.135.220.15]:45142 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758791Ab2GLIKt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 12 Jul 2012 04:10:49 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id 90A1DA3A4A
	for <util-linux@vger.kernel.org>; Thu, 12 Jul 2012 10:10:47 +0200 (CEST)
From: Petr Uzel <petr.uzel@suse.cz>
To: util-linux <util-linux@vger.kernel.org>
Subject: [PATCH 1/2] swapon: kill unused variables in show_table()
Date: Thu, 12 Jul 2012 10:09:58 +0200
Message-Id: <1342080599-12346-1-git-send-email-petr.uzel@suse.cz>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


Signed-off-by: Petr Uzel <petr.uzel@suse.cz>
---
 sys-utils/swapon.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 0858894..05d025c 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -216,7 +216,6 @@ static int show_table(int tt_flags, int bytes)
 	struct libmnt_fs *fs;
 
 	int i, rc = 0;
-	struct list_head *p, *pnext;
 	struct tt *tt;
 
 	if (!st)
-- 
1.7.7

