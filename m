Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wi0-f180.google.com ([209.85.212.180]:39279 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751772Ab3DMTzz (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:55:55 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so505165wiw.13
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:55:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 17/33] fdformat: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:45 +0100
Message-Id: <1365882901-11429-18-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/fdformat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/disk-utils/fdformat.c b/disk-utils/fdformat.c
index 509a605..b50ba30 100644
--- a/disk-utils/fdformat.c
+++ b/disk-utils/fdformat.c
@@ -159,7 +159,8 @@ int main(int argc, char **argv)
 	       (param.head == 2) ? _("Double") : _("Single"),
 	       param.track, param.sect, param.size >> 1);
 	format_disk(ctrl);
-	close(ctrl);
+	if (close_fd(ctrl) != 0)
+		err(EXIT_FAILURE, _("write failed"));
 
 	if (verify)
 		verify_disk(argv[0]);
-- 
1.8.2.1

