Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.17.8]:49234 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751303Ab2G0Ig1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jul 2012 04:36:27 -0400
Message-ID: <50125308.2070003@bernhard-voelker.de>
Date: Fri, 27 Jul 2012 10:36:24 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] tests: search mount point in canonicalized form in /proc/mounts
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


>From 9fe90eaa1c1d425437eab705a29e7c7800ffa7fe Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Fri, 27 Jul 2012 10:35:01 +0200
Subject: [PATCH] tests: search mount point in canonicalized form in
 /proc/mounts

* tests/functions.sh (ts_is_mounted): Enhance to resolve symlinks in
given mount point before grep'ing in /proc/mount.

If the test directory is on a symlink, then e.g. tests/ts/cramfs/doubles
failed because the kernel keeps the mount entry in a canonicalized form
in /proc/mounts while this function searched for it with the original
path name.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 tests/functions.sh |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index 74cde97..a3bb482 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -377,7 +377,10 @@ function ts_device_has_uuid {
 }

 function ts_is_mounted {
-	local DEV=$1
+	local DEV=$( readlink -f $1 )
+	if [ ".$DEV" = '.' ]; then
+	  DEV=$1
+	fi

 	grep -q $DEV /proc/mounts && return 0

-- 
1.7.7


