Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32985 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752454AbdCEUwu (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:50 -0500
Received: by mail-wm0-f67.google.com with SMTP id n11so10897548wma.0
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:49 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 11/13] libfdisk: fix potentially null
Date: Sun,  5 Mar 2017 20:52:30 +0000
Message-Id: <20170305205232.24030-12-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

1248:3: note: in expansion of macro 'FDISK_INIT_UNDEF'
   FDISK_INIT_UNDEF(xpa->size);
   ^~~~~~~~~~~~~~~~
libfdisk/src/partition.c:1247:15: warning: potential null pointer
dereference [-Wnull-dereference]
   xpa->resize = 0;
   ~~~~~~~~~~~~^~~
libfdisk/src/partition.c:1246:18: warning: potential null pointer
dereference [-Wnull-dereference]
   xpa->movestart = 0;
   ~~~~~~~~~~~~~~~^~~

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libfdisk/src/partition.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/libfdisk/src/partition.c b/libfdisk/src/partition.c
index 1e8c1eb32..adb4acfe4 100644
--- a/libfdisk/src/partition.c
+++ b/libfdisk/src/partition.c
@@ -1243,6 +1243,10 @@ int fdisk_set_partition(struct fdisk_context *cxt, size_t partno,
 
 	if (pa->resize || fdisk_partition_has_start(pa) || fdisk_partition_has_size(pa)) {
 		xpa = __copy_partition(pa);
+		if (xpa == NULL) {
+			rc = 1;
+			goto done;
+		}
 		xpa->movestart = 0;
 		xpa->resize = 0;
 		FDISK_INIT_UNDEF(xpa->size);
-- 
2.12.0

