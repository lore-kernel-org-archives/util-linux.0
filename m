Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-we0-f178.google.com ([74.125.82.178]:50969 "EHLO
	mail-we0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754018Ab3HQSQH (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Sat, 17 Aug 2013 14:16:07 -0400
Received: by mail-we0-f178.google.com with SMTP id u57so2601591wes.37
        for <util-linux@vger.kernel.org>; Sat, 17 Aug 2013 11:16:05 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 04/16] docs: be clear which last(1) is deprecated
Date: Sat, 17 Aug 2013 19:15:09 +0100
Message-Id: <1376763321-22782-5-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
References: <1376763321-22782-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

The recently merged sysvinit last(1) and lastb(1) are supported.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 Documentation/deprecated.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/deprecated.txt b/Documentation/deprecated.txt
index f78965c..9a21980 100644
--- a/Documentation/deprecated.txt
+++ b/Documentation/deprecated.txt
@@ -51,7 +51,7 @@ Why:	parallel port printers are probably almost extinct devices
 
 --------------------------
 
-What:	last(1)
+What:	deprecated_last(1)
 Why:	nobody uses this implementation
 
 ----------------------------
-- 
1.8.3.4

