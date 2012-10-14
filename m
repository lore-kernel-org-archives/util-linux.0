Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp3-g21.free.fr ([212.27.42.3]:43021 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751352Ab2JNNxY (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Oct 2012 09:53:24 -0400
From: Gilles Espinasse <g.esp@free.fr>
To: util-linux@vger.kernel.org
Cc: Gilles Espinasse <g.esp@free.fr>
Subject: [PATCH] tests : fix ipcs basic limit when bc is not available
Date: Sun, 14 Oct 2012 15:52:55 +0200
Message-Id: <1350222775-9153-1-git-send-email-g.esp@free.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Gilles Espinasse <g.esp@free.fr>

Skip basic limit test if bc is not available.
That happen to be the case when building from sources, following LFS book
---
 tests/ts/ipcs/limits2 |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tests/ts/ipcs/limits2 b/tests/ts/ipcs/limits2
index acb1749..f99a354 100755
--- a/tests/ts/ipcs/limits2
+++ b/tests/ts/ipcs/limits2
@@ -21,6 +21,7 @@ TS_DESC="basic limits"
 
 . $TS_TOPDIR/functions.sh
 ts_init "$*"
+type bc >/dev/null 2>&1 || ts_skip "cannot find bc command"
 
 . $TS_SELF/functions.sh
 
-- 
1.7.2.5

