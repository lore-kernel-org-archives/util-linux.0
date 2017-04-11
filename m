Return-Path: util-linux-owner@vger.kernel.org
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34876 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752770AbdDKKEQ (ORCPT
        <rfc822;util-linux@vger.kernel.org>); Tue, 11 Apr 2017 06:04:16 -0400
Received: by mail-wm0-f68.google.com with SMTP id d79so13983399wmi.2
        for <util-linux@vger.kernel.org>; Tue, 11 Apr 2017 03:04:15 -0700 (PDT)
From: Sami Kerola <kerolasa@iki.fi>
To: util-linux@vger.kernel.org
Cc: Sami Kerola <kerolasa@iki.fi>
Subject: [PATCH] bash-completion: update fincore
Date: Tue, 11 Apr 2017 11:04:12 +0100
Message-Id: <20170411100412.7169-1-kerolasa@iki.fi>
Sender: util-linux-owner@vger.kernel.org
List-ID: <util-linux.vger.kernel.org>

Add RES column to --output completions.

Commit: e4e8b57be2b63fed82647e4d5efd0e0eaf36b19e
Signed-off-by: Sami Kerola <kerolasa@iki.fi>
---
 bash-completion/fincore | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bash-completion/fincore b/bash-completion/fincore
index 9b1aed8f3..4988f198b 100644
--- a/bash-completion/fincore
+++ b/bash-completion/fincore
@@ -9,7 +9,7 @@ _fincore_module()
 			local prefix realcur OUTPUT_ALL OUTPUT
 			realcur="${cur##*,}"
 			prefix="${cur%$realcur}"
-			OUTPUT_ALL='PAGES SIZE FILE'
+			OUTPUT_ALL='PAGES SIZE FILE RES'
 			for WORD in $OUTPUT_ALL; do
 				if ! [[ $prefix == *"$WORD"* ]]; then
 					OUTPUT="$WORD $OUTPUT"
-- 
2.12.2

