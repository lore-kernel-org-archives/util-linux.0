Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:49877 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757484AbcLAI6B (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Thu, 1 Dec 2016 03:58:01 -0500
Received: from tenfore.ga-group.nl ([217.186.11.144]) by mail.gmx.com
 (mrgmx001 [212.227.17.190]) with ESMTPSA (Nemesis) id
 0LtZcC-1ct1gy1Ny8-010y8E for <util-linux@vger.kernel.org>; Thu, 01 Dec 2016
 09:57:52 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 10/11] travis: let OSX auto-skip utmpx tools
Date: Thu,  1 Dec 2016 09:57:50 +0100
Message-Id: <1480582671-17627-1-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
References: <1480582332-17407-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

It will disable all these programs automatically except wall(1)
which is now non-Linux compatible.

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 .travis-functions.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/.travis-functions.sh b/.travis-functions.sh
index ca73a9f..11e7707 100755
--- a/.travis-functions.sh
+++ b/.travis-functions.sh
@@ -108,16 +108,8 @@ function osx_install_script
 	brew link --force ncurses
 
 	OSX_CONFOPTS="
-		--disable-runuser \
-		--disable-su \
-		--disable-login \
-		--disable-last \
-		--disable-utmpdump \
-		--disable-agetty \
-		--disable-wall \
 		--disable-ipcrm \
 		--disable-ipcs \
-		--disable-write \
 	"
 
 	# workaround: glibtoolize could not find sed
-- 
1.8.5.6

