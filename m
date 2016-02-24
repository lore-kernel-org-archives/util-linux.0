Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:63910 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751760AbcBXL3w (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Wed, 24 Feb 2016 06:29:52 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MUm1o-1aQvsA3Zvw-00YDNc for
 <util-linux@vger.kernel.org>; Wed, 24 Feb 2016 12:29:51 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/2] chrt: restore removed ifdef SCHED_RESET_ON_FORK
Date: Wed, 24 Feb 2016 12:29:49 +0100
Message-Id: <1456313389-7290-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1456313389-7290-1-git-send-email-sweet_f_a@gmx.de>
References: <1456313389-7290-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

They got lost in acde3a05.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 schedutils/chrt.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/schedutils/chrt.c b/schedutils/chrt.c
index 84a6b34..363d6e1 100644
--- a/schedutils/chrt.c
+++ b/schedutils/chrt.c
@@ -168,14 +168,18 @@ static const char *get_policy_name(int policy)
 	case SCHED_OTHER:
 		return "SCHED_OTHER";
 	case SCHED_FIFO:
+#ifdef SCHED_RESET_ON_FORK
 	case SCHED_FIFO | SCHED_RESET_ON_FORK:
+#endif
 		return "SCHED_FIFO";
 #ifdef SCHED_IDLE
 	case SCHED_IDLE:
 		return "SCHED_IDLE";
 #endif
 	case SCHED_RR:
+#ifdef SCHED_RESET_ON_FORK
 	case SCHED_RR | SCHED_RESET_ON_FORK:
+#endif
 		return "SCHED_RR";
 #ifdef SCHED_BATCH
 	case SCHED_BATCH:
-- 
1.8.4.5

