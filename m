Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f45.google.com ([74.125.83.45]:45224 "EHLO
	mail-ee0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGTz5 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:55:57 -0400
Received: by mail-ee0-f45.google.com with SMTP id c1so2407750eek.4
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:56 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 20/34] chfn: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:35 +0100
Message-Id: <1373226889-3451-21-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 login-utils/chfn.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/login-utils/chfn.c b/login-utils/chfn.c
index 95e8d9d..5aa491d 100644
--- a/login-utils/chfn.c
+++ b/login-utils/chfn.c
@@ -227,7 +227,6 @@ static int parse_argv(int argc, char *argv[], struct finfo *pinfo)
 			usage(stderr);
 		/* ok, we were given an argument */
 		info_given = true;
-		status = 0;
 
 		/* now store the argument */
 		switch (c) {
-- 
1.8.3.2

