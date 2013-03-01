Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:59607 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab3CAEBs (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Thu, 28 Feb 2013 23:01:48 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 3F37933DC51
	for <util-linux-ng@vger.kernel.org>; Fri,  1 Mar 2013 04:01:47 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH 1/2] unshare(1): delete empty NOTES section
Date: Thu, 28 Feb 2013 23:03:01 -0500
Message-Id: <1362110582-23406-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 sys-utils/unshare.1 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/unshare.1 b/sys-utils/unshare.1
index 8cdc6e5..58f2bb2 100644
--- a/sys-utils/unshare.1
+++ b/sys-utils/unshare.1
@@ -61,7 +61,6 @@ Unshare the pid namespace.
 .TP
 .BR \-U , " \-\-user"
 Unshare the user namespace.
-.SH NOTES
 .SH SEE ALSO
 .BR unshare (2),
 .BR clone (2)
-- 
1.8.1.2

