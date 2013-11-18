Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:44297 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752679Ab3KRTAS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Nov 2013 14:00:18 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Fix man mount page typeo
Date: Mon, 18 Nov 2013 14:00:17 -0500
Message-Id: <1384801217-24052-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Slight grammatical error in the mount man page

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 sys-utils/mount.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/mount.8 b/sys-utils/mount.8
index 9b9a9db..65a054e 100644
--- a/sys-utils/mount.8
+++ b/sys-utils/mount.8
@@ -162,7 +162,7 @@ udev symlinks in the /etc/fstab file. The tags are
 more readable, robust and portable. The
 .BR mount (8)
 command internally uses udev
-symlinks, so use the symlinks in /etc/fstab has no advantage over the tags.
+symlinks, so the use of symlinks in /etc/fstab has no advantage over the tags.
 For more details see
 .BR libblkid (3).
 
-- 
1.8.3.2

