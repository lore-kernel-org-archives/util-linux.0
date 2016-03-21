Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:51431 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755463AbcCUNEt (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 21 Mar 2016 09:04:49 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M7UUd-1ZtS3s1rXD-00xLto for
 <util-linux@vger.kernel.org>; Mon, 21 Mar 2016 14:04:47 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 4/5] tests: skip ipcs test which require /proc
Date: Mon, 21 Mar 2016 14:04:44 +0100
Message-Id: <1458565485-27856-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
References: <1458565485-27856-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/ts/ipcs/functions.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/ts/ipcs/functions.sh b/tests/ts/ipcs/functions.sh
index 80c9416..a9cf228 100644
--- a/tests/ts/ipcs/functions.sh
+++ b/tests/ts/ipcs/functions.sh
@@ -16,6 +16,8 @@
 # GNU General Public License for more details.
 #
 
+test -f /proc/sys/kernel/shmall || ts_skip "no /proc"
+
 PAGE_SIZE=$($TS_HELPER_SYSINFO pagesize)
 
 # kernel files
-- 
1.8.4.5

