Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33447 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753430AbcDSUfw (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2016 16:35:52 -0400
Received: by mail-wm0-f65.google.com with SMTP id y144so8321416wmd.0
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 13:35:51 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 2/5] libmount: fix memory leak
Date: Tue, 19 Apr 2016 21:35:42 +0100
Message-Id: <1461098145-2988-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
References: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Found with scan-build.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/utils.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/libmount/src/utils.c b/libmount/src/utils.c
index 0fcc1d0..8b80609 100644
--- a/libmount/src/utils.c
+++ b/libmount/src/utils.c
@@ -1107,7 +1107,7 @@ char *mnt_get_kernel_cmdline_option(const char *name)
 int mnt_guess_system_root(dev_t devno, struct libmnt_cache *cache, char **path)
 {
 	char buf[PATH_MAX];
-	char *dev = NULL, *spec;
+	char *dev = NULL, *spec = NULL;
 	unsigned int x, y;
 	int allocated = 0;
 
@@ -1169,8 +1169,8 @@ int mnt_guess_system_root(dev_t devno, struct libmnt_cache *cache, char **path)
 		if (dev && !cache)
 			allocated = 1;
 	}
-	free(spec);
 done:
+	free(spec);
 	if (dev) {
 		*path = allocated ? dev : strdup(dev);
 		if (!path)
-- 
2.8.0

