Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f46.google.com ([74.125.82.46]:64051 "EHLO
	mail-wg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751605AbaJZWHS (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 26 Oct 2014 18:07:18 -0400
Received: by mail-wg0-f46.google.com with SMTP id x13so36561wgg.17
        for <util-linux@vger.kernel.org>; Sun, 26 Oct 2014 15:07:16 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/4] sfdisk: return deterministic value from sfdisk_deinit()
Date: Sun, 26 Oct 2014 22:07:06 +0000
Message-Id: <1414361229-23921-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
References: <1414361229-23921-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

disk-utils/sfdisk.c:222:9: warning: variable 'rc' is uninitialized when
used here [-Wuninitialized]
        return rc;
disk-utils/sfdisk.c:208:8: note: initialize the variable 'rc' to silence
this warning
        int rc;

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/sfdisk.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index b0332f2..f48d1c7 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -205,7 +205,6 @@ static void sfdisk_init(struct sfdisk *sf)
 static int sfdisk_deinit(struct sfdisk *sf)
 {
 	struct fdisk_context *parent;
-	int rc;
 
 	assert(sf);
 	assert(sf->cxt);
@@ -219,7 +218,7 @@ static int sfdisk_deinit(struct sfdisk *sf)
 	fdisk_unref_context(sf->cxt);
 	memset(sf, 0, sizeof(*sf));
 
-	return rc;
+	return 0;
 }
 
 static void backup_sectors(struct sfdisk *sf,
-- 
2.1.2

