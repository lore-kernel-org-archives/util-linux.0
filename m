Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp3-g21.free.fr ([212.27.42.3]:52166 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753617Ab2JNPTT (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Sun, 14 Oct 2012 11:19:19 -0400
From: Gilles Espinasse <g.esp@free.fr>
To: util-linux@vger.kernel.org
Cc: Gilles Espinasse <g.esp@free.fr>
Subject: [PATCH] tests : skip ipcs limits overflow when bc is not available
Date: Sun, 14 Oct 2012 17:19:10 +0200
Message-Id: <1350227950-27687-1-git-send-email-g.esp@free.fr>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Gilles Espinasse <g.esp@free.fr>

Found only this one while trying as-root tests
---
 tests/ts/ipcs/limits |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/tests/ts/ipcs/limits b/tests/ts/ipcs/limits
index ed6e084..b44adb1 100755
--- a/tests/ts/ipcs/limits
+++ b/tests/ts/ipcs/limits
@@ -23,6 +23,7 @@ TS_DESC="limits overflow"
 
 ts_init "$*"
 ts_skip_nonroot
+type bc >/dev/null 2>&1 || ts_skip "cannot find bc command"
 
 . $TS_SELF/functions.sh
 
-- 
1.7.2.5

