Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55840 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752382AbbDMMB6 (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Mon, 13 Apr 2015 08:01:58 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0LwrS8-1ZRiOK2qwi-016Omn for
 <util-linux@vger.kernel.org>; Mon, 13 Apr 2015 14:01:56 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH v2 7/7] travis: install socat
Date: Mon, 13 Apr 2015 14:01:53 +0200
Message-Id: <1428926513-25449-8-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
References: <1428926513-25449-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 .travis-functions.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.travis-functions.sh b/.travis-functions.sh
index 86146b0..3b1d291 100755
--- a/.travis-functions.sh
+++ b/.travis-functions.sh
@@ -85,6 +85,7 @@ function travis_install_script
 		libudev-dev \
 		gtk-doc-tools \
 		ntp \
+		socat \
 		|| return
 }
 
-- 
1.8.4.5

