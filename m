Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:57539 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750917AbbACJVC (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 3 Jan 2015 04:21:02 -0500
Received: by mail-wi0-f178.google.com with SMTP id em10so608034wid.17
        for <util-linux@vger.kernel.org>; Sat, 03 Jan 2015 01:21:00 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/2] lslocks: fix type warning
Date: Sat,  3 Jan 2015 09:20:04 +0000
Message-Id: <1420276805-3154-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

misc-utils/lslocks.c:229:2: warning: format '%x' expects argument of type
'unsigned int *', but argument 3 has type 'int *' [-Wformat=]

Reference: http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/fs/locks.c?id=5e0f872c7d7e371fbdf09e864eddd24bddfda8fe#n2533
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/lslocks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc-utils/lslocks.c b/misc-utils/lslocks.c
index abc6a16..d351d7c 100644
--- a/misc-utils/lslocks.c
+++ b/misc-utils/lslocks.c
@@ -223,7 +223,7 @@ out:
  */
 static ino_t get_dev_inode(char *str, dev_t *dev)
 {
-	int maj = 0, min = 0;
+	unsigned int maj = 0, min = 0;
 	ino_t inum = 0;
 
 	sscanf(str, "%02x:%02x:%ju", &maj, &min, &inum);
-- 
2.2.1

