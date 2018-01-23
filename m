Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.18]:49876 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751834AbeAWP7c (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Tue, 23 Jan 2018 10:59:32 -0500
Received: from zappa.l.ga-group.nl ([87.128.112.108]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LeN3N-1f9mpT2tnJ-00qDux for <util-linux@vger.kernel.org>; Tue, 23 Jan 2018
 16:59:30 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 5/7] tests: suppress warning for old sync(1)
Date: Tue, 23 Jan 2018 16:59:26 +0100
Message-Id: <20180123155928.7629-6-sweet_f_a@gmx.de>
In-Reply-To: <20180123155928.7629-1-sweet_f_a@gmx.de>
References: <20180123155928.7629-1-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: root <root@adsiz>

Old sync(1) prints a warning which looks ugly among our
test output: "sync: ignoring all arguments"

Seen on travis, Ubuntu <= 14.04 (Trusty).

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index ef11a893e..d1c97e0b6 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -635,7 +635,7 @@ function ts_fstab_open {
 
 function ts_fstab_close {
 	echo "# -->" >> /etc/fstab
-	sync /etc/fstab
+	sync /etc/fstab 2>/dev/null
 }
 
 function ts_fstab_addline {
@@ -669,7 +669,7 @@ function ts_fstab_clean {
 s/# <!-- util-linux.*-->//;
 /^$/d" /etc/fstab
 
-	sync /etc/fstab
+	sync /etc/fstab 2>/dev/null
 	ts_unlock "fstab"
 }
 
-- 
2.13.6

