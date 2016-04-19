Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36545 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754338AbcDSUfy (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 19 Apr 2016 16:35:54 -0400
Received: by mail-wm0-f65.google.com with SMTP id l6so8273144wml.3
        for <util-linux@vger.kernel.org>; Tue, 19 Apr 2016 13:35:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 4/5] lib: avoid double free in loopdev.c
Date: Tue, 19 Apr 2016 21:35:44 +0100
Message-Id: <1461098145-2988-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
References: <1461098145-2988-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Found with scan-build.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 lib/loopdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/loopdev.c b/lib/loopdev.c
index 9ae61da..ca5d2f4 100644
--- a/lib/loopdev.c
+++ b/lib/loopdev.c
@@ -460,6 +460,7 @@ static int loop_scandir(const char *dirname, int **ary, int hasprefix)
 			tmp = realloc(*ary, arylen * sizeof(int));
 			if (!tmp) {
 				free(*ary);
+				ary = NULL;
 				closedir(dir);
 				return -1;
 			}
-- 
2.8.0

