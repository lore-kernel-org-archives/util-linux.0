Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37372 "EHLO
	mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161328AbcBSVvF (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Feb 2016 16:51:05 -0500
Received: by mail-wm0-f44.google.com with SMTP id g62so89159325wme.0
        for <util-linux@vger.kernel.org>; Fri, 19 Feb 2016 13:50:54 -0800 (PST)
From: Romain Naour <romain.naour@gmail.com>
To: util-linux@vger.kernel.org
Cc: Romain Naour <romain.naour@gmail.com>
Subject: [PATCH 1/2] build-sys: fix typo
Date: Fri, 19 Feb 2016 22:50:47 +0100
Message-Id: <1455918648-11430-1-git-send-email-romain.naour@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When timer_create is available have_timer must be
set to "yes". But instead have_time is used.

Replace have_time by have_timer.

Fixes:
http://autobuild.buildroot.net/results/993/9935cd0522d4f978ba2e788a690f66790686b76b

Signed-off-by: Romain Naour <romain.naour@gmail.com>
---
 configure.ac | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 227ba25..961c1ab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -402,7 +402,7 @@ AC_CHECK_FUNCS([clock_gettime], [],
 
 have_timer="no"
 AC_CHECK_FUNCS([timer_create],
-	[have_time="yes"],
+	[have_timer="yes"],
 	[AC_CHECK_LIB([rt], [timer_create], [
 		have_timer="yes"
 		REALTIME_LIBS="-lrt"
-- 
2.5.0

