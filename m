Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-qg0-f42.google.com ([209.85.192.42]:52998 "EHLO
	mail-qg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751347AbaJIAqY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 8 Oct 2014 20:46:24 -0400
Received: by mail-qg0-f42.google.com with SMTP id z60so172502qgd.29
        for <util-linux@vger.kernel.org>; Wed, 08 Oct 2014 17:46:23 -0700 (PDT)
From: "Raphael S. Carvalho" <raphaelsc@cloudius-systems.com>
To: util-linux@vger.kernel.org
Cc: "Raphael S. Carvalho" <raphaelsc@cloudius-systems.com>
Subject: [PATCH] blkdiscard: fix underflow when offset is greater than device size
Date: Wed,  8 Oct 2014 21:46:07 -0300
Message-Id: <1412815567-2565-1-git-send-email-raphael.scarv@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

From: "Raphael S. Carvalho" <raphaelsc@cloudius-systems.com>

If offset (range[0]) is greater than device size (blksize), the variable 'end'
will be greater than blksize, and range[1] (length) will be recalculated.
The underflow happens when subtracting range[0] (offset) from blksize, thus
range[1] will be the result of an underflow. The bug leads to unwanted behavior
from the program, where range[1] is likely to be a high number and then will
discard a considerable amount of blocks from the device. The fix consists of
exitting the program with an error message when the condition stated above is
true. Spotted while auditing the code.

Signed-off-by: Raphael S. Carvalho <raphaelsc@cloudius-systems.com>
---
 sys-utils/blkdiscard.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sys-utils/blkdiscard.c b/sys-utils/blkdiscard.c
index 2ddcdb1..2f22af7 100644
--- a/sys-utils/blkdiscard.c
+++ b/sys-utils/blkdiscard.c
@@ -149,6 +149,8 @@ int main(int argc, char **argv)
 	range[1] &= ~(secsize - 1);
 
 	/* is the range end behind the end of the device ?*/
+	if (range[0] > blksize)
+		err(EXIT_FAILURE, _("%s: offset is greater than device size"), path);
 	end = range[0] + range[1];
 	if (end < range[0] || end > blksize)
 		range[1] = blksize - range[0];
-- 
1.9.3

