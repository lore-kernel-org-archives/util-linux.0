Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f180.google.com ([74.125.82.180]:41082 "EHLO
	mail-we0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752290AbaBPPXJ (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sun, 16 Feb 2014 10:23:09 -0500
Received: by mail-we0-f180.google.com with SMTP id u57so10047657wes.11
        for <util-linux@vger.kernel.org>; Sun, 16 Feb 2014 07:23:07 -0800 (PST)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 2/4] build-sys: add libs-only to config-gen.d
Date: Sun, 16 Feb 2014 15:22:54 +0000
Message-Id: <1392564176-11596-3-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
References: <1392564176-11596-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 tools/config-gen.d/libs-only.conf | 10 ++++++++++
 1 file changed, 10 insertions(+)
 create mode 100644 tools/config-gen.d/libs-only.conf

diff --git a/tools/config-gen.d/libs-only.conf b/tools/config-gen.d/libs-only.conf
new file mode 100644
index 0000000..f000288
--- /dev/null
+++ b/tools/config-gen.d/libs-only.conf
@@ -0,0 +1,10 @@
+include:core.conf
+
+--disable-diskutils
+--disable-fdisks
+--disable-loginutils
+--disable-miscutils
+--disable-schedutils
+--disable-sysutils
+--disable-termutils
+--disable-textutils
-- 
1.8.5.5

