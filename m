Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f169.google.com ([209.85.212.169]:36418 "EHLO
	mail-wi0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbbJaTVl (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 31 Oct 2015 15:21:41 -0400
Received: by wicfx6 with SMTP id fx6so28544717wic.1
        for <util-linux@vger.kernel.org>; Sat, 31 Oct 2015 12:21:40 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 08/12] mkfs.bfs: fix block device open race
Date: Sat, 31 Oct 2015 19:21:20 +0000
Message-Id: <1446319284-24778-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
References: <1446319284-24778-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

This fix makes mkfs.bfs also to detect if block device is busy, and warn if
the device is misaligned.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.bfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index 7057194..139130e 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -187,7 +187,7 @@ int main(int argc, char **argv)
 	if (!S_ISBLK(statbuf.st_mode))
 		errx(EXIT_FAILURE, _("%s is not a block special device"), device);
 
-	fd = open(device, O_RDWR | O_EXCL);
+	fd = open_blkdev_or_file(device, O_RDWR);
 	if (fd < 0)
 		err(EXIT_FAILURE, _("cannot open %s"), device);
 
-- 
2.6.2

