Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f170.google.com ([74.125.82.170]:34940 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752588AbaHFUwY (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 6 Aug 2014 16:52:24 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so3180303wes.29
        for <util-linux@vger.kernel.org>; Wed, 06 Aug 2014 13:52:23 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH] swapon: remove invalid error string print outs
Date: Wed,  6 Aug 2014 21:52:18 +0100
Message-Id: <1407358338-2099-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

To avoid messages like this:

$ swapon /dev/zram0
swapon: /dev/zram0: read swap header failed: Success

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/swapon.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sys-utils/swapon.c b/sys-utils/swapon.c
index 193fcbf..ea5fdb2 100644
--- a/sys-utils/swapon.c
+++ b/sys-utils/swapon.c
@@ -511,13 +511,13 @@ static int swapon_checks(const char *special)
 	}
 
 	if (S_ISBLK(st.st_mode) && blkdev_get_size(fd, &devsize)) {
-		warn(_("%s: get size failed"), special);
+		warnx(_("%s: get size failed"), special);
 		goto err;
 	}
 
 	hdr = swap_get_header(fd, &sig, &pagesize);
 	if (!hdr) {
-		warn(_("%s: read swap header failed"), special);
+		warnx(_("%s: read swap header failed"), special);
 		goto err;
 	}
 
-- 
2.0.4

