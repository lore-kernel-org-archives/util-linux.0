Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f171.google.com ([74.125.82.171]:57856 "EHLO
	mail-we0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751688Ab3AaTty (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Thu, 31 Jan 2013 14:49:54 -0500
Received: by mail-we0-f171.google.com with SMTP id u54so2443085wey.16
        for <util-linux@vger.kernel.org>; Thu, 31 Jan 2013 11:49:52 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 1/2] build-sys: add namespace.h to distribution
Date: Thu, 31 Jan 2013 19:49:48 +0000
Message-Id: <1359661788-16188-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 include/Makemodule.am | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/Makemodule.am b/include/Makemodule.am
index 5538570..c8af1ec 100644
--- a/include/Makemodule.am
+++ b/include/Makemodule.am
@@ -24,6 +24,7 @@ dist_noinst_HEADERS += \
 	include/mbsalign.h \
 	include/md5.h \
 	include/minix.h \
+	include/namespace.h \
 	include/nls.h \
 	include/optutils.h \
 	include/pager.h \
-- 
1.8.1.2

