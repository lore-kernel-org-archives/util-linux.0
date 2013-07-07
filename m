Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f45.google.com ([74.125.83.45]:42101 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTzy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:54 -0400
Received: by mail-ee0-f45.google.com with SMTP id c1so2411698eek.18
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:52 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 19/34] eject: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:34 +0100
Message-Id: <1373226889-3451-20-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/eject.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/eject.c b/sys-utils/eject.c
index f98f227..5bcde68 100644
--- a/sys-utils/eject.c
+++ b/sys-utils/eject.c
@@ -636,7 +636,7 @@ static int eject_scsi(int fd)
 		return 0;
 
 	/* force kernel to reread partition table when new disc inserted */
-	status = ioctl(fd, BLKRRPART);
+	ioctl(fd, BLKRRPART);
 	return 1;
 }
 
-- 
1.8.3.2

