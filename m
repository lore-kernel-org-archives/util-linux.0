Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-pb0-f42.google.com ([209.85.160.42]:62748 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754675Ab3IYPcb (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 25 Sep 2013 11:32:31 -0400
Received: by mail-pb0-f42.google.com with SMTP id un15so6227766pbc.1
        for <util-linux@vger.kernel.org>; Wed, 25 Sep 2013 08:32:30 -0700 (PDT)
From: Namhyung Kim <namhyung@gmail.com>
To: util-linux@vger.kernel.org
Subject: [PATCH 2/4] libmount: Free splitted optstr's when error occurred
Date: Thu, 26 Sep 2013 00:32:04 +0900
Message-Id: <1380123126-3030-2-git-send-email-namhyung@gmail.com>
In-Reply-To: <1380123126-3030-1-git-send-email-namhyung@gmail.com>
References: <1380123126-3030-1-git-send-email-namhyung@gmail.com>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

When strdup() failed, u, v and f optstr's should be freed.

Signed-off-by: Namhyung Kim <namhyung@gmail.com>
---
 libmount/src/fs.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/libmount/src/fs.c b/libmount/src/fs.c
index c95cdc7..e3a2e1a 100644
--- a/libmount/src/fs.c
+++ b/libmount/src/fs.c
@@ -774,8 +774,12 @@ int mnt_fs_set_options(struct libmnt_fs *fs, const char *optstr)
 		if (rc)
 			return rc;
 		n = strdup(optstr);
-		if (!n)
+		if (!n) {
+			free(u);
+			free(v);
+			free(f);
 			return -ENOMEM;
+		}
 	}
 
 	free(fs->fs_optstr);
-- 
1.7.9.2

