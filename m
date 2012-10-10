Return-Path: util-linux-owner@vger.kernel.org
Received: from smtp.gentoo.org ([140.211.166.183]:33053 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750882Ab2JJE3V (ORCPT <rfc822;util-linux-ng@vger.kernel.org>);
	Wed, 10 Oct 2012 00:29:21 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by smtp.gentoo.org (Postfix) with ESMTP id 59EE033C235
	for <util-linux-ng@vger.kernel.org>; Wed, 10 Oct 2012 04:29:21 +0000 (UTC)
From: Mike Frysinger <vapier@gentoo.org>
To: util-linux-ng@vger.kernel.org
Subject: [PATCH] sfdisk: fix aliasing warnings
Date: Wed, 10 Oct 2012 00:29:54 -0400
Message-Id: <1349843394-22920-1-git-send-email-vapier@gentoo.org>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Compiles down to the same code.

Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 fdisks/sfdisk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index 3450f52..e59d52a 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -1561,12 +1561,14 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
 	return 0;
     }
 
-    unsigned int sig = *(unsigned short *)(s->data + 2);
-    if (sig <= 0x1ae
-	&& *(unsigned short *)(s->data + sig) == 0x55aa
-	&& (1 & *(unsigned char *)(s->data + sig + 2))) {
+    unsigned short sig, magic;
+    memcpy(&sig, s->data + 2, sizeof(sig));
+    if (sig <= 0x1ae) {
+	memcpy(&magic, s->data + sig, sizeof(magic));
+	if (magic == 0x55aa && (1 & *(unsigned char *)(s->data + sig + 2))) {
 	    warnx(_("DM6 signature found - giving up\n"));
 	    return 0;
+	}
     }
 
     for (pno = 0; pno < 4; pno++, cp += sizeof(struct partition)) {
-- 
1.7.12

