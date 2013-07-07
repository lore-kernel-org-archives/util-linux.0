Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-ea0-f182.google.com ([209.85.215.182]:64510 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753125Ab3GGT4G (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 7 Jul 2013 15:56:06 -0400
Received: by mail-ea0-f182.google.com with SMTP id d10so2505822eaj.27
        for <util-linux@vger.kernel.org>; Sun, 07 Jul 2013 12:56:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 23/34] column: assigned value is never read [clang-analyzer]
Date: Sun,  7 Jul 2013 20:54:38 +0100
Message-Id: <1373226889-3451-24-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
References: <1373226889-3451-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/column.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/text-utils/column.c b/text-utils/column.c
index ee9fdd7..25a2286 100644
--- a/text-utils/column.c
+++ b/text-utils/column.c
@@ -173,7 +173,6 @@ int main(int argc, char **argv)
 		default:
 			usage(EXIT_FAILURE);
 	}
-	argc -= optind;
 	argv += optind;
 
 	if (!*argv)
-- 
1.8.3.2

