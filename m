Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f52.google.com ([74.125.82.52]:37394 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMT4X (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:23 -0400
Received: by mail-wg0-f52.google.com with SMTP id n12so3621454wgh.19
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:22 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 27/33] mkfs.minix: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:55 +0100
Message-Id: <1365882901-11429-28-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.minix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/disk-utils/mkfs.minix.c b/disk-utils/mkfs.minix.c
index e80d1d6..3a1617b 100644
--- a/disk-utils/mkfs.minix.c
+++ b/disk-utils/mkfs.minix.c
@@ -804,7 +804,8 @@ int main(int argc, char ** argv) {
 
 	mark_good_blocks();
 	write_tables();
-	close(DEV);
+	if (close_fd(DEV) != 0)
+		err(MKFS_EX_ERROR, _("write failed"));
 
 	return MKFS_EX_OK;
 }
-- 
1.8.2.1

