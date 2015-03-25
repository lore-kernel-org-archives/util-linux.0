Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:59510 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751261AbbCYJkN (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 25 Mar 2015 05:40:13 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx101)
 with ESMTPSA (Nemesis) id 0LcnRD-1ZJQb62eff-00kA82 for
 <util-linux@vger.kernel.org>; Wed, 25 Mar 2015 10:40:11 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] last: fix first (current) runlevel line
Date: Wed, 25 Mar 2015 10:40:09 +0100
Message-Id: <1427276410-25271-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1427276410-25271-1-git-send-email-sweet_f_a@gmx.de>
References: <1427276410-25271-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Since 744c7fec lastrch was not set to current time anymore, but we need it.

 # broken:
 $ ./last -x | grep -m 2 runlevel
 runlevel (to lvl 5)   3.11.10-25-deskt Wed Feb 18 13:11 - 01:00 (-16484+-12:-11)
 runlevel (to lvl 5)   3.11.10-25-deskt Thu Jan 22 16:50 - 13:11 (26+20:21)

 # fixed:
 $ ./last -x | grep -m 2 runlevel
 runlevel (to lvl 5)   3.11.10-25-deskt Wed Feb 18 13:11   still running
 runlevel (to lvl 5)   3.11.10-25-deskt Thu Jan 22 16:50 - 13:11 (26+20:21)

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 login-utils/last.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/login-utils/last.c b/login-utils/last.c
index 9682764..4a165c2 100644
--- a/login-utils/last.c
+++ b/login-utils/last.c
@@ -638,7 +638,7 @@ static void process_wtmp_file(const struct last_control *ctl,
 	/*
 	 * Fill in 'lastdate'
 	 */
-	lastdate = lastdown;
+	lastdate = lastrch = lastdown;
 
 	/*
 	 * Install signal handlers
-- 
1.8.4.5

