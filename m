Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f51.google.com ([74.125.82.51]:50857 "EHLO
	mail-wg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753313Ab3IHQJV (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 8 Sep 2013 12:09:21 -0400
Received: by mail-wg0-f51.google.com with SMTP id a12so4519588wgh.30
        for <util-linux@vger.kernel.org>; Sun, 08 Sep 2013 09:09:20 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/4] tools: generate autotools files if missing
Date: Sun,  8 Sep 2013 17:09:07 +0100
Message-Id: <1378656549-3729-2-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1378656549-3729-1-git-send-email-kerolasa@iki.fi>
References: <1378656549-3729-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tools/config-gen | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tools/config-gen b/tools/config-gen
index 72cefc9..b7ccadd 100755
--- a/tools/config-gen
+++ b/tools/config-gen
@@ -28,5 +28,9 @@ if [ -n "$CFLAGS" ]; then
 	export CFLAGS
 fi
 
+if [ ! -f ./configure ]; then
+	./autogen.sh
+fi
+
 echo
 ./configure $opts
-- 
1.8.4

