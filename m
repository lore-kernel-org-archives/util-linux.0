Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f178.google.com ([209.85.212.178]:54176 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3DMTz6 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:58 -0400
Received: by mail-wi0-f178.google.com with SMTP id hr17so507772wib.5
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:57 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 18/33] partx: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:46 +0100
Message-Id: <1365882901-11429-19-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/partx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 49ef1dc..b93ddf3 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -987,6 +987,8 @@ int main(int argc, char **argv)
 	if (loopdev)
 		loopcxt_deinit(&lc);
 
-	close(fd);
+	if (close_fd(fd) != 0)
+		err(EXIT_FAILURE, _("write failed"));
+
 	return rc ? EXIT_FAILURE : EXIT_SUCCESS;
 }
-- 
1.8.2.1

