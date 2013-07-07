Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ee0-f43.google.com ([74.125.83.43]:52546 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGT4N (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:13 -0400
Received: by mail-ee0-f43.google.com with SMTP id l10so2395204eei.2
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:12 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 25/34] dmesg: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:40 +0100
Message-Id: <1373226889-3451-26-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/dmesg.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sys-utils/dmesg.c b/sys-utils/dmesg.c
index 64b1c09..85488bb 100644
--- a/sys-utils/dmesg.c
+++ b/sys-utils/dmesg.c
@@ -1349,7 +1349,6 @@ int main(int argc, char *argv[])
 		}
 	}
 	argc -= optind;
-	argv += optind;
 
 	if (argc > 1)
 		usage(stderr);
-- 
1.8.3.2

