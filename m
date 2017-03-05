Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33834 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752213AbdCEUwk (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Sun, 5 Mar 2017 15:52:40 -0500
Received: by mail-wr0-f194.google.com with SMTP id u48so19504319wrc.1
        for <util-linux@vger.kernel.org>; Sun, 05 Mar 2017 12:52:39 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH 02/13] libmount: fix use of preprocessor identifier
Date: Sun,  5 Mar 2017 20:52:21 +0000
Message-Id: <20170305205232.24030-3-kerolasa@iki.fi>
In-Reply-To: <20170305205232.24030-1-kerolasa@iki.fi>
References: <20170305205232.24030-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

libmount/src/context_mount.c:990:5: warning: undefined preprocessor
identifier 'USE_LIBMOUNT_SUPPORT_MTAB'

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 libmount/src/context_mount.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/libmount/src/context_mount.c b/libmount/src/context_mount.c
index 23f0e303a..6368e9ba8 100644
--- a/libmount/src/context_mount.c
+++ b/libmount/src/context_mount.c
@@ -987,7 +987,7 @@ int mnt_context_do_mount(struct libmnt_context *cxt)
 	} else
 		res = do_mount_by_pattern(cxt, cxt->fstype_pattern);
 
-#if USE_LIBMOUNT_SUPPORT_MTAB
+#ifdef USE_LIBMOUNT_SUPPORT_MTAB
 	if (mnt_context_get_status(cxt)
 	    && !mnt_context_is_fake(cxt)
 	    && !cxt->helper) {
-- 
2.12.0

