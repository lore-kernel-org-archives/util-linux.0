Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.20]:59882 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932593AbbCPOPi (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 16 Mar 2015 10:15:38 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0M0smx-1ZOvrz1nbT-00vC2t for
 <util-linux@vger.kernel.org>; Mon, 16 Mar 2015 15:15:36 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] tests: remove warning from test output
Date: Mon, 16 Mar 2015 15:15:35 +0100
Message-Id: <1426515335-21539-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <201503161514.16813.sweet_f_a@gmx.de>
References: <201503161514.16813.sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This was added in 3f8478a7 but it's only printed in --help.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/expected/tailf/simple | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/expected/tailf/simple b/tests/expected/tailf/simple
index 5edc76b..ddf72de 100644
--- a/tests/expected/tailf/simple
+++ b/tests/expected/tailf/simple
@@ -1,3 +1,2 @@
-tailf: warning: use of 'tailf' is deprecated, use 'tail -f' instead
 a b c d e f g h i j k l m n o p q r s t u v w x y z
 0 1 2 3 4 5 6 7 8 9
-- 
1.8.4.5

