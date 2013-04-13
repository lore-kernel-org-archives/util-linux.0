Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33535 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMT4b (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:31 -0400
Received: by mail-wi0-f173.google.com with SMTP id m6so508139wiv.6
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:30 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 30/33] fallocate: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:58 +0100
Message-Id: <1365882901-11429-31-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/fallocate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sys-utils/fallocate.c b/sys-utils/fallocate.c
index ff0f9e6..6a87673 100644
--- a/sys-utils/fallocate.c
+++ b/sys-utils/fallocate.c
@@ -168,6 +168,7 @@ int main(int argc, char **argv)
 		err(EXIT_FAILURE, _("%s: fallocate failed"), fname);
 	}
 
-	close(fd);
+	if (close_fd(fd) != 0)
+		err(EXIT_FAILURE, _("write failed: %s"), fname);
 	return EXIT_SUCCESS;
 }
-- 
1.8.2.1

