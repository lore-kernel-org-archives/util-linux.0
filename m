Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35206 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752313AbdDFVLV (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 6 Apr 2017 17:11:21 -0400
Received: by mail-wr0-f194.google.com with SMTP id t20so14808552wra.2
        for <util-linux@vger.kernel.org>; Thu, 06 Apr 2017 14:11:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] libmount: fix file descriptor leak
Date: Thu,  6 Apr 2017 22:11:16 +0100
Message-Id: <20170406211116.4543-2-kerolasa@iki.fi>
In-Reply-To: <20170406211116.4543-1-kerolasa@iki.fi>
References: <20170406211116.4543-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/utils.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 7e028ee02..3b27135cd 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -647,18 +647,17 @@ done:
 
 static int try_write(const char *filename)
 {
-	int fd;
+	int fd, ret = 0;
 
 	if (!filename)
 		return -EINVAL;
 
 	fd = open(filename, O_RDWR|O_CREAT|O_CLOEXEC,
 			    S_IWUSR|S_IRUSR|S_IRGRP|S_IROTH);
-	if (fd >= 0) {
-		close(fd);
-		return 0;
-	}
-	return -errno;
+	if (fd < 0)
+		ret = -errno;
+	close(fd);
+	return ret;
 }
 
 /**
-- 
2.12.2

