Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f41.google.com ([74.125.82.41]:50251 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751623AbaJZWHW (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 Oct 2014 18:07:22 -0400
Received: by mail-wg0-f41.google.com with SMTP id b13so4455096wgh.24
        for <util-linux@vger.kernel.org>; Sun, 26 Oct 2014 15:07:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/4] fstrim: initialize path variable
Date: Sun, 26 Oct 2014 22:07:07 +0000
Message-Id: <1414361229-23921-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
References: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Reading the code this initialization is not necessary, so the change is
mostly about silencing a compiler warning and ensuring the program keeps
on working if there is a future bug that could make uninitialized 'path'
reachable to use.

sys-utils/fstrim.c:247: warning: 'path' may be used uninitialized in this
function

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/fstrim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sys-utils/fstrim.c b/sys-utils/fstrim.c
index 481a4cb..b18cdb2 100644
--- a/sys-utils/fstrim.c
+++ b/sys-utils/fstrim.c
@@ -244,7 +244,7 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 
 int main(int argc, char **argv)
 {
-	char *path;
+	char *path = NULL;
 	int c, rc, verbose = 0, all = 0;
 	struct fstrim_range range;
 
-- 
2.1.2

