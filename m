Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:32875 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754435AbbBOAx0 (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 14 Feb 2015 19:53:26 -0500
Received: by mail-we0-f171.google.com with SMTP id p10so23180363wes.2
        for <util-linux@vger.kernel.org>; Sat, 14 Feb 2015 16:53:25 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] sfdisk: include rpmatch.h
Date: Sun, 15 Feb 2015 00:52:49 +0000
Message-Id: <1423961569-18812-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Some libc's do not have rpmatch(), and they need the workaround in the
header file.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 disk-utils/sfdisk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/disk-utils/sfdisk.c b/disk-utils/sfdisk.c
index b10c004..b7d4480 100644
--- a/disk-utils/sfdisk.c
+++ b/disk-utils/sfdisk.c
@@ -40,6 +40,7 @@
 #include "colors.h"
 #include "blkdev.h"
 #include "all-io.h"
+#include "rpmatch.h"
 
 #include "libfdisk.h"
 #include "fdisk-list.h"
-- 
2.3.0

