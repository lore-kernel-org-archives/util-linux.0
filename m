Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33686 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753168AbcELMJJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 12 May 2016 08:09:09 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so15779451wme.0
        for <util-linux@vger.kernel.org>; Thu, 12 May 2016 05:09:09 -0700 (PDT)
From: Sassan Panahinejad <sassan@sassan.me.uk>
To: util-linux@vger.kernel.org
Cc: Sassan Panahinejad <sassan@sassan.me.uk>
Subject: [PATCH] libfdisk: fix range checking for fdisk_set_last_lba
Date: Thu, 12 May 2016 13:09:00 +0100
Message-Id: <1463054940-3217-1-git-send-email-sassan@sassan.me.uk>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

---
 libfdisk/src/context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libfdisk/src/context.c b/libfdisk/src/context.c
index 26f526a..ab4709c 100644
--- a/libfdisk/src/context.c
+++ b/libfdisk/src/context.c
@@ -1012,7 +1012,7 @@ fdisk_sector_t fdisk_set_last_lba(struct fdisk_context *cxt, fdisk_sector_t lba)
 {
 	assert(cxt);
 
-	if (lba > cxt->total_sectors - 1 && lba < 1)
+	if (lba > cxt->total_sectors - 1 || lba < 1)
 		return -ERANGE;
 	cxt->last_lba = lba;
 	return 0;
-- 
2.1.0

