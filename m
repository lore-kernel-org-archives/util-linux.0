Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.186]:59860 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751877Ab2G0IK6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 27 Jul 2012 04:10:58 -0400
Message-ID: <50124D10.4080906@bernhard-voelker.de>
Date: Fri, 27 Jul 2012 10:10:56 +0200
From: Bernhard Voelker <mail@bernhard-voelker.de>
MIME-Version: 1.0
To: "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>
Subject: [PATCH] tests: update oddinput test
Content-Type: text/plain; charset=ISO-8859-1
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>


>From ca423116354d7ea1fb7604d838078a41840af19e Mon Sep 17 00:00:00 2001
From: Bernhard Voelker <mail@bernhard-voelker.de>
Date: Fri, 27 Jul 2012 10:10:10 +0200
Subject: [PATCH] tests: update oddinput test

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 tests/expected/fdisk/oddinput |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/expected/fdisk/oddinput b/tests/expected/fdisk/oddinput
index 14f2528..a681d0d 100644
--- a/tests/expected/fdisk/oddinput
+++ b/tests/expected/fdisk/oddinput
@@ -9,6 +9,6 @@ Sector size (logical/physical): 512 bytes / 512 bytes
 I/O size (minimum/optimal): 512 bytes / 512 bytes

 Nonexistant file
-lt-fdisk: cannot open _a_file_that_does_not_exist_: No such file or directory
+fdisk: cannot open _a_file_that_does_not_exist_: No such file or directory
 Too small file
-lt-fdisk: cannot open oddinput.toosmall: Invalid argument
+fdisk: cannot open oddinput.toosmall: Invalid argument
-- 
1.7.7


