Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f50.google.com ([74.125.83.50]:63765 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGT4T (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:19 -0400
Received: by mail-ee0-f50.google.com with SMTP id d49so2365461eek.37
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:18 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 27/34] sfdisk: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:42 +0100
Message-Id: <1373226889-3451-28-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 fdisks/sfdisk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fdisks/sfdisk.c b/fdisks/sfdisk.c
index 6b757a7..152e5f5 100644
--- a/fdisks/sfdisk.c
+++ b/fdisks/sfdisk.c
@@ -1505,7 +1505,7 @@ msdos_partition(char *dev, int fd, unsigned long start, struct disk_desc *z) {
     struct partition pt;
     struct sector *s;
     struct part_desc *partitions = &(z->partitions[0]);
-    int pno = z->partno;
+    int pno;
     int bsd_later = 1;
     unsigned short sig, magic;
 #ifdef __linux__
-- 
1.8.3.2

