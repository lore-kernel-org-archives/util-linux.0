Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.22]:55727 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751454AbcCVQxQ (ORCPT <rfc822;util-linux@vger.kernel.org>);
	Tue, 22 Mar 2016 12:53:16 -0400
Received: from zappa.ga.local ([82.139.197.16]) by mail.gmx.com (mrgmx103)
 with ESMTPSA (Nemesis) id 0M09Ee-1ZuylK32SK-00uKqv for
 <util-linux@vger.kernel.org>; Tue, 22 Mar 2016 17:53:14 +0100
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 1/3] build-sys: ignore vim .swp files
Date: Tue, 22 Mar 2016 17:53:11 +0100
Message-Id: <1458665593-7963-2-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1458665593-7963-1-git-send-email-sweet_f_a@gmx.de>
References: <1458665593-7963-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 .gitignore | 1 +
 1 file changed, 1 insertion(+)

diff --git a/.gitignore b/.gitignore
index 841111e..064010b 100644
--- a/.gitignore
+++ b/.gitignore
@@ -11,6 +11,7 @@
 *.so
 *.so.*
 *.static
+*.swp
 *.vim
 *.[ao]
 *~
-- 
1.8.4.5

