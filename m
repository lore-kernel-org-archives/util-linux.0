Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f50.google.com ([74.125.82.50]:62723 "EHLO
	mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbaG3Vog (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Wed, 30 Jul 2014 17:44:36 -0400
Received: by mail-wg0-f50.google.com with SMTP id n12so1811221wgh.21
        for <util-linux@vger.kernel.org>; Wed, 30 Jul 2014 14:44:35 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/2] build-sys: remove swap-common.h from sys-utils/Makemodule.am
Date: Wed, 30 Jul 2014 22:44:30 +0100
Message-Id: <1406756671-26805-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The commit 25a365e moved the file to include/

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 sys-utils/Makemodule.am | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sys-utils/Makemodule.am b/sys-utils/Makemodule.am
index 4741fed..ca47df8 100644
--- a/sys-utils/Makemodule.am
+++ b/sys-utils/Makemodule.am
@@ -253,8 +253,7 @@ dist_man_MANS += \
 
 swapon_SOURCES = \
 	sys-utils/swapon.c \
-	sys-utils/swapon-common.c \
-	sys-utils/swapon-common.h
+	sys-utils/swapon-common.c
 swapon_CFLAGS = $(AM_CFLAGS) \
 	-I$(ul_libblkid_incdir) \
 	-I$(ul_libmount_incdir) \
-- 
2.0.3

