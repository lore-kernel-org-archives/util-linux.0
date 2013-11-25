Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:48597 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752093Ab3KYPX1 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 25 Nov 2013 10:23:27 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] mount.8: fix grammar
Date: Mon, 25 Nov 2013 10:23:26 -0500
Message-Id: <1385393006-27390-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Switch "A unbindable" to "An unbindable"

Reported-by: Regid Ichira <regid23@nt1.in>
Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 sys-utils/mount.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 65a054e..8fb21a5 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -466,7 +466,7 @@ Since Linux 2.6.15 it is possible to mark a mount and its submounts as shared,
 private, slave or unbindable. A shared mount provides ability to create mirrors
 of that mount such that mounts and umounts within any of the mirrors propagate
 to the other mirror. A slave mount receives propagation from its master, but
-any not vice-versa.  A private mount carries no propagation abilities.  A
+any not vice-versa.  A private mount carries no propagation abilities.  An
 unbindable mount is a private mount which cannot be cloned through a bind
 operation. Detailed semantics is documented in
 .B Documentation/filesystems/sharedsubtree.txt
-- 
1.8.3.2

