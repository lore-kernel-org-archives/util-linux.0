Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-la0-f48.google.com ([209.85.215.48]:36696 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752424AbbFSTlP (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Fri, 19 Jun 2015 15:41:15 -0400
Received: by lacny3 with SMTP id ny3so80091628lac.3
        for <util-linux@vger.kernel.org>; Fri, 19 Jun 2015 12:41:14 -0700 (PDT)
From: Boris Egorov <egorov@linux.com>
To: util-linux@vger.kernel.org
Cc: Boris Egorov <egorov@linux.com>
Subject: [PATCH 3/3] cfdisk: fix condition logic [cppcheck]
Date: Sat, 20 Jun 2015 01:41:01 +0600
Message-Id: <1434742861-11704-4-git-send-email-egorov@linux.com>
In-Reply-To: <1434742861-11704-1-git-send-email-egorov@linux.com>
References: <1434742861-11704-1-git-send-email-egorov@linux.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

[disk-utils/cfdisk.c:1181] -> [disk-utils/cfdisk.c:1181]: (warning)
Possible null pointer dereference: data - otherwise it is redundant to
check it against null.

Signed-off-by: Boris Egorov <egorov@linux.com>
---
 disk-utils/cfdisk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/cfdisk.c b/disk-utils/cfdisk.c
index 6f26a3d..4627107 100644
--- a/disk-utils/cfdisk.c
+++ b/disk-utils/cfdisk.c
@@ -1178,7 +1178,7 @@ inline static int extra_insert_pair(struct cfdisk_line *l, const char *name, con
 
 	assert(l);
 
-	if (!data && !*data)
+	if (!data || !*data)
 		return 0;
 
 	lsl = scols_table_new_line(l->extra, NULL);
-- 
2.1.4

--
To unsubscribe from this list: send the line "unsubscribe util-linux" in
