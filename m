Return-Path: util-linux-owner@vger.kernel.org
Received: from moutng.kundenserver.de ([212.227.126.171]:60640 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934Ab2HUP10 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 21 Aug 2012 11:27:26 -0400
From: Bernhard Voelker <mail@bernhard-voelker.de>
To: util-linux@vger.kernel.org
Cc: Bernhard Voelker <mail@bernhard-voelker.de>
Subject: [PATCH] fdisk: fix typo in comment
Date: Tue, 21 Aug 2012 17:26:33 +0200
Message-Id: <1345562793-25246-1-git-send-email-mail@bernhard-voelker.de>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

* fdisks/utils.c: s/firts/first/. Found by misspellings.

Signed-off-by: Bernhard Voelker <mail@bernhard-voelker.de>
---
 fdisks/utils.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fdisks/utils.c b/fdisks/utils.c
index 84cdd4d..77b0be6 100644
--- a/fdisks/utils.c
+++ b/fdisks/utils.c
@@ -317,7 +317,7 @@ static int __discover_topology(struct fdisk_context *cxt)
  * fdisk_zeroize_firstsector:
  * @cxt: fdisk context
  *
- * Zero's in-memory firts sector buffer
+ * Zero's in-memory first sector buffer
  */
 void fdisk_zeroize_firstsector(struct fdisk_context *cxt)
 {
-- 
1.7.7

