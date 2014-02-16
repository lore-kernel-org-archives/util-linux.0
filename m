Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:42886 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752497AbaBPXys (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 18:54:48 -0500
Received: by mail-we0-f180.google.com with SMTP id u57so9936775wes.25
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 15:54:47 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 6/9] swaplabel: wrong version number in check
Date: Sun, 16 Feb 2014 23:54:19 +0000
Message-Id: <1392594862-15807-6-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
References: <1392594862-15807-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

$ swaplabel /dev/sda2
swaplabel: /dev/sda2: unsupported swap version '1'

The mkswap does not allow any other version, so swaplabel(8) must be
wrong.

Reference: https://github.com/karelzak/util-linux/blob/master/disk-utils/mkswap.c#L520
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/swaplabel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/disk-utils/swaplabel.c b/disk-utils/swaplabel.c
index a5ccb7e..5d048aa 100644
--- a/disk-utils/swaplabel.c
+++ b/disk-utils/swaplabel.c
@@ -70,7 +70,7 @@ static blkid_probe get_swap_prober(const char *devname)
 		/* supported is SWAPSPACE2 only */
 		if (blkid_probe_lookup_value(pr, "VERSION", &version, NULL) == 0
 		    && version
-		    && strcmp(version, "2"))
+		    && strcmp(version, "1"))
 			warnx(_("%s: unsupported swap version '%s'"),
 						devname, version);
 		else
-- 
1.9.0

