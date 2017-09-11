Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38807 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751045AbdIKT4F (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 11 Sep 2017 15:56:05 -0400
Received: by mail-wm0-f68.google.com with SMTP id x17so7682750wmd.5
        for <util-linux@vger.kernel.org>; Mon, 11 Sep 2017 12:56:04 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/2] rfkill: do not fsync(3) /dev/rfkill file descriptor
Date: Mon, 11 Sep 2017 20:55:58 +0100
Message-Id: <20170911195558.740-2-kerolasa@iki.fi>
In-Reply-To: <20170911195558.740-1-kerolasa@iki.fi>
References: <20170911195558.740-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Attempt to fsync() this device returns EINVAL, causing the rfkill always to
return EXIT_FAILURE when either block or unblock is requested.  Simply
closing the file descriptor will fix the issue.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/rfkill.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/rfkill.c b/sys-utils/rfkill.c
index 6b586d2ed..7914c4309 100644
--- a/sys-utils/rfkill.c
+++ b/sys-utils/rfkill.c
@@ -452,7 +452,7 @@ static int rfkill_block(uint8_t block, const char *param)
 		closelog();
 	}
 	free(message);
-	return close_fd(fd);
+	return close(fd);
 }
 
 static void __attribute__((__noreturn__)) usage(void)
-- 
2.14.1

