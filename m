Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f53.google.com ([74.125.82.53]:57572 "EHLO
	mail-wg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3DMT4M (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:12 -0400
Received: by mail-wg0-f53.google.com with SMTP id c11so3531924wgh.8
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:10 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 23/33] fsck.cramfs: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:51 +0100
Message-Id: <1365882901-11429-24-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fsck.cramfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/disk-utils/fsck.cramfs.c b/disk-utils/fsck.cramfs.c
index 5c4b8c4..3c861d5 100644
--- a/disk-utils/fsck.cramfs.c
+++ b/disk-utils/fsck.cramfs.c
@@ -513,7 +513,8 @@ static void do_file(char *path, struct cramfs_inode *i)
 	if (i->size)
 		do_uncompress(path, fd, offset, i->size);
 	if (opt_extract) {
-		close(fd);
+		if (close_fd(fd) != 0)
+			err(FSCK_EX_ERROR, _("write failed: %s"), path);
 		change_file_status(path, i);
 	}
 }
-- 
1.8.2.1

