Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:62154 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754807AbcCQKEK (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Thu, 17 Mar 2016 06:04:10 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx102)
 with ESMTPSA (Nemesis) id 0MGXV6-1ac9Ch0Z2e-00DGbP for
 <util-linux@vger.kernel.org>; Thu, 17 Mar 2016 11:04:07 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/2] build-sys: no need to un-ignore tracked files
Date: Thu, 17 Mar 2016 11:04:05 +0100
Message-Id: <1458209046-18526-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 .gitignore | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/.gitignore b/.gitignore
index a008740..841111e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -55,16 +55,6 @@ tests/run.sh.log
 tests/run.sh.trs
 update.log
 
-# libuuid depends on AX_TLS macro
-!m4/tls.m4
-
-# GTK_DOC_CHECK depends on gtk-doc.m4
-!m4/gtk-doc.m4
-
-# util-linux specific macros
-!m4/ul.m4
-!m4/compiler.m4
-
 #
 # binaries
 #
-- 
1.8.4.5

