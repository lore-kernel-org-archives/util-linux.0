Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f175.google.com ([209.85.212.175]:55555 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMT4R (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:17 -0400
Received: by mail-wi0-f175.google.com with SMTP id c10so506233wiw.14
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 25/33] mkfs.bfs: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:53 +0100
Message-Id: <1365882901-11429-26-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/mkfs.bfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/mkfs.bfs.c b/disk-utils/mkfs.bfs.c
index 0a296f3..6f11bf7 100644
--- a/disk-utils/mkfs.bfs.c
+++ b/disk-utils/mkfs.bfs.c
@@ -289,7 +289,7 @@ int main(int argc, char **argv)
 	if (write(fd, &de, sizeof(de)) != sizeof(de))
 		err(EXIT_FAILURE, _("error writing .. entry"));
 
-	if (close(fd) < 0)
+	if (close_fd(fd) != 0)
 		err(EXIT_FAILURE, _("error closing %s"), device);
 
 	return EXIT_SUCCESS;
-- 
1.8.2.1

