Return-Path: util-linux-owner@vger.kernel.org
Received: from mout.gmx.net ([212.227.17.21]:49325 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751548AbdF2CJM (ORCPT <rfc822;util-linux@vger.kernel.org>);
        Wed, 28 Jun 2017 22:09:12 -0400
Received: from tenfore.ga-group.nl ([92.195.15.151]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MVedf-1dF3Q91HgN-00Z0FQ for
 <util-linux@vger.kernel.org>; Thu, 29 Jun 2017 04:09:10 +0200
From: Ruediger Meier <sweet_f_a@gmx.de>
To: util-linux@vger.kernel.org
Subject: [PATCH 3/3] docs: correct line(1) deprecation comment
Date: Thu, 29 Jun 2017 04:09:08 +0200
Message-Id: <1498702148-11755-4-git-send-email-sweet_f_a@gmx.de>
In-Reply-To: <1498702148-11755-1-git-send-email-sweet_f_a@gmx.de>
References: <1498702148-11755-1-git-send-email-sweet_f_a@gmx.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: Ruediger Meier <ruediger.meier@ga-group.nl>

Signed-off-by: Ruediger Meier <ruediger.meier@ga-group.nl>
---
 Documentation/deprecated.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index b7f64df..82b80c1 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -50,7 +50,7 @@ Why:    udevd links libblkid directly; the 'list' is unnecessary, use lsblk(8)
 --------------------------
 
 What:   line(1) command
-Why:    useless, nobody uses this command, head(1) is better
+Why:    use the read(1) command
 
 --------------------------
 
-- 
1.8.5.6

