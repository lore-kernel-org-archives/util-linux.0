Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.15.15]:52608 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1426386AbcBRNMw (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 18 Feb 2016 08:12:52 -0500
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0LfTVx-1aCEzi1zaL-00p3Gs for
 <util-linux@vger.kernel.org>; Thu, 18 Feb 2016 14:12:51 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 04/15] build-sys: fix [g]libtoolize version for OSX
Date: Thu, 18 Feb 2016 14:12:44 +0100
Message-Id: <1455801169-10470-5-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
References: <1455801169-10470-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

follow-up 0024583c

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 autogen.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/autogen.sh b/autogen.sh
index bfa46fe..116885b 100755
--- a/autogen.sh
+++ b/autogen.sh
@@ -75,7 +75,7 @@ if ! ($LIBTOOLIZE --version) < /dev/null > /dev/null 2>&1; then
 	echo
 	DIE=1
 else
-	ltver=$($LIBTOOLIZE --version | awk '/^libtoolize/ { print $4 }')
+	ltver=$($LIBTOOLIZE --version | awk '/^[g]*libtoolize/ { print $4 }')
 	ltver=${ltver:-"none"}
 	test ${ltver##2.} = "$ltver" && {
 		echo
-- 
1.8.4.5

