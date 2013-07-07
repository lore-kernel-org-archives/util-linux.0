Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f172.google.com ([209.85.215.172]:35604 "EHLO
	mail-ea0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGT4A (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:00 -0400
Received: by mail-ea0-f172.google.com with SMTP id q10so2527982eaj.31
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:55:59 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 21/34] mesg: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:36 +0100
Message-Id: <1373226889-3451-22-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 term-utils/mesg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/term-utils/mesg.c b/term-utils/mesg.c
index 430236f..638a8c7 100644
--- a/term-utils/mesg.c
+++ b/term-utils/mesg.c
@@ -115,7 +115,6 @@ int main(int argc, char *argv[])
 			usage(stderr);
 		}
 
-	argc -= optind;
 	argv += optind;
 
 	if ((tty = ttyname(STDERR_FILENO)) == NULL)
-- 
1.8.3.2

