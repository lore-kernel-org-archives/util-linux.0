Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62687 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbcKGIfb (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Mon, 7 Nov 2016 03:35:31 -0500
Received: from tenfore.ga-group.nl ([2.247.115.183]) by mail.gmx.com
 (mrgmx101) with ESMTPSA (Nemesis) id 0MAloF-1bxqur1jZ5-00Bx88 for
 <util-linux@vger.kernel.org>; Mon, 07 Nov 2016 09:35:18 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH] tests: let lsmod fail silently
Date: Mon,  7 Nov 2016 09:35:17 +0100
Message-Id: <1478507717-10996-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

This is mostly for non-Linux systems where lsmod is not
even available.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 tests/functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tests/functions.sh b/tests/functions.sh
index fe3ff57..9239ab4 100644
--- a/tests/functions.sh
+++ b/tests/functions.sh
@@ -654,7 +654,7 @@ function ts_scsi_debug_init {
 		|| ts_skip "cannot load scsi_debug module (modprobe)"
 
 	# it might be still not loaded, modprobe.conf or whatever
-	lsmod | grep -q "^scsi_debug " \
+	lsmod 2>/dev/null | grep -q "^scsi_debug " \
 		|| ts_skip "scsi_debug module not loaded (lsmod)"
 
 	udevadm settle
@@ -683,7 +683,7 @@ function ts_scsi_debug_rmmod {
 	# not exist at all.
 	[ $UID -eq 0 ] || return 0
 	[ -n "$TS_DEVICE" ] || return 0
-	lsmod | grep -q "^scsi_debug " || return 0
+	lsmod 2>/dev/null | grep -q "^scsi_debug " || return 0
 
 	udevadm settle
 
-- 
1.8.5.6

