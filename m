Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:37626 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753216Ab3DMT43 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 13 Apr 2013 15:56:29 -0400
Received: by mail-wg0-f45.google.com with SMTP id l18so3656527wgh.12
        for <util-linux@vger.kernel.org>; Sat, 13 Apr 2013 12:56:28 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 29/33] swaplabel: check writing to a file descriptor was successful
Date: Sat, 13 Apr 2013 20:54:57 +0100
Message-Id: <1365882901-11429-30-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
References: <1365882901-11429-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/swaplabel.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/disk-utils/swaplabel.c b/disk-utils/swaplabel.c
index 3e3e78b..a5ccb7e 100644
--- a/disk-utils/swaplabel.c
+++ b/disk-utils/swaplabel.c
@@ -145,7 +145,10 @@ static int change_info(const char *devname, const char *label, const char *uuid)
 		}
 	}
 
-	close(fd);
+	if (close_fd(fd) != 0) {
+		warn(_("write failed: %s"), devname);
+		return -1;
+	}
 	return 0;
 err:
 	if (fd >= 0)
-- 
1.8.2.1

