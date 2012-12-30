Return-Path: util-linux-owner@vger.kernel.org
Received: from gerolde.archlinux.org ([66.211.214.132]:36158 "EHLO
	gerolde.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754872Ab2L3UA0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 30 Dec 2012 15:00:26 -0500
From: Dave Reisner <dreisner@archlinux.org>
To: util-linux@vger.kernel.org
Cc: Dave Reisner <dreisner@archlinux.org>
Subject: [PATCH] configure: invert flag for sulogin emergency mount
Date: Sun, 30 Dec 2012 15:00:23 -0500
Message-Id: <1356897623-1646-1-git-send-email-dreisner@archlinux.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This should be disabled by default

Signed-off-by: Dave Reisner <dreisner@archlinux.org>
---
Following up on:

http://www.spinics.net/lists/util-linux-ng/msg07317.html

 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 9c08fc0..85c3dcf 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1308,9 +1308,9 @@ fi
 
 
 AC_ARG_ENABLE([sulogin-emergency-mount],
-  AS_HELP_STRING([--disable-sulogin-emergency-mount],
-		 [do not use emergency mount of /dev and /proc for sulogin]),
-  [], enable_sulogin_emergency_mount=yes
+  AS_HELP_STRING([--enable-sulogin-emergency-mount],
+		 [use emergency mount of /dev and /proc for sulogin]),
+  [], enable_sulogin_emergency_mount=no
 )
 
 if test "x$enable_sulogin_emergency_mount" = xyes; then
-- 
1.8.0.3

