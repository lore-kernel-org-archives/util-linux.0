Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wg0-f44.google.com ([74.125.82.44]:56748 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753634Ab2JHHIv (ORCPT
	<rfc822;util-linux@vger.kernel.org>); Mon, 8 Oct 2012 03:08:51 -0400
Received: by mail-wg0-f44.google.com with SMTP id dr13so3493411wgb.1
        for <util-linux@vger.kernel.org>; Mon, 08 Oct 2012 00:08:50 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: kerolasa@iki.fi
Subject: [PATCH 03/14] docs: fix column.1 groff syntax error
Date: Mon,  8 Oct 2012 08:08:09 +0100
Message-Id: <1349680100-18120-4-git-send-email-kerolasa@iki.fi>
In-Reply-To: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
References: <1349680100-18120-1-git-send-email-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Quote backslash which user is expected to see.

Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 text-utils/column.1 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/text-utils/column.1 b/text-utils/column.1
index 3727048..b6da45f 100644
--- a/text-utils/column.1
+++ b/text-utils/column.1
@@ -73,7 +73,7 @@ The util-linux version 2.23 changed
 option to be non-greedy, for example:
 .PP
 .EX
-$ printf "a:b:c\n1::3\n" | column  -t -s ':'
+$ printf "a:b:c\\n1::3\\n" | column  -t -s ':'
 .EE
 .PP
 old output:
-- 
1.7.12.2

