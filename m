Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63130 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751278AbcBXL3w (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Feb 2016 06:29:52 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MWhRH-1aSJaH2YjT-00Xw8B for
 <util-linux@vger.kernel.org>; Wed, 24 Feb 2016 12:29:50 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] chrt: fix case SCHED_RR
Date: Wed, 24 Feb 2016 12:29:48 +0100
Message-Id: <1456313389-7290-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Looks like the logic was mistakenly changed in acde3a05.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 schedutils/chrt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 030be57..84a6b34 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -175,10 +175,10 @@ static const char *get_policy_name(int policy)
 		return "SCHED_IDLE";
 #endif
 	case SCHED_RR:
+	case SCHED_RR | SCHED_RESET_ON_FORK:
 		return "SCHED_RR";
 #ifdef SCHED_BATCH
 	case SCHED_BATCH:
-	case SCHED_RR | SCHED_RESET_ON_FORK:
 		return "SCHED_BATCH";
 #endif
 #ifdef SCHED_DEADLINE
-- 
1.8.4.5

