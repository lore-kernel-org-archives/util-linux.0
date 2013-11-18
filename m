Return-Path: util-linux-owner@vger.kernel.org
Received: from rrcs-67-78-168-186.se.biz.rr.com ([67.78.168.186]:44306 "EHLO
	iriserv.iradimed.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751561Ab3KRTPw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 18 Nov 2013 14:15:52 -0500
From: Phillip Susi <psusi@ubuntu.com>
To: util-linux@vger.kernel.org
Subject: [PATCH] Add ext4 to list of filesystems with progress bars in fsck man page
Date: Mon, 18 Nov 2013 14:15:50 -0500
Message-Id: <1384802150-24264-1-git-send-email-psusi@ubuntu.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Phillip Susi <psusi@ubuntu.com>
---
 disk-utils/fsck.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/fsck.8 b/disk-utils/fsck.8
index 52629c7..4620c44 100644
--- a/disk-utils/fsck.8
+++ b/disk-utils/fsck.8
@@ -267,7 +267,7 @@ also skips non-existing devices that have the special filesystem type
 .TP
 .BR \-C \ [ \fIfd\fR ]
 Display completion/progress bars for those filesystem checkers (currently
-only for ext2 and ext3) which support them.  \fBfsck\fR will manage the
+only for ext[234]) which support them.  \fBfsck\fR will manage the
 filesystem checkers so that only one of them will display
 a progress bar at a time.  GUI front-ends may specify a file descriptor
 .IR fd ,
-- 
1.8.3.2

