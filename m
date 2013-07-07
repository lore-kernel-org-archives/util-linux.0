Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f48.google.com ([74.125.83.48]:60670 "EHLO
	mail-ee0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTzf (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:35 -0400
Received: by mail-ee0-f48.google.com with SMTP id b47so2360367eek.21
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:34 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 13/34] libmount: fix memory leak [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:28 +0100
Message-Id: <1373226889-3451-14-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/utils.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 1655764..7714b50 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -198,6 +198,7 @@ int mnt_chdir_to_parent(const char *target, char **filename)
 		else
 			memcpy(*filename, last, strlen(last) + 1);
 	}
+	free(buf);
 	return 0;
 err:
 	free(buf);
-- 
1.8.3.2

