Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f45.google.com ([74.125.82.45]:57399 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760521Ab3DBTnX (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Tue, 2 Apr 2013 15:43:23 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so844693wgg.0
        for <util-linux@vger.kernel.org>; Tue, 02 Apr 2013 12:43:22 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 08/13] partx: remove deprecated option from usage()
Date: Tue,  2 Apr 2013 20:42:52 +0100
Message-Id: <1364931777-2645-9-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
References: <1364931777-2645-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The fact that -l, --list is deprecated will remain in manual page till
unforeseeable future.  Meanwhile the usage() can be made shorter.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/partx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/disk-utils/partx.c b/disk-utils/partx.c
index 9fa9587..49ef1dc 100644
--- a/disk-utils/partx.c
+++ b/disk-utils/partx.c
@@ -706,7 +706,6 @@ static void __attribute__((__noreturn__)) usage(FILE *out)
 	fputs(USAGE_OPTIONS, out);
 	fputs(_(" -a, --add            add specified partitions or all of them\n"), out);
 	fputs(_(" -d, --delete         delete specified partitions or all of them\n"), out);
-	fputs(_(" -l, --list           list partitions (DEPRECATED)\n"), out);
 	fputs(_(" -s, --show           list partitions\n\n"), out);
 	fputs(_(" -u, --update         update specified partitions or all of them\n"), out);
 	fputs(_(" -b, --bytes          print SIZE in bytes rather than in human readable format\n"), out);
-- 
1.8.2

