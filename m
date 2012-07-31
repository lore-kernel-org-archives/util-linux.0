Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:49603 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266Ab2GaG0j (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 31 Jul 2012 02:26:39 -0400
Message-ID: <50177A9B.8000609@bernhard-voelker.de>
Date: Tue, 31 Jul 2012 08:26:35 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] tests: cleanup ts_is_mounted
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


>From c30efb198ea1e6e62712de7e3e3369ffa2d296ff Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Tue, 31 Jul 2012 08:24:13 +0200
Subject: [PATCH] tests: cleanup ts_is_mounted

* tests/functions.sh (ts_is_mounted): Remove check for canonicalization
failure again, because it is now done by ts_canonicalize.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 tests/functions.sh |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index 0613505..9716534 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -394,9 +394,6 @@ function ts_device_has_uuid {

 function ts_is_mounted {
 	local DEV=$(ts_canonicalize "$1")
-	if [ ".$DEV" = '.' ]; then
-	  DEV=$1
-	fi

 	grep -q $DEV /proc/mounts && return 0

-- 
1.7.7


