Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:35778 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdBMWGw (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Mon, 13 Feb 2017 17:06:52 -0500
Received: by mail-wr0-f194.google.com with SMTP id o16so25889467wra.2
        for <util-linux@vger.kernel.org>; Mon, 13 Feb 2017 14:06:52 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 6/7] libblkid: declare across file variables in blkidP.h [smatch scan]
Date: Mon, 13 Feb 2017 22:06:40 +0000
Message-Id: <20170213220641.1395-7-kerolasa@iki.fi>
In-Reply-To: <20170213220641.1395-1-kerolasa@iki.fi>
References: <20170213220641.1395-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Else these variables will cause following warning:

libblkid/src/superblocks/superblocks.c:165:29: warning: symbol
'superblocks_drv' was not declared.  Should it be static?

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libblkid/src/blkidP.h | 5 +++++
 libblkid/src/probe.c  | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/libblkid/src/blkidP.h b/libblkid/src/blkidP.h
index 817c8b02b..de41473a8 100644
--- a/libblkid/src/blkidP.h
+++ b/libblkid/src/blkidP.h
@@ -116,6 +116,11 @@ struct blkid_chaindrv {
 	void		(*free_data)(blkid_probe, void *);
 };
 
+/* chains */
+extern const struct blkid_chaindrv superblocks_drv;
+extern const struct blkid_chaindrv topology_drv;
+extern const struct blkid_chaindrv partitions_drv;
+
 /*
  * Low-level probe result
  */
diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c
index df90a82e0..ab05fb2d3 100644
--- a/libblkid/src/probe.c
+++ b/libblkid/src/probe.c
@@ -115,11 +115,6 @@
 #include "strutils.h"
 #include "list.h"
 
-/* chains */
-extern const struct blkid_chaindrv superblocks_drv;
-extern const struct blkid_chaindrv topology_drv;
-extern const struct blkid_chaindrv partitions_drv;
-
 /*
  * All supported chains
  */
-- 
2.11.1

