Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33027 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755203AbdERVTy (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Thu, 18 May 2017 17:19:54 -0400
Received: by mail-wr0-f194.google.com with SMTP id w50so662527wrc.0
        for <util-linux@vger.kernel.org>; Thu, 18 May 2017 14:19:54 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 1/3] rename: make --no-act to imply --verbose
Date: Thu, 18 May 2017 22:19:34 +0100
Message-Id: <20170518211936.28153-2-kerolasa@iki.fi>
In-Reply-To: <20170518211936.28153-1-kerolasa@iki.fi>
References: <20170518211936.28153-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

It is reasonable to assume use of --no-act means one wants to always see
what would have happen if rename is done.  To say same slightly differently,
if there is sn use case for silent rename --no-act run I cannot think one.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 misc-utils/rename.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/misc-utils/rename.c b/misc-utils/rename.c
index c1b9d4a0e..502e888d7 100644
--- a/misc-utils/rename.c
+++ b/misc-utils/rename.c
@@ -154,11 +154,11 @@ int main(int argc, char **argv)
 
 	while ((c = getopt_long(argc, argv, "vsVhn", longopts, NULL)) != -1)
 		switch (c) {
-		case 'v':
-			verbose = 1;
-			break;
 		case 'n':
 			noact = 1;
+			/* fallthrough */
+		case 'v':
+			verbose = 1;
 			break;
 		case 's':
 			do_rename = do_symlink;
-- 
2.13.0

